<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.SystemUtil"%>
<%=SystemUtil.getBaseDoctype()%>
<html>
<head>
<%=SystemUtil.getBaseJs("layout", "ztree", "ztree_edit",
					"ckeditor")%>
<script type="text/javascript">
	var hhckeditor = {
		setup : function(config) {
			this.setValue(config[this.id] || '');
		},
		commit : function(config) {
			var value = this.getValue();
			if (value) {
				config[this.id] = value;
			}
		},
		onOk : function(page, src, xtype, config) {
			var editor = page.getParentEditor();
			var field = editor.document.createElement('img');
			field.setAttribute('src', src);
			field.setAttribute('xtype', xtype);
			editor.insertElement(field);

			if (config == null) {
				config = {};
				page.commitContent(config);
			}
			for(var p in config){
				if(config[p]==null || config[p]==''){
					delete config[p];
				}
			}
			var configStr = BaseUtil.toString(config);
			field.setAttribute('config', configStr.substr(1,
					configStr.length - 2));

			field.setAttribute('ztype', 'span');
		},
		onShow : function(page, iframeId) {
			var e = page;
			delete e.textField;
			var d = e.getParentEditor().getSelection().getSelectedElement();
			e.textField = d;
			var config = {};
			if (d) {
				config = d.getAttribute('config');
				if (config) {
					config = BaseUtil.toObject('{' + config + '}');
				}
				if (config == null || config == '') {
					config = {};
				}
			}
			if (iframeId) {
				var iframe = window.frames[iframeId];
				if (iframe.setValues) {
					iframe.setValues(config);
				} else {
					BaseUtil.iframeLoad(iframe, function() {
						iframe.setValues(config);
					});
				}
			} else {
				e.setupContent(config);
			}
		},
		addButton : function(editor, commandname, xtype, label, icon) {
			editor.addCommand(commandname, new CKEDITOR.dialogCommand(
					commandname));
			editor.ui.addButton(commandname, {
				label : label,
				icon : icon,
				command : commandname
			});
			if (editor.addMenuItems) {
				var object = {};
				object[commandname] = {
					label : label,
					command : commandname,
					icon : icon,
					group : commandname
				};
				editor.addMenuItems(object);
			}
			if (editor.contextMenu) {
				editor.contextMenu.addListener(function(element, selection) {
					if (element != null
							&& element.getAttribute('xtype') == xtype) {
						var returnobj = {};
						returnobj[commandname] = CKEDITOR.TRISTATE_OFF;
						return returnobj;
					}
				});
			}
		},
		addWidget : function(params) {
			var wjj = params.wjj;
			var xtype = params.xtype;
			var text = params.text;
			CKEDITOR.plugins
					.add(
							wjj,
							{
								init : function(editor) {
									hhckeditor.addButton(editor, wjj, xtype,
											text,
											'/hhcommon/opensource/ckeditor/plugins/'
													+ wjj + '/' + wjj + '.jpg');

									CKEDITOR.dialog
											.add(
													wjj,
													function(a) {
														return {
															title : text,
															minWidth : 550,
															minHeight : 300,
															onShow : function() {
																hhckeditor
																		.onShow(
																				this,
																				'jsp-form-properties-'
																						+ xtype);
															},
															onOk : function() {
																var values = window.frames['jsp-form-properties-'
																		+ xtype]
																		.getValues();
																if (values == null) {
																	return false;
																}
																hhckeditor
																		.onOk(
																				this,
																				'/hhcommon/opensource/ckeditor/plugins/'
																						+ wjj
																						+ '/'
																						+ wjj
																						+ '.jpg',
																				xtype,
																				values);
															},
															onLoad : function() {
															},
															contents : [ {
																//id : 'info',
																label : text,
																title : text,
																elements : [ {
																	id : "iframe",
																	type : "html",
																	html : '<iframe src="jsp-form-properties-'+xtype+'" name="jsp-form-properties-'+xtype+'" id="jsp-form-properties-'+xtype+'" class="cke_pasteframe" style="width:550px;height:300px" frameborder="0"  allowTransparency="true" ></iframe>'
																} ]
															} ]
														};
													});
								},
								requires : [ 'fakeobjects' ]
							});
		}
	}

	var extraPlugins = 'hhtext,hhtextarea,hhcheck,hhcheckbox,hhradio,hhcombobox,hhitemselect,hhdate,hhuploadpic,hhfile,hhckeditor,hhselectUser,hhselectOrg,hhselectColor,hhtableitem';
	var formitems = [
	//  'Form', 'Checkbox', 'Radio',
	//'Textarea', 'Select', 'Button',
	//, 'TextField', 
	'hhtext', 'hhtextarea', 'hhcheck', 'hhcheckbox', 'hhradio', 'hhcombobox',
			'hhitemselect', 'hhdate', 'hhuploadpic', 'hhfile', 'hhckeditor',
			'hhselectUser', 'hhselectOrg', 'hhselectColor' ,'hhtableitem'];
	window.onload = function() {
		var editor = CKEDITOR
				.replace(
						'editor',
						{
							extraPlugins : extraPlugins,
							toolbar : [
									{
										name : 'document',
										items : [
												'Source',
												'-',
												'NewPage'/*, 'Save',, 'DocProps',
																																																																																																																																																																																																																																		'Preview', 'Print', '-'*/,
												'Templates' ]
									},
									{
										name : 'clipboard',
										items : [ 'Cut', 'Copy', 'Paste',
												'PasteText', 'PasteFromWord',
												'-', 'Undo', 'Redo' ]
									},
									{
										name : 'editing',
										items : [ 'Find', 'Replace', '-',
												'SelectAll', '-',
												'SpellChecker', 'Scayt' ]
									},
									{
										name : 'basicstyles',
										items : [ 'Bold', 'Italic',
												'Underline', 'Strike',
												'Subscript', 'Superscript',
												'-', 'RemoveFormat' ]
									},
									{
										name : 'paragraph',
										items : [ 'NumberedList',
												'BulletedList', '-', 'Outdent',
												'Indent', '-', 'Blockquote',
												'CreateDiv', '-',
												'JustifyLeft', 'JustifyCenter',
												'JustifyRight', 'JustifyBlock',
												'-', 'BidiLtr', 'BidiRtl' ]
									},
									{
										name : 'links',
										items : [ 'Link', 'Unlink', 'Anchor' ]
									},
									{
										name : 'insert',
										items : [ 'Image', 'Flash', 'Table',
												'HorizontalRule', 'Smiley',
												'SpecialChar', 'PageBreak',
												'Iframe' ]
									},
									{
										name : 'styles',
										items : [ 'Styles', 'Format', 'Font',
												'FontSize' ]
									},
									{
										name : 'colors',
										items : [ 'TextColor', 'BGColor' ]
									},
									{
										name : 'tools',
										items : [ 'Maximize'/* , 'ShowBlocks', '-', 'About' */]
									}, '/', {
										name : 'forms',
										items : formitems
									} ],
							height : Browser.getHeight() - 185,
							fullPage : false,
							contentsCss : '/hhcommon/opensource/jquery/jqueryuiframe.css',
							menu_groups : 'clipboard,form,tablecell,tablecellproperties,tablerow,tablecolumn,table,anchor,link,flash,checkbox,radio,textfield,hiddenfield,imagebutton,button,select,textarea,'
									+ extraPlugins
						});
		CKEDITOR.instances['editor'].on("instanceReady", function() {
			var toolId = '#cke_71';
			if(Browser.type.indexOf('IE')>-1){
				toolId='#cke_72';
			}
			$(toolId).find('a').each(
					function() {
						var ckeditor_a = $(this);
						var background = ckeditor_a.find('span').eq(0).css(
								'background-image')
						var li = $('<li></li>');
						var a = $('<a></a>');
						if(Browser.type.indexOf('IE')>-1){
							li.attr('onclick', ckeditor_a.attr('onmouseup'));
						}else{
							li.attr('onclick', ckeditor_a.attr('onclick'));
						}
						a.html('<span class="ui-icon" ></span>'
								+ ckeditor_a.attr('title'));
						a.find('span').css('background-image', background);
						li.append(a);
						$("#btn_menu").append(li);
					});
			$("#btn_menu").menu();
			$(toolId).remove();
		});
	};

	var selectTreeNode = {};

	function addFormType() {
		var selectNode = TreeUtil.getSelectNode('formTree');
		Dialog.open({
			url : 'jsp-form-ckeditor-formtreeedit',
			params : {
				selectNode : selectNode,
				callback : function() {
					TreeUtil.refresh('formTree');
				}
			}
		});
	}
	function remove(treeNode) {
		Dialog.confirm({
			message : '您确认要删除数据吗？',
			yes : function(result) {
				Request.request('form-CkFormTree-deleteTreeByIds', {
					data : {
						ids : treeNode.id
					},
					callback : function(result) {
						if (result.success) {
							TreeUtil.refresh('formTree');
						}
					}
				});
			}
		});
	}
	function edit(treeNode) {
		Dialog.open({
			url : 'jsp-form-ckeditor-formtreeedit',
			params : {
				id : treeNode.id,
				callback : function() {
					TreeUtil.refresh('formTree');
				}
			}
		});
	}

	function formTreeClick(treeNode) {
		if (treeNode.leaf == 1) {
			$('#formdivspan').html('（' + treeNode.text + '）');
			$("#formdiv").undisabled();
			selectTreeNode = treeNode;
			CKEDITOR.instances.editor.setData(selectTreeNode.html.replace(
					/<span config/g, '<img config').replace(/><\/span>/g,
					'ztype="span" />'));
		}
	}
	function updateHtml() {
		var html = CKEDITOR.instances.editor.getData().replace(/<img config/g,
				'<span config').replace(/ztype="span" \/>/g, '></span>');
		var jsonConfig = [];
		var $html = $(html);
		$html.find("[xtype]").each(function() {
			var config = $(this).getConfig();
			if (!config.text) {
				config.text = config.name;
			}
			jsonConfig.push(config);
		});
		var data = {
			id : selectTreeNode.id,
			html : html,
			jsonConfig : BaseUtil.toString(jsonConfig)
		};
		Request.request('form-CkFormTree-updateHtml', {
			data : data
		}, function(result) {
			if (result.success) {
				selectTreeNode.html = data.html;
				TreeUtil.updateNode('formTree', selectTreeNode);
				TreeUtil.getTree('formTree').refresh();
			}
		});
	}
	function openview() {
		BaseUtil.openHref('jsp-form-ckeditor-ckeditorview', {
			html : CKEDITOR.instances.editor.getData(),
			title : selectTreeNode.text
		});
	}
	function init() {
		$("#formdiv").disabled('请选择表单！');
	}
</script>
<style>
.ui-menu {
	width: 100%;
}
</style>
</head>
<body>
	<div xtype="border_layout">
		<div config="render : 'west'">
			<div xtype="toolbar" config="type:'head'">
				<span xtype="button" config="onClick:addFormType,text:'添加'"></span>
				<span xtype="button"
					config="onClick : TreeUtil.refresh,text : '刷新' ,params: 'formTree' "></span>
			</div>
			<span xtype="tree"
				config=" id:'formTree' , url:'form-CkFormTree-queryTreeList' , remove : remove , edit : edit, onClick : formTreeClick"></span>
		</div>
		<div id="formdiv">

			<div xtype="border_layout">
				<div config="render : 'west' ,width:120 ,open:0 ">
					<div xtype="toolbar" config="type:'head'" style="height:28px;text-align:center;">控件列表</div>
					<ul id="btn_menu"  style="width:117px;border:0px;">
					</ul>
				</div>
				<div>
					<div xtype="toolbar" config="type:'head'">
						<span xtype="button" config="onClick:updateHtml,text:'保存'"></span>
						<span xtype="button" config="onClick : openview,text : '预览'"></span>
						&nbsp;&nbsp;<span id="formdivspan" style="color: red;"></span>
					</div>
					<textarea id="editor" name="editor"></textarea>
				</div>
			</div>
		</div>
	</div>
</body>
</html>