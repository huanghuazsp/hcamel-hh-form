$import('com.hh.form.property.BaseProperty');
Ext.define('com.hh.form.property.ComboBoxTreeProperty', {
	extend : 'com.hh.form.property.BaseProperty',
	title : '下拉树属性设置',
	constructor : function(config) {
		this.config = config || {};
		this.superclass.constructor.call(this, this.config);
	},
	beInitCmp : function() {
		this.formItems = [ {
			fieldLabel : '请求',
			name : 'action',
			allowBlank : false,
			columnWidth : 1
		}, {
			title : '请求参数',
			xtype : 'widgetPropertiesField',
			columnWidth : 1,
			name : 'extraParams',
			no_delete_key : [ 'table_name' ],
			value : [ {
				key : "table_name",
				value : ''
			} ]
		} ];
	},
});