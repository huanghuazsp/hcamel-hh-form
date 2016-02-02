package com.hh.form.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.form.bean.HhFormTree_bak;
import com.hh.form.service.impl.FormTreeService;
import com.hh.system.service.impl.BaseService;
import com.hh.system.util.base.BaseServiceAction;

@SuppressWarnings("serial")
public class ActionFormTree extends  BaseServiceAction<HhFormTree_bak>{
	@Autowired
	private FormTreeService service;
	public BaseService<HhFormTree_bak> getService() {
		return service;
	}

}
