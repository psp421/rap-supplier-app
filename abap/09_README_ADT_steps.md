# ABAP RAP Objects — ADT Creation Guide

Create all objects in this order inside ADT/Eclipse connected to system JFA.
**Package:** ZBPSUPPLIER (create this package first)

---

## Step 1: Create Package ZBPSUPPLIER
- ADT: File > New > ABAP Package
- Name: ZBPSUPPLIER | Description: BP Supplier Management
- Superpackage: ZLOCAL
- Create a development transport when prompted

---

## Step 2: Create Database Table ZBP_SUPPLIER
- New > Other ABAP Repository Object > Dictionary > Database Table
- Name: ZBP_SUPPLIER
- Paste content from: `01_ZBP_SUPPLIER_table.asddls`
- Activate (Ctrl+F3)

---

## Step 3: Create Draft Table ZBP_SUPPLIER_D
- New > Other ABAP Repository Object > Dictionary > Database Table
- Name: ZBP_SUPPLIER_D
- Paste content from: `02_ZBP_SUPPLIER_D_draft_table.asddls`
- Activate

> Alternative: After saving the Behavior Definition (Step 5), right-click it >
> "Generate Draft Table" — ADT creates ZBP_SUPPLIER_D automatically with correct draft fields.

---

## Step 4: Create Interface CDS View ZI_BP_SUPPLIER
- New > Other ABAP Repository Object > Core Data Services > Data Definition
- Name: ZI_BP_SUPPLIER | Template: Define Root View Entity
- Paste content from: `03_ZI_BP_SUPPLIER_interface_view.ddls`
- Activate

---

## Step 5: Create Behavior Definition ZI_BP_SUPPLIER
- Right-click ZI_BP_SUPPLIER in Project Explorer > New > Behavior Definition
- (Or: New > Other ABAP Repository Object > Core Data Services > Behavior Definition)
- Paste content from: `04_ZI_BP_SUPPLIER_behavior_def.bdef`
- Activate
- ADT auto-creates class ZBP_I_BP_SUPPLIER (the implementation class skeleton)

---

## Step 6: Fill Behavior Implementation ZBP_I_BP_SUPPLIER
- Open class ZBP_I_BP_SUPPLIER in ADT
- Click on the "Local Types" tab (CCIMP include)
- Replace existing content with: `05_ZBP_I_BP_SUPPLIER_impl_class_CCIMP.abap`
- Activate

---

## Step 7: Create Projection CDS View ZC_BP_SUPPLIER
- New > Other ABAP Repository Object > Core Data Services > Data Definition
- Name: ZC_BP_SUPPLIER | Template: Define Projection View
- Paste content from: `06_ZC_BP_SUPPLIER_projection_view.ddls`
- Activate

---

## Step 8: Create Behavior Projection ZC_BP_SUPPLIER
- Right-click ZC_BP_SUPPLIER in Project Explorer > New > Behavior Definition
- Paste content from: `07_ZC_BP_SUPPLIER_behavior_projection.bdef`
- Activate

---

## Step 9: Create Service Definition ZUI_BP_SUPPLIER_O4
- New > Other ABAP Repository Object > Business Services > Service Definition
- Name: ZUI_BP_SUPPLIER_O4
- Paste content from: `08_ZUI_BP_SUPPLIER_O4_service_def.srvd`
- Activate

---

## Step 10: Create and Publish Service Binding ZUI_BP_SUPPLIER_O4
- New > Other ABAP Repository Object > Business Services > Service Binding
- Name: ZUI_BP_SUPPLIER_O4
- Description: Service Binding: BP Supplier OData V4
- Binding Type: OData V4 - UI
- Service Definition: ZUI_BP_SUPPLIER_O4
- Reference: `09_ZUI_BP_SUPPLIER_O4_service_binding.srvb`
- Click **Publish** in the Service Binding editor
- Copy the Service URL shown — you need it for ui5.yaml

Service URL pattern:
  /sap/opu/odata4/sap/zui_bp_supplier_o4/srvd/sap/zui_bp_supplier_o4/0001/

---

## Step 11: Quick Test in ADT Preview
- In the Service Binding editor, click **Preview**
- Browser opens with Fiori Elements List Report
- Click "+" → fill Supplier Name + Status → Save
- Verify record appears in the list table

---

## Step 12: Update Fiori App Configuration
After publishing, update these two files in rap-supplier-app/:

**ui5.yaml** — replace the placeholder host:
  url: https://<YOUR-ABAP-CLOUD-HOST>
  Find the hostname in: BTP Cockpit > Instances > ABAP Cloud instance > Endpoints

**webapp/annotations/annotation.xml** — verify the namespace:
  Browse to: <service-url>/$metadata
  Copy the exact Namespace from the Schema element
  Replace "com.sap.gateway.srvd.zui_bp_supplier_o4.v0001" in annotation.xml

---

## Field Status Quick Reference

| Field              | Create | Update | Notes                        |
|--------------------|--------|--------|------------------------------|
| SupplierUUID       | Auto   | Read-only | UUID auto-generated        |
| SupplierName       | Mandatory | Mandatory | Required in behavior def |
| Status             | Mandatory | Mandatory | A=Active, I=Inactive       |
| BPNumber           | Optional  | Optional  |                            |
| Street/City/Country| Optional  | Optional  |                            |
| Phone/Email        | Optional  | Optional  |                            |
| PaymentTerms       | Optional  | Optional  |                            |
| Currency           | Optional  | Optional  |                            |
| CreatedBy/At       | Auto   | Read-only | @Semantics auto-populate   |
| ChangedBy/At       | Auto   | Auto      | @Semantics auto-populate   |
