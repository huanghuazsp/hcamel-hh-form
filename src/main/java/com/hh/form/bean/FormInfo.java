package com.hh.form.bean;

import com.hh.hibernate.util.base.BaseTreeNodeEntity;

public class FormInfo extends BaseTreeNodeEntity<FormInfo> {
	private String html;
	private String tableName;
	private String jsonConfig;
	private String eventList;
	
	public String getHtml() {
		return html;
	}
	public void setHtml(String html) {
		this.html = html;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getJsonConfig() {
		return jsonConfig;
	}
	public void setJsonConfig(String jsonConfig) {
		this.jsonConfig = jsonConfig;
	}
	public String getEventList() {
		return eventList;
	}
	public void setEventList(String eventList) {
		this.eventList = eventList;
	}
	
}
