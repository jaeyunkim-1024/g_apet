package batch.config.aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 21.batch
* - 패키지명		: batch.config.aspect
* - 파일명		: ExcuteAspect.java
* - 작성일		: 2017. 4. 13.
* - 작성자		: snw
* - 설명			: Batch Excute Aspect
* </pre>
*/
@Component
@Aspect
@Slf4j
public class ExecuteAspect {

	@Pointcut("@annotation(scheduled)")
	private void scheduledTarget(Scheduled scheduled) {
		log.info("scheduledTarget");
	}

	@Before("scheduledTarget(scheduled)")
	public void beforeLogging(JoinPoint joinPoint, Scheduled scheduled) {
		String methodName= joinPoint.getSignature().getName();
		String className = joinPoint.getTarget().getClass().getName();
		log.info("=======================================================================");
		log.info("= {} {} {} {}", "BATCH", className, methodName, "Start");
		log.info("=======================================================================");
	}

	@AfterReturning("scheduledTarget(scheduled)")
	public void returningLogging(JoinPoint joinPoint, Scheduled scheduled) {
		String methodName= joinPoint.getSignature().getName();
		String className = joinPoint.getTarget().getClass().getName();
		log.info("=======================================================================");
		log.info("= {} {} {} {}", "BATCH", className, methodName, "End");
		log.info("=======================================================================");
	}

	@AfterThrowing("scheduledTarget(scheduled)")
	public void throwingLogging(JoinPoint joinPoint, Scheduled scheduled) {
		String methodName= joinPoint.getSignature().getName();
		String className = joinPoint.getTarget().getClass().getName();
		log.info("=======================================================================");
		log.info("= {} {} {} {}", "BATCH", className, methodName, "Throwing");
		log.info("=======================================================================");
	}

}
