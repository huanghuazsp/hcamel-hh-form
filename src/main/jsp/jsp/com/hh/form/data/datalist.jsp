<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<%=BaseSystemUtil.getBaseJs("layout", "ztree", "ztree_edit")%>
<script type="text/javascript">
	var typeTreeObject = null;
	var dataTreeObject = null;

	var selectTypeNode = null;

	function init() {
		typeTreeObject = $('#typeTreeSpan').getWidget();
		dataTreeObject = $('#dataTreeSpan').getWidget();
		$("#datacenter").disabled('请选择字典类别！');
	}

	function addType() {
		var selectNode = typeTreeObject.getSelectNode();
		Dialog.open({
			url : 'jsp-form-data-datatypeedit',
			params : {
				selectNode : selectNode,
				callback : function() {
					typeTreeObject.refresh();
				}
			}
		});
	}
	function editType(treeNode) {
		Dialog.open({
			url : 'jsp-form-data-datatypeedit',
			params : {
				treeNode : treeNode,
				callback : function() {
					typeTreeObject.refresh();
				}
			}
		});
	}
	function removeType(treeNode) {
		$.hh.tree.deleteData({
			pageid : 'typeTree',
			action : 'form-FormDataType-deleteTreeByIds',
			id : treeNode.id
		});
	}

	function typeTreeClick( treeNode) {
		if (treeNode.leaf == 1) {
			selectTypeNode = treeNode;
			$('#msgspan').html(selectTypeNode.text);
			$("#datacenter").undisabled();
			$.hh.tree.loadData('dataTree', {
				params : {
					dataTypeId : treeNode.code
				}
			});
		}
	}

	function addData() {
		var selectNode = dataTreeObject.getSelectNode();
		Dialog.open({
			url : 'jsp-form-data-dataedit',
			params : {
				selectNode : selectNode,
				selectTypeNode : selectTypeNode,
				callback : function() {
					dataTreeObject.refresh();
				}
			}
		});
	}

	function editData(treeNode) {
		Dialog.open({
			url : 'jsp-form-data-dataedit',
			params : {
				treeNode : treeNode,
				selectTypeNode : selectTypeNode,
				callback : function() {
					dataTreeObject.refresh();
				}
			}
		});
	}
	function removeData(treeNode) {
		$.hh.tree.deleteData({
			pageid : 'dataTree',
			action : 'form-FormData-deleteTreeByIds',
			id : treeNode.id
		});
	}
</script>
</head>
<body>
	<div xtype="border_layout">
		<div config="render : 'west' ,width:'50%' ">
			<div xtype="toolbar" config="type:'head'">
				<span xtype="button" config="onClick:addType,text:'添加'"></span>
				<span xtype="button"
					config="onClick : function(){typeTreeObject.refresh()},text : '刷新'"></span>
			</div>
			<span id="typeTreeSpan" xtype="tree"
				config=" id:'typeTree' , url:'form-FormDataType-queryTreeList' , remove : removeType , edit : editType , onClick : typeTreeClick"></span>
		</div>
		<div id="datacenter">
			<div xtype="toolbar" config="type:'head'">
				<span xtype="button" config="onClick:addData,text:'添加'"></span>
				<span xtype="button"
					config="onClick : function(){dataTreeObject.refresh()} ,text: '刷新'"></span>
					&nbsp;<span id="msgspan" style="color:red;" ></span>
			</div>
			<span id="dataTreeSpan" xtype="tree"
				config=" id:'dataTree' , url:'form-FormData-queryTreeList' , remove : removeData , edit : editData "></span>
		</div>
	</div>
</body>
</html>