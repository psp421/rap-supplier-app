@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View: BP Supplier'
@Metadata.allowExtensions: true

@UI.headerInfo: {
  typeName:       'Supplier',
  typeNamePlural: 'Suppliers',
  title:       { type: #STANDARD, value: 'SupplierName' },
  description: { type: #STANDARD, value: 'BPNumber' }
}

define root view entity ZC_BP_SUPPLIER
  provider contract transactional_query
  as projection on ZI_BP_SUPPLIER
{
      @UI.facet: [
        { id: 'GeneralInfo',  purpose: #STANDARD, type: #FIELDGROUP_REFERENCE,
          label: 'General Information', targetQualifier: 'GeneralInfo', position: 10 },
        { id: 'AddressInfo',  purpose: #STANDARD, type: #FIELDGROUP_REFERENCE,
          label: 'Address',             targetQualifier: 'AddressInfo', position: 20 },
        { id: 'ContactInfo',  purpose: #STANDARD, type: #FIELDGROUP_REFERENCE,
          label: 'Contact',             targetQualifier: 'ContactInfo', position: 30 },
        { id: 'FinancialInfo',purpose: #STANDARD, type: #FIELDGROUP_REFERENCE,
          label: 'Financial Details',   targetQualifier: 'FinancialInfo', position: 40 },
        { id: 'AdminInfo',    purpose: #STANDARD, type: #FIELDGROUP_REFERENCE,
          label: 'Administrative Data', targetQualifier: 'AdminInfo', position: 50 }
      ]

  key SupplierUUID,

      @UI.lineItem:       [{ position: 10, label: 'BP Number' }]
      @UI.selectionField: [{ position: 10 }]
      @UI.fieldGroup:     [{ qualifier: 'GeneralInfo', position: 10, label: 'Business Partner Number' }]
      BPNumber,

      @UI.lineItem:       [{ position: 20, label: 'Supplier Name' }]
      @UI.selectionField: [{ position: 20 }]
      @UI.fieldGroup:     [{ qualifier: 'GeneralInfo', position: 20, label: 'Supplier Name' }]
      SupplierName,

      @UI.lineItem:       [{ position: 30, label: 'Status' }]
      @UI.selectionField: [{ position: 30 }]
      @UI.fieldGroup:     [{ qualifier: 'GeneralInfo', position: 30, label: 'Status' }]
      Status,

      @UI.fieldGroup: [{ qualifier: 'AddressInfo', position: 10, label: 'Street' }]
      Street,

      @UI.lineItem:       [{ position: 40, label: 'City' }]
      @UI.selectionField: [{ position: 40 }]
      @UI.fieldGroup:     [{ qualifier: 'AddressInfo', position: 20, label: 'City' }]
      City,

      @UI.lineItem:       [{ position: 50, label: 'Country' }]
      @UI.selectionField: [{ position: 50 }]
      @UI.fieldGroup:     [{ qualifier: 'AddressInfo', position: 30, label: 'Country' }]
      Country,

      @UI.fieldGroup: [{ qualifier: 'ContactInfo', position: 10, label: 'Phone' }]
      Phone,

      @UI.fieldGroup: [{ qualifier: 'ContactInfo', position: 20, label: 'Email' }]
      Email,

      @UI.fieldGroup: [{ qualifier: 'FinancialInfo', position: 10, label: 'Payment Terms' }]
      PaymentTerms,

      @UI.lineItem:   [{ position: 60, label: 'Currency' }]
      @UI.fieldGroup: [{ qualifier: 'FinancialInfo', position: 20, label: 'Currency' }]
      Currency,

      @UI.hidden: true
      @UI.fieldGroup: [{ qualifier: 'AdminInfo', position: 10, label: 'Created By' }]
      CreatedBy,

      @UI.hidden: true
      @UI.fieldGroup: [{ qualifier: 'AdminInfo', position: 20, label: 'Created At' }]
      CreatedAt,

      @UI.hidden: true
      @UI.fieldGroup: [{ qualifier: 'AdminInfo', position: 30, label: 'Changed By' }]
      ChangedBy,

      @UI.hidden: true
      @UI.fieldGroup: [{ qualifier: 'AdminInfo', position: 40, label: 'Changed At' }]
      ChangedAt,

      @UI.hidden: true
      LocalLastChangedAt
}
