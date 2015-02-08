package com.hh.form.bean;

import com.hh.hibernate.util.base.BaseTreeNodeEntity;

public class FormData extends BaseTreeNodeEntity<FormData> {
	private String dataTypeId;

	public String getDataTypeId() {
		return dataTypeId;
	}

	public void setDataTypeId(String dataTypeId) {
		this.dataTypeId = dataTypeId;
	}

}
