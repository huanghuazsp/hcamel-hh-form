<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>子结构</title>
<%=BaseSystemUtil.getBaseJs("checkform")+BaseSystemUtil.getKey("form")%>
<script type="text/javascript">
	
</script>
</head>
<body>
	<form id="form" xtype="form">
		<table xtype="form">
			<tr>
				<td xtype="label">名称：</td>
				<td><span xtype="text" config=" name : 'name',required :true"></span></td>
				<td xtype="label">中文名称：</td>
				<td><span xtype="text" config=" name : 'textfield' "></span></td>
			</tr>
			<tr>
				<td xtype="label">子结构：</td>
				<td colspan="3"><span xtype="selectTree" 
					config="name: 'formId' , noCheckParent : true ,  tableName : 'HH_CK_FORM_TREE' , url : 'form-SysFormTree-queryTreeList'"></span>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>