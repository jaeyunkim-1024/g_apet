package biz.app.pay.model;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import framework.common.constants.CommonConstants;
import framework.common.model.BaseSysVO;
import framework.common.util.PetraUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.model
* - 파일명		: PayCashRefundVO.java
* - 작성일		: 2017. 3. 10.
* - 작성자		: snw
* - 설명			: 결제 현금 환불 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class PayCashRefundVO extends BaseSysVO{

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 현금 환불 번호 */
	private Long cashRfdNo;

	/** 결제 번호 */
	private Long payNo;

	/** 환불 유형 코드 */
	private String rfdTpCd;

	/** 환불 상태 코드 */
	private String rfdStatCd;

	/** 은행 코드 */
	private String bankCd;

	/** 계좌 번호 */
	private String acctNo;

	/** 예금주 명 */
	private String ooaNm;

	/** 예정 금액 */
	private Long schdAmt;
	
	/** 환불 금액 */
	private Long rfdAmt;

	/** 완료 일시 */
	private Timestamp cpltDtm;	

	/** 완료자 번호 */
	private Integer cpltrNo;
	
	/** 완료자 명 */
	private String cpltrNm;
	
	/** 메모 */
	private String memo;

	/*********************
	 * 결제 기본 정보
	 *********************/
	/** 주문 번호 */
	private String 	ordNo;

	/** 클레임 번호 */
	private String 	clmNo;
	
	public String getOoaNm() {
		if(StringUtil.isNotEmpty(this.ooaNm) && StringUtils.endsWith(this.ooaNm, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ooaNm, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ooaNm;
	}
	
	public String getAcctNo() {
		if(StringUtil.isNotEmpty(this.acctNo) && StringUtils.endsWith(this.acctNo, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.acctNo, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.acctNo;
	}


}