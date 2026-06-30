@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View: BP Supplier'

define root view entity ZI_BP_SUPPLIER
  as select from zbp_supplier
{
  key supplier_uuid         as SupplierUUID,
      bp_number             as BPNumber,
      supplier_name         as SupplierName,
      street                as Street,
      city                  as City,
      country               as Country,
      phone                 as Phone,
      email                 as Email,
      payment_terms         as PaymentTerms,
      currency              as Currency,
      status                as Status,

      @Semantics.user.createdBy: true
      created_by            as CreatedBy,

      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,

      @Semantics.user.lastChangedBy: true
      changed_by            as ChangedBy,

      @Semantics.systemDateTime.lastChangedAt: true
      changed_at            as ChangedAt,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}
