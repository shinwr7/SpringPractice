package org.ict.controller.di.classfile;

import org.springframework.stereotype.Component;

// ������Ʈ ��ĵ ���
// ������̼� @Component, @Controller, @Repository, @Service �� �ϳ���
// Ŭ������ ���� �ٿ��ָ� root-context(bean container)�� �����ϴ� ����Դϴ�.
@Component
public class Singer {

	public void sing() {
		System.out.println("������ �뷡�� �մϴ�.");
	}
}
