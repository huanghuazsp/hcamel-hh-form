package com.hh.form.service.impl;

import java.util.ArrayList;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Service;

import com.hh.usersystem.bean.usersystem.HhXtCd;
import com.hh.usersystem.util.steady.StaticProperties;

@Service
public class SetupInitializerForm {

	@PostConstruct
	public void initialize() {
		HhXtCd rootHhXtCd = new HhXtCd("94805849-70ae-4504-8192-2ab56fc83bb5",
				"表单设计", "com.hh.global.NavigAtionWindow",
				"/hhcommon/images/icons/world/world.png", 1, 0);
		rootHhXtCd.setChildren(new ArrayList<HhXtCd>());
//		rootHhXtCd.getChildren().add(
//				new HhXtCd("cd9f0f50-0813-4d34-aa2d-6956c3d92b44", "表单设计器",
//						"com.hh.form.MainFormDesigner",
//						"/hhcommon/images/icons/world/world.png", 0, 1));
		
		rootHhXtCd.getChildren().add(
				new HhXtCd("8d86355a-0c6e-4f2a-a1c7-f4c31e744988", "表单结果",
						"jsp-form-service-formtree",
						"/hhcommon/images/icons/world/world.png", 0, 1));

		rootHhXtCd.getChildren().add(
				new HhXtCd("0233e554-5735-4586-a100-a62a84c0f71b",
						"表单设计器CkEditor", "jsp-form-ckeditor-ckEditor",
						"/hhcommon/images/icons/world/world.png", 0, 1));

		rootHhXtCd.getChildren().add(
				new HhXtCd("8bc6e72d-27b2-46eb-aef7-d073d89bbd1b", "表单模板",
						"jsp-form-ckeditor-formmodel",
						"/hhcommon/images/icons/world/world.png", 0, 1));

		for (HhXtCd hhXtCd : StaticProperties.hhXtCds) {
			if ("系统管理".equals(hhXtCd.getText())) {
				hhXtCd.getChildren().add(rootHhXtCd);
				break;
			}
		}

		// StaticProperties.hhXtCds.add(rootHhXtCd);
	}
}