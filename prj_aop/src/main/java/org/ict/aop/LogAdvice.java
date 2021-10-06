package org.ict.aop;



import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {
	
	// 1번 advice
	@Before("execution(* org.ict.service.SampleService*.*(..))")
	public void logBefore() {
		log.info("==============");
	}
	
	// 2번 advice
	@Before("execution(* org.ict.service.SampleService*.doAdd(String, String)) && args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		
		log.info("str1 : " + str1);
		log.info("str2 : " + str2);
	}
	
	@AfterThrowing(pointcut = "execution(* org.ict.service.SampleService*.*(..))", throwing="exception")
	public void logException(Exception exception) {
		log.info("Exception....!!!!");
		log.info("exception: " + exception);
	}
	
	@Around("execution(* org.ict.service.SampleService*.*(..))")
	public Object logTime(ProceedingJoinPoint pjp) {
		
		// 시작 시간 얻기
		long start = System.currentTimeMillis();
		// 어떤 메서드인지
		log.info("Target: " + pjp.getTarget());
		
		// 어떤 파라미터를 받았는지
		log.info("Param : " + Arrays.toString(pjp.getArgs()));
		
		Object result = null;
		
		try { 
			result = pjp.proceed(); // 원래 실행하려던 메서드 실행
		} catch(Throwable e) {
			e.printStackTrace();
		}
		// 끝나는 시간
		long end = System.currentTimeMillis();
		// 끝시간 - 시작시간 = 소요시간
		log.info("TIME : " + (end - start));
		
		return result;
	}
	
	@After("execution(* org.ict.service.SampleService*.*(..))")
	public void endMethod() {
		log.info("메서드 끝");
	}
}
