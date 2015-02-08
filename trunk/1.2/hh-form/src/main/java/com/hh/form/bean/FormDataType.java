package com.hh.form.bean;

import com.hh.hibernate.util.base.BaseTreeNodeEntity;

public class FormDataType extends BaseTreeNodeEntity<FormDataType> {
	private String type;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}
