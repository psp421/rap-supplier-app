sap.ui.define([
  "sap/fe/core/AppComponent"
], function(AppComponent) {
  "use strict";
  return AppComponent.extend("com.accenture.rapsupplier.Component", {
    metadata: {
      interfaces: ["sap.ui.core.IAsyncContentCreation"],
      manifest: "json"
    }
  });
});
