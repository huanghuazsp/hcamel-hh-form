package com.hh.form.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.hh.form.bean.HhXtForm;
import com.hh.form.bean.model.Column;
import com.hh.form.service.impl.HhXtFormService;
import com.hh.system.util.MessageException;
import com.hh.system.util.base.BaseAction;
import com.hh.system.util.model.ReturnModel;
import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings("serial")
public class ActionFormWidget extends BaseAction implements
		ModelDriven<HhXtForm> {
	private HhXtForm hhXtForm = new HhXtForm();
	private int deleteTable;
	@Autowired
	private HhXtFormService hhXtFormService;

	public void save() {
		try {
			HhXtForm hhXtForm = hhXtFormService
					.save(this.hhXtForm, deleteTable==1);
			this.getResultMap().put("object", hhXtForm);
		} catch (MessageException e) {
			this.getResultMap().put("returnModel",
					new ReturnModel(e.getMessage()));
		}
		this.returnResult();
	}

	public void findObjectByDataId() {
		HhXtForm hhXtForm = hhXtFormService.findObjectByDataId(this.hhXtForm
				.getDataId());
		this.returnResult(hhXtForm);
	}

	public void findObjectById() {
		HhXtForm hhXtForm = hhXtFormService.findObjectById(this.hhXtForm
				.getId());
		this.returnResult(hhXtForm);
	}

	public void deleteByIds() {
		hhXtFormService.deleteByIds(this.getIds());
	}
	
	public void queryColumnList() {
		List<Column> maps = hhXtFormService
					.queryColumnList(this.hhXtForm);
		this.returnResult(maps);
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

	public HhXtForm getModel() {
		return hhXtForm;
	}
}
