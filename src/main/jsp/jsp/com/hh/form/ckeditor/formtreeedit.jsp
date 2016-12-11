<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.SystemUtil"%>
<%=SystemUtil.getBaseDoctype()%>
<html>
<head>
<title>表单树编辑</title>
<%=SystemUtil.getBaseJs("checkform")%>
<script type="text/javascript">
	var params = $.hh.getIframeParams();
	var width = 600;
	var height = 300;
	function save() {
		$.hh.validation.check('form', function(formData) {
			if(formData.leaf==1 && (formData.tableName==null || formData.tableName=='')){
				Dialog.infomsg("类型为表单时，表名不能为空！");
				return;
			}
			Request.request('form-SysFormTree-saveTree', {
				data : formData,
				callback : function(result) {
					if (result.success!=false) {
						params.callback();
						Dialog.close();
					}
				}
			});
		});
	}

	function findData(id) {
		Request.request('form-SysFormTree-findObjectById', {
			data : {
				id : params.id
			},
			callback : function(result) {
				$('#form').setValue(result);
				if (result.leaf == 1) {
					$('#leafspan').disabled();
				}
			}
		});
	}

	function init() {
		if (params.selectNode) {
			if (params.selectNode.isParent) {
				$("#node_span").setValue(params.selectNode);
			}
		}
		if (params.id) {
			findData(params.id);
		}
	}
</script>
</head>
<body>
	<div xtype="hh_content">
		<form id="form" xtype="form">
			<span xtype="text" config="name: 'html' ,hidden:true"></span>
			<span xtype="text" config="name: 'eventList' ,hidden:true"></span>
			<span xtype="text" config="name: 'id' ,hidden:true"></span>
			<table xtype="form">
				<tbody>
					<tr>
						<td xtype="label">名称：</td>
						<td><span xtype="text" config=" name : 'text',required :true"></span></td>
						<td xtype="label">父节点：</td>
						<td><span xtype="selectTree" id="node_span"
							config="name: 'node' , noCheckLeaf:true,tableName : 'sys_form_tree' , url : 'form-SysFormTree-queryTreeList'"></span>
						</td>
					</tr>
					<tr>
						<td xtype="label">类型：</td>
						<td><span id="leafspan" xtype="radio"
							config="name: 'leaf' ,value : 0, data :[{id:1,text:'表单'},{id:0,text:'类别'}]"></span></td>
						<td xtype="label">是否展开：</td>
						<td><span xtype="radio"
							config="name: 'expanded' ,value : 0,  data :[{id:1,text:'是'},{id:0,text:'否'}]"></span></td>
					</tr>
					<tr>
						<td xtype="label">表名：</td>
						<td colspan="3"><span xtype="text" config=" name : 'tableName' "></span></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<div xtype="toolbar">
		<span xtype="button" config="text:'保存' , onClick : save "></span>
		<span xtype="button" config="text:'取消' , onClick : Dialog.close "></span>
	</div>
</body>
</html>