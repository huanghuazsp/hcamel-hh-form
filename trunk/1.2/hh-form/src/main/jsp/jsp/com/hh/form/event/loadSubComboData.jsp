<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.SystemUtil"%>
<%=SystemUtil.getBaseDoctype()%>
<html>
<head>
<title>设值</title>
<%=SystemUtil.getBaseJs("checkform")
					+ SystemUtil.getKey("event")%>
<script type="text/javascript">
	
</script>
</head>
<body>
	<form id="form" xtype="form" >
		<table xtype="form">
			<tr>
				<td xtype="label">渲染控件：</td>
				<td><span xtype="combobox" configVar="fieldListConfig"></span></td>
			</tr>
		</table>
	</form>
</body>
</html>