$import('com.hh.form.property.BaseProperty');
Ext.define('com.hh.form.property.BaseWidgetProperty', {
	extend : 'com.hh.form.property.BaseProperty',
	constructor : function(config) {
		this.config = config || {};
		this.superclass.constructor.call(this, this.config);
	}
});