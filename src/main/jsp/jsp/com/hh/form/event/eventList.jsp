<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>事件列表</title>
<%=BaseSystemUtil.getBaseJs()%>
<%
	
%>
<script type="text/javascript">
	var width = 600;
	var height = 500;
	function doAdd() {
		Dialog.open({
			url : 'jsp-form-event-eventEdit',
			params : {
				callback : function(){
					
				}
			}
		});
	}
</script>
</head>
<body>
<div xtype="toolbar" config="type:'head'">
	<span xtype="button" config="onClick : doAdd ,text : '添加'  "></span>
	</div>
	<div id="pagelist" xtype="pagelist"
		config=" paging : false , params :  {nxb:2},column : [
		{
			name : 'text' ,
			text : '名称'
		}
	]">
	</div>
</body>
</html>