package com.hh.form.service.impl;

import java.util.UUID;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Service;

import com.hh.usersystem.bean.usersystem.SysMenu;
import com.hh.usersystem.util.steady.StaticProperties;

@Service
public class SetupInitializerForm {
	public static void main(String[] args) {
		System.out.println(UUID.randomUUID().toString());
	}

	@PostConstruct
	public void initialize() {
		for (SysMenu hhXtCd : StaticProperties.hhXtCds) {
			if ("系统管理".equals(hhXtCd.getText())) {
				hhXtCd.getChildren().add(new SysMenu("6db7d002-da87-4c6f-832b-929aa6e64111", "表单设计",
						"jsp-form-service-formmain", "/hhcommon/images/extjsico/17460321.png", 0, 1));
				break;
			}
		}
	}
}