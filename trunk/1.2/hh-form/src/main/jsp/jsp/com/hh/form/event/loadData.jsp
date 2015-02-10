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
	<form id="form" xtype="form">
		<table xtype="form">
			<tr>
				<td xtype="label">加载控件：</td>
				<td><span xtype="combobox" configVar="fieldListConfig"></span></td>
			</tr>
		</table>
	</form>
</body>
</html>