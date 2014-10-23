Ext.define('com.hh.form.PropertyGridPanel', {
	extend : 'com.hh.base.BasePanel',
	title : null,
	region : 'east',
	width : 300,
	constructor : function(config) {
		this.config = config || {};
		this.superclass.constructor.call(this, this.config);
		var page = this;
		var propertyGrid = Ext.create('Ext.grid.property.Grid', {
			id : this.config.propertyGridId,
			title : '基本属性',
			tbar : this.getToolbar(),
			region : 'center',
			height : this.config.propertyHeight,
			padding : '1',
			source : {},
			listeners : {
				propertychange : function(source, recordId, value, oldValue,
						eOpts) {
					var widget_id = source["id<font color='red'>（只读）</font>"];

					if (recordId == "id<font color='red'>（只读）</font>") {
						widget_id = oldValue;
					}
					var widget = Ext.getCmp(widget_id);
					if (recordId.indexOf("（只读）") < 0) {
						if ('fieldLabel' == recordId) {
							widget.setFieldLabel(value);
						} else {
							if (recordId == 'name') {
								widget[recordId] = value;
								source.name = value;
								propertyGrid.setSource(source);
							} else {
								widget[recordId] = value;
							}
						}
					} else {
						source[recordId] = oldValue;
						propertyGrid.setSource(source);
					}
					page.config.canvasForm.doLayout();
				}
			}
		});

		this.propertyGrid = propertyGrid;

		this.add(propertyGrid);
	},
	getTbarItems : function() {
		return [ this.getToolbarItem("getValues") ];
	},
	getToolbar : function() {
		var panel = this;
		return Ext.create('com.hh.base.BaseToolbar', {
			items : panel.getTbarItems()
		});
	},
	getToolbarItem : function(type) {
		var panel = this;
		if (type == 'getValues') {
			return {
				icon : 'struts-image?path=com/hh/form/img/settings1_16x16.gif',
				text : '设置属性',
				handler : function() {
					panel.doSetProperty();
				}
			};
		}
	},
	doSetProperty : function() {
		com.hh.form.WidgetTree.openWidgetSettings(this.config.canvasForm,
				this.propertyGrid);
	}
});