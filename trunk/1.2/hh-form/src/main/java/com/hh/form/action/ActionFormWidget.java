package com.hh.form.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.form.bean.HhXtForm_bak;
import com.hh.form.bean.model.Column;
import com.hh.form.service.impl.HhXtFormService;
import com.hh.system.util.MessageException;
import com.hh.system.util.base.BaseAction;
import com.hh.system.util.model.ReturnModel;
import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings("serial")
public class ActionFormWidget extends BaseAction implements
		ModelDriven<HhXtForm_bak> {
	private HhXtForm_bak hhXtForm = new HhXtForm_bak();
	private int deleteTable;
	@Autowired
	private HhXtFormService hhXtFormService;

	public Object save() {
		try {
			HhXtForm_bak hhXtForm = hhXtFormService
					.save(this.hhXtForm, deleteTable==1);
		} catch (MessageException e) {
			return e;
		}
		return null;
	}

	public Object findObjectByDataId() {
		HhXtForm_bak hhXtForm = hhXtFormService.findObjectByDataId(this.hhXtForm
				.getDataId());
		return hhXtForm;
	}

	public Object findObjectById() {
		HhXtForm_bak hhXtForm = hhXtFormService.findObjectById(this.hhXtForm
				.getId());
		return hhXtForm;
	}

	public void deleteByIds() {
		hhXtFormService.deleteByIds(this.getIds());
	}
	
	public Object queryColumnList() {
		List<Column> maps = hhXtFormService
					.queryColumnList(this.hhXtForm);
		return maps;
	}
	
	public void deleteColumnByIdsTabName(){
		hhXtFormService.deleteColumnByIdsTabName(this.getIds(),hhXtForm.getTableName());
	}

	public int isDeleteTable() {
		return deleteTable;
	}

	public void setDeleteTable(int deleteTable) {
		this.deleteTable = deleteTable;
	}

	public HhXtForm_bak getModel() {
		return hhXtForm;
	}
}
