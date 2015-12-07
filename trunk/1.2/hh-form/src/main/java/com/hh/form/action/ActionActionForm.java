package com.hh.form.action;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.form.service.impl.ActionFormService;
import com.hh.system.util.MessageException;
import com.hh.system.util.base.BaseAction;
import com.hh.system.util.model.ReturnModel;
import com.hh.system.util.request.Request;

@SuppressWarnings("serial")
public class ActionActionForm extends BaseAction {
	private String tableName;
	private String keywords;
	private String id;
	private String dataId;
	@Autowired
	private ActionFormService actionFormService;
	private Map<String, String> userMap = new HashMap<String, String>();
	public Object queryPagingDataByTableName() {
		return actionFormService.queryByTableName(dataId, keywords,
				this.getPageRange());
	}

	public Object findObjectById() {
		Map<String, Object> map = actionFormService.findObjectById(id,
				tableName);
		return map;
	}

	public Object save() {
		try {
			Map<String, Object> paraMap =Request.getParamMapByRequest(request);
			Map<String, Object> map = actionFormService.save(paraMap);
		} catch (MessageException e) {
			return e;
		}
		return null;
	}
	public Object workflowSave() {
		try {
			Map<String, Object> paraMap =Request.getParamMapByRequest(request);
			Map<String, Object> map = actionFormService.workflowSave(paraMap);
		} catch (MessageException e) {
			return e;
		}
		return null;
	}
	
	public void deleteByIds() {
		actionFormService.deleteByIds(this.getIds(),tableName);
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
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

	public String getDataId() {
		return dataId;
	}

	public void setDataId(String dataId) {
		this.dataId = dataId;
	}

	public Map<String, String> getUserMap() {
		return userMap;
	}

	public void setUserMap(Map<String, String> userMap) {
		this.userMap = userMap;
	}
	
	
}
