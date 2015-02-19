package com.hh.form.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.form.bean.FormDataType;
import com.hh.form.service.impl.FomDataTypeService;
import com.hh.system.service.impl.BaseMongoService;
import com.hh.system.util.base.BaseServiceAction;

@SuppressWarnings("serial")
public class ActionFormDataType extends BaseServiceAction<FormDataType> {

	public BaseMongoService<FormDataType> getService() {
		return formDataTypeService;
	}

	@Autowired
	private FomDataTypeService formDataTypeService;



}
