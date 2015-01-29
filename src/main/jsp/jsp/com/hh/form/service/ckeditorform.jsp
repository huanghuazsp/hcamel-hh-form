<%@page import="com.hh.form.bean.HhCkFormTree"%>
<%@page import="com.hh.form.bean.FormInfo"%>
<%@page import="com.hh.form.service.impl.FormInfoService"%>
<%@page import="com.hh.form.service.impl.CkFormTreeService"%>
<%@page import="com.hh.system.service.impl.BeanFactoryHelper"%>
<%@page import="com.hh.system.util.Convert"%>
<%@page import="com.hh.system.util.Check"%>
<%@page import="com.hh.system.util.Json"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>表单</title>
<%=BaseSystemUtil.getBaseJs("checkform", "date", "ckeditor")%>
<%
	String id = Convert.toString(request.getParameter("hrefckeditor"));
	String databaseType = Convert.toString(request.getParameter("databaseType"));
	String jsonConfig = "[]";
	String tableName = "";
	String html = "";
	if("relation".equals(databaseType)){
		CkFormTreeService ckFormTreeService = BeanFactoryHelper
				.getBeanFactory().getBean(CkFormTreeService.class);
		HhCkFormTree hhCkFormTree = ckFormTreeService.findObjectById(id);
		jsonConfig = hhCkFormTree.getJsonConfig();
		tableName = hhCkFormTree.getTableName();
		html = hhCkFormTree.getHtml();
	}else{
		FormInfoService formInfoService = BeanFactoryHelper
				.getBeanFactory().getBean(FormInfoService.class);
		FormInfo formInfo = formInfoService.findObjectById(id);
		jsonConfig = formInfo.getJsonConfig();
		tableName = formInfo.getTableName();
		html = formInfo.getHtml();
	}
	
	
	String type = Convert.toString(request.getParameter("type"));
%>
<script type="text/javascript">
	var params = BaseUtil.getIframeParams();
	var dataManager = params.dataManager?BaseUtil.toObject(params.dataManager):[];
	var actionType = '<%=Convert.toString(request.getParameter("actionType"))%>';
	var tableName = '<%=tableName%>';
	var objectId= '<%=Convert.toString(request.getParameter("objectId"))%>';
	function save(submit) {
		if ($("#form").validationEngine('validate')) {
			var object = $("#form").getValue();

			var object2 = {};
			for ( var p in object) {
				object2['object.' + p] = object[p];
			}
			object2['object.tableName'] = tableName;
			object2['object.id'] = objectId;
			if (submit == null) {
				Request.request('form-MongoFormOper-save', {
					async : false,
					data : object2
				}, function(result) {
					if (result.success) {
						if (params.callback) {
							params.callback();
							Dialog.close();
						}
						return object;
					} else {
						return null;
					}
				});
			}
			object.tableName = tableName;
			return object;
		} else {
			Dialog.errormsg("验证失败！！");
		}
	}
	function init() {
		$.each(dataManager, function(i, data) {
			if (data.readonly == 1) {
				$('#span_' + data.field).toView();
			}
			if (data.hidden == 1) {
				$('#span_' + data.field).hide();
			}
		});
		if (objectId) {
			Request.request('form-MongoFormOper-findObjectById', {
				defaultMsg:false,
				data : {
					id : objectId,
					tableName : tableName
				}
			}, function(result) {
				if (actionType == 'select') {
					$('#form').setValue(result, true);
				} else {
					$('#form').setValue(result);
				}
			});
		}
	}
</script>
<script type="text/javascript">
$(function(){
	var width = $('#form').find('table').eq(0).css('width');
	$('#maintable').css('width',width);
});
</script>
</head>
<body>
	<%
		if (!"workflow".equals(type)) {
	%>
	<div xtype="hh_content">
		<%
			}
		%>
		<table cellpadding="0" cellspacing="0" border="0" width="100%"
			height="100%">
			<tr>
				<td align="center" valign="top">
					<table  id="maintable"   cellspacing="0" cellpadding="0">
						<tr>
							<td align=left>
								<form id="form" xtype="form" style="padding-top: 20px">
									<%=Convert.toString(html)%>
								</form>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<%
			if (!"workflow".equals(type)) {
		%>
	</div>
	<div xtype="toolbar" id="toolbar">
		<span xtype="button" config="text:'保存' , onClick : save ,itype:'save'"></span> <span
			xtype="button" config="text:'取消' , onClick : Dialog.close,itype:'close' "></span>
	</div>
	<%
		}
	%>
</body>
</html>