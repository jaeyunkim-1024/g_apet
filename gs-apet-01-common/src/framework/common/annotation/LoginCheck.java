package framework.common.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Login Check Annotation
 * 
 * @author valueFactory
 * @since 2015. 01. 27.
 */
 
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface LoginCheck {

	boolean popup() default false;

	String loginType() default "";

	boolean noMemCheck() default true;
}
