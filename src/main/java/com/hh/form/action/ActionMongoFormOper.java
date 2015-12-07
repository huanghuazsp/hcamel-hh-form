package com.hh.form.action;

import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.form.service.impl.MongoFormOperService;
import com.hh.system.util.base.BaseAction;

@SuppressWarnings("serial")
public class ActionMongoFormOper extends BaseAction {
	private String tableName;
	private String id;
	private Map<String, Object> object;
	@Autowired
	private MongoFormOperService service;
	
	
	public Object queryPagingData() {
		return service.queryPagingData(convertMap(object), this.getPageRange(),tableName);
	}

	public Object findObjectById() {
		Map<String, Object> map = service.findObjectById(id,
				tableName);
		return map;
	}
	
	public void deleteByIds() {
		service.deleteByIds(this.getIds(),tableName);
	}

	public void save() {
		service.save(convertMap(object));
	}

	public Map<String, Object> getObject() {
		return object;
	}

	public void setObject(Map<String, Object> object) {
		this.object = object;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}
