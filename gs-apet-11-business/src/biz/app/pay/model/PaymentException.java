package biz.app.pay.model;

import biz.app.order.model.OrderComplete;
import biz.interfaces.gsr.model.GsrMemberPointVO;
import lombok.extern.slf4j.Slf4j;

/**
 * Root of the hierarchy of data access exceptions discussed in
 * <a href="http://www.amazon.com/exec/obidos/tg/detail/-/0764543857/">Expert One-On-One J2EE Design and Development</a>.
 * Please see Chapter 9 of this book for detailed discussion of the
 * motivation for this package.
 *
 * <p>This exception hierarchy aims to let user code find and handle the
 * kind of error encountered without knowing the details of the particular
 * data access API in use (e.g. JDBC). Thus it is possible to react to an
 * optimistic locking failure without knowing that JDBC is being used.
 *
 * <p>As this class is a runtime exception, there is no need for user code
 * to catch it or subclasses if any error is to be considered fatal
 * (the usual case).
 *
 * @author Rod Johnson
 */
@Slf4j
public class PaymentException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	private String	exCode;

	private String	loginType;

	private String[]	params;

	private String	returnUrl;
	
	private OrderComplete ordComplete;

	private GsrMemberPointVO gsrMemberPointVO;

	public PaymentException(String exCode) {
		this.exCode = exCode;

		log.error("[exCode] : " + exCode + "\n" + this.getMessage());
	}

	public PaymentException(String exCode, String loginType) {
		this.exCode = exCode;
		this.loginType = loginType;

		log.error("[exCode] : " + exCode + ", loginType : " + loginType + "\n" + this.getMessage());
	}

	public PaymentException(String exCode, String[] params) {
		this.exCode = exCode;
		this.params = params;

		log.error("[exCode] : " + exCode + ", params : " + String.join(",",params) + "\n" + this.getMessage());
	}

	public PaymentException(String exCode, String loginType, String returnUrl) {
		this.exCode = exCode;
		this.loginType = loginType;
		this.returnUrl = returnUrl;

		log.error("[exCode] : " + exCode + ", loginType : " + loginType + ", returnUrl : " + returnUrl + "\n" + this.getMessage());
	}
	
	public PaymentException(String exCode, OrderComplete ordComplete) {
		this.exCode = exCode;
		this.ordComplete = ordComplete;
		this.gsrMemberPointVO = null;
		log.error("[exCode] : " + exCode + ", returnUrl : " + returnUrl + "\n" + this.getMessage());
	}

	public PaymentException(String exCode, OrderComplete ordComplete, GsrMemberPointVO gsrMemberPointVO) {
		this.exCode = exCode;
		this.ordComplete = ordComplete;
		this.gsrMemberPointVO = gsrMemberPointVO;
		log.error("[exCode] : " + exCode + ", returnUrl : " + returnUrl + "\n" + this.getMessage());
	}

	public String getExCode() {
		return this.exCode;
	}

	public String getLoginType() {
		return this.loginType;
	}

	public String getReturnUrl() {
		return this.returnUrl;
	}

	public String[] getParams() {
		return this.params;
	}

	public OrderComplete getOrdComplete() {
		return ordComplete;
	}

	public GsrMemberPointVO getGsrMemberPointVO() { return this.gsrMemberPointVO; }

	public void setOrdComplete(OrderComplete ordComplete) {
		this.ordComplete = ordComplete;
	}

}