<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>事件列表</title>
<%=BaseSystemUtil.getBaseJs()+ BaseSystemUtil.getKey("event")%>
<%
	
%>
<script type="text/javascript">
var width = 700;
var height = 450;
var params = $.hh.getIframeParams();
function doAdd() {
	Dialog.open({
		url : 'jsp-form-event-eventEdit',
		params : {
			data : params.data,
			callback : function(data) {
				var dataList = $('#pagelist').data('data') || [];
				dataList.push(data);
				$('#pagelist').loadData({
					data : dataList
				});
			}
		}
	});
}

function doEdit() {
	$.hh.pagelist.callRow("pagelist", function(row) {
		Dialog.open({
			url : 'jsp-form-event-eventEdit',
			params : {
				row : row,
				data : params.data,
				callback : function(data) {
					$("#pagelist").getWidget().updateRow(data);
				}
			}
		});
	});
}

function doDelete() {
	$.hh.pagelist.callRow("pagelist", function(row) {
		$("#pagelist").getWidget().deleteRow(row);
	});
}

function doSave() {
	params.callback($('#pagelist').data('data') || []);
	Dialog.closethis();
}

var pagelistConfig = {
	paging : false,
	column : [ {
		name : 'eventName',
		text : '名称'
	} ],
	data : params.eventList
}

function init() {
	
}
</script>
</head>
<body>
	<div xtype="hh_content" style="overflow: visible;">
		<div xtype="toolbar" config="type:'head'">
			<span xtype="button" config="onClick:doAdd,text:'添加' , itype :'add' "></span>
			<span xtype="button"
				config="onClick:doEdit,text:'修改' , itype :'edit' "></span> <span
				xtype="button"
				config="onClick:doDelete,text:'删除' , itype :'delete' "></span>
		</div>
		<div id="pagelist" xtype="pagelist" configVar=" pagelistConfig"></div>
	</div>
	<div xtype="toolbar">
		<span xtype="button"
			config="onClick : doSave ,text : '保存' ,itype:'save' "></span>
	</div>
</body>
</html>