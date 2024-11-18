package biz.app.receipt.model;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import biz.app.order.model.OrderDetailVO;
import framework.common.constants.CommonConstants;
import framework.common.model.BaseSysVO;
import framework.common.util.PetraUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CashReceiptVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 현금 영수증 번호 */
	private Long cashRctNo;

	/** 원 현금 영수증 번호 */
	private Long orgCashRctNo;

	/** 주문 번호 */
	private String ordNo;

	/** 클레임 번호 */
	private String clmNo;
	
	/** 발행 유형 코드 */
	private String crTpCd;

	/** 현금 영수증 상태 코드 */
	private String cashRctStatCd;

	/** 사용 구분 코드 */
	private String useGbCd;

	/** 발급 수단 코드 */
	private String isuMeansCd;

	/** 발급 수단 번호 */
	private String isuMeansNo;

	/** 발행 구분 코드 */
	private String isuGbCd;

	/** 결제 금액 */
	private Long payAmt;
	
	/** 공급 금액 */
	private Long splAmt;

	/** 공급 금액 */
	private Long taxSplAmt;

	/** 부가세 금액 */
	private Long staxAmt;

	/** 봉사료 금액 */
	private Long srvcAmt;

	/** 상점 아이디 */
	private String strId;
	
	/** 연동 일시 */
	private Timestamp lnkDtm;

	/** 연동 거래 번호 */
	private String lnkDealNo;

	
	/** 연동 결과 메세지 */
	private String lnkRstMsg;

	
	
	
	/** 사이트 ID */
	private Long stId;

	/** 회원 번호 */
	private Long mbrNo;

	/** 회원 명 */
	private String mbrNm;

	/** 주문 상태 코드 */
	private String ordStatCd;

	/** 주문 매체 코드 */
	private String ordMdaCd;

	/** 채널 ID */
	private Integer chnlId;

	/** 회원 등급 코드 */
	private String mbrGrdCd;

	/** 주문자 명 */
	private String ordNm;

	/** 주문자 ID */
	private String ordrId;
	
	/** 주문자 이메일 */
	private String ordrEmail;

	/** 주문자 전화 */
	private String ordrTel;

	/** 주문자 휴대폰 */
	private String ordrMobile;

	/** 주문자 IP */
	private String ordrIp;

	/** 주문 접수 일시 */
	private Timestamp ordAcptDtm;

	/** 주문 완료 일시 */
	private Timestamp ordCpltDtm;
	
	/** 외부 주문 번호 */
	private String outsideOrdNo;
	
	/** 주문 처리 결과 코드 */
	private String ordPrcsRstCd;
	
	/** 주문 처리 결과 메세지 */
	private String ordPrcsRstMsg;	
	
	/** 데이터 상태 코드 */
	private String dataStatCd;
	
	/** 사이트 명 */
	private String stNm;	
	
	/** 결제 수단 코드 */
	private String payMeansCd;
	
	/** 결제일 */
	private Timestamp rsvPayCpltDtm;
	
	/** 결제 금액 합계 */
	private Long payAmtTotal;	

	/** 받는분명 */
	private String rsvAdrsNm;

	 /** 수령인 전화번호 */
	private String rsvTel;

	 /** 수령인 휴대폰 */
	private String rsvMobile;

	/** 수령인 도로명 주소 1 */
	private String rsvRoadAddr;

	/** 수령인 도로명 주소 2 */
	private String rsvRoadDtlAddr;	
	
	/** 결제 취소 금액 합계 */
	private Long clmAmtTotal;

	/** 주문전체취소 */
	private String cancelAll;

	/** 거래 번호(결제) */
	private String dealNo;

	/** 승인 번호(결제) */
	private String cfmNo;

	/** 반품 가능 여부 */
	private String rtnPsbYn;
	
	/** 주문 상세 List VO */
	private List<OrderDetailVO> orderDetailListVO;

	/** 주문 번호 카운트 */
	private Integer ordDtlCnt;

	/** 주문 번호 일련번호 */
	private Integer ordDtlRowNum;

	/** 주문 상세 상태 코드 */
	private String ordDtlStatCd;

	/** 업체 명 */
	private String compNm;

	/** 상품 명 */
	private String goodsNm;

	/** 단품 명 */
	private String itemNm;

	/** 판매 금액 */
	private Long saleAmt;

	/** 주문 수량 */
	private Integer ordQty;
	
	/** 적용 수량 */
	private Integer aplQty;
	
	/** 수령인 명 */
	private String adrsNm;
	
	/** 현금 영수증 URL **/
	public String	getCashReceiptUrl(){
		if (StringUtil.isNotEmpty (lnkDealNo) )  {
			return null;
//			return INIPayUtil.getCashReceiptUrl(lnkDealNo) ;
		}else{
			return "";
		}
	};
	
	public String getOrdNm() {
		if(StringUtil.isNotEmpty(this.ordNm) && StringUtils.endsWith(this.ordNm, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordNm, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordNm;
	}

	public String getOrdrTel() {
		if(StringUtil.isNotEmpty(this.ordrTel) && StringUtils.endsWith(this.ordrTel, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordrTel, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordrTel;
	}

	public String getOrdrMobile() {
		if(StringUtil.isNotEmpty(this.ordrMobile) && StringUtils.endsWith(this.ordrMobile, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordrMobile, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordrMobile;
	}
	
	public String getRsvTel() {
		if(StringUtil.isNotEmpty(this.rsvTel) && StringUtils.endsWith(this.rsvTel, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.rsvTel, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.rsvTel;
	}

	public String getRsvMobile() {
		if(StringUtil.isNotEmpty(this.rsvMobile) && StringUtils.endsWith(this.rsvMobile, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.rsvMobile, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.rsvMobile;
	}
	
	public String getOrdrEmail() {
		if(StringUtil.isNotEmpty(this.ordrEmail) && StringUtils.endsWith(this.ordrEmail, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordrEmail, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordrEmail;
	}

	public String getRsvAdrsNm() {
		if(StringUtil.isNotEmpty(this.rsvAdrsNm) && StringUtils.endsWith(this.rsvAdrsNm, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.rsvAdrsNm, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.rsvAdrsNm;
	}
	
	public String getAdrsNm() {
		if(StringUtil.isNotEmpty(this.adrsNm)) {
			if (StringUtils.endsWith(this.adrsNm, "=")) {
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
				WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
				PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
				return StringEscapeUtils.unescapeHtml4(PetraUtil.twoWayDecrypt(this.adrsNm, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp()));
			} else {
				return StringEscapeUtils.unescapeHtml4(this.adrsNm);
			}
		}
		return this.adrsNm;
	}

	public String getOrdrId() {
		if(StringUtil.isNotEmpty(this.ordrId) && StringUtils.endsWith(this.ordrId, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordrId, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordrId;
	}
	
	public String getRsvRoadDtlAddr() {
		if(StringUtil.isNotEmpty(this.rsvRoadDtlAddr) && StringUtils.endsWith(this.rsvRoadDtlAddr, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.rsvRoadDtlAddr, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.rsvRoadDtlAddr;
	}
	
	public String getIsuMeansNo() {
		if(StringUtil.isNotEmpty(this.isuMeansNo) && StringUtils.endsWith(this.isuMeansNo, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.isuMeansNo, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.isuMeansNo;
	}
}