@EndUserText.label : 'BP Supplier Draft Table'
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
define table zbp_supplier_d {
  key client          : abap.clnt not null;
  key supplieruuid    : sysuuid_x16 not null;
  "%admin"            : include sych_bdl_draft_admin_inc;
  bpnumber            : abap.char(10);
  suppliername        : abap.char(80);
  street              : abap.char(60);
  city                : abap.char(40);
  country             : land1;
  phone               : abap.char(30);
  email               : abap.char(80);
  paymentterms        : abap.char(4);
  currency            : waers;
  status              : abap.char(1);
  createdby           : syuname;
  createdat           : timestampl;
  changedby           : syuname;
  changedat           : timestampl;
  locallastchangedat  : timestampl;
}
