Ext.define('com.hh.form.actionform.PageEditPanel', {
	extend : 'com.hh.global.SimpleFormPanelWindow',
	title : '编辑',
	width : 700,
	height : 400,
	entityKey : 'id',
	constructor : function(config) {
		this.config = config || {};
		this.superclass.constructor.call(this, this.config);
	},
	loadData : function(id) {
		var hhXtForm = this.config.parentPanel.hhXtForm;
		var page = this;
		this.object = Request.request(this.action + this.editAction, {
			id : id,
			tableName : hhXtForm.tableName
		}, function(object) {
			page.object = object;
			FormPanel.setValues(page.form, page.object);
			page.afDataLoad();
		});
	},
	getFormItems : function() {
		var hhXtForm = this.config.parentPanel.hhXtForm;
		var formWidgetList = Ext.decode(hhXtForm.formSource);
		formWidgetList.push({
			name : 'id',
			hidden : true
		});
		formWidgetList.push({
			fieldLabel : 'dataId',
			name : 'dataId',
			hidden : true,
			value : hhXtForm.dataId
		});
		return formWidgetList;
	},
	submitForm : function() {
		var data = this.form.getForm().getValues();

		if (Util.isNull(data.id)) {
			data.id = UUID.getUUID();
		}

		this.config.parentPanel.grid.getStore()
				.remove(this.config.parentRecord);
		this.config.parentPanel.grid.getStore().add(data);
		if (this.up('window') != null) {
			this.up('window').close();
		} else {
			this.close();
		}
	},
	getBtns : function() {
		return [ this.getBtnByType("save"), this.getBtnByType("cancel") ];
	},
	loadData : function(id, parentRecord) {
		FormPanel.setValues(this.form, parentRecord.data);
	}
});