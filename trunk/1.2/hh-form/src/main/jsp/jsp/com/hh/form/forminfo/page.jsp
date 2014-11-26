<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%@page import="com.google.gson.Gson"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>流程设计</title>
<%=BaseSystemUtil.getBaseJs("right_menu")%>
<%
	Gson gson = new Gson();
%>
<style type="text/css">
</style>
<script type="text/javascript">
	function init() {
		loadData();
	}
	var pathList = [];
	var hidata = {};
	var requestParams = {
		node : 'root'
	};
	function refresh() {
		loadData(true);
	}
	function loadData(editresult) {
		if (editresult) {
			var tempPathList = [];
			var path = '';
			for (var i = 0; i < pathList.length - 1; i++) {
				tempPathList.push(pathList[i]);
				path = pathList[i];
			}
			pathList = tempPathList;
			delete hidata[requestParams.node];
		}
		if (hidata[requestParams.node]) {
			pathList.push(requestParams.node);
			renderList(hidata[requestParams.node]);
		} else {
			Request.request('form-FormInfo-queryTreeList', {
				data : requestParams,
				callback : function(result) {
					pathList.push(requestParams.node);
					hidata[requestParams.node] = result;
					renderList(result);
				}
			});
		}
	}

	function renderList(result) {
		if (pathList.length > 1) {
			$('#backbtn').undisabled();
		} else {
			$('#backbtn').disabled();
		}
		for (var i = 0; i < result.length; i++) {
			result[i].img = result[i].leaf == 0 ? StaticVar.img_wenjianjia
					: StaticVar.img_wenjian;
		}
		$('#gridView').setConfig({
			data : result
		});
		$('#gridView').render();
	}

	var gridViewConfig = {
		margin : 10,
		rightMenu : [ {
			text : '编辑',
			img : StaticVar.img_edit,
			onClick : function(data) {
				Dialog.open({
					url : 'jsp-form-forminfo-edit',
					params : {
						callback : loadData,
						node : data.node,
						id : data.id
					}
				});
			}
		}, {
			text : '查看配置列表',
			img : StaticVar.img_edit,
			onClick : function(data) {
				BaseUtil.addTab({
					id : 'form_view_' + data.text,
					text :  '表单查看-'+data.text,
					src : 'jsp-form-service-formlist?formId=' + data.id
				});
			}
		},  {
			text : '删除',
			img : StaticVar.img_delete,
			onClick : function(data) {
				Request.request('form-FormInfo-deleteTreeByIds', {
					data : {
						ids : data.id
					}
				}, function(result) {
					if (result.success) {
						loadData(result);
					}
				});
			}
		} ],
		onClick : function(data) {
			if (data.leaf == 1) {
				var param = {
					text : data.text,
					objectId : data.id
				};
				BaseUtil.addTab({
					id : 'form_' + data.text,
					text :  '表单设计-'+data.text,
					src : 'jsp-form-ckeditor-ckEditoredit?' + $.param(param)
				});
			} else {
				requestParams.node = data.id;
				loadData();
			}
		},
		update : function(id) {
			Request.request('form-FormInfo-order', {
				data : {
					ids : id
				}
			});
		},
		data : []
	};

	function doBack() {
		var tempPathList = [];
		var path = '';
		for (var i = 0; i < pathList.length - 1; i++) {
			tempPathList.push(pathList[i]);
			path = pathList[i];
		}
		pathList = tempPathList;
		requestParams.node = path;
		renderList(hidata[path]);
	}

	function addFormType() {
		Dialog.open({
			url : 'jsp-form-forminfo-edit',
			params : {
				callback : loadData,
				node : requestParams.node
			}
		});
	}
</script>
</head>
<body>
	<div xtype="toolbar" config="type:'head'">
		<span id="backbtn" xtype="button"
			config="onClick: doBack ,text:'后退' , icon : 'ui-icon-arrow-1-w' "></span>
		<span xtype="button" config="onClick: addFormType ,text:'添加'"></span>
		<span xtype="button" config="onClick: refresh ,text:'刷新'"></span>
	</div>
	<div style="padding: 25px;">
		<span id="gridView" xtype="gridView" configVar="gridViewConfig"></span>
	</div>
</body>
</html>