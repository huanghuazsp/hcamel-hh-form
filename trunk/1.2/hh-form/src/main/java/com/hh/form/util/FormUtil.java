package com.hh.form.util;

import java.io.BufferedReader;
import java.io.StringWriter;
import java.lang.reflect.InvocationTargetException;
import java.sql.Clob;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.beanutils.BeanUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.hh.form.bean.HhXtForm_bak;
import com.hh.form.bean.model.Column;
import com.hh.system.util.Check;
import com.hh.system.util.Convert;
import com.hh.system.util.date.DateFormat;
import com.hh.system.util.statics.StaticVar;

public class FormUtil {
	public static List<Column> xtFormToColumn(String formSource) {
		try {
			List<Column> columnList = new ArrayList<Column>();
			JSONArray userArray = new JSONArray(formSource);
			for (int i = 0; i < userArray.length(); i++) {
				JSONObject jsonObject = userArray.getJSONObject(i);
				String[] names = JSONObject.getNames(jsonObject);
				Map<String, Object> colMap = new HashMap<String, Object>();
				if (StaticVar.DATABASE.equals("mysql")) {
					for (String name : names) {
						if ("name".equals(name)) {
							colMap.put("name", jsonObject.get(name));
						} else if ("maxLength".equals(name)) {
							colMap.put("length", jsonObject.get(name));
							Long length = Convert.toLong(jsonObject.get(name));
							if (length > 512) {
								colMap.put("type", "text");
							} else if (length > 65535) {
								colMap.put("type", "longtext");
							}
						} else if ("xtype".equals(name)) {
							if (Check.isEmpty(colMap.get("type"))) {
								String xtype = (String) jsonObject.get(name);
								if ("widgetDateTimer".equals(xtype)
										|| "widgetDateField".equals(xtype)
										|| "widgetDateTimer".equals(xtype)) {
									colMap.put("type", "datetime");
								} else if ("numberfield".equals(xtype)) {
									colMap.put("type", "decimal(38,0)");
								} else if ("htmleditor".equals(xtype)) {
									colMap.put("type", "longtext");
								} else {
									colMap.put("type", "text");
								}
							}
						} else if ("allowBlank".equals(name)) {
							colMap.put("empty", jsonObject.get(name));
						} else if ("value".equals(name)) {
							colMap.put("defaultValue", jsonObject.get(name));
						} else if ("fieldLabel".equals(name)) {
							colMap.put("note", jsonObject.get(name));
						}
					}
				} else if (StaticVar.DATABASE.equals("oracle")) {
					for (String name : names) {
						if ("name".equals(name)) {
							colMap.put("name", jsonObject.get(name));
						} else if ("maxLength".equals(name)) {
							colMap.put("length", jsonObject.get(name));
							Long length = Convert.toLong(jsonObject.get(name));
							if (length > 2000) {
								colMap.put("type", "CLOB");
							}
						} else if ("xtype".equals(name)) {
							if (Check.isEmpty(colMap.get("type"))) {
								String xtype = (String) jsonObject.get(name);
								if ("datefield".equals(xtype)
										|| "widgetDateField".equals(xtype)
										|| "widgetDateTimer".equals(xtype)) {
									colMap.put("type", "TIMESTAMP");
								} else if ("numberfield".equals(xtype)) {
									colMap.put("type", "NUMBER");
								} else if ("htmleditor".equals(xtype)) {
									colMap.put("type", "CLOB");
								} else {
									colMap.put("type", "VARCHAR2");
								}
							}
						} else if ("allowBlank".equals(name)) {
							colMap.put("empty", jsonObject.get(name));
						} else if ("value".equals(name)) {
							colMap.put("defaultValue", jsonObject.get(name));
						} else if ("fieldLabel".equals(name)) {
							colMap.put("note", jsonObject.get(name));
						}
					}
				}
				Column column = new Column();
				try {
					BeanUtils.populate(column, colMap);
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				}
				columnList.add(column);
			}
			return columnList;
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static List<String> getCreateTableSql(String tableName,
			List<Column> columnList, boolean deleteTable, String oldTableName,
			List<Column> list) {
		List<String> sqlList = new ArrayList<String>();
		if (deleteTable) {
			if (StaticVar.DATABASE.equals("mysql")) {
				sqlList = createMysqlTable(tableName, columnList);
			} else if (StaticVar.DATABASE.equals("oracle")) {
				sqlList = createTable(tableName, columnList);
			}
		} else {
			if (tableName.equals(oldTableName)) {
				if (StaticVar.DATABASE.equals("mysql")) {
					sqlList = alterMysqlTable(tableName, columnList, list);
				} else if (StaticVar.DATABASE.equals("oracle")) {
					sqlList = alterTable(tableName, columnList, list);
				}
			} else {
				if (StaticVar.DATABASE.equals("mysql")) {
					sqlList = createMysqlTable(tableName, columnList);
				} else if (StaticVar.DATABASE.equals("oracle")) {
					sqlList = createTable(tableName, columnList);
				}
			}
		}
		return sqlList;
	}

	private static List<String> alterMysqlTable(String tableName,
			List<Column> columnList, List<Column> list) {
		Map<String, Column> map = Convert.listToMap(list, "getName");
		Set<String> oldKeySet = map.keySet();
		List<String> sqlList = new ArrayList<String>();
		for (Column column : columnList) {
			if (oldKeySet.contains(column.getName().toUpperCase())) {
				Column oldColumn = map.get(column.getName().toUpperCase());
				String oldConType = Convert.toString(oldColumn.getType());
				String oldConLength = Convert.toString(oldColumn.getLength());
				int oldLength = 0;
				if (Check.isNumber(oldConLength)) {
					oldLength = Integer.valueOf(oldConLength);
				}
				if (!oldConType.equalsIgnoreCase(column.getType())
						|| oldLength != column.getLength()) {
					sqlList.add("alter table " + tableName + " modify  COLUMN"
							+ "`" + column.getName() + "` " + column.getType()
							+ "   DEFAULT " + column.getDefaultValue()
							+ " COMMENT '" + column.getNote() + "'");
				}
			} else {
				sqlList.add("alter table " + tableName + " add  COLUMN" + "`"
						+ column.getName() + "` " + column.getType()
						+ "   DEFAULT " + column.getDefaultValue()
						+ " COMMENT '" + column.getNote() + "'");
			}
		}
		return sqlList;
	}

	private static List<String> alterTable(String tableName,
			List<Column> columnList, List<Column> list) {
		Map<String, Column> map = Convert.listToMap(list, "getName");
		Set<String> oldKeySet = map.keySet();
		List<String> sqlList = new ArrayList<String>();
		for (Column column : columnList) {
			String length = "";
			length = "("
					+ ("TIMESTAMP".equals(column.getType()) ? 6 : (column
							.getLength() * 2)) + ") ";
			if ("CLOB".equals(column.getType())
					|| "BLOB".equals(column.getType())) {
				length = "";
			}
			if (oldKeySet.contains(column.getName().toUpperCase())) {
				Column oldColumn = map.get(column.getName().toUpperCase());
				String oldConType = Convert.toString(oldColumn.getType());
				String oldConLength = Convert.toString(oldColumn.getLength());
				int oldLength = 0;
				if (Check.isNumber(oldConLength)) {
					oldLength = Integer.valueOf(oldConLength);
				}
				if (!oldConType.equalsIgnoreCase(column.getType())
						|| oldLength != column.getLength()) {
					if ("CLOB".equalsIgnoreCase(oldConType)
							&& "CLOB".equalsIgnoreCase(column.getType())) {
					} else {
						sqlList.add("alter table " + tableName + " modify "
								+ column.getName() + " " + column.getType()
								+ "" + length);
					}
				}
			} else {
				sqlList.add("alter table " + tableName + " add "
						+ column.getName() + " " + column.getType() + ""
						+ length);
			}
			String sql = "comment on column " + tableName + "."
					+ column.getName() + "  is '" + column.getNote() + "'";
			sqlList.add(sql);
		}
		return sqlList;
	}

	private static List<String> createTable(String tableName,
			List<Column> columnList) {
		List<String> sqlList = new ArrayList<String>();
		StringBuffer createTableSql = new StringBuffer("");
		createTableSql.append("create table " + tableName + " ( ");
		for (Column column : columnList) {

			String length = "";
			if (!"CLOB".equals(column.getType())
					&& !"BLOB".equals(column.getType())) {
				length = "("
						+ ("TIMESTAMP".equals(column.getType()) ? 6 : (column
								.getLength() * 2)) + ") ";
			}

			createTableSql.append(column.getName() + " " + column.getType()
					+ length);
			if (!column.isEmpty()) {
				createTableSql.append(" not null ");
			}
			createTableSql.append(" , ");

		}
		createTableSql.append("id VARCHAR2(64) not null primary key");
		createTableSql.append(" ) ");

		sqlList.add(createTableSql.toString());

		for (Column column : columnList) {
			String sql = "comment on column " + tableName + "."
					+ column.getName() + "  is '" + column.getNote() + "'";
			sqlList.add(sql);
		}
		return sqlList;
	}

	private static List<String> createMysqlTable(String tableName,
			List<Column> columnList) {
		List<String> sqlList = new ArrayList<String>();
		StringBuffer createTableSql = new StringBuffer("");
		createTableSql.append("create table " + tableName + " ( ");
		for (Column column : columnList) {
			createTableSql.append("`" + column.getName() + "` "
					+ column.getType() + "   DEFAULT "
					+ column.getDefaultValue() + " COMMENT '"
					+ column.getNote() + "',");
		}
		createTableSql.append("`ID` varchar(64) NOT NULL,");
		createTableSql.append("PRIMARY KEY (`ID`) ) ");
		sqlList.add(createTableSql.toString());
		return sqlList;
	}

	public static String getInsertDataSql(HhXtForm_bak hhXtForm) {
		List<Column> columnList = xtFormToColumn(hhXtForm.getFormSource());
		StringBuffer sqlkey = new StringBuffer("(");
		StringBuffer sqlvalue = new StringBuffer("(");
		for (Column column : columnList) {
			sqlkey.append(column.getName() + ",");
			sqlvalue.append(":" + column.getName() + ",");
		}
		sqlkey.append("id)");
		sqlvalue.append(":id)");
		String sql = "insert into " + hhXtForm.getTableName() + " "
				+ sqlkey.toString() + " values " + sqlvalue.toString();
		return sql;
	}

	public static String getUpdateDataSql(HhXtForm_bak hhXtForm) {
		StringBuffer stringBuffer = new StringBuffer();
		List<Column> columnList = xtFormToColumn(hhXtForm.getFormSource());

		for (int i = 0; i < columnList.size(); i++) {
			Column column = columnList.get(i);
			stringBuffer.append(column.getName() + "=:" + column.getName());
			if (i != columnList.size() - 1) {
				stringBuffer.append(",");
			}
		}
		String sql = "update " + hhXtForm.getTableName() + " set  "
				+ stringBuffer.toString() + " where id=:id";
		return sql;
	}

	public static String[] getQueryPageSql(HhXtForm_bak hhXtForm) {
		return getQueryPageSql(hhXtForm, false);
	}

	public static String[] getQueryPageSql(HhXtForm_bak hhXtForm, boolean isKeywords) {
		StringBuffer sql = new StringBuffer("select * FROM "
				+ hhXtForm.getTableName() + "   ");
		StringBuffer countsql = new StringBuffer("select count(*) FROM "
				+ hhXtForm.getTableName() + "   ");
		if (isKeywords) {
			List<Column> columnList = xtFormToColumn(hhXtForm.getFormSource());
			sql.append(" where ");
			countsql.append(" where ");
			for (Column column : columnList) {
				sql.append(column.getName() + "|| ");
				countsql.append(column.getName() + "|| ");
			}
			sql.append(" id like :keywords");
			countsql.append(" id like :keywords ");
		}

		return new String[] { sql.toString(), countsql.toString() };
	}

	public static void typeConversion(Map<String, Object> parameterMap,
			HhXtForm_bak hhXtForm) {
		List<Column> columnList = xtFormToColumn(hhXtForm.getFormSource());
		for (Column column : columnList) {
			Object value = parameterMap.get(column.getName());
			if ("TIMESTAMP".equals(column.getType())
					|| "datetime".equals(column.getType())) {
				if (value != null && !"".equals(value)) {
					parameterMap.put(column.getName(),
							DateFormat.strToDate(value.toString()));
				}
			} else if (column.getType().startsWith("decimal")) {
				parameterMap.put(column.getName(),
						Convert.toInt(value.toString()));
			}
			if (value == null) {
				parameterMap.put(column.getName(), "");
			}
		}
	}

	public static String getDeleteDataSql(String tableName) {
		return "delete from " + tableName + " where id in ( :ids )";
	}

	public static String dataBaseTypeToJavaType(String dataBaseType) {
		if ("TIMESTAMP".equals(dataBaseType)) {
			return "java.util.Date";
		} else if ("NUMBER".equals(dataBaseType)) {
			return "Long";
		} else if ("VARCHAR2".equals(dataBaseType)) {
			return "String";
		} else if ("CLOB".equals(dataBaseType)) {
			return "String";
		} else {
			System.err.println("类型没有定义！！！");
			return "String";
		}
	}

	public static void mapClobToString(Map<String, Object> map) {
		if (map == null) {
			return;
		}
		Set<String> set = map.keySet();
		for (String key : set) {
			Object object = map.get(key);
			if (object instanceof Clob) {
				try {
					Clob clob = ((Clob) object);
					BufferedReader in = new BufferedReader(
							clob.getCharacterStream());
					StringWriter out = new StringWriter();
					int c;
					while ((c = in.read()) != -1) {
						out.write(c);
					}
					map.put(key, out.toString());
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	public static Map<String, Object> mapUpperNameToWidgetName(
			Map<String, Object> map, String formSource) {
		if (map == null) {
			return null;
		}
		Map<String, Object> objectMap = new HashMap<String, Object>();
		List<Column> columnList = xtFormToColumn(formSource);
		Set<String> keySet = map.keySet();
		for (String key : keySet) {
			boolean as = true;
			for (Column column : columnList) {
				if (key.toUpperCase().equals(column.getName().toUpperCase())) {
					objectMap.put(column.getName(), map.get(key));
					as = false;
				}
			}
			if (as) {
				objectMap.put(key, map.get(key));
			}
		}
		objectMap.put("id", objectMap.get("ID"));
		return objectMap;
	}
}
