package com.hh.form.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.form.bean.HhFormTree;
import com.hh.form.service.impl.FormTreeService;
import com.hh.system.service.impl.BaseTreeService;
import com.hh.system.util.base.BaseServiceAction;

@SuppressWarnings("serial")
public class ActionFormTree extends  BaseServiceAction<HhFormTree>{
	@Autowired
	private FormTreeService service;
	public BaseTreeService<HhFormTree> getService() {
		return service;
	}

}
