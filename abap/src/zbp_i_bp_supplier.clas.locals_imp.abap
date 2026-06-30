*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* temporary helper types

CLASS lhc_supplier DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_global_authorizations
      FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Supplier
      RESULT result.

    METHODS fill_preliminary_key
      FOR NUMBERING
      IMPORTING entities FOR CREATE Supplier.

ENDCLASS.

CLASS lhc_supplier IMPLEMENTATION.

  METHOD get_global_authorizations.
    " For development/testing: grant all authorizations.
    " For production: implement proper authority-check against F_LFA1_BUK or similar.
    result-%create         = if_abap_behv=>auth-allowed.
    result-%update         = if_abap_behv=>auth-allowed.
    result-%delete         = if_abap_behv=>auth-allowed.
    result-%action-Edit    = if_abap_behv=>auth-allowed.
    result-%action-Prepare = if_abap_behv=>auth-allowed.
  ENDMETHOD.

  METHOD fill_preliminary_key.
    " Assign UUID to each new Supplier before INSERT into draft table.
    LOOP AT entities INTO DATA(entity).
      IF entity-SupplierUUID IS INITIAL.
        APPEND VALUE #(
          %cid                = entity-%cid
          %key-SupplierUUID   = cl_system_uuid=>create_uuid_x16_static( )
        ) TO mapped-Supplier.
      ELSE.
        APPEND VALUE #(
          %cid                = entity-%cid
          %key-SupplierUUID   = entity-SupplierUUID
        ) TO mapped-Supplier.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
