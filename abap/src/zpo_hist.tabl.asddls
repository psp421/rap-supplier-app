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
