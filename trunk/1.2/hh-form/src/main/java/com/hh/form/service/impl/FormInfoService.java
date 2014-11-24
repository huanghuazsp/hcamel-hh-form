package com.hh.form.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.hh.form.bean.FormInfo;
import com.hh.system.service.impl.BaseMongoService;
import com.hh.system.util.dto.ParamFactory;
import com.hh.system.util.statics.StaticVar;

@Service
public class FormInfoService extends BaseMongoService<FormInfo> {

	public void updateHtml(FormInfo object) {
		Map<String, Object> updateMap = new HashMap<String, Object>();
		updateMap.put("html", object.getHtml());
		updateMap.put("jsonConfig", object.getJsonConfig());
		dao.updateEntity(FormInfo.class,
				ParamFactory.getParam().is(StaticVar.entityId, object.getId()),
				updateMap);
	}

}
