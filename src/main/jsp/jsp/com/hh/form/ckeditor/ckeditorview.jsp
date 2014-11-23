<%@page import="com.hh.system.util.Convert"%>
<%@page import="com.hh.system.util.Check"%>
<%@page import="com.hh.system.util.Json"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>表单预览</title>
<%=BaseSystemUtil.getBaseJs("checkform","date","ckeditor")%>
<%
Map<String,Object> paramMap =   Json.toMap(request.getParameter("params"));
String html =  Convert.toString(paramMap.get("html")).replaceAll("<img config", "<span config").replaceAll("ztype=\"span\" />", "></span>");
String title =  Convert.toString(paramMap.get("title"));
%>
<script type="text/javascript">
$(function(){
	var width = $('#form').find('table').eq(0).css('width');
	$('#maintable').css('width',width);
});
</script>
</head>
<body>
	<table cellpadding="0" cellspacing="0" border="0" width="100%"
		height="100%">
		<tr>
			<td align="center" valign="top">
				<table id="maintable"  cellspacing="0" cellpadding="0">
					<tr>
						<td align="left">
							<form id="form" xtype="form" style="padding-top:20px">
								<h1 style="text-align:center;"><%=title%></h1>
								<%=html%>
							</form>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>