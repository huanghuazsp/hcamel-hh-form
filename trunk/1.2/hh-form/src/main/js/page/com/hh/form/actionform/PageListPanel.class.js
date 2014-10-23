Ext.define('com.hh.form.actionform.PageListPanel', {
	extend : 'Ext.form.FieldContainer',
	mixins : {
		bindable : 'Ext.util.Bindable',
		field : 'Ext.form.field.Field'
	},
	alias : 'widget.widgetPageList',
	layout : 'fit',
	constructor : function(config) {
		this.config = config || {};
		var me = this;
		if (this.config.formDesigner) {
			this.config.border = 1;
			this.config.style = {
				borderColor : '#000000',
				borderStyle : 'solid',
				borderWidth : '1px'
			};
			me.html = '<font color=red>我是子表</font>';
		}

		this.superclass.constructor.call(this, this.config);

		if (this.config.formDesigner) {
			return;
		} else {
			this.fieldLabel = null;
		}
		this.init();
	},
	fields : [ 'key', 'value' ],
	getGridStore : function() {
		var me = this;
		return Ext.create('Ext.data.Store', {
			fields : me.fields,
			data : {
				'items' : me.config.value
			},
			proxy : {
				type : 'memory',
				reader : {
					type : 'json',
					root : 'items'
				}
			}
		});
	},
	gridColumns : [ {
		header : '键',
		dataIndex : 'key',
		flex : 1
	}, {
		header : '值',
		dataIndex : 'value',
		flex : 1
	} ],
	getGridColumns : function() {
		return this.gridColumns;
	},
	init : function() {
		var me = this;

		var hhXtForm = Request.synRequestObject(
				"form-FormWidget-findObjectByDataId", {
					dataId : me.config.formDataId
				});

		this.hhXtForm = hhXtForm;
		var formWidgetList = [];
		if (hhXtForm != null) {
			formWidgetList = Ext.decode(hhXtForm.formSource);
		}
		var fields = [];
		var gridColumnsList = [];
		gridColumnsList.push({
			text : 'id',
			dataIndex : 'id',
			hidden : true,
			flex : 1
		});
		fields.push("id");
		for ( var i = 0; i < formWidgetList.length; i++) {
			var formWidget = formWidgetList[i];
			fields.push(formWidget.name);

			var gridColumns = {
				text : formWidget.fieldLabel,
				dataIndex : formWidget.name,
				flex : 1
			};


			gridColumnsList.push(gridColumns);
		}

		this.gridColumns = gridColumnsList;
		this.fields = fields;

		var gridStore = this.store = me.getGridStore();
		var grid = this.grid = Ext.create('Ext.grid.Panel', {
			plugins : Ext.create('Ext.grid.plugin.CellEditing'),
			store : gridStore,
			border : true,
			title : me.config.fieldLabel,
			columns : me.getGridColumns(),
			tbar : me.getToolbar(),
			selModel : Ext.create('Ext.selection.CheckboxModel')
		});
		me.add(grid);
	},
	getToolbarItem : function(type) {
		var panel = this;
		if (type == 'add') {
			return {
				iconCls : 'add',
				text : '添加',
				handler : function() {
					panel.doAdd();
				}
			};
		} else if (type == 'delete') {
			return {
				iconCls : 'delete',
				text : '删除',
				handler : function() {
					panel.doDelete();
				}
			};
		} else if (type == 'update') {
			return {
				iconCls : 'update',
				text : '编辑',
				handler : function() {
					panel.doUpdate();
				}
			};
		}
	},
	getTbarItems : function() {
		return [ this.getToolbarItem("add"), '-',
				this.getToolbarItem("update"), '-',
				this.getToolbarItem("delete") ];
	},
	getToolbar : function() {
		var panel = this;
		return Ext.create('com.hh.base.BaseToolbar', {
			items : panel.getTbarItems()
		});
	},
	doAdd : function() {
		var editPageUrl = 'com.hh.form.actionform.PageEditPanel';
		var page = this;
		ExtUtil.open(editPageUrl, {
			parentPanel : this,
			callbackRefresh : function() {
				page.store.load();
			}
		});
	},
	doDelete : function() {
		var grid = this.grid;
		var records = grid.getSelectionModel().getSelection();
		grid.getStore().remove(records);
	},
	doUpdate : function() {
		var page = this;
		var editPageUrl = 'com.hh.form.actionform.PageEditPanel';
		var record = this.grid.getSelectionModel().getSelection();
		if (Util.isNull(record)) {
			ExtFrame.info('请选中要编辑的数据！');
		} else {
			ExtUtil.open(editPageUrl, {
				parentPanel : this,
				parentRecord : record[0],
				callbackRefresh : function() {
					page.store.load();
				}
			});
		}
	},
	getValue : function() {
		var objectList = [];
		if (this.grid != null) {
			this.grid.getStore().each(function(record) {
				objectList.push(record.data);
			});
		}
		return Ext.encode(objectList);
	},
	setValue : function(value) {
		this.grid.getStore().removeAll();
		if (!Util.isNull(value)) {
			var objectList = Ext.decode(value);
			for ( var i = 0; i < objectList.length; i++) {
				this.grid.getStore().add(objectList[i]);
			}
		}
	},
	getSubmitData : function() {
		var object = {};
		object[this.getName()] = this.getValue();
		return object;
	}
});