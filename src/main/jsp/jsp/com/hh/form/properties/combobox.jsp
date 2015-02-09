<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>下拉框</title>
<%=BaseSystemUtil.getBaseJs("checkform")
					+ BaseSystemUtil.getKey("form")%>
<script type="text/javascript">
	function dataitemChange(value) {
		$('#span_url').setValue('form-FormData-queryTreeList?dataTypeId='+value.id);
	}
	var dataitemConfig = {
		onChange : dataitemChange,
		noCheckParent : true,
		name : 'dataitem',
		findTextAction : 'form-FormDataType-findObjectById',
		url : 'form-FormDataType-queryTreeList'
	}
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
				<td xtype="label">必填：</td>
				<td colspan="3"><span xtype="check"
					config=" name : 'required'  "></span></td>
			</tr>
			<tr>
				<td xtype="label">数据字典：</td>
				<td colspan="3"><span xtype="tableitem"
					configVar="tableitemConfig"></span></td>
			</tr>
			<tr>
				<td xtype="label">地址：</td>
				<td colspan="3"><span xtype="text" config=" name : 'url' "></span></td>
			</tr>
			<tr>
				<td xtype="label">字典项：</td>
				<td colspan="3"><span xtype="selectTree" configVar="dataitemConfig"></span></td>
			</tr>
		</table>
	</form>
</body>
</html>