<%@page import="com.hh.system.util.pk.PrimaryKey"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.hh.system.util.SystemUtil"%>
<%=SystemUtil.getBaseDoctype()%>
<html>
<head>
<%=SystemUtil.getBaseJs("layout", "ztree", "ztree_edit","ueditor")%>

</head>
<body  xtype="border_layout">
		<div config="render : 'west' ,resizable :false ,width:150 ">
			<div xtype="toolbar" config="type:'head'"
				style="height: 28px; text-align: center;">
				<div style="margin: 5px 0px 0px 0px">控件列表</div>
			</div>
			<span xtype=menu  configVar="widgetMenu"></span>
		</div>
		<div>
			<div xtype="toolbar" config="type:'head'">
				<span xtype="button"
					config="onClick:updateHtml,text:'保存',itype:'save' "></span> <span
					xtype="button"
					config="onClick : openview,text : '预览' ,itype:'view' "></span> <span
					xtype="button" config="onClick : doEventList ,text : '事件' ,icon:'hh_img_event' "></span>
			</div>
			<div id="editor_div" style="overflow-y : auto">
			 <script id="editor" type="text/plain" style="width:99.8%;height:500px;"></script>
			 </div>
		</div>

<script type="text/javascript">
	var selectHHImg = null;
	var isUeditorForm = true;
	
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');
    
    function getData() {
		var html = ue.getContent();
		var jsonConfig = [];
		var $html = $('<span>' + html + '</span>');
		$html.find('table').each(function(){
			$(this).attr('xtype','form');
			$(this).removeAttr('width');
			if($(this).attr('hhwidth')){
				$(this).attr('width',$(this).attr('hhwidth'));
			}
			$(this).find('td').each(function(){
				$(this).removeAttr('width');
				$(this).removeClass('selectTdClass');
				if($(this).attr('hhwidth')){
					$(this).attr('width',$(this).attr('hhwidth'));
				}
			});
		});
		
		$html.find('img[xtype]').each(function(){
			$(this)[0].outerHTML=$(this)[0].outerHTML.replace(/<img /g,
			'<span ').replace(/\/>/g, '></span>');
		});
		
		html=$html.html();
		$html.find("[xtype]").each(function() {
			var config = $(this).getConfig();
			if ($(this).attr('xtype') != 'form') {
				if (!config.textfield) {
					config.textfield = config.name;
				}
				jsonConfig.push(config);
			}
		});
		return {
			html : html,
			jsonConfigObject : jsonConfig,
			eventListObject : eventList,
			eventList : $.hh.toString(eventList),
			jsonConfig : $.hh.toString(jsonConfig)
		};
	}
	var text = '';
	
	function setData(data){
		if(data.eventList){
			eventList=$.hh.toObject(data.eventList);
		}else{
			eventList=[];
		}
		text = data.text;
		Doing.show();
		if(data.html){
			var span = $('<span></span>');
			span.html(data.html);
			span.find('span[xtype]').each(function(){
				$(this)[0].outerHTML = $(this)[0].outerHTML.replace(/<span /g,
				'<img ').replace(/><\/span>/g, '/>');
			});
			ue.setContent(span.html());
		}else{
			ue.setContent('');
		}
		Doing.hide();
		/*if($.hh.browser.type.indexOf('IE')>-1){
			try{
				CKEDITOR.tools.callFunction(4,this);
				setTimeout(function(){
					CKEDITOR.tools.callFunction(4,this);
					Doing.hide();
				},500);
			}catch(e){
				Doing.hide();
			}
		}else{
			Doing.hide();
		}*/
	}
	
	var eventList = [];

    function updateHtml (){
		parent.updateHtml(getData());
	}
    function openview() {
		var data = getData();
		parent.Request.submit('jsp-form-ckeditor-ckeditorview', {
			html : data.html,
			eventList : data.eventList,
			title : text
		});
	}
    
    function doEventList() {
		var data = getData();
		data.eventList=data.eventListObject;
		data.jsonConfig=data.jsonConfigObject;
		Dialog.open({
			url : 'jsp-form-event-eventList',
			params : {
				eventList : eventList,
				data : data,
				callback : function(eventListResult) {
					eventList = eventListResult;
				}
			}
		});
	}
    
    var widgetMenu = {
			data : [ {
				text : '单行文本框',
				img : '/hhcommon/opensource/ckeditor/plugins/hhtext/hhtext.jpg',
				xtype : 'text',
				onClick : widgetClick
			},{
				text : '文本域',
				img : '/hhcommon/opensource/ckeditor/plugins/hhtextarea/hhtextarea.jpg',
				xtype : 'textarea',
				onClick : widgetClick
			},{
				text : '复选按钮',
				img : '/hhcommon/opensource/ckeditor/plugins/hhcheck/hhcheck.jpg',
				xtype : 'check',
				onClick : widgetClick
			},{
				text : '复选按钮组',
				img : '/hhcommon/opensource/ckeditor/plugins/hhcheckbox/hhcheckbox.jpg',
				xtype : 'checkbox',
				onClick : widgetClick
			},{
				text : '单选框',
				img : '/hhcommon/opensource/ckeditor/plugins/hhradio/hhradio.jpg',
				xtype : 'radio',
				onClick : widgetClick
			},{
				text : '下拉框',
				img : '/hhcommon/opensource/ckeditor/plugins/hhcombobox/hhcombobox.jpg',
				xtype : 'combobox',
				onClick : widgetClick
			},{
				text : '双向选择器',
				img : '/hhcommon/opensource/ckeditor/plugins/hhitemselect/hhitemselect.jpg',
				xtype : 'itemselect',
				onClick : widgetClick
			},{
				text : '日期控件',
				img : '/hhcommon/opensource/ckeditor/plugins/hhdate/hhdate.jpg',
				xtype : 'date',
				onClick : widgetClick
			},{
				text : '图片上传',
				img : '/hhcommon/opensource/ckeditor/plugins/hhuploadpic/hhuploadpic.jpg',
				xtype : 'uploadpic',
				onClick : widgetClick
			},/* {
				text : '附件上传',
				img : '/hhcommon/opensource/ckeditor/plugins/hhfile/hhfile.jpg',
				xtype : 'file',
				onClick : widgetClick
			}, */{
				text : '附件上传',
				img : '/hhcommon/opensource/ckeditor/plugins/hhfileUpload/hhfileUpload.jpg',
				xtype : 'fileUpload',
				onClick : widgetClick
			},{
				text : '文本编辑器',
				img : '/hhcommon/opensource/ckeditor/plugins/hhckeditor/hhckeditor.jpg',
				xtype : 'ckeditor',
				onClick : widgetClick
			},{
				text : '选择用户',
				img : '/hhcommon/opensource/ckeditor/plugins/hhselectUser/hhselectUser.jpg',
				xtype : 'selectUser',
				onClick : widgetClick
			},{
				text : '选择机构',
				img : '/hhcommon/opensource/ckeditor/plugins/hhselectOrg/hhselectOrg.jpg',
				xtype : 'selectOrg',
				onClick : widgetClick
			},{
				text : '选择颜色',
				img : '/hhcommon/opensource/ckeditor/plugins/hhselectColor/hhselectColor.jpg',
				xtype : 'selectColor',
				onClick : widgetClick
			},{
				text : '子结构',
				img : '/hhcommon/opensource/ckeditor/plugins/hhtableitem/hhtableitem.jpg',
				xtype : 'tableitem',
				onClick : widgetClick
			}]
	};
    
    function widgetClick(){
    	widgetOpen(this.xtype);
    }
    

	function setPropertiesHH(){
		widgetOpen(selectHHImg.getAttribute('xtype'),selectHHImg.getAttribute('config'));
	}
    
    function widgetOpen(xtype,config){
    		config = $.hh.toObject('{' + config + '}');
    		Dialog.open({
				url :  'jsp-form-properties-'+xtype,
				params : {
					data : config,
					xtype:xtype,
					callback : function(data) {
						widgetDoingSave(xtype,data);
					}
				}
			});
    }
    
    function widgetDoingSave(xtype,config){
    	if (config == null) {
			config = {};
		}
		for ( var p in config) {
			if (config[p] == null || config[p] == '') {
				delete config[p];
			}
		}
		var configStr = $.hh.toString(config).replace(/\"/g,"'");
		
		
		var width = config.width ;
    	var height = config.height;
    	var height_ = 34;
   		if(xtype=='ckeditor' 
   			|| xtype=='date'
   			|| xtype=='itemselect'
   			|| xtype=='selectColor'
   			|| xtype=='selectOrg'
   			|| xtype=='selectUser'
   			|| xtype=='tableitem'
   			|| xtype=='text'
   			|| xtype=='textarea'
   				 ){
   			width = config.width || '100%'
   			if(xtype=='ckeditor'){
   				height_=234;
   			}else if(xtype=='itemselect'){
   				height_=244;
   			}else if(xtype=='tableitem'){
   				height_=60;
   			}else if(xtype=='textarea'){
   				height_=78;
   			}
   			if(!height){
   				height=height_;
      		}
    	}
		
		var obj = {
	        src:'/hhcommon/images/widget/'+xtype+'.png',
	        xtype : xtype,
	        width:width,
	        height:height,
	        config: configStr.substr(1,configStr.length - 2)
	    };
		ue.execCommand( 'insertimage', obj );
    }
    
    function setHeight(height) {
		$('#editor').height(height - 180);
		$('#editor_div').height(height - 35);
		
	}
</script>
</body>
</html>