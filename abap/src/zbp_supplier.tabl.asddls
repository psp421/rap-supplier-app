@EndUserText.label : 'BP Supplier Master Data'
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
define table zbp_supplier {
  key client            : abap.clnt not null;
  key supplier_uuid     : sysuuid_x16 not null;
  bp_number             : abap.char(10);
  supplier_name         : abap.char(80) not null;
  street                : abap.char(60);
  city                  : abap.char(40);
  country               : land1;
  phone                 : abap.char(30);
  email                 : abap.char(80);
  payment_terms         : abap.char(4);
  currency              : waers;
  status                : abap.char(1);
  created_by            : syuname;
  created_at            : timestampl;
  changed_by            : syuname;
  changed_at            : timestampl;
  local_last_changed_at : timestampl;
}
