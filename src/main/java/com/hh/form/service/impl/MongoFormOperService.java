package com.hh.form.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Service;

import com.hh.mongo.dao.inf.IMongoDAOInf;
import com.hh.system.util.Check;
import com.hh.system.util.Convert;
import com.hh.system.util.Json;
import com.hh.system.util.PrimaryKey;
import com.hh.system.util.dto.PageRange;
import com.hh.system.util.dto.PagingData;
import com.hh.system.util.dto.ParamFactory;
import com.hh.system.util.dto.ParamInf;

@Service
public class MongoFormOperService {
	@Autowired
	private IMongoDAOInf springMongoDAOImpl;

	public void save(Map<String, Object> objectMap) {
		String tableName = Convert.toString(objectMap.get("tableName"));
		String id = Convert.toString(objectMap.get("id"));
		objectMap.remove("tableName");
		objectMap.put("_id", id);
		if (Check.isEmpty(id)) {
			String uuidString = PrimaryKey.getUUID();
			objectMap.put("_id", uuidString);
			objectMap.put("id", uuidString);
		}
		springMongoDAOImpl.save(tableName, objectMap);
	}

	public Map<String, Object> findObjectById(String id, String tableName) {
		return springMongoDAOImpl.findById(tableName, id);
	}

	public PagingData<Map<String, Object>> queryPagingData(
			Map<String, Object> object, PageRange pageRange, String tableName) {
		ParamInf paramList = ParamFactory.getParam();
		if (object != null) {
			Object value = object.get("cond");
			if (Check.isNoEmpty(value)) {
				List<Map<String, Object>> baseCondMapList = Json
						.toMapList(value.toString());
				for (Map<String, Object> baseCondMap : baseCondMapList) {
					List<Criteria> criteriasList = new ArrayList<Criteria>();
					List<Map<String, Object>> condMapList = Json
							.toMapList(Convert.toString(baseCondMap.get("cond")));

					String andor = Convert.toString(baseCondMap.get("andor"));

					for (Map<String, Object> map : condMapList) {
						Object valueObject = map.get("value");
						String field = Convert.toString(map.get("field"));
						String cond = Convert.toString(map.get("cond"));

						if (Check.isNoEmpty(valueObject)) {
							Criteria criteria = new Criteria(field);
							if ("=".equals(cond)) {
								criteria.is(valueObject);
							} else if ("!=".equals(cond)) {
								criteria.ne(valueObject);
							} else {
								criteria.regex(Convert.toString(valueObject));
							}
							criteriasList.add(criteria);
						}
					}
					Criteria criteria = new Criteria();
					if (criteriasList.size() > 0) {
						Criteria[] criterias = new Criteria[criteriasList
								.size()];
						for (int i = 0; i < criteriasList.size(); i++) {
							criterias[i] = criteriasList.get(i);
						}
						if ("or".equals(andor)) {
							criteria.orOperator(criterias);
						} else {
							criteria.andOperator(criterias);
						}
					}
					paramList.add(criteria);
				}
			}
		}
		PagingData<Map<String, Object>> resultMap = springMongoDAOImpl
				.queryPage(tableName,pageRange, paramList);
		return resultMap;
	}

	public void deleteByIds(String ids, String tableName) {
		springMongoDAOImpl.remove(tableName, Convert.strToList(ids));
	}
}
