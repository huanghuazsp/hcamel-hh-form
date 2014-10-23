$import('com.hh.form.actionform.PageListPanel');
Ext
		.define(
				'com.hh.form.actionform.PageEdit',
				{
					extend : 'com.hh.global.SimpleFormPanelWindow',
					action : 'form-ActionForm-',
					title : '编辑',
					width : 700,
					height : 400,
					entityKey : 'id',
					constructor : function(config) {
						this.config = config || {};
						this.superclass.constructor.call(this, this.config);
					},
					loadData : function(id) {
						var page = this;
						var hhXtForm = this.config.parentPanel.hhXtForm;
						Request.request(this.action + this.editAction, {
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
					}
				});