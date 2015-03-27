package com.hh.form.service.impl;

import org.springframework.stereotype.Service;

import com.hh.form.bean.HhCkFormTree;
import com.hh.system.service.impl.BaseService;

@Service
public class CkFormTreeService extends BaseService<HhCkFormTree> {

	public void updateHtml(HhCkFormTree object) {
		dao.updateEntity("update " + HhCkFormTree.class.getName()
				+ " set html=:html,jsonConfig=:jsonConfig,eventList=:eventList where id=:id", object);

	}
}
