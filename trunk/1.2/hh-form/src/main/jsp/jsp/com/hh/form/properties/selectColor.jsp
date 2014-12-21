<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>颜色控件</title>
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
		</table>
	</form>
</body>
</html>