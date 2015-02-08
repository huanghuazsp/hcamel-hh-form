package com.hh.form.service.impl;

import org.springframework.stereotype.Service;

import com.hh.form.bean.FormData;
import com.hh.system.service.impl.BaseMongoService;
import com.hh.system.util.dto.ParamFactory;
import com.hh.system.util.dto.ParamInf;
import com.hh.system.util.statics.StaticVar;

@Service
public class FormDataService extends BaseMongoService<FormData> {
	protected boolean checkTreeTextOnly(FormData entity) {
		return dao.count(
				this.getGenericType(0),
				ParamFactory.getParam().ne(StaticVar.mongoEntityId, entity.getId()).is(StaticVar.text, entity.getText())
						.is(StaticVar.node, entity.getNode()).is("dataTypeId", entity.getDataTypeId())) > 0 ? true
				: false;
	}

}
