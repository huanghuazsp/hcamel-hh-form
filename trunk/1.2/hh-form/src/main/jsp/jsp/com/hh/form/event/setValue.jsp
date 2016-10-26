<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>设值</title>
<%=BaseSystemUtil.getBaseJs("checkform")
					+ BaseSystemUtil.getKey("event")%>
<script type="text/javascript">
	
</script>
</head>
<body>
	<form id="form" xtype="form" class="form">
		<table xtype="form">
			<tr>
				<td xtype="label">设置控件：</td>
				<td><span xtype="combobox" configVar="fieldListConfig"></span></td>
			</tr>
			<tr>
				<td colspan="2"><span xtype="radio" configVar=" radioConfig"></span></td>
			</tr>
			<tr>
				<td xtype="label">设置公式：</td>
				<td><span xtype="textarea"
					config=" name: 'formula',required:true "></span></td>
			</tr>
		</table>
	</form>
</body>
</html>