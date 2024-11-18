package framework.common.aspect;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * Bo RequestMapping Aspect
 * 
 * @author valueFactory
 * @since 2015. 06. 13.
 */
 
@Component
@Aspect
@Slf4j
public class RequestMappingAspect {

	@SuppressWarnings("unused")
	@Pointcut("within(@org.springframework.stereotype.Controller * || @org.springframework.web.bind.annotation.RestController *) && @annotation(requestMapping) && execution(* *(..))")
	private void requestMappingTarget(RequestMapping requestMapping) {
		//requestMappingTarget : do nothing
		log.info("requestMappingTarget start");
	}

	@Before("requestMappingTarget(requestMapping)")
	public void beforeLogging(JoinPoint joinPoint, RequestMapping requestMapping) {

		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String methodName = joinPoint.getSignature().getName();
		String className = joinPoint.getTarget().getClass().getName();
		
		log.info("##### {} : {}", "RequestMapping URL", requestMapping.value());
		log.info("##### {} {} {} [{}]", className, methodName, "Start", request.getRequestedSessionId());
		
		log.info("##### {} #####", "Parameter Information");
		
		for (Object args : joinPoint.getArgs()) {
			if (args instanceof String) {
				log.info("String : " + args);
			} else if (args instanceof Integer) {
				log.info("Integer : " + args);
			} else if (args instanceof Double) {
				log.info("Double : " + args);
			} else if (args instanceof Boolean) {
				log.info("Boolean : " + args);
			} else {
				// View 관련 로그 제외
				if (args != null && args.getClass() != null
						&& StringUtil.nvl(args.getClass().getName()).indexOf("View") < 0
						&& StringUtil.nvl(args.getClass().getName()).indexOf("org.springframework") < 0) {
					log.info(ToStringBuilder.reflectionToString(args, ToStringStyle.MULTI_LINE_STYLE));
				}
			}

		}
	}

	@AfterReturning("requestMappingTarget(requestMapping)")
	public void returningLogging(JoinPoint joinPoint, RequestMapping requestMapping){

		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String methodName = joinPoint.getSignature().getName();
		String className = joinPoint.getTarget().getClass().getName();
		
		log.info("##### {} : {}", "RequestMapping URL", requestMapping.value());
		log.info("##### {} {} {} [{}]", className, methodName, "End", request.getRequestedSessionId());
	}

	@AfterThrowing("requestMappingTarget(requestMapping)")
	public void throwingLogging(JoinPoint joinPoint, RequestMapping requestMapping){

		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String methodName = joinPoint.getSignature().getName();
		String className = joinPoint.getTarget().getClass().getName();
		
		log.info("##### {} : {}", "RequestMapping URL", requestMapping.value());
		log.info("##### {} {} {} [{}]", className, methodName, "Throwing", request.getRequestedSessionId());
	}
}
