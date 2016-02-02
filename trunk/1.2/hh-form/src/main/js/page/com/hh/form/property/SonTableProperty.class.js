$import('com.hh.form.property.BaseProperty');
Ext.define('com.hh.form.property.SonTableProperty', {
	extend : 'com.hh.form.property.BaseProperty',
	title : '子表信息',
	constructor : function(config) {
		this.config = config || {};
		this.superclass.constructor.call(this, this.config);
	},
	beInitCmp : function() {
		this.formItems = [ {
			"xtype" : "widgetComboBoxTree",
			"name" : "formDataId",
			"columnWidth" : "0.5",
			"fieldLabel" : "子表",
			"allowBlank" : false,
			"action" : "form-FormTree-queryTreeListe",
			"submitType" : "id",
			"defaultSubmitValue" : "root",
			"paramType" : "paramsMap"
		} ];
	}
});