<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>选择机构</title>
<%=BaseSystemUtil.getBaseJs("checkform","pinyin")+BaseSystemUtil.getKey("form")%>
<script type="text/javascript">
	
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
				<td xtype="label">宽度：</td>
				<td colspan="3"><span xtype="text" config=" name : 'width' ,number : true "></span></td>
			</tr>
			<tr>
				<td xtype="label">必填：</td>
				<td><span xtype="check" config=" name : 'required'  "></span></td>
				<td xtype="label">多选：</td>
				<td><span xtype="check" config=" name : 'many'  "></span></td>
			</tr>
			<tr>
				<td xtype="label">类型：</td>
				<td colspan="3"><span xtype="radio"
					config="name: 'selectType' ,defaultValue : 'job',  data :[ { id : 'job' , text : '岗位' } , { id : 'dept' , text : '部门' } , { id : 'org' , text : '机构' }  ]"></span></td>
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