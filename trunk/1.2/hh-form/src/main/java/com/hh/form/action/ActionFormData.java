package com.hh.form.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.form.bean.FormData;
import com.hh.form.service.impl.FormDataService;
import com.hh.system.service.impl.BaseMongoService;
import com.hh.system.util.Convert;
import com.hh.system.util.base.BaseMongoAction;
import com.hh.system.util.dto.ParamFactory;

@SuppressWarnings("serial")
public class ActionFormData extends BaseMongoAction<FormData> {

	public BaseMongoService<FormData> getService() {
		return formDataService;
	}

	@Autowired
	private FormDataService formDataService;

	public void queryTreeList() {
		this.returnResult(formDataService.queryTreeList(object.getNode(),
				Convert.toBoolean(request.getParameter("isNoLeaf")),
				ParamFactory.getParam()
						.is("dataTypeId", object.getDataTypeId())));
	}

}
