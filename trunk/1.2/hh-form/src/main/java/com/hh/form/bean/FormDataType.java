package com.hh.form.bean;

import javax.persistence.Column;

import com.hh.hibernate.util.base.BaseTreeNodeEntity;

public class FormDataType extends BaseTreeNodeEntity<FormDataType> {
	private String code;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

}
