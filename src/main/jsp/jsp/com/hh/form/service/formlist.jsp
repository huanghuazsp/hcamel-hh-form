<%@page import="com.hh.form.bean.FormInfo"%>
<%@page import="com.hh.form.service.impl.FormInfoService"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%@page import="com.hh.form.bean.HhCkFormTree"%>
<%@page import="com.hh.form.service.impl.CkFormTreeService"%>
<%@page import="com.hh.system.service.impl.BeanFactoryHelper"%>
<%@page import="com.hh.system.util.Convert"%>
<%@page import="com.hh.system.util.Check"%>
<%@page import="com.hh.system.util.Json"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<%=BaseSystemUtil.getBaseJs()%>
<%
	String id = Convert.toString(request.getParameter("formId"));
	String databaseType = Convert.toString(request.getParameter("databaseType"));
	String jsonConfig = "[]";
	String tableName = "";
	if("relation".equals(databaseType)){
		CkFormTreeService ckFormTreeService = BeanFactoryHelper
				.getBeanFactory().getBean(CkFormTreeService.class);
		HhCkFormTree hhCkFormTree = ckFormTreeService.findObjectById(id);
		jsonConfig = hhCkFormTree.getJsonConfig();
		tableName = hhCkFormTree.getTableName();
	}else{
		FormInfoService formInfoService = BeanFactoryHelper
				.getBeanFactory().getBean(FormInfoService.class);
		FormInfo formInfo = formInfoService.findObjectById(id);
		jsonConfig = formInfo.getJsonConfig();
		tableName = formInfo.getTableName();
	}
%>
<script type="text/javascript">
	var formId = '<%=id%>';
	var  column =  <%=jsonConfig%>;
	var tableName = '<%=tableName%>';
	
	
	for(var i=0;i<column.length;i++){
		var data = column[i];
		data.id=data.name;
	}
	var pagelistConfig = {
		url : 'form-MongoFormOper-queryPagingData',
		params : {
			tableName : tableName
		},
		render : false
	};
	function init() {
		var width = (Browser.getWidth() - 150) / column.length;
		var dataList = [];
		$.each(column, function(index, data) {
			data.contentwidth = width;
			dataList.push(data);
		});
		pagelistConfig.column = dataList;
		$('#pagelist').render();
		
		doAddGroup();
	}

	function doAdd() {
		Dialog.open({
			width : Browser.getMainWidth() * 0.9,
			height : Browser.getMainHeight() * 0.85,
			url : 'jsp-form-service-ckeditorform?databaseType=<%=databaseType%>&hrefckeditor=' + formId,
			params : {
				callback : function() {
					$("#pagelist").loadData();
				}
			}
		});
	}
	function doEdit() {
		PageUtil.callRow("pagelist", function(row) {
			Dialog.open({
				width : Browser.getMainWidth() * 0.9,
				height : Browser.getMainHeight() * 0.85,
				url : 'jsp-form-service-ckeditorform?databaseType=<%=databaseType%>&hrefckeditor=' + formId
						+ '&objectId=' + row.id,
				params : {
					callback : function() {
						$("#pagelist").loadData();
					}
				}
			});
		});
	}
	function doView() {
		PageUtil.callRow("pagelist", function(row) {
			Dialog.open({
				width : Browser.getMainWidth() * 0.9,
				height : Browser.getMainHeight() * 0.85,
				url : 'jsp-form-service-ckeditorform?actionType=select&databaseType=<%=databaseType%>&hrefckeditor=' + formId
						+ '&objectId=' + row.id,
				params : {
					callback : function() {
						$("#pagelist").loadData();
					}
				}
			});
		});
	}
	function doDelete() {
		PageUtil.deleteData({
			data : {
				tableName : tableName
			},
			pageid : 'pagelist',
			action : 'form-MongoFormOper-deleteByIds'
		});
	}
	var selectConfig = {
		data : column
	};
	var condConfig = {
		data : [ {
			id : 'like',
			text : '包含'
		}, {
			id : '=',
			text : '等于'
		}, {
			id : '!=',
			text : '不等于'
		} ]
	};
	var andorConfig = {
		data : [ {
			id : 'and',
			text : '与'
		}, {
			id : 'or',
			text : '或'
		} ]
	};
	var tableitemConfig = {
		name : 'cond',
		trhtml : '<tr>'
				//+'<td xtype="label" style="width:50px">关系：</td><td  style="width:50px"><span valuekey="andor"  xtype="combobox" configVar="andorConfig"></span></td>'
				+ '<td xtype="label" style="width:50px">字段：</td><td  style="width:150px"><span valuekey="field"  xtype="combobox" configVar="selectConfig"></span></td>'
				+ '<td xtype="label" style="width:50px">条件：</td><td  style="width:100px"><span valuekey="cond"  xtype="combobox" configVar="condConfig"></span></td>'
				+ '<td xtype="label" style="width:50px">值：</td><td><span valuekey="value" xtype="text"  ></span></td></tr>'
	};
	var groupi =1;
	function doAddGroup(){
		var trhtml = '<tr type="queryFormTr">'
								+'<td style="width: 100px;"><span type="andor" xtype="radio"'
									+' config="name: \'andor'+groupi+'\' ,defaultValue : \'and\',  data :[{id:\'and\',text:\'与\'},{id:\'or\',text:\'或\'}]"></span></td>'
								+'<td><span type="tableitem" xtype="tableitem" configVar="tableitemConfig"></span></td>'
							+'</tr>';
		var tr = $(trhtml);
		tr.renderAll();
		$('#queryForm').append(tr);
		groupi++;
	}
	
	function doQuery() {
		var formdata = [];
		$('[type=queryFormTr]').each(function(){
			var object = {};
			var andor = $(this).find("[type=andor]").getValue();
			var cond = $(this).find("[type=tableitem]").getValue();
			object.andor=andor;
			object.cond=cond;
			formdata.push(object);
		});
		var data = {};
		data['object.cond'] = BaseUtil.toString(formdata);
		data.tableName = tableName;
		$('#pagelist').loadData({
			params : data
		});
	}
</script>
</head>
<body>
	<div xtype="toolbar" config="type:'head'">
		<span xtype="button" config="onClick:doAdd,text:'添加' ,itype:'add' "></span> <span
			xtype="button" config="onClick:doEdit,text:'修改',itype:'edit'"></span> <span
			xtype="button" config="onClick:doView,text:'查看' ,itype:'view'"></span> <span
			xtype="button" config="onClick:doDelete,text:'删除' ,itype:'delete'"></span> <span
			xtype="button" config="onClick: doQuery ,text:'查询' ,itype:'query'"></span>
	</div>
	<table xtype="form" id="queryForm">
		<!-- <tr>
			<td colspan="4"><span xtype="button" config="onClick: doAddGroup ,text:'添加分组'"></span></td>
		</tr> -->
	</table>
	<div id="pagelist" xtype="pagelist" configVar="pagelistConfig"></div>
</body>
</html>