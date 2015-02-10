<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.PrimaryKey"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>添加事件</title>
<%=BaseSystemUtil.getBaseJs("checkform")
					+ BaseSystemUtil.getKey("event")%>
<%
	String frameId = PrimaryKey.getPrimaryKeyUUID();
%>
<script type="text/javascript">
	var width = 700;
	var height = 550;
	var frameId = '<%=frameId%>';
	var row = params.row || {
		id : BaseUtil.getUUID()
	}
	
	params.row=row;

	function doSave() {
		FormUtil.check('form', function(formData) {
			var subframe = window.frames[frameId].getValues();
			if(subframe){
				$.extend(formData,subframe);
			}else{
				return;
			}
			params.callback(formData);
			Dialog.close();
		});
	}
	var comboboxConfig = {
		name : 'eventType',
		defautlValue : 'setValue',
		onChange : function(value) {
			$('#' + frameId).attr('src', 'jsp-form-event-' + value);
		},
		data : [ {
			id : 'setValue',
			text : '设值'
		}, {
			id : 'loadData',
			text : '数据加载'
		} ]
	}

	function init() {
		BaseUtil.setFrameParams(frameId, params);
		$('#form').setValue(row);
		var eventType = $('#span_eventType').getValue();
		$('#' + frameId).attr('src', 'jsp-form-event-' + eventType);
	}

	function setHeight(height) {
		$('#' + frameId).height(height - 150);
	}
</script>
</head>
<body>
	<form id="form" xtype="form">
		<span xtype="text" config=" hidden:true,name : 'id'"></span>
		<div xtype="hh_content" style="overflow: visible;">
			<table xtype="form">
				<tr>
					<td xtype="label">事件类别：</td>
					<td><span xtype="combobox" configVar="comboboxConfig"></span></td>
				</tr>
				<tr>
					<td xtype="label">事件名称：</td>
					<td><span xtype="text"
						config="name : 'eventName' ,required:true "></span></td>
				</tr>
			</table>
			<hr />
			<iframe id="<%=frameId%>" name="<%=frameId%>" width=100% height=100%
				frameborder=0 src=""></iframe>
		</div>
	</form>
	<div xtype="toolbar">
		<span xtype="button" config="onClick : doSave ,text : '保存'  "></span>
	</div>

</body>
</html>