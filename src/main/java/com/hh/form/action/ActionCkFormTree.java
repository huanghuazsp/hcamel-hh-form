package com.hh.form.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.form.bean.HhCkFormTree;
import com.hh.form.service.impl.CkFormTreeService;
import com.hh.system.service.impl.BaseTreeService;
import com.hh.system.util.MessageException;
import com.hh.system.util.base.BaseServiceAction;
import com.hh.system.util.model.ReturnModel;

@SuppressWarnings("serial")
public class ActionCkFormTree extends BaseServiceAction<HhCkFormTree> {
	@Autowired
	private CkFormTreeService service;

	public BaseTreeService<HhCkFormTree> getService() {
		return service;
	}

	public void updateHtml() {
		service.updateHtml(object);
	}

}
