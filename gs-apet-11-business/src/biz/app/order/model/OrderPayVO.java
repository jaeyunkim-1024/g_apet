package biz.app.order.model;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import framework.common.constants.CommonConstants;
import framework.common.util.MaskingUtil;
import framework.common.util.PetraUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.model
* - 파일명		: PayBaseComplete.java
* - 작성일		: 2017. 1. 31.
* - 작성자		: snw
* - 설명			: 결제 완료 정보
* </pre>
*/
@Data
public class OrderPayVO  implements Serializable{

	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;

	/** 주문상품 금액 */
	private Long goodsAmt;

	/** 실배송비 */
	private Long dlvrAmt;

	/** 적립금 사용 금액 */
	private Long svmnAmt;
	
	/** 적립금 취소 금액 */
	private Long clmSvmnAmt;

	/** 쿠폰 할인 금액 */
	private Long cpDcAmt;

	/** 결제 금액 */
	private Long payAmt;

	/**  적립예정금액 */
	private Long ordSvmn;

	/*******************
	 * 주문의 주결제 수단
	 ******************/
	/** 결제 수단 */
	private String payMeansCd;

	/** 결제 상태 코드 */
	private String payStatCd;

	/** 결제 완료 일시 */
	private Timestamp payCpltDtm;
	
	/** 승인 번호 */
	private String cfmNo;

	/** 승인 일시 */
	private Timestamp cfmDtm;
	
	/** 카드사 코드 */
	private String cardcCd;
	
	/** 카드사 코드 명 */
	private String cardcNm;

	/** 카드 번호 */
	private String cardNo;

	/** 할부개월수 */
	private String instmntInfo;

	/** 무이자여부 */
	private String fintrYn;

	/** 은행 코드 */
	private String bankCd;

	/** 은행 명 */
	private String bankNm;
	
	/** 계좌 번호 */
	private String acctNo;

	/** 예금주 명 */
	private String ooaNm;
	
	/** 입금자 명 */
	private String dpstrNm;

	/** 입금 예정 일자 */
	private String dpstSchdDt;
	
	/** 입금 예정 일시 명(FO) */
	private String dpstSchdDtNm;
	
	/** 클레임 상품 금액 합계 */
	private Long clmGoodsAmt;
	
	/** 클레임  원 취소된 배송 금액 */
	private Long clmOrgDlvrcAmt;
	
	/** 클레임  쿠폰 할인 금액 */
	private Long clmCpDcAmt;
	
	/** 클레임 신규 반품/교한 회수 배송비 금액*/
	private Long clmNewRtnOrgDlvrcAmt;
	
	/** 클레임 추가 배송비 */
	private Long clmDlvrcAmt;	
	
	/** 클레임 결제 금액 */
	private Long clmPayAmt;
	
	/** 최초 결제 금액 */
	private Long ordPayAmt;
	
	/** 거래번호 */
	private String dealNo;
	
	/* 최초결제금액 */
	private Long orgPayAmt;
	/* 최초 상품금액 */
	private Long orgGoodsAmt;
	/* 최초 배송비 */
	private Long orgDlvrAmt;
	/* 최초 쿠폰할인 */
	private Long orgCpDcAmt;
	private Long orgPnt;
	/* 최초 GS 포인트 */
	private Long orgGsPnt;
	/* 최초 MP 포인트 */
	private Long orgMpPnt;
	private Long orgAddMpPnt;
	/* 환불금액 */
	private Long refundAmt;
	/* 환불 취소상품금액 */
	private Long refundCnclGoodsAmt;
	/* 환불 배송비 */
	private Long refundDlvrAmt;
	/* 환불 쿠폰할인 */
	private Long refundCpDcAmt;
	/* 환불 추가배송비 */
	private Long refundAddDlvrAmt;
	private Long refundPnt;
	/* 환불 GS 포인트 */
	private Long refundGsPnt;
	/* 환불 MP 포인트 */
	private Long refundMpPnt;
	private Long refundAddMpPnt;
	/* 최종결제금액 */
	private Long finalPayAmt;
	
	private String ordCncYn;
	/** 주문 남은 수량 여부 */
	private String ordRmnYn;
	
	/** 재계산 여부 - 포인트관련 */
	private String reCalcYn;
	private String ciCtfVal;
	private Long sumIsuSchdPnt;
	
	public String getMaskedCardNo() {
		return (StringUtil.isNotBlank(cardNo))?MaskingUtil.getCard(cardNo):"";
	}
	
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
