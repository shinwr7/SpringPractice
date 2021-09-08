package org.ict.controller.di.classfile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Broadcast {
	
	private Stage stage;
	
	// @Autowired�� �̿��� ������ �����ڿ��� ������ �� �ֽ��ϴ�.
	@Autowired
	public Broadcast(Stage stage) {
		this.stage = stage;
	}
	
	public void broadcast() {
		System.out.print("��� ����� ");
		stage.perform();
	}
}
