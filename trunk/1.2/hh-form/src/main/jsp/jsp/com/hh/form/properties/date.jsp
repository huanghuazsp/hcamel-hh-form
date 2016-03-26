<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>日期控件</title>
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
				<td xtype="label">默认值：</td>
				<td colspan="3"><span xtype="text" configVar=" defaultValueDateConfig "></span></td>
			</tr>
			<tr>
				<td xtype="label">格式：<img   src="/hhcommon/opensource/jquery/image/12/help.gif"  title="请输入：yyyy=年,MM=月,dd=日,HH=小时,mm=分,ss=秒，的组合！如（yyyy-MM-dd HH:mm:ss）" /></td>
				<td colspan="3"><span xtype="text" config=" name : 'type'  , data : ['yyyy-MM-dd' , 'yyyy-MM-dd HH:mm:ss', 'yyyy-MM' , 'yyyy'  , 'HH:mm:ss' , 'HH:mm' ,'yyyy-MM-dd HH']  "></span></td>
			</tr>
			<tr>
				<td xtype="label">宽度：</td>
				<td ><span xtype="text" config=" name : 'width' ,number : true "></span></td>
				<td xtype="label">只读：</td>
				<td ><span xtype="check" config=" name : 'readonly'  "></span></td>
			</tr>
			<tr>
				<td xtype="label">必填：</td>
				<td colspan="3"><span xtype="check" config=" name : 'required'  "></span></td>
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