Ext.define('com.hh.form.ColumnList', {
	extend : 'com.hh.global.SimpleGridPanelWindow',
	action : 'form-FormWidget-',
	title : '删除字段',
	width : 700,
	height : 400,
	modal : true,
	gridAction : 'queryColumnList',
	constructor : function(config) {
		this.config = config || {};
		this.superclass.constructor.call(this, this.config);
	},
	pkey : 'name',
	getTbarItems : function() {
		return [this.getToolbarItem("delete")];
	},
	getRightMenuItems : function() {
		var toolbarItems = [];
		toolbarItems.push(this.getToolbarItem("delete"));
		return toolbarItems;
	},
	getContainerRightMenuItems : function() {
		var toolbarItems = [];
		return toolbarItems;
	},
	getGridColumns : function() {
		return [{
					text : '表名',
					dataIndex : 'tableName',
					flex : 1
				}, {
					text : '中文名称',
					dataIndex : 'note',
					flex : 1
				}, {
					text : '列名',
					dataIndex : 'name',
					flex : 1
				}, {
					text : '类型',
					dataIndex : 'type',
					flex : 1
				}, {
					text : '长度',
					dataIndex : 'length',
					flex : 1
				}, {
					text : '是否在表单上',
					dataIndex : 'isInForm',
					flex : 1,
					renderer : function(value) {
						return value == 1 ? '是' : '<font color=red>否</font>';
					}
				}];
	},
	getStoreFields : function() {
		return ['tableName', 'name', 'type', 'length', 'isInForm', 'note'];
	},
	doDelete : function() {
		var panel = this;
		var url = panel.action + 'deleteColumnByIdsTabName';
		var grid = this.grid;
		var records = grid.getSelectionModel().getSelection();
		this.doBaseDelete(grid, records, url);
	},
	doBaseDelete : function(grid, records, url) {
		if (Util.isNull(records)) {
			ExtFrame.info("请选中要删除的数据！");
		} else {
			var strids = Util.recordsToStrByKey(records, this.pkey);
			var orgids = Util.recordsToStrByKey(records, "orgid");
			var createUsers = Util.recordsToStrByKey(records, "createUser");

			if (Util.isNull(strids)) {
				return;
			}
			var result = Ext.Msg
					.confirm(
							'请确认',
							'<span style="color:red"><b>提示:</b>您确认要删除信息吗？,请慎重...</span>',
							function(btn) {
								if (btn == 'yes') {
									Request.synRequestObject(url, {
												ids : strids,
												orgids : orgids,
												createUsers : createUsers,
												tableName : records[0]
														.get('tableName')
											});
									grid.getStore().load();
								}
							});
		}
	}
});