*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* temporary helper types

CLASS lhc_supplier DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_global_authorizations
      FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Supplier
      RESULT result.

ENDCLASS.

CLASS lhc_supplier IMPLEMENTATION.

  METHOD get_global_authorizations.
    result-%create      = if_abap_behv=>auth-allowed.
    result-%update      = if_abap_behv=>auth-allowed.
    result-%delete      = if_abap_behv=>auth-allowed.
    result-%action-Edit = if_abap_behv=>auth-allowed.
  ENDMETHOD.

ENDCLASS.
