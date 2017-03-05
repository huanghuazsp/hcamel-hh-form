<%@page import="com.hh.system.service.impl.BeanFactoryHelper"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.SystemUtil"%>
<%=SystemUtil.getBaseDoctype()%>
<html>
<head>
<title>表单设计</title>
<%=SystemUtil.getBaseJs("layout")%>
<script type="text/javascript">
	var emailMenu = {
		data : [ {
			text : '表单设计器',
			//img : '/hhcommon/images/icons/world/world.png',
			url : 'jsp-form-ckeditor-ckEditor',
			onClick : onClick
		},{
			text : '表单结果',
			//img : '/hhcommon/images/icons/world/world.png',
			url : 'jsp-form-service-formtree',
			onClick : onClick
		},  {
			text : '表单模板',
			//img : '/hhcommon/images/icons/world/world.png',
			url : 'jsp-form-ckeditor-formmodel',
			onClick : onClick
		}
		]
	};
	
	function onClick(){
		$('#system').attr('src',this.url);
	}
	
	
</script>
</head>
<body>
	<div xtype="border_layout">
		<div config="render : 'west',width:60,open:0">
			<span xtype=menu  configVar="emailMenu"></span>
		</div>
		<div style="overflow: visible;" id=centerdiv>
			<iframe id="system" name="system" width=100%
				height=100% frameborder=0 src="jsp-form-ckeditor-ckEditor"></iframe>
		</div>
	</div>
</body>
</html>