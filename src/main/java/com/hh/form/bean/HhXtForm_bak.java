package com.hh.form.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.hh.hibernate.util.base.BaseEntity;

//@Entity
//@Table(name = "HH_XT_FORM")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class HhXtForm_bak extends BaseEntity implements java.io.Serializable {
	private String formSource;
	private String tableName;
	private String dataId;
	private String packageName;

	@Column(nullable = false, length = 36)
	public String getDataId() {
		return dataId;
	}

	public void setDataId(String dataId) {
		this.dataId = dataId;
	}

	@Lob
	public String getFormSource() {
		return formSource;
	}

	public void setFormSource(String formSource) {
		this.formSource = formSource;
	}

	@Column(length = 32)
	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	@Column(length = 128)
	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

}
