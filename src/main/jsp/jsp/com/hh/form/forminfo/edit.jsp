<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.SystemUtil"%>
<%=SystemUtil.getBaseDoctype()%>
<html>
<head>
<title>流程编辑</title>
<%=SystemUtil.getBaseJs("checkform")%>
<script type="text/javascript">
	var params = $.hh.getIframeParams();
	var width = 600;
	var height = 350;

	var queryData = null;

	function save() {
		$.hh.validation.check('form', function(formData) {
			if (queryData) {
				$.extend(queryData, formData);
				delete queryData.createTime;
				delete queryData.updateTime;
				formData = queryData;
			}
			formData.id = params.id;
			Request.request('form-FormInfo-saveTree', {
				data : formData,
				callback : function(result) {
					if (result.success!=false) {
						params.callback(result);
						Dialog.close();
					}
				}
			});
		});
	}

	function findData(id) {
		Request.request('form-FormInfo-findObjectById', {
			data : {
				id : params.id
			},
			callback : function(result) {
				queryData = result;
				$('#form').setValue(result);
			}
		});
	}

	function init() {
		if (params.id) {
			findData(params.id);
		}
	}
</script>
</head>
<body>
	<div xtype="hh_content">
		<form id="form" xtype="form" class="form">
			<span xtype="text" config="name: 'html' ,hidden:true"></span> <span
				xtype="text" config="name: 'eventList' ,hidden:true"></span> <span
				xtype="text" config="name: 'id' ,hidden:true"></span>
			<table xtype="form">
				<tbody>
					<tr>
						<td xtype="label">名称：</td>
						<td><span xtype="text" config=" name : 'text',required :true"></span></td>
					</tr>
					<tr>
						<td xtype="label">类型：</td>
						<td><span id="leafspan" xtype="radio"
							config="name: 'leaf' ,value : 1, data :[{id:1,text:'表单'},{id:0,text:'类别'}]"></span></td>
					</tr>
					<tr>
						<td xtype="label">上级节点：</td>
						<td><span xtype="selectTree" id="node_span"
							config="name: 'node' , findTextAction: 'form-FormInfo-findObjectById', url : 'form-FormInfo-queryTreeList'"></span>
						</td>
					</tr>
					<tr>
						<td xtype="label">业务表名：</td>
						<td><span xtype="text" config="name: 'tableName' "></span></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<div xtype="toolbar">
		<span xtype="button"
			config="text:'保存' , onClick : save ,itype:'save' "></span> <span
			xtype="button"
			config="text:'取消' , onClick : Dialog.close ,itype:'close'"></span>
	</div>
</body>
</html>