package com.hh.form.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.form.bean.HhCkFormTree;
import com.hh.form.service.impl.CkFormTreeService;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.base.BaseServiceAction;

@SuppressWarnings("serial")
public class ActionCkFormTree extends BaseServiceAction<HhCkFormTree> {
	@Autowired
	private CkFormTreeService service;

	public BaseService<HhCkFormTree> getService() {
		return service;
	}

	public void updateHtml() {
		service.updateHtml(object);
	}

}
