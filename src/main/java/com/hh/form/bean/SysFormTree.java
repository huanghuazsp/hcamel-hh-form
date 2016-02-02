package com.hh.form.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.hh.hibernate.util.base.BaseTreeNodeEntity;

@Entity
@Table(name = "SYS_FORM_TREE")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SysFormTree extends BaseTreeNodeEntity<SysFormTree> {
	private String html;
	private String tableName;
	private String jsonConfig;
	private String eventList;
	
	@Lob
	@Column(name = "HTML_")
	public String getHtml() {
		return html;
	}

	public void setHtml(String html) {
		this.html = html;
	}
	@Column(name = "TABLE_NAME_")
	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	@Lob
	@Column(name = "JSON_CONFIG_")
	public String getJsonConfig() {
		return jsonConfig;
	}

	public void setJsonConfig(String jsonConfig) {
		this.jsonConfig = jsonConfig;
	}
	@Lob
	@Column(name = "EVENT_LIST_")
	public String getEventList() {
		return eventList;
	}

	public void setEventList(String eventList) {
		this.eventList = eventList;
	}
	
}
