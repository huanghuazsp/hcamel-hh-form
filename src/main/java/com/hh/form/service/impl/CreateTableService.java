package com.hh.form.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hh.form.bean.model.Column;
import com.hh.hibernate.dao.inf.IHibernateDAO;
import com.hh.system.util.Check;
import com.hh.system.util.Convert;
import com.hh.system.util.SysParam;

@Service
public class CreateTableService {
	@SuppressWarnings("rawtypes")
	@Autowired
	private IHibernateDAO hibernateDAO;
	private static final Logger logger = Logger
			.getLogger(CreateTableService.class);
	public void createTable(String tableName, List<String> sqlList,
			boolean deleteTable, int count) {

		if (count > 0) {
			if (deleteTable) {
				hibernateDAO.executeSql("drop table " + tableName);
			}
		}
		for (String string : sqlList) {
			hibernateDAO.executeSql(string);
		}

	}

	public int isDataBaseTable(String tableName) {
		int count = 0;
		if (SysParam.DATABASE.equals("mysql")) {
			count = hibernateDAO
					.findCountBySql(
							"SELECT	COUNT(*)  FROM	information_schema. TABLES WHERE TABLES .TABLE_NAME = ? AND TABLES .TABLE_SCHEMA = ?",
							new Object[] { tableName, SysParam.DATABASE_SCHEMA });
		} else if (SysParam.DATABASE.equals("oracle")) {
			count = hibernateDAO
					.findCountBySql(
							"select COUNT(*) from TABS t where lower(t.table_name)=lower(?)",
							new Object[] { tableName });
		}
		return count;
	}

	public void deleteTableByTableName(String tableName) {
		hibernateDAO.executeSql("drop table " + tableName);
	}

	public List<Column> queryColumnsByTableName(String tableName) {
		List<Column> columns = new ArrayList<Column>();
		if (Check.isEmpty(tableName)) {
			return columns;
		}

		List<Map<String, Object>> returnMaps = new ArrayList<Map<String, Object>>();
		if (SysParam.DATABASE.equals("mysql")) {
			returnMaps = hibernateDAO.queryListBySql(
					"select * from information_schema.`COLUMNS`  where TABLE_SCHEMA='"
							+ SysParam.DATABASE_SCHEMA + "' and TABLE_NAME='"
							+ (tableName.toLowerCase()) + "'", new HashMap<String, Object>());
		} else if (SysParam.DATABASE.equals("oracle")) {
			returnMaps = hibernateDAO
					.queryListBySql(
							"Select t.*,b.comments From user_tab_columns t  ,user_col_comments b where t.COLUMN_NAME = b.COLUMN_NAME and t.table_name = b.table_name and t.table_name ='"
									+ tableName.toUpperCase() + "'",
							new HashMap<String, Object>());
		}
		for (Map<String, Object> map : returnMaps) {
			Column column = new Column();
			column.setTableName(Convert.toString(map.get("TABLE_NAME")));
			column.setName(Convert.toString(map.get("COLUMN_NAME")));
			column.setType(Convert.toString(map.get("DATA_TYPE")));
			if (SysParam.DATABASE.equals("mysql")) {
				column.setNote(Convert.toString(map.get("COLUMN_COMMENT")));
				column.setLength(Convert.toInt(map.get("CHARACTER_MAXIMUM_LENGTH")));
			} else if (SysParam.DATABASE.equals("oracle")) {
				column.setLength(Convert.toInt(map.get("DATA_LENGTH")));
				column.setNote(Convert.toString(map.get("COMMENTS")));
			}
			columns.add(column);
		}
		return columns;
	}

	public void deleteColumnByIdsTabName(List<String> strToList,
			String tableName) {
		for (String string : strToList) {
			hibernateDAO.executeSql("alter table " + tableName
					+ " drop column " + string + "");
		}
	}
}
