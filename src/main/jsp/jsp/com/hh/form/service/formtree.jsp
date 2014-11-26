<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<%=BaseSystemUtil.getBaseJs("layout", "ztree", "ztree_edit")%>
<script type="text/javascript">
	function formTreeClick(treeNode) {
		if (treeNode.leaf == 1) {
			$('#startserviceiframe').attr('src',
					'jsp-form-service-formlist?databaseType=relation&formId=' + treeNode.id);
		}
	}
	function init() {
	}
</script>
</head>
<body>
	<div xtype="border_layout">
		<div config="render : 'west'">
			<div xtype="toolbar" config="type:'head'">
				<span xtype="button"
					config="onClick : TreeUtil.refresh,text : '刷新' ,params: 'formTree' "></span>
			</div>
			<span xtype="tree"
				config=" id:'formTree' , url:'form-CkFormTree-queryTreeList' , onClick : formTreeClick"></span>
		</div>
		<div id="formdiv"  style="overflow: visible;">
			<iframe id="startserviceiframe" name="startserviceiframe" width=100%
				height=100% frameborder=0
				src="jsp-system-tools-messagepage?text=请选择表单！！"></iframe>
		</div>
	</div>
</body>
</html>