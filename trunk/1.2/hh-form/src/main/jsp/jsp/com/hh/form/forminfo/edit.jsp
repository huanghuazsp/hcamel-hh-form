<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.BaseSystemUtil"%>
<%=BaseSystemUtil.getBaseDoctype()%>
<html>
<head>
<title>流程编辑</title>
<%=BaseSystemUtil.getBaseJs("checkform")%>
<script type="text/javascript">
	var params = BaseUtil.getIframeParams();
	var width = 600;
	var height = 350;
	
	var queryData = null;
	
	function save() {
		FormUtil.check('form', function(formData) {
			if(queryData){
				$.extend(queryData,formData);
				delete queryData.dcreate;
				delete queryData.dupdate;
				formData=queryData;
			}
			formData.id=params.id;
			formData.node=params.node;
			Request.request('form-FormInfo-saveTree', {
				data : formData,
				callback : function(result) {
					if(result.success){
						params.callback(result);
						Dialog.close();
					}
				}
			});
		});
	}
	
	function findData(id){
		Request.request('form-FormInfo-findObjectById', {
			data : {id:params.id},
			callback : function(result) {
				queryData=result;
				$('#form').setValue(result);
			}
		});
	}
	
	function init(){
		if(params.id){
			findData(params.id);
		}
	}
</script>
</head>
<body>
	<div xtype="hh_content">
		<form id="form" xtype="form">
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
						<td xtype="label">业务表名：</td>
						<td><span xtype="text" config="name: 'tableName' "></span></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<div xtype="toolbar">
		<span xtype="button" config="text:'保存' , onClick : save ,itype:'save' "></span>
		<span xtype="button" config="text:'取消' , onClick : Dialog.close ,itype:'close'"></span>
	</div>
</body>
</html>