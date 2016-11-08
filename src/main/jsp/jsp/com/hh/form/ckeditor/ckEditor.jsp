<%@page import="com.hh.system.util.pk.PrimaryKey"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<%=BaseSystemUtil.getBaseJs("layout", "ztree", "ztree_edit")%>
<script type="text/javascript">
	<%String workflowiframeId =  PrimaryKey.getUUID();%>
	var iframeId = '<%=workflowiframeId%>';
	var selectTreeNode = {};
	var eventList = [];

	function addFormType() {
		var selectNode = $.hh.tree.getSelectNode('formTree');
		Dialog.open({
			url : 'jsp-form-ckeditor-formtreeedit',
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
				Request.request('form-SysFormTree-deleteTreeByIds', {
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
			url : 'jsp-form-ckeditor-formtreeedit',
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
		Request.request('form-SysFormTree-updateHtml', {
			data : data
		}, function(result) {
			if (result.success!=false) {
				selectTreeNode.html = data.html;
				$.hh.tree.updateNode('formTree', selectTreeNode);
				$.hh.tree.getTree('formTree').refresh();
			}
		});
	}

	function init() {
		$('#'+iframeId).attr('src','jsp-form-ckeditor-ueditor');
	}
	function querytree(){
		$('#span_formTree').loadData({
			params : {text:$('#span_treeText').getValue()}
		});
	}
</script>
</head>
<body>
	<div xtype="border_layout">
		<div config="render : 'west'" style="overflow :hidden; ">
			<div xtype="toolbar" config="type:'head'">
				<span xtype="button" config="onClick:addFormType,text:'添加'"></span>
				<span xtype="text" config=" name : 'treeText' ,width:90 ,enter: querytree"></span>
				<span xtype="button" config=" icon :'hh_img_query' , onClick : querytree "></span>
			</div>
			<span xtype="tree"
				config=" id:'formTree' , url:'form-SysFormTree-queryList' , remove : remove , edit : edit, onClick : formTreeClick,nheight:42 "></span>
		</div>
		<div id="formdiv"  style="overflow: visible;">
			<iframe id="<%=workflowiframeId%>" name="<%=workflowiframeId%>" width=100%
					height=100% frameborder=0 
					src=""></iframe>
		</div>
	</div>
</body>
</html>