<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>文本框</title>
<%=BaseSystemUtil.getBaseJs("checkform","pinyin")+BaseSystemUtil.getKey("form")%>
<script type="text/javascript">
	
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
				<td xtype="label">默认值：</td>
				<td><span xtype="text" configVar=" defaultValueConfig "></span></td>
				<td xtype="label">水印：</td>
				<td><span xtype="text" config=" name : 'watermark' "></span></td>
			</tr>
			<tr>
			<td xtype="label">宽度：</td>
				<td ><span xtype="text" config=" name : 'width' ,number : true "></span></td>
			<td xtype="label">只读：</td>
				<td ><span xtype="check" config=" name : 'readonly'  "></span></td>
			</tr>
			<tr>
				<td xtype="label">必填：</td>
				<td><span xtype="check" config=" name : 'required'  "></span>
				</td>
				<td xtype="label">长度：</td>
				<td><span xtype="text" config=" name : 'minSize' ,number : true ,width:50"></span>
				~
				<span xtype="text" config=" name : 'maxSize' ,number : true,width:50 "></span></td>
			</tr>
			<tr>
				<td xtype="label">数字：</td>
				<td ><span xtype="check" config=" name : 'number'  "></span></td>
				<td xtype="label">大小：</td>
				<td><span xtype="text" config=" name : 'min' ,number : true ,width:50"></span>
				~
				<span xtype="text" config=" name : 'max' ,number : true,width:50 "></span></td>
			</tr>
			<tr>
				<td xtype="label">验证：</td>
				<td  colspan="3">
					<span xtype="check" config=" name : 'integer'  "></span>整数|
					<span xtype="check" config=" name : 'yw'  "></span>英文|
					<span xtype="check" config=" name : 'image'  "></span>图片|
				</td>
			</tr>
			<tr>
				<td xtype="label">改变事件：</td>
				<td colspan="3"><span xtype="combobox" configVar=" blurEventConfig "></span></td>
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