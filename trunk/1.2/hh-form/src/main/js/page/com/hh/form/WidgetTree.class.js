Ext.define('com.hh.form.WidgetTree', {
	extend : 'com.hh.global.BaseSimpleTreePanel',
	title : '控件列表',
	dragSources : {},
	width : 160,
	mouseenter_widget_id : '',
	baseWidgetParamMap : {},
	constructor : function(config) {
		this.config = config || {};
		this.superclass.constructor.call(this, this.config);
		this.getRightMenu();
	},
	loadBaseWidgetParamMap : function(records) {
		var page = this;
		for (var i = 0; i < records.length; i++) {
			var raw = records[i].raw;
			if (raw.widget_xtype) {
				var widgetParam = {};
				for (var p in raw) {
					if (p.indexOf('widget_') > -1) {
						widgetParam[p.replace('widget_', '')] = raw[p];
					}
				}
				page.baseWidgetParamMap[raw.widget_xtype] = widgetParam;
			}
			if (records[i].childNodes != null
					&& records[i].childNodes.length > 0) {
				page.loadBaseWidgetParamMap(records[i].childNodes);
			}
		}
	},
	getTreePanelListeners : function() {
		var page = this;
		return {
			beforeitemmouseenter : function(view, record, ele) {
				if (!page.dragSources[record.get('id')] && record.get('leaf')) {
					var widgetDragSource = new Ext.dd.DragSource(ele, {
								group : 'canvasForm'
							});
					page.dragSources[record.get('id')] = widgetDragSource;
					widgetDragSource.afterDragDrop = function(target, e, id) {
						var canvasForm = Ext.getCmp(page.config.canvasFormId);
						var widget = page.createWidget(record);// 创建UI元素
						canvasForm.add(widget);
						canvasForm.doLayout();
					}
				}
			},
			load : function(view, node, records) {
				page.baseWidgetParamMap = {};
				page.loadBaseWidgetParamMap(records);
			}
		};
	},
	getTbarItems : function() {
		return [this.getToolbarItem("expandAll"),
				this.getToolbarItem("collapseAll")];
	},
	query_action : 'system-ResourceFile-json?path=com/hh/form/widget-tree.json',
	getWidgetListeners : function(id_name) {
		var page = this;
		var canvasForm = Ext.getCmp(page.config.canvasFormId);
		return {
			render : function(p) {
				var widgetDragSource_1 = new Ext.dd.DragSource(p.getEl(), {
							group : 'canvasForm'
						});
				widgetDragSource_1.afterDragDrop = function(target, e, id) {
					var source_widget = Ext.getCmp(id_name);
					var target_widget = Ext.getCmp(page.mouseenter_widget_id);
					if (canvasForm.items == null) {
						return;
					}
					var items_ = canvasForm.items.items;
					var items = [];
					var is_add = false;
					for (var i = 0; i < items_.length; i++) {
						if (target_widget != null) {
							if (items_[i].id == target_widget.id) {
								is_add = true;
							}
						}
						if (is_add) {
							if (source_widget.id != items_[i].id) {
								items.push(items_[i]);
							}
						}
					}
					var javaScriptCode = 'canvasForm.add(source_widget';
					for (var i = 0; i < items.length; i++) {
						javaScriptCode += ',items[' + i + ']';
					}
					javaScriptCode += ')';
					eval('(' + javaScriptCode + ')');
				}
				p.getEl().on('contextmenu', function(e) {
							page.selectedWidget(id_name);
							page.rightMenu.showAt(e.getXY());
							page.rightMenu.doConstrain();
							e.stopEvent();
						});
				p.getEl().on('click', function() {
							page.selectedWidget(id_name);
						});
				//google 高版本不支持
				p.getEl().on('mouseenter', function() {
							page.mouseenter_widget_id = id_name;
						});
			}
		};
	},
	createWidget : function(record) {
		var page = this;
		var canvasForm = Ext.getCmp(page.config.canvasFormId);
		var id_name = UUID.getUUID(30);
		var object = {
			name : id_name,
			id : id_name,
			listeners : page.getWidgetListeners(id_name),
			formDesigner : true
		};
		var raw = record.raw;
		var widgetParam = {};
		for (var p in raw) {
			if (p.indexOf('widget_') > -1) {
				widgetParam[p.replace('widget_', '')] = raw[p];
			}
		}
		Ext.apply(object, widgetParam);
		var widget = Ext.widget(record.raw.widget_xtype, object);
		return widget;
	},
	getRightMenu : function() {
		var panel = this;
		this.rightMenu = Ext.create('Ext.menu.Menu', {
					items : panel.getRightMenuItems()
				});

		return this.rightMenu;
	},
	getRightMenuItems : function() {
		var toolbarItems = [];
		toolbarItems.push(this.getToolbarItem("delete"));
		toolbarItems.push(this.getToolbarItem("settings"));
		return toolbarItems;
	},
	getToolbarItem : function(type) {
		var panel = this;
		if (type == 'add') {
		} else if (type == 'delete') {
			return {
				iconCls : 'delete',
				text : '删除',
				handler : function() {
					panel.deleteWidgetById();
				}
			};
		} else if (type == 'settings') {
			return {
				icon : 'struts-image?path=com/hh/form/img/settings1_16x16.gif',
				text : '属性',
				handler : function() {
					panel.doOpenWidgetSettings();
				}
			};
		}
	},
	doOpenWidgetSettings : function() {
		var page = this;
		var propsGrid = Ext.getCmp(page.config.propertyGridId);
		var canvasForm = Ext.getCmp(page.config.canvasFormId);
		com.hh.form.WidgetTree.openWidgetSettings(canvasForm, propsGrid);
	},
	statics : {
		openWidgetSettings : function(canvasForm, propertyGrid) {
			var data = propertyGrid.getSource();
			var xtype = data["xtype<font color='red'>（只读）</font>"];
			var classjs = '';
			if ('widgetComboBoxTree' == xtype
					|| 'widgetComboBoxMultiTree' == xtype) {
				classjs = 'com.hh.form.property.ComboBoxTreeProperty';
			} else if ('widgetComboBox' == xtype) {
				classjs = 'com.hh.form.property.ComboBoxProperty';
			} else if ('widgetRadioGroup' == xtype) {
				classjs = 'com.hh.form.property.RadioGroupProperty';
			} else if ('widgetItemSelector' == xtype) {
				classjs = 'com.hh.form.property.ItemSelectorProperty';
			} else if ('widgetPageList' == xtype) {
				classjs = 'com.hh.form.property.SonTableProperty';
			} else {
				classjs = 'com.hh.form.property.BaseWidgetProperty';
			}

			ExtUtil.open(classjs, {
						propertyGrid : propertyGrid,
						canvasForm : canvasForm
					});
		}
	},
	deleteWidgetById : function() {
		var page = this;
		var propsGrid = Ext.getCmp(page.config.propertyGridId);
		var source = propsGrid.getSource();
		var canvasForm = Ext.getCmp(page.config.canvasFormId);
		var widget = Ext.getCmp(source["id<font color='red'>（只读）</font>"]);
		canvasForm.remove(widget);
	},
	getProObject : function(id_name) {
		var page = this;
		var widget_ = Ext.getCmp(id_name);
		var proObject = {
			"className<font color='red'>（只读）</font>" : widget_.$className,
			"id<font color='red'>（只读）</font>" : widget_.getId(),
			"xtype<font color='red'>（只读）</font>" : widget_.xtype,
			name : widget_.name
		};

		var baseWidgetParam = page.baseWidgetParamMap[widget_.xtype];
		for (var p in baseWidgetParam) {
			if(p!='xtype'){
				proObject[p] = widget_[p];
			}
		}

		return proObject;
	},
	selectedWidget : function(id_name) {
		var page = this;
		var proObject = page.getProObject(id_name);
		var propsGrid = Ext.getCmp(page.config.propertyGridId);
		propsGrid.setSource(proObject);
		return proObject;
	}
});