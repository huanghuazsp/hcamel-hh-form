package com.hh.form.bean;

import javax.persistence.Column;

import com.hh.hibernate.util.base.BaseTreeNodeEntity;

public class FormData extends BaseTreeNodeEntity<FormData> {
	private String dataTypeId;

	public String getDataTypeId() {
		return dataTypeId;
	}

	public void setDataTypeId(String dataTypeId) {
		this.dataTypeId = dataTypeId;
	}

	
	private String code;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
}
