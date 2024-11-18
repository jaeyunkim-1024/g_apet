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
* - 파일명		: PayBaseVO.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: snw
* - 설명			: 결제 기본 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class PayBaseVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 결제 번호 */
	private Long 	payNo;

	/** 주문 클레임 구분 코드 */
	private String 	ordClmGbCd;

	/** 주문 번호 */
	private String 	ordNo;

	/** 클레임 번호 */
	private String 	clmNo;

	/** 결제 구분 코드 */
	private String 	payGbCd;

	/** 결제 수단 코드 */
	private String 	payMeansCd;
	
	/** 결제 수단 명 */
	private String 	payMeansNm;

	/** 결제 상태 코드 */
	private String 	payStatCd;

	/** 원 결제 번호 */
	private Long 	orgPayNo;

	/** 결제 완료 일시 */
	private Timestamp payCpltDtm;

	/** 결제 금액 */
	private Long 	payAmt;
	/** 결제 금액 : 마이너스 환불 제외 */
	private Long 	payAmt01;
	/** 결제 금액 : 입금( 마이너스 환불 )*/
	private Long 	payAmt02;

	/** 환불 금액 */
	private Long		refundAmt;

	/** 결제 잔여 금액 */
	private Long		payRmnAmt;
	
	/** 상점아이디 */
	private String 	strId;

	/** 거래 번호 */
	private String 	dealNo;

	/** 승인 번호 */
	private String 	cfmNo;

	/** 승인 일시 */
	private Timestamp cfmDtm;

	/** 승인 결과 코드 */
	private String 	cfmRstCd;

	/** 승인 결과 메세지 */
	private String 	cfmRstMsg;

	/** 카드사 코드 */
	private String	cardcCd;

	/** 카드번호 */
	private String	cardNo;
	
	/** 은행 코드 */
	private String 	bankCd;

	/** 계좌 번호 */
	private String 	acctNo;

	/** 예금주 명 */
	private String 	ooaNm;

	/** 입금자 명 */
	private String 	dpstrNm;

	/** 입금 예정 일자 */
	private String 	dpstSchdDt;

	/** 입금 예정 금액 */
	private Long 	dpstSchdAmt;

	/** 입금 확인 메세지 */
	private String 	dpstCheckMsg;

	/** 취소 여부 */
	private String 	cncYn;

	/** 총 결제금액 */
	private Long payAmtTotal;
	
	/** 연동응답결과 */
	private String lnkRspsRst;
	
	/** 관리자 등록 여부 */
	private String 	mngrRegYn;
	
	/** 관리자 확인 여부 */
	private String 	mngrCheckYn;
	
	/** 포인트 전액 결제 여부 */
	private Boolean isPointFullPay;
	
	
	/** 카드 영수증 URL **/
	public String	getCardReceiptUrl(){
		if (StringUtil.isNotEmpty (dealNo) )  {
			return null ;
//			return INIPayUtil.getCardReceiptUrl(dealNo) ;
		}else{
			return "";
		}
	 
		
	};
	
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

	public String getDpstrNm() {
		if(StringUtil.isNotEmpty(this.dpstrNm) && StringUtils.endsWith(this.dpstrNm, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.dpstrNm, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.dpstrNm;
	}
}