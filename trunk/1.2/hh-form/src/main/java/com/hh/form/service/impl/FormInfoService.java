package com.hh.form.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.hh.form.bean.FormInfo;
import com.hh.system.service.impl.BaseMongoService;
import com.hh.system.util.StaticVar;
import com.hh.system.util.dto.ParamFactory;

@Service
public class FormInfoService extends BaseMongoService<FormInfo> {
	@Override
	protected boolean getCache() {
		return true;
	}

	public void updateHtml(FormInfo object) {
		Map<String, Object> updateMap = new HashMap<String, Object>();
		updateMap.put("html", object.getHtml());
		updateMap.put("jsonConfig", object.getJsonConfig());
		updateMap.put("eventList", object.getEventList());
		dao.updateEntityCache(FormInfo.class,
				ParamFactory.getParam().is(StaticVar.mongoEntityId, object.getId()),
				updateMap);
	}

}
