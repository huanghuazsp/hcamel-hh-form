package com.hh.form.service.impl;

import org.springframework.stereotype.Service;

import com.hh.form.bean.SysFormTree;
import com.hh.system.service.impl.BaseService;

@Service
public class SysFormTreeService extends BaseService<SysFormTree> {

	public void updateHtml(SysFormTree object) {
		dao.updateEntity("update " + SysFormTree.class.getName()
				+ " set html=:html,jsonConfig=:jsonConfig,eventList=:eventList where id=:id", object);

	}
}
