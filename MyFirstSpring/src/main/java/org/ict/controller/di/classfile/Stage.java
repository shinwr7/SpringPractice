package org.ict.controller.di.classfile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Stage {

	// Singer ���� @Autowired�� ���̸�, �����̳� ���ο�
	// ��ġ�ϴ� �ڷ����� �����ϸ� �ڵ����� �������踦 ������ݴϴ�.
	@Autowired
	private Singer singer;
	
	// ��ü ������ ������ SingerŸ���� �Ķ���ͷ� �����ؾ���
	public Stage(Singer singer) {
		this.singer = singer;
	}
	
	public void perform() {
		System.out.print("���뿡�� ");
		// ���� ������ ������ ���.
		singer.sing();
	}
	
}
