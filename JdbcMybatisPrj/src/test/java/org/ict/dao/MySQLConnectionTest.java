package org.ict.dao;


import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;


// @Log4j는 로깅 기능을 쓸 수 있도록 도와줍니다.
// System.out.println(); 같은 경우는 로깅만을 목적으로
// 나온 기능이 아니기 때문에 메모리를 잡아먹습니다.
// 따라서 log를 찍을 때 System.out.println(); 을 쓰는 건 권장되지 않습니다.
// 로깅만 할 수 있도록 Log4j를 사용합니다.
// 참고로 Log4j2는 spring-boot에서 쓰고, Log4j는 spring에서 씁니다.

@Log4j
public class MySQLConnectionTest {
	
	// 커넥터 설정 완료.
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		try(Connection con = 
				DriverManager.getConnection(
						"jdbc:mysql://127.0.0.1:3306/mysql?useSSL=false&serverTimezone=UTC",
						"root", // 계정
						"shin8149" //비밀번호
						)) {
			log.info(con);
			log.info("MySQL 연결 완료");
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}
	
	@Test
	public void testConnection2() {
		log.info("@Test가 없으면 실행이 안됩니다.");
	}

	// DB 연동 다른 방법! (차이는 없다.)
//	private final String DRIVER = "com.mysql.cj.jdbc.Driver";
//	private final String URL = 
//			"jdbc:mysql://127.0.0.1:3306/mysql?useSSL=false&serverTimezone=UTC";
//	private final String USER = "root";
//	private final String PW = "shin8149";
//	
//	@Test
//	public void testConnection() throws Exception {
//		Class.forName(DRIVER);
//		try(Connection con = DriverManager.getConnection(URL, USER, PW)) {
//			
//			log.info(con);
//			log.info("mysql에 연결되었습니다.");
//		} catch(Exception e) {
//			e.printStackTrace();
//		}
//	}
	

	
}
