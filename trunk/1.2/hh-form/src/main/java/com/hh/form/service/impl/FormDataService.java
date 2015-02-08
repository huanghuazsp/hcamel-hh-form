package com.hh.form.service.impl;

import org.springframework.stereotype.Service;

import com.hh.form.bean.FormData;
import com.hh.system.service.impl.BaseMongoService;
import com.hh.system.util.dto.ParamFactory;
import com.hh.system.util.dto.ParamInf;
import com.hh.system.util.statics.StaticVar;

@Service
public class FormDataService extends BaseMongoService<FormData> {
	protected boolean checkTextOnly(FormData entity) {
		return dao.count(
				FormData.class,
				ParamFactory.getParam().is(StaticVar.text, entity.getText())
						.ne(StaticVar.entityId, entity.getId())
						.is("node", entity.getNode())
						.is("dataTypeId", entity.getDataTypeId())) > 0 ? true
				: false;
	}

}
