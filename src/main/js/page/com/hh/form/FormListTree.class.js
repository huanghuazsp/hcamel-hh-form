Ext.define('com.hh.form.FormListTree', {
	extend : 'com.hh.global.BaseSimpleTreePanel',
	title : '表单列表',
	query_action : 'form-FormTree-queryTreeList',
	editPage : 'com.hh.form.tree.FormTreeEdit',
	delete_action : 'form-FormWidget-deleteByIds',
	constructor : function(config) {
		this.config = config || {};
		this.superclass.constructor.call(this, this.config);
	}
});