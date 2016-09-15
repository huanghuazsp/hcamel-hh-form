<%@page import="com.hh.system.util.PrimaryKey"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<%=BaseSystemUtil.getBaseJs("layout", "ztree", "ztree_edit",
					"ckeditor")%>
<script type="text/javascript">
	<%String workflowiframeId =  PrimaryKey.getUUID();%>
	var iframeId = '<%=workflowiframeId%>';
	var selectTreeNode = {};
	var eventList = [];

	function addFormType() {
		var selectNode = $.hh.tree.getSelectNode('formTree');
		Dialog.open({
			url : 'jsp-form-forminfo-edit',
			params : {
				selectNode : selectNode,
				callback : function() {
					$.hh.tree.refresh('formTree');
				}
			}
		});
	}
	function remove(treeNode) {
		Dialog.confirm({
			message : '您确认要删除数据吗？',
			yes : function(result) {
				Request.request('form-FormInfo-deleteTreeByIds', {
					data : {
						ids : treeNode.id
					},
					callback : function(result) {
						if (result.success!=false) {
							$.hh.tree.refresh('formTree');
						}
					}
				});
			}
		});
	}
	function edit(treeNode) {
		Dialog.open({
			url : 'jsp-form-forminfo-edit',
			params : {
				id : treeNode.id,
				callback : function() {
					$.hh.tree.refresh('formTree');
				}
			}
		});
	}

	function formTreeClick(treeNode) {
		if (treeNode.leaf == 1) {
			$('#formdivspan').html('（' + treeNode.text + '）');
			$("#formdiv").undisabled();
			selectTreeNode = treeNode;
			window.frames[iframeId].setData({
				text:selectTreeNode.text,
				html:selectTreeNode.html,
				eventList:selectTreeNode.eventList
			});
		}
	}
	function updateHtml(data) {
		data.id=selectTreeNode.id;
		Request.request('form-FormInfo-updateHtml', {
			data : data
		}, function(result) {
			if (result.success!=false) {
				selectTreeNode.html = data.html;
				selectTreeNode.eventList = data.eventList;
				$.hh.tree.updateNode('formTree', selectTreeNode);
				$.hh.tree.getTree('formTree').refresh();
			}
		});
	}

	function init() {
	}
</script>
<style>
.ui-menu {
	width: 100%;
}
</style>
</head>
<body>
	<div xtype="border_layout">
		<div config="render : 'west'">
			<div xtype="toolbar" config="type:'head'">
				<span xtype="button" config="onClick:addFormType,text:'添加'"></span>
				<span xtype="button"
					config="onClick : $.hh.tree.refresh,text : '刷新' ,params: 'formTree' "></span>
			</div>
			<span xtype="tree"
				config=" id:'formTree' , url:'form-FormInfo-queryTreeList' , remove : remove , edit : edit, onClick : formTreeClick"></span>
		</div>
		<div id="formdiv"  style="overflow: visible;">
			<iframe id="<%=workflowiframeId%>" name="<%=workflowiframeId%>" width=100%
					height=100% frameborder=0 
					src="jsp-form-ckeditor-editor"></iframe>
		</div>
	</div>
</body>
</html>