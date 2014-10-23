$import('com.hh.form.property.BaseProperty');
Ext.define('com.hh.form.property.ComboBoxProperty', {
			extend : 'com.hh.form.property.BaseProperty',
			title : '下拉框属性设置',
			constructor : function(config) {
				this.config = config || {};
				this.superclass.constructor.call(this, this.config);
			},
			beInitCmp : function() {
				this.formItems = [{
							fieldLabel : '选项',
							xtype : 'widgetPropertiesFieldList',
							columnWidth : 1,
							name : 'data',
							keyText : '提交值',
							valueText : '显示值'
						}, {
							fieldLabel : '请求',
							name : 'action',
							allowBlank : false,
							columnWidth : 1
						}, {
							title : '请求参数',
							xtype : 'widgetPropertiesField',
							columnWidth : 1,
							name : 'extraParams',
							no_delete_key : ['table_name'],
							value : [{
										key : "table_name",
										value : ''
									}]
						}];
			}
		});