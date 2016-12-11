<%@page import="com.hh.system.util.date.DateFormat"%>
<%@page import="com.hh.usersystem.IUser"%>
<%@page import="com.hh.system.util.Convert"%>
<%@page import="com.hh.system.util.Check"%>
<%@page import="com.hh.system.util.Json"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.SystemUtil"%>
<%=SystemUtil.getBaseDoctype()%>
<html>
<head>
<title>表单预览</title>
<%=SystemUtil.getBaseJs("checkform", "date", "ueditor", "fileUpload")%>
<%
Map<String,Object> paramMap =   Json.toMap(request.getParameter("params"));
String html =  Convert.toString(paramMap.get("html"));
String eventList =  Convert.toString(paramMap.get("eventList"));
String title =  Convert.toString(paramMap.get("title"));

IUser user =	(IUser)session.getAttribute("loginuser");
if(user!=null){
	html=html.replaceAll("\\$\\{当前登录人}", user.getText())
	.replaceAll("\\$\\{当前登录人岗位}",  user.getJobText())
	.replaceAll("\\$\\{当前登录人所在部门}",  user.getDeptText())
	.replaceAll("\\$\\{当前登录人所在机构}",  user.getOrgText());
}
html=html
.replaceAll("\\$\\{当前时间yyyy-MM-dd}",  DateFormat.getDate("yyyy-MM-dd"))
.replaceAll("\\$\\{当前时间yyyy-MM-dd HH:mm:ss}",  DateFormat.getDate("yyyy-MM-dd HH:mm:ss"))
.replaceAll("\\$\\{当前时间yyyy-MM}",  DateFormat.getDate("yyyy-MM"))
.replaceAll("\\$\\{当前时间yyyy}",  DateFormat.getDate("yyyy"))
.replaceAll("\\$\\{当前时间HH:mm:ss}",  DateFormat.getDate("HH:mm:ss"))
.replaceAll("\\$\\{当前时间HH:mm}",  DateFormat.getDate("HH:mm"))
.replaceAll("\\$\\{当前时间yyyy-MM-dd HH}",  DateFormat.getDate("yyyy-MM-dd HH"));
String type = Convert.toString(request.getParameter("type"));
%>
<script type="text/javascript">
<%
StringBuffer eventStr = new StringBuffer();
if(Check.isNoEmpty(eventList)){
		
	List<Map<String,Object>> mapList = Json.toMapList(eventList);
	for(Map<String,Object> map : mapList){
		String eventType = Convert.toString(map.get("eventType"));
		String eventid = Convert.toString(map.get("id"));
		String widget = Convert.toString(map.get("widget"));
		String formula = Convert.toString(map.get("formula"));
		
		eventStr.append("function "+eventid+"(params){ \n");
		if("setValue".equals(eventType)){
			eventStr.append(" var data = $('#form').getValue(); \n");
			
			eventStr.append(" $('#span_"+widget+"').setValue("+formula+"); \n");
		}else if("loadSubComboData".equals(eventType)){
			eventStr.append(" $('#span_"+widget+"').setConfig({params:{node:params}}); \n");
			eventStr.append(" $('#span_"+widget+"').render(); \n");
		}
		
		eventStr.append("}\n");
	}
	
}

%>
<%=eventStr.toString()%>
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