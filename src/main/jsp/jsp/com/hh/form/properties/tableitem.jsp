<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>子结构</title>
<%=BaseSystemUtil.getBaseJs("checkform","pinyin")+BaseSystemUtil.getKey("form")%>
<script type="text/javascript">
	var subTable = {
		name : 'formId',
		noCheckParent : true,
		findTextAction :$.hh.getRootFrame().contextPath+ '/form-SysFormTree-findObjectById',
		url : 'form-SysFormTree-queryTreeList'
	}
</script>
</head>
<body>
<div xtype="hh_content" style="overflow: visible;">
	<form id="form" xtype="form" class="form">
		<table xtype="form">
			<tr>
				<td xtype="label">中文名称：</td>
				<td><span xtype="text" config=" name : 'textfield' ,blur: zwblur "></span></td>
				<td xtype="label">名称：<img id="refreshName" style="cursor:pointer;"  src="/hhcommon/opensource/jquery/image/16/refresh.png"  title="根据中文名获取拼音"  /></td>
				<td ><span xtype="text" config=" name : 'name',required :true"></span></td>
			</tr>
			<tr>
				<td xtype="label">子结构：</td>
				<td colspan="3"><span xtype="selectTree" configVar="subTable"></span></td>
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