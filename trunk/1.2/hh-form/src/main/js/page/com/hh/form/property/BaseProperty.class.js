Ext.define('com.hh.form.property.BaseProperty', {
	extend : 'com.hh.base.BaseServicePanel',
	constructor : function(config) {
		this.config = config || {};
		this.callParent(arguments);
		this.initCmp();
	},
	beInitCmp : function() {
	},
	afInitCmp : function() {
	},
	initCmp : function() {
		this.beInitCmp();
		this.form = Ext.create('com.hh.base.BaseFormPanel', {
			items : this.getFormItems(),
			buttons : this.getFormButton()
		});
		var data = this.config.propertyGrid.getSource();
		this.data = data;
		FormPanel.setValues(this.form, data);
		this.add(this.form);
		this.afInitCmp();
	},
	title : '属性设置',
	width : 600,
	height : 400,
	modal : true,
	formItems : [],
	getFormItems : function() {
		var formItems = [ {
			fieldLabel : '名称',
			name : 'fieldLabel',
			maxLength : 32,
			columnWidth : 0.5
		}, {
			fieldLabel : '英文名称',
			name : 'name',
			maxLength : 32,
			allowBlank : false,
			columnWidth : 0.5,
			listeners : {
				'change' : function(field, newValue) {
					field.setValue(newValue);
				}
			}
		}, {
			fieldLabel : '列宽',
			xtype : 'numberfield',
			name : 'columnWidth',
			columnWidth : 0.5,
			maxValue : 1
		}, {
			fieldLabel : '高',
			xtype : 'numberfield',
			name : 'height',
			columnWidth : 0.5
		}, {
			fieldLabel : '最小长度',
			xtype : 'numberfield',
			name : 'minLength',
			columnWidth : 0.5
		}, {
			fieldLabel : '最大长度',
			xtype : 'numberfield',
			name : 'maxLength',
			columnWidth : 0.5
		} , {
			xtype : 'widgetRadioGroup',
			fieldLabel : '是否可为空',
			name : 'allowBlank',
			allowBlank : false,
			data : [ {
				"id" : 1,
				"text" : "是"
			}, {
				"id" : 0,
				"text" : "否"
			} ],
			value : 0
		}];

		for ( var i = 0; i < this.formItems.length; i++) {
			formItems.push(this.formItems[i]);
		}
		return formItems;
	},
	doSave : function() {
		var page = this;
		var values = page.form.getForm().getValues();
		Ext.apply(page.data, values);
		page.config.propertyGrid.setSource(page.data);
		var widget = Ext.getCmp(page.data["id<font color='red'>（只读）</font>"]);
		for ( var p in values) {
			if ('fieldLabel' == p) {
				widget.setFieldLabel(values[p]);
			} else if ('height' == p) {
				widget.setHeight(parseInt(values[p]));
			} else {
				widget[p] = values[p];
			}
		}
		page.config.canvasForm.doLayout();
		this.closePage();
	},
	getFormButton : function() {
		var page = this;
		return [ {
			iconCls : 'yes',
			text : '保    存',
			handler : function() {
				page.doSave();
			}
		}, {
			iconCls : 'cancel',
			text : '取    消',
			handler : function() {
				this.up('window').close();
			}
		} ];
	}
});