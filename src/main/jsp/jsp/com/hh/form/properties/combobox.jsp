<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>下拉框</title>
<%=BaseSystemUtil.getBaseJs("checkform","pinyin")+BaseSystemUtil.getKey("form")%>
<script type="text/javascript">
	function dataitemChange(value) {
		$('#span_url').setValue('system-SysData-queryTreeListCode?dataTypeId='+value.id);
	}
	var dataitemConfig = {
		onChange : dataitemChange,
		name : 'dataitem',
		findTextAction :$.hh.getRootFrame().contextPath+ '/system-SysDataType-findObjectByCode',
		url : $.hh.getRootFrame().contextPath+ '/system-SysDataType-queryTreeListCode'
	}
</script>
</head>
<body>
<div xtype="hh_content" style="overflow: visible;">
	<form id="form" xtype="form">
		<table xtype="form">
			<tr>
				<td xtype="label">中文名称：</td>
				<td><span xtype="text" config=" name : 'textfield' ,blur: zwblur "></span></td>
				<td xtype="label">名称：<img id="refreshName" style="cursor:pointer;"  src="/hhcommon/opensource/jquery/image/16/refresh.png"  title="根据中文名获取拼音"  /></td>
				<td ><span xtype="text" config=" name : 'name',required :true"></span></td>
			</tr>
			<tr>
				<td xtype="label">必填：</td>
				<td ><span xtype="check"
					config=" name : 'required'  "></span></td>
				<td xtype="label">不渲染：</td>
				<td ><span xtype="checkbox" config=" name : 'render'  , data : [{'id':'false' ,'text':''}] " ></span></td>
			</tr>
			<tr>
				<td xtype="label">数据字典：</td>
				<td colspan="3"><span xtype="tableitem"
					configVar="tableitemConfig"></span></td>
			</tr>
			<tr>
				<td xtype="label">地址：</td>
				<td colspan="3"><span xtype="text" config=" name : 'url' "></span></td>
			</tr>
			<tr>
				<td xtype="label">字典项：</td>
				<td colspan="3"><span xtype="selectTree" configVar="dataitemConfig"></span></td>
			</tr>
			<tr>
				<td xtype="label">选择事件：</td>
				<td colspan="3"><span xtype="combobox" configVar=" onChangeEventConfig "></span></td>
			</tr>
			<tr>
				<td xtype="label">setvalue事件：</td>
				<td colspan="3"><span xtype="combobox" configVar=" setValueEventConfig "></span></td>
			</tr>
		</table>
	</form>
</div>
<div xtype="toolbar">
	<span xtype="button" config="onClick : doSave ,text : '保存'  "></span>
	<span xtype="button" config="onClick : doCancel ,text : '取消'  "></span>
</div>
</body>
</html>