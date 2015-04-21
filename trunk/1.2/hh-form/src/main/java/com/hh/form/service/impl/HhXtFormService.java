package com.hh.form.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hh.form.bean.HhXtForm;
import com.hh.form.bean.model.Column;
import com.hh.form.util.FormUtil;
import com.hh.hibernate.dao.inf.IHibernateDAO;
import com.hh.system.util.Check;
import com.hh.system.util.Convert;
import com.hh.system.util.MessageException;
import com.hh.system.util.dto.ParamFactory;

@Service
public class HhXtFormService {

	@Autowired
	private IHibernateDAO<HhXtForm> xtFormDAO;
//	@Autowired
//	private HhXtDataService hhXtDataService;
	
	@Autowired
	private FormTreeService formTreeService;
	@Autowired
	private CreateTableService createTableService;

	public HhXtForm save(HhXtForm hhXtForm, boolean deleteTable)
			throws MessageException {
		if (checkTableNameOnly(hhXtForm)) {
			throw new MessageException("表名称不能一致：" + hhXtForm.getTableName());
		}

		if ("FORM_".equals(hhXtForm.getTableName())) {
			throw new MessageException("请输入表名！");
		}
		int count = createTableService.isDataBaseTable(hhXtForm.getTableName());

		if (count < 1) {
			deleteTable = true;
		}

		String oldTableName = null;
		HhXtForm hhXtForm1 = null;
		List<String> sqlList = new ArrayList<String>();
		if (Check.isEmpty(hhXtForm.getId())) {
			xtFormDAO.createEntity(hhXtForm);

		} else {
			hhXtForm1 = xtFormDAO.findEntityByPK(HhXtForm.class,
					hhXtForm.getId());
			oldTableName = hhXtForm1.getTableName();
			xtFormDAO.mergeEntity(hhXtForm);
		}
		List<Column> columnList = FormUtil.xtFormToColumn(hhXtForm
				.getFormSource());
		sqlList = FormUtil.getCreateTableSql(hhXtForm.getTableName(),
				columnList, deleteTable, oldTableName,
				createTableService.queryColumnsByTableName(oldTableName));
		createTableService.createTable(oldTableName, sqlList, deleteTable,
				count);
		return hhXtForm;
	}

	private boolean checkTableNameOnly(HhXtForm hhXtForm) {
		return xtFormDAO
				.findWhetherData(
						"select count(o) from "
								+ hhXtForm.getClass().getName()
								+ " o "
								+ "where lower(o.tableName)=lower(:tableName) and (o.id!=:id or :id is null) ",
						hhXtForm);
	}

	public HhXtForm findObjectByDataId(String dataId) {
		HhXtForm hhXtForm = xtFormDAO.findEntity(HhXtForm.class,
				ParamFactory.getParamHb().is("dataId",
						dataId));
		return hhXtForm;
	}

	public HhXtForm findObjectById(String id) {
		HhXtForm hhXtForm = xtFormDAO.findEntityByPK(HhXtForm.class, id);
		return hhXtForm;
	}

	public void deleteByIds(String ids) {
		List<String> deleteList =formTreeService.deleteTreeByIds(ids);
//		List<String> deleteList = Convert.strToList(ids); 
		List<HhXtForm> hhXtForms = xtFormDAO.queryList(HhXtForm.class,
				ParamFactory.getParamHb().in("dataId",
						deleteList));
		for (HhXtForm hhXtForm : hhXtForms) {
			createTableService.deleteTableByTableName(hhXtForm.getTableName());
		}

		xtFormDAO.deleteEntity(HhXtForm.class, "dataId", deleteList);
	}

	public List<Column> queryColumnList(HhXtForm hhXtForm) {

		List<Column> columnList = FormUtil.xtFormToColumn(hhXtForm
				.getFormSource());
		List<String> columnIdList = new ArrayList<String>();
		for (Column column : columnList) {
			columnIdList.add(column.getName());
		}

		List<Column> columnsList = createTableService
				.queryColumnsByTableName(hhXtForm.getTableName());
		for (Column map : columnsList) {
			String columnName = map.getName();
			if (!columnIdList.contains(columnName)) {
				map.setIsInForm("0");
			} else {
				map.setIsInForm("1");
			}
		}
		return columnsList;
	}

	public void deleteColumnByIdsTabName(String ids, String tableName) {
		createTableService.deleteColumnByIdsTabName(Convert.strToList(ids),
				tableName);
	}

}
