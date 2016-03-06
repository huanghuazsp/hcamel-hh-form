<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%@page import="com.google.gson.Gson"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>表单设计</title>
<%=BaseSystemUtil.getBaseJs("gridviewService")%>
<%
	Gson gson = new Gson();
%>
<style type="text/css">
</style>
<script type="text/javascript">
	var queryAction = 'form-FormInfo-queryTreeList';
	function init() {
		loadData();
	}

	var gridViewConfig = {
		margin : 10,
		onClick : function(data) {
			if (data.leaf == 1) {
				$.hh.addTab({
					id : data.id,
					text :  '表单查看-'+data.text,
					src : 'jsp-form-service-formlist?formId=' + data.id
				});
			} else {
				requestParams.node = data.id;
				loadData();
			}
		},
		update : function(id) {
			Request.request('form-FormInfo-orderAll', {
				data : {
					ids : id
				}
			});
		},
		data : []
	};

</script>
</head>
<body>
	<div xtype="toolbar" config="type:'head'">
		<span id="backbtn" xtype="button"
			config="onClick: doBack ,text:'后退' , icon :'hh_img_left' "></span>
		<span xtype="button" config="onClick: refresh ,text:'刷新' ,itype:'refresh'"></span>
	</div>
	<div style="padding: 25px;">
		<span id="gridView" xtype="gridView" configVar="gridViewConfig"></span>
	</div>
</body>
</html>