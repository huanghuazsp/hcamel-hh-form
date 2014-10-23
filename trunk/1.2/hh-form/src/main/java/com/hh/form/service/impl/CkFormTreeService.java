package com.hh.form.service.impl;

import org.springframework.stereotype.Service;

import com.hh.form.bean.HhCkFormTree;
import com.hh.system.service.impl.BaseTreeService;

@Service
public class CkFormTreeService extends BaseTreeService<HhCkFormTree> {

	public void updateHtml(HhCkFormTree object) {
		dao.updateEntity("update " + HhCkFormTree.class.getName()
				+ " set html=:html,jsonConfig=:jsonConfig where id=:id", object);

	}
}
