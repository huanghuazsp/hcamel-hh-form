<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>添加事件</title>
<%=BaseSystemUtil.getBaseJs("checkform")%>
<%
	
%>
<script type="text/javascript">
	var width = 550;
	var height = 400;
	var params = BaseUtil.getIframeParams();
	var data = params.data;
	
	var row = params.row || {id:BaseUtil.getUUID()}
	
	function doSave() {
		FormUtil.check('form', function(formData) {
			params.callback(formData);
			Dialog.close();
		});
	}
	var comboboxConfig = {
		name : 'eventType',
		defautlValue : 'setValue',
		onChange : function(value) {
			console.log(value);
		},
		data : [ {
			id : 'setValue',
			text : '设值'
		}, {
			id : 'loadData',
			text : '数据加载'
		} ]
	}

	var fieldListConfig = {
		name : 'widget',
		data : []
	}
	for (var i = 0; i < data.jsonConfig.length; i++) {
		var jsonData = data.jsonConfig[i];
		fieldListConfig.data.push({
			id : jsonData.name,
			text : jsonData.textfield || jsonData.name
		});
	}

	var radioConfig = {
		name : 'radioConfig',
		data : fieldListConfig.data,
		onChange : function(value) {
			$('#span_formula').setValue(
					$('#span_formula').getValue() + ' data.' + value);
		}
	}

	function init() {
		$('#form').setValue(row);
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
					<td><span xtype="text" config="name : 'eventName' ,required:true "></span></td>
				</tr>
			</table>
			<hr />
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
					<td><span xtype="textarea" config=" name: 'formula',required:true "></span></td>
				</tr>
			</table>
		</div>
	</form>
	<div xtype="toolbar">
		<span xtype="button" config="onClick : doSave ,text : '保存'  "></span>
	</div>

</body>
</html>