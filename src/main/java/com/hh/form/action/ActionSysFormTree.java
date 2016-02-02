package com.hh.form.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.form.bean.SysFormTree;
import com.hh.form.service.impl.SysFormTreeService;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.base.BaseServiceAction;

@SuppressWarnings("serial")
public class ActionSysFormTree extends BaseServiceAction<SysFormTree> {
	@Autowired
	private SysFormTreeService service;

	public BaseService<SysFormTree> getService() {
		return service;
	}

	public void updateHtml() {
		service.updateHtml(object);
	}

}
