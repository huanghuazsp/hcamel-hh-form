package com.hh.form.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hh.form.bean.HhXtForm_bak;
import com.hh.form.util.FormUtil;
import com.hh.hibernate.dao.inf.IHibernateDAO;
import com.hh.system.util.Check;
import com.hh.system.util.Convert;
import com.hh.system.util.MessageException;
import com.hh.system.util.dto.PageRange;
import com.hh.system.util.dto.ParamFactory;

@Service
public class ActionFormService {
	@SuppressWarnings("rawtypes")
	@Autowired
	private IHibernateDAO hibernateDAO;

	@Autowired
	private IHibernateDAO<HhXtForm_bak> hhXtFormDAO;

	public Map<? extends String, ? extends Object> queryByTableName(
			String dataId, String keywords, PageRange pageRange) {
		HhXtForm_bak hhXtForm = hhXtFormDAO.findEntity(HhXtForm_bak.class,
				ParamFactory.getParamHb().is("dataId",
						dataId));
		String[] querySqls = null;
		if (Check.isEmpty(keywords)) {
			querySqls = FormUtil.getQueryPageSql(hhXtForm);
		} else {
			querySqls = FormUtil.getQueryPageSql(hhXtForm, true);
		}
		Map<String, Object> paraMap = new HashMap<String, Object>();
		paraMap.put("keywords", "%" + keywords + "%");
		Map<String, Object> pageMap = hibernateDAO.queryPagingData(
				querySqls[0], querySqls[1], paraMap, pageRange);
		List<Map<String, Object>> listMaps = (List<Map<String, Object>>) pageMap
				.get("items");
		List<Map<String, Object>> returnlistMaps = new ArrayList<Map<String, Object>>();
		if (!Check.isEmpty(listMaps)) {
			for (Map<String, Object> map : listMaps) {
				Map<String, Object> objectMap = FormUtil
						.mapUpperNameToWidgetName(map, hhXtForm.getFormSource());
				FormUtil.mapClobToString(objectMap);
				returnlistMaps.add(objectMap);
			}
		}
		pageMap.put("items", returnlistMaps);
		return pageMap;
	}

	public Map<String, Object> findObjectById(String id, String tableName) {
		HhXtForm_bak hhXtForm = hhXtFormDAO.findEntity(HhXtForm_bak.class,
				ParamFactory.getParamHb().is("tableName",
						tableName));
		Map<String, Object> map = hibernateDAO.findEntity(tableName, id);
		Map<String, Object> objectMap = FormUtil.mapUpperNameToWidgetName(map,
				hhXtForm.getFormSource());
		FormUtil.mapClobToString(objectMap);
		return objectMap;
	}

	public void deleteByIds(String ids, String tableName) {
		String sql = FormUtil.getDeleteDataSql(tableName);
		List<String> idList = Convert.strToList(ids);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ids", idList);
		hibernateDAO.executeSql(sql, map);
	}

	public Map<String, Object> save(Map<String, Object> parameterMap)
			throws MessageException {

		String dataId = (String) parameterMap.get("dataId");

		HhXtForm_bak hhXtForm = hhXtFormDAO.findEntity(HhXtForm_bak.class,
				ParamFactory.getParamHb().is("dataId",
						dataId));

		FormUtil.typeConversion(parameterMap, hhXtForm);

		if (parameterMap.get("id") == null || "".equals(parameterMap.get("id"))) {
			String sql = FormUtil.getInsertDataSql(hhXtForm);
			parameterMap.put("id", UUID.randomUUID().toString());
			hibernateDAO.executeSql(sql, parameterMap);
		} else {
			String sql = FormUtil.getUpdateDataSql(hhXtForm);
			hibernateDAO.executeSql(sql, parameterMap);
		}
		return parameterMap;
	}

	public Map<String, Object> workflowSave(Map<String, Object> parameterMap)
			throws MessageException {
		String dataId = (String) parameterMap.get("dataId");
		HhXtForm_bak hhXtForm = hhXtFormDAO.findEntity(HhXtForm_bak.class,
				ParamFactory.getParamHb().is("dataId",
						dataId));
		FormUtil.typeConversion(parameterMap, hhXtForm);
		if ("insert".equals(parameterMap.get("saveType"))) {
			parameterMap.put("id", UUID.randomUUID().toString());
			String sql = FormUtil.getInsertDataSql(hhXtForm);
			hibernateDAO.executeSql(sql, parameterMap);
		} else {
			String sql = FormUtil.getUpdateDataSql(hhXtForm);
			hibernateDAO.executeSql(sql, parameterMap);
		}
		return parameterMap;
	}
}
