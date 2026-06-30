# Creates database table ZPO_HIST in package ZTEST_VS on JFA system
# Run in a normal PowerShell terminal (NOT the Claude Code terminal)

$SapUrl    = "https://d2c9146d-b14f-463a-a9cb-aa56822c90d4.abap.eu10.hana.ondemand.com"
$Client    = "100"
$Package   = "ZTEST_VS"
$TableName = "ZPO_HIST"

$cred     = Get-Credential -Message "Enter your SAP JFA credentials"
$user     = $cred.UserName
$pass     = $cred.GetNetworkCredential().Password
$b64      = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${user}:${pass}"))
$authHdr  = "Basic $b64"

$baseHdr = @{
    "Authorization" = $authHdr
    "sap-client"    = $Client
    "Accept"        = "application/xml"
}

Write-Host "Step 1: Fetching CSRF token..." -ForegroundColor Cyan
$csrfResp = Invoke-WebRequest -Uri "$SapUrl/sap/bc/adt/ddic/tables/$TableName" `
    -Method Get `
    -Headers ($baseHdr + @{ "X-CSRF-Token" = "Fetch" }) `
    -ErrorAction SilentlyContinue
$csrfToken = $csrfResp.Headers["x-csrf-token"]

if (-not $csrfToken) {
    Write-Host "  Table may not exist yet - trying package endpoint for CSRF..." -ForegroundColor Yellow
    $csrfResp2 = Invoke-WebRequest -Uri "$SapUrl/sap/bc/adt/packages/$Package" `
        -Method Get `
        -Headers ($baseHdr + @{ "X-CSRF-Token" = "Fetch" }) `
        -ErrorAction SilentlyContinue
    $csrfToken = $csrfResp2.Headers["x-csrf-token"]
}

if (-not $csrfToken) {
    Write-Error "Could not retrieve CSRF token. Check credentials."
    exit 1
}
Write-Host "  CSRF token obtained." -ForegroundColor Green

Write-Host "Step 2: Creating table $TableName in package $Package..." -ForegroundColor Cyan

$tableXml = @"
<?xml version="1.0" encoding="utf-8"?>
<dataDefinitions:tableDefinition
  xmlns:dataDefinitions="http://www.sap.com/adt/ddic/tableDefinitions"
  xmlns:adtcore="http://www.sap.com/adt/core"
  adtcore:packageName="$Package"
  adtcore:responsible=""
  adtcore:description="PO History">
</dataDefinitions:tableDefinition>
"@

$createHdr = $baseHdr + @{
    "X-CSRF-Token" = $csrfToken
    "Content-Type" = "application/vnd.sap.adt.ddic.tableDefinitions.v1+xml"
}

try {
    $createResp = Invoke-WebRequest `
        -Uri "$SapUrl/sap/bc/adt/ddic/tables/$TableName`?corrNr=" `
        -Method Put `
        -Headers $createHdr `
        -Body ([Text.Encoding]::UTF8.GetBytes($tableXml)) `
        -ErrorAction Stop
    Write-Host "  Table object created: $($createResp.StatusCode)" -ForegroundColor Green
} catch {
    $errBody = $_.Exception.Response
    if ($errBody) {
        $reader = New-Object IO.StreamReader($errBody.GetResponseStream())
        Write-Host "  Response: $($reader.ReadToEnd())" -ForegroundColor Red
    }
    Write-Error "Creation failed: $($_.Exception.Message)"
    exit 1
}

Write-Host "Step 3: Setting DDL source..." -ForegroundColor Cyan

$ddlSource = @"
@EndUserText.label : 'PO History'
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
define table zpo_hist {
  key client     : abap.clnt not null;
  key po_uuid    : sysuuid_x16 not null;
  po_number      : abap.char(10);
  created_at     : timestampl;
  changed_at     : timestampl;
}
"@

$srcHdr = $baseHdr + @{
    "X-CSRF-Token" = $csrfToken
    "Content-Type" = "text/plain; charset=utf-8"
}

try {
    $srcResp = Invoke-WebRequest `
        -Uri "$SapUrl/sap/bc/adt/ddic/tables/$TableName/source/main" `
        -Method Put `
        -Headers $srcHdr `
        -Body ([Text.Encoding]::UTF8.GetBytes($ddlSource)) `
        -ErrorAction Stop
    Write-Host "  Source set: $($srcResp.StatusCode)" -ForegroundColor Green
} catch {
    Write-Warning "Source PUT failed (may be normal if object already includes source): $($_.Exception.Message)"
}

Write-Host "Step 4: Activating $TableName..." -ForegroundColor Cyan

$activateBody = "<adtcore:objectReferences xmlns:adtcore=`"http://www.sap.com/adt/core`"><adtcore:objectReference adtcore:uri=`"/sap/bc/adt/ddic/tables/$TableName`" adtcore:type=`"TABL/DT`"/></adtcore:objectReferences>"

$actHdr = $baseHdr + @{
    "X-CSRF-Token" = $csrfToken
    "Content-Type" = "application/vnd.sap.adt.activation.request+xml"
}

try {
    $actResp = Invoke-WebRequest `
        -Uri "$SapUrl/sap/bc/adt/activation" `
        -Method Post `
        -Headers $actHdr `
        -Body ([Text.Encoding]::UTF8.GetBytes($activateBody)) `
        -ErrorAction Stop
    Write-Host "  Activated: $($actResp.StatusCode)" -ForegroundColor Green
} catch {
    Write-Warning "Activation call returned: $($_.Exception.Message)"
}

Write-Host ""
Write-Host "Done. Table ZPO_HIST should now exist in package ZTEST_VS on JFA." -ForegroundColor Green
Write-Host "Refresh the ABAP repository tree in VSCode to see it." -ForegroundColor Yellow
