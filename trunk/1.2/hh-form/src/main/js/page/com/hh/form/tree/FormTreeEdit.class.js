Ext.define('com.hh.form.tree.FormTreeEdit', {
	extend : 'com.hh.global.SimpleFormPanelWindow',
	action : 'form-FormTree-',
	submitMethod : 'saveTree',
	title : '编辑',
	width : 600,
	height : 300,
	typeHidden : true,
	constructor : function(config) {
		this.config = config || {};
		this.superclass.constructor.call(this, this.config);
	},
	getFormItems : function() {
		var page = this;
		var record = page.config.selectRecord;
		var type = '';
		var pid = 'root';
		if (record && page.config.addType != 'root') {
			pid = record.raw.id;
		}
		return [{
					fieldLabel : 'ID',
					name : 'id',
					hidden : true
				}, {
					fieldLabel : '名称',
					name : 'text',
					maxLength : 32,
					columnWidth : 0.5
				}, {
					name : 'icon',
					xtype : 'widgetComboBoxTree',
					fieldLabel : '小图标',
					allowBlank : true,
					hidden : true,
					columnWidth : 0.5,
					action : 'system-ResourceFile-queryIconFilePathList',
					extraParams : {
						path : "/hhcommon/images"
					},
					selectType : 'img',
					select : 'leaf'
				}, {
					xtype : 'widgetRadioGroup',
					fieldLabel : '是否叶子',
					name : 'leaf',
					allowBlank : false,
					data : [{
								"id" : 1,
								"text" : "是"
							}, {
								"id" : 0,
								"text" : "否"
							}],
					value : 0,
					columnWidth : 0.5
				}, {
					xtype : 'widgetRadioGroup',
					fieldLabel : '是否展开',
					allowBlank : false,
					name : 'expanded',
					data : [{
								"id" : 1,
								"text" : "是"
							}, {
								"id" : 0,
								"text" : "否"
							}],
					value : 0,
					columnWidth : 0.5
				}, {
					xtype : "widgetComboBoxTree",
					name : "node",
					columnWidth : 0.5,
					defaultSubmitValue : 'root',
					fieldLabel : "父节点",
					extraParams : {isNoLeaf:true},
					action : "form-FormTree-queryTreeList",
					value : pid
				}];
	}
});