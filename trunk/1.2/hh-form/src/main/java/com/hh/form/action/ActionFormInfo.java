package com.hh.form.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.form.bean.FormInfo;
import com.hh.form.service.impl.FormInfoService;
import com.hh.system.service.impl.BaseMongoService;
import com.hh.system.util.base.BaseMongoAction;

@SuppressWarnings("serial")
public class ActionFormInfo extends BaseMongoAction<FormInfo> {
	public BaseMongoService<FormInfo> getService() {
		return service;
	}

	@Autowired
	private FormInfoService service;
	
	public void updateHtml() {
//		service.updateHtml(object);
	}

}
