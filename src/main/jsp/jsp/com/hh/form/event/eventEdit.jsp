<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.pk.PrimaryKey"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>添加事件</title>
<%=BaseSystemUtil.getBaseJs("checkform")
					+ BaseSystemUtil.getKey("event")%>
<%
	String frameId = PrimaryKey.getUUID();
%>
<script type="text/javascript">
	var width = 650;
	var height = 500;
	var frameId = 'eventFrameId';
	var row = params.row || {
		id : $.hh.getUUID()
	}

	params.row = row;

	function doSave() {
		$.hh.validation.check('form', function(formData) {
			var subframe = window.frames[frameId].getValues();
			if (subframe) {
				$.extend(formData, subframe);
			} else {
				return;
			}
			params.callback(formData);
			Dialog.closethis();
		});
	}
	var comboboxConfig = {
		name : 'eventType',
		defautlValue : 'setValue',
		onChange : function(value) {
			if (value) {
				$('#' + frameId).attr('src', 'jsp-form-event-'+value );
			}
		},
		data : [ {
			id : 'setValue',
			text : '设值'
		}, {
			id : 'loadSubComboData',
			text : '加载子下拉框数据'
		} ]
	}

	function init() {
		$.hh.setFrameParams(frameId, params);
		$('#form').setValue(row);
		var eventType = $('#span_eventType').getValue();
		if (eventType) {
			$('#' + frameId).attr('src','jsp-form-event-'+ eventType );
		}
	}

	function setHeight(height) {
		$('#' + frameId).height(height - 180);
	}
</script>
</head>
<body>
	<div xtype="hh_content" style="overflow: visible;">
		<form id="form" xtype="form" class="form">
			<span xtype="text" config=" hidden:true,name : 'id'"></span>
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
			<iframe id="eventFrameId" name="eventFrameId" width=100% height=100%
				frameborder=0 src=""></iframe>
		</form>
	</div>
	<div xtype="toolbar">
		<span xtype="button" config="onClick : doSave ,text : '保存'  "></span>
	</div>

</body>
</html>