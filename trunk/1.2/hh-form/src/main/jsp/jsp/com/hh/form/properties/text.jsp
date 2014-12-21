<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>文本框</title>
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
				<td ><span xtype="text" config=" name : 'name',required :true"></span></td>
				<td xtype="label">中文名称：</td>
				<td><span xtype="text" config=" name : 'textfield' "></span></td>
			</tr>
			<tr>
			<td xtype="label">宽度：</td>
				<td colspan="3" ><span xtype="text" config=" name : 'width' ,number : true "></span></td>
			</tr>
			<tr>
				<td xtype="label">必填：</td>
				<td><span xtype="check" config=" name : 'required'  "></span>
				</td>
				<td xtype="label">长度：</td>
				<td><span xtype="text" config=" name : 'minSize' ,number : true ,width:50"></span>
				~
				<span xtype="text" config=" name : 'maxSize' ,number : true,width:50 "></span></td>
			</tr>
			<tr>
				<td xtype="label">数字：</td>
				<td ><span xtype="check" config=" name : 'number'  "></span></td>
				<td xtype="label">大小：</td>
				<td><span xtype="text" config=" name : 'min' ,number : true ,width:50"></span>
				~
				<span xtype="text" config=" name : 'max' ,number : true,width:50 "></span></td>
			</tr>
			<tr>
				<td xtype="label">验证：</td>
				<td  colspan="3">
					<span xtype="check" config=" name : 'integer'  "></span>整数|
					<span xtype="check" config=" name : 'yw'  "></span>英文|
					<span xtype="check" config=" name : 'image'  "></span>图片|
				</td>
			</tr>
		</table>
	</form>
</body>
</html>