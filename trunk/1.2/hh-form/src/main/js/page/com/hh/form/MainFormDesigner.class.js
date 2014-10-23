$import(['com.hh.form.WidgetTree', 'com.hh.form.FormListTree',
		'com.hh.form.PropertyGridPanel', 'com.hh.form.actionform.PageListPanel']);
Ext.define('com.hh.form.MainFormDesigner', {
	extend : 'com.hh.base.BaseServicePanel',
	title : '表单设计',
	form_id : null,
	constructor : function(config) {
		this.config = config || {};
		this.superclass.constructor.call(this, this.config);
		var page = this;

		var canvasFormId = this.id + '_canvasForm';
		var propertyGridId = this.id + '_propertyGrid';

		var widgetTree = Ext.create('com.hh.form.WidgetTree', {
					disabled : true,
					canvasFormId : canvasFormId,
					propertyGridId : propertyGridId
				});

		this.widgetTree = widgetTree;

		var canvasForm = Ext.create('com.hh.base.BaseFormPanel', {
					title : '设计器',
					icon : 'struts-image?path=com/hh/form/img/computer2_16x16.gif',
					id : canvasFormId,
					buttons : null,
					listeners : {
						render : function(form) {
							var canvasFormDropTargetEl = form.getDragEl();
							var canvasFormDropTarget = new Ext.dd.DropTarget(
									canvasFormDropTargetEl, {
										group : 'canvasForm'
									});
						}
					}
				});

		this.canvasForm = canvasForm;

		var sourcePanel = Ext.create('Ext.panel.Panel', {
					icon : 'struts-image?path=com/hh/form/img/script_16x16.gif',
					autoScroll : true,
					title : '脚本'
				});

		this.sourcePanel = sourcePanel;

		var mainTab = Ext.create("com.hh.base.BaseTabPanel", {
					tbar : this.getToolbar(),
					bbar : this.getBbar(),
					disabled : true,
					padding : '1',
					region : 'center',
					listeners : {
						tabchange : function(this_tabPanel, newCard, oldCard) {
							if ('脚本' == newCard.title) {
								var source = page.getFormSource();
								sourcePanel.update(source.replace(/\,/g,
										',<br/>'));
							}
						}
					}
				});

		mainTab.add(canvasForm);
		mainTab.add(sourcePanel);
		mainTab.setActiveTab(canvasForm);

		var mainPanel = Ext.create('com.hh.base.BasePanel', {
					items : [widgetTree, mainTab]
				});

		var formListTree = Ext.create('com.hh.form.FormListTree', {
			getTreePanelListeners : function() {
				return {
					load : function() {
						widgetTree.setDisabled(true);
						mainTab.setDisabled(true);
					},
					itemclick : function(view, record) {
						widgetTree.setTitle('表单控件' + '<font color="red">（'
								+ record.get("text") + '）</font>');
						canvasForm.setTitle('设计器' + '<font color="red">（'
								+ record.get("text") + '）</font>');

						widgetTree.setDisabled(false);
						mainTab.setDisabled(false);
						page.dataId = record.get("id");
						var object = Request.synRequestObject(
								'form-FormWidget-findObjectByDataId', {
									dataId : page.dataId
								});
						canvasForm.removeAll();
						page.form_id = null;
						page.tableName.setValue(null);
						if (object) {
							page.packageName.setValue(object.packageName);
							page.form_id = object.id;
							page.tableName
									.setValue(object.tableName == null
											? ""
											: object.tableName.replace('FORM_',
													'') == null
													? ''
													: object.tableName.replace(
															'FORM_', ''));
							var form_items_list = Ext.decode(object.formSource);
							for (var i = 0; i < form_items_list.length; i++) {
								var return_widget_config = form_items_list[i];
								return_widget_config_id = UUID.getUUID(30);
								Ext.apply(return_widget_config, {
									id : return_widget_config_id,
									labelWidth : 70,
									listeners : page.widgetTree
											.getWidgetListeners(return_widget_config_id)
								});
								if (form_items_list[i].xtype == 'widgetItemSelector'
										|| form_items_list[i].xtype == 'widgetRadioGroup'
										|| form_items_list[i].xtype == 'widgetDateField'
										|| form_items_list[i].xtype == 'widgetPageList') {
									Ext.apply(return_widget_config, {
												formDesigner : true
											});
								}
								var add_widget = Ext.widget(
										form_items_list[i].xtype,
										return_widget_config)
								canvasForm.add(add_widget);
							}
						}
					}
				};
			}
		});

		var eastpanel = Ext.create('com.hh.form.PropertyGridPanel', {
					propertyHeight : this.height / 2,
					propertyGridId : propertyGridId,
					canvasForm : canvasForm
				});

		this.add(formListTree);
		this.add(mainPanel);
		this.add(eastpanel);
	},
	getToolBarByType : function(type) {
		var page = this;
		if (type == 'preview') {
			return {
				icon : 'struts-image?path=com/hh/form/img/search.gif',
				text : '预览',
				handler : function() {
					if (page.canvasForm.items == null) {
						return;
					}
					var items = page.canvasForm.items.items;
					var proObjectList = [];
					for (var i = 0; i < items.length; i++) {
						if ('Ext.ux.form.MultiSelect' != items[i].$className) {
							var proObject = page.widgetTree
									.getProObject(items[i].id);
							proObject.xtype = proObject["xtype<font color='red'>（只读）</font>"];
							proObjectList.push(proObject);
						}
					}
					var form = Ext.create('com.hh.base.BaseFormPanel', {
								buttons : null,
								items : proObjectList
							});
					var panel = Ext.create('com.hh.base.BaseServicePanel', {
								title : '预览',
								width : Browser.getWidth() - 500,
								height : Browser.getHeight()
										- 120,
								modal : true,
								items : form
							});
					ExtUtil.openPanel(panel);
				}
			};
		} else if (type == "save") {
			var page = this;
			return {
				iconCls : 'save_',
				text : '保存',
				handler : function() {
					var object = Request.synRequestObject(
							'form-FormWidget-save', {
								tableName : 'FORM_' + page.tableName.getValue(),
								packageName : page.packageName.getValue(),
								deleteTable : page.bjg.getValue()[page.bjg
										.getName()],
								formSource : page.getFormSource(),
								dataId : page.dataId,
								id : page.form_id
							});
					if (object.object != null) {
						page.form_id = object.object.id;
					}

				}
			};
		} else if (type == "deleteColumn") {
			return {
				icon : 'struts-image?path=com/hh/form/img/table_delete.png',
				text : '删除字段',
				handler : function() {
					Desktop.openWindow('com.hh.form.ColumnList', {
								extraParams : {
									tableName : 'FORM_'
											+ page.tableName.getValue(),
									formSource : page.getFormSource(),
									dataId : page.dataId,
									id : page.form_id
								},
								addWindow : false
							});
				}
			};
		}
	},
	getBbarItems : function() {
		var bjg = this.bjg = Ext.create('com.hh.global.widget.RadioGroup', {
					xtype : "widgetRadioGroup",
					name : "bjg",
					columnWidth : null,
					columns : null,
					fieldLabel : "表结构",
					labelWidth : 40,
					width : 150,
					value : 0,
					data : [{
								id : 1,
								text : '重建'
							}, {
								id : 0,
								text : '修改'
							}]
				});
		this.packageName = Ext.create('Ext.form.field.Text', {
					fieldLabel : '包',
					labelWidth : 20,
					value : 'com.hh.form',
					width : 100
				});
		return [bjg, this.getToolBarByType('deleteColumn')/*
															 * ,
															 * this.packageName,
															 * this.getToolBarByType('source_code')
															 */];
	},
	getToolBarItems : function() {
		var qianzui = Ext.create('Ext.form.field.Text', {
					fieldLabel : '数据库表名称',
					labelWidth : 85,
					width : 140,
					value : 'FORM_'
				});
		this.tableName = Ext.create('Ext.form.field.Text', {
					width : 100
				});
		return [this.getToolBarByType('preview'), qianzui, this.tableName,
				this.getToolBarByType('save')];
	},
	getBbar : function() {
		return Ext.create('com.hh.base.BaseToolbar', {
					enableOverflow : true,
					items : this.getBbarItems()
				});
	},
	getToolbar : function() {
		return Ext.create('com.hh.base.BaseToolbar', {
					enableOverflow : true,
					items : this.getToolBarItems()
				});
	},
	getFormSource : function() {
		if (this.canvasForm.items == null) {
			return;
		}
		var items = this.canvasForm.items.items;
		var proObjectList = [];

		for (var i = 0; i < items.length; i++) {
			if ('Ext.ux.form.MultiSelect' != items[i].$className) {
				var proObject = this.widgetTree.getProObject(items[i].id);
				delete proObject["id<font color='red'>（只读）</font>"];
				delete proObject["className<font color='red'>（只读）</font>"];
				if (proObject.minLength == 0) {
					delete proObject.minLength;
				}
				proObjectList.push(proObject);
			}
		}
		return Json.objTostr(proObjectList).replace(
				/\<font color='red'>（只读）<\/font>/g, '');
	}
});