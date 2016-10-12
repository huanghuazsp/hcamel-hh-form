package com.hh.form.service.impl;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Service;

import com.hh.system.util.pk.PrimaryKey;
import com.hh.usersystem.bean.usersystem.SysMenu;
import com.hh.usersystem.util.steady.StaticProperties;

@Service
public class SetupInitializer {
	public static void main(String[] args) {
		System.out.println(PrimaryKey.getUUID());
	}

	@PostConstruct
	public void initialize() {
		for (SysMenu hhXtCd : StaticProperties.sysMenuList) {
			if ("系统管理".equals(hhXtCd.getText())) {
				hhXtCd.getChildren().add(new SysMenu( "xTxBOR4fbANwYEbH3U5","表单设计",
						"jsp-form-service-formmain", "/hhcommon/images/extjsico/17460321.png", 0, 1));
				break;
			}
		}
	}
}