Ext.define('com.hh.form.actionform.PageList', {
	extend : 'com.hh.global.SimpleGridPanelWindow',
	action : 'form-ActionForm-',
	editPage : 'com.hh.form.actionform.PageEdit',
	gridAction : 'queryPagingDataByTableName',
	constructor : function(config) {
		this.config = config || {};
		var form_data_id = this.config.id.substr(this.config.id.length - 36);
		var hhXtForm = Request.synRequestObject(
				"form-FormWidget-findObjectByDataId", {
					dataId : form_data_id
				});

		this.hhXtForm = hhXtForm;

		this.extraParams = {
			tableName : hhXtForm.tableName,
			dataId : hhXtForm.dataId
		};

		var formWidgetList = Ext.decode(hhXtForm.formSource);

		var fields = [];
		var gridColumnsList = [];
		gridColumnsList.push({
					text : 'id',
					dataIndex : 'id',
					hidden : true,
					flex : 1
				});
		fields.push("id");
		for (var i = 0; i < formWidgetList.length; i++) {
			var formWidget = formWidgetList[i];
			fields.push(formWidget.name);

			var gridColumns = {
				text : formWidget.fieldLabel,
				dataIndex : formWidget.name,
				flex : 1
			};

			if (formWidget.xtype == 'datefield'
					|| formWidget.xtype == 'widgetDateField'
					|| formWidget.xtype == 'widgetDateTimer') {
				Ext.apply(gridColumns, {
							renderer : Ext.util.Format
									.dateRenderer('Y年m月d日 H时i分s秒')
						});
			}

			gridColumnsList.push(gridColumns);
		}

		gridColumnsList.push(this.getOperateGridColumn());

		this.gridColumnsList = gridColumnsList;
		this.fields = fields;
		this.superclass.constructor.call(this, this.config);
	},
	doSearch : function() {
		var params = {};
		if (this.searchPabnel != null) {
			var items = this.searchPabnel.getForm().items;
			for (var i = 0; i < items.length; i++) {
				params[items[i].name] = this.searchPabnel.getForm()
						.findField(items[i].name).getValue();
			}
		}
		params['keywords'] = this.fieldkeywords.getValue();
		Ext.apply(this.grid.getStore().proxy.extraParams, params);
		this.grid.getStore().load();
	},
	getTbarItems : function() {
		this.fieldkeywords = Ext.create('Ext.form.field.Text', {
					labelWidth : 40,
					fieldLabel : '搜索',
					name : 'keywords',
					width : 200
				});
		return [this.getToolbarItem("add"), '-', this.getToolbarItem("update"),
				'-', this.getToolbarItem("delete"), '->', this.fieldkeywords,
				this.getToolbarItem("search")];
	},
	getGridColumns : function() {
		return this.gridColumnsList;
	},
	getStoreFields : function() {
		return this.fields;
	},
	doDelete : function() {
		var panel = this;
		var records = this.grid.getSelectionModel().getSelection();
		if (Util.isNull(records)) {
			ExtFrame.info("请选中要删除的数据！");
		} else {
			var strids = Util.recordsToStrByKey(records, "id");
			if (Util.isNull(strids)) {
				return;
			}
			var result = Ext.Msg
					.confirm(
							'请确认',
							'<span style="color:red"><b>提示:</b>您确认要删除信息吗？,请慎重...</span>',
							function(btn) {
								if (btn == 'yes') {
									Request.synRequestObject(
											'form-ActionForm-deleteByIds', {
												ids : strids,
												tableName : panel.hhXtForm.tableName
											});
									panel.grid.getStore().load();
								}
							});
		}
	},
	doOperateDelete : function(record) {
		var panel = this;
		var result = Ext.Msg.confirm('请确认',
				'<span style="color:red"><b>提示:</b>您确认要删除信息吗？,请慎重...</span>',
				function(btn) {
					if (btn == 'yes') {
						Request.synRequestObject('form-ActionForm-deleteByIds',
								{
									ids : record.get('id'),
									tableName : panel.hhXtForm.tableName
								});
						panel.grid.getStore().load();
					}
				});
	}
});