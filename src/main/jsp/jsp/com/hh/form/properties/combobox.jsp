<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>下拉框</title>
<%=BaseSystemUtil.getBaseJs("checkform")%>
<script type="text/javascript">
	var params = BaseUtil.getIframeParams();
	function setValues(config) {
		$('#form').renderAll();
		$('#form').setValue(config);
	}
	function getValues() {
		if ($("#form").validationEngine('validate')) {
			return $("#form").getValue()
		} else {
			Dialog.errormsg("验证失败！！");
			return null;
		}
	}

	var tableitemConfig = {
		name : 'data',
		required : true,
		valueType:'object',
		trhtml : '<tr><td xtype="label">提交值：</td><td><span xtype="text" valuekey="id" config=" required :true"></span></td>'
		+'<td xtype="label">显示值：</td><td><span xtype="text" valuekey="text" config=" required :true"></span></td></tr>'
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
				<td><span xtype="text" config=" name : 'text' "></span></td>
			</tr>
			<tr>
				<td xtype="label">必填：</td>
				<td colspan="3"><span xtype="check" config=" name : 'required'  "></span></td>
			</tr>
			<tr>
				<td xtype="label">选择项：</td>
				<td colspan="3"><span xtype="tableitem" configVar="tableitemConfig"></span></td>
			</tr>
		</table>
	</form>
</body>
</html>