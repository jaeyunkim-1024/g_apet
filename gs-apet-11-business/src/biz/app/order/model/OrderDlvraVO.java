package biz.app.order.model;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringEscapeUtils;
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
* - 패키지명		: biz.app.order.model
* - 파일명		: OrderDlvraVO.java
* - 작성일		: 2017. 1. 23.
* - 작성자		: snw
* - 설명			: 주문 배송지 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDlvraVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 주문 배송지 번호 */
	private Long		ordDlvraNo;

	/** 수취인 명 */
	private String	adrsNm;
	
	/** 전화 */
	private String	tel;
	
	/** 휴대폰 */
	private String	mobile;
	
	/** 우편번호 구 */
	private String	postNoOld;
	
	/** 지번 주소 */
	private String	prclAddr;
	
	/** 지번 상세 주소 */
	private String 	prclDtlAddr;

	/** 지번 전체 주소 */
	private String   fullPrclAddr;

	/** 우편번호 신 */
	private String 	postNoNew;
	
	/** 도로명 주소 */
	private String	roadAddr;
	
	/** 도로명 상세 주소 */
	private String	roadDtlAddr;
	
	/** 도로명 전체 주소 */
	private String   fullRoadAddr;
	
	/** 배송 메모 */
	private String	dlvrMemo;
	
	/** 상품 수령 위치 코드 */
	private String	goodsRcvPstCd;

	/** 상품 수령 위치 코드 */
	private String	goodsRcvPstNm;
	
	/** 상품 수령 위치 기타 */
	private String	goodsRcvPstEtc;
	
	/** 배송 요청사항 여부 */
	private String	dlvrDemandYn;
	
	/** 공동 현관 출입 방법 코드 */
	private String	pblGateEntMtdCd;

	/** 공동 현관 출입 방법 코드 */
	private String	pblGateEntMtdNm;
	
	/** 공동 현관 비밀번호 */
	private String	pblGatePswd;
	
	/** 배송 요청사항 */
	private String	dlvrDemand;
	
	/** 배송 권역 코드 */
	private String	dlvrAreaCd;
	
	/** 배송 권역 이름 */
	private String	dlvrAreaNm;
	
	/** 배송 센터 코드 */
	private String	dlvrCntrCd;
	
	/** 배송 센터 이름 */
	private String	dlvrCntrNm;
	
	/** 배송 처리 유형 */
	private String	dlvrPrcsTpCd;
	
	/** 시 */
	private String	sido;
	
	/** 구군 */
	private String	gugun;
	
	/** 동 */
	private String	dong;
	
	/** 배송 완료 사진 URL*/
	private String	dlvrCpltPicUrl;
	
	/** 배송 SMS */
	private String dlvrSms;
	
	/** 배송 완료 여부 */
	private String dlvrCpltYn;
	
	/** 배송지명  */
	private String gbNm;

	public String getEscapedGbNm() {
		return (StringUtil.isNotBlank(gbNm))?StringEscapeUtils.unescapeHtml4(gbNm):"";
	}
	public String getEscapedAdrsNm() {
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
		return "";
	}
	public String getEscapedRoadDtlAddr() {
		if(StringUtil.isNotEmpty(this.roadDtlAddr)) {
			if (StringUtils.endsWith(this.roadDtlAddr, "=")) {
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
				WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
				PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
				return StringEscapeUtils.unescapeHtml4(PetraUtil.twoWayDecrypt(this.roadDtlAddr, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp()));
			} else {
				return StringEscapeUtils.unescapeHtml4(this.roadDtlAddr);
			}
		}
		return "";
	}
	public String getEscapedGoodsRcvPstEtc() {
		return (StringUtil.isNotBlank(goodsRcvPstEtc))?StringEscapeUtils.unescapeHtml4(goodsRcvPstEtc):"";
	}
	public String getEscapedPblGatePswd() {
		if (StringUtil.isNotBlank(pblGatePswd)){
			if (StringUtils.endsWith(pblGatePswd, "=")) {
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
				WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
				PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
				return StringEscapeUtils.unescapeHtml4(PetraUtil.twoWayDecrypt(pblGatePswd, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp()));
			} else {
				return StringEscapeUtils.unescapeHtml4(pblGatePswd);
			}
		}
		return "";
	}
	
	public String getPblGatePswd() {
		if (StringUtil.isNotBlank(pblGatePswd)){
			if (StringUtils.endsWith(pblGatePswd, "=")) {
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
				WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
				PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
				return StringEscapeUtils.unescapeHtml4(PetraUtil.twoWayDecrypt(pblGatePswd, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp()));
			} else {
				return StringEscapeUtils.unescapeHtml4(pblGatePswd);
			}
		}
		return pblGatePswd;
	}
	public String getEscapedDlvrDemand() {
		return (StringUtil.isNotBlank(dlvrDemand))?StringEscapeUtils.unescapeHtml4(dlvrDemand):"";
	}
	
	public String getEscapedDlvrMemo() {
		return (StringUtil.isNotBlank(dlvrMemo))?StringEscapeUtils.unescapeHtml4(dlvrMemo):"";
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
	
	public String getTel() {
		if(StringUtil.isNotEmpty(this.tel) && StringUtils.endsWith(this.tel, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.tel, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.tel;
	}

	public String getMobile() {
		if(StringUtil.isNotEmpty(this.mobile) && StringUtils.endsWith(this.mobile, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.mobile, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.mobile;
	}
	
	public String getRoadDtlAddr() {
		if(StringUtil.isNotEmpty(this.roadDtlAddr)) {
			if (StringUtils.endsWith(this.roadDtlAddr, "=")) {
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
				WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
				PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
				return StringEscapeUtils.unescapeHtml4(PetraUtil.twoWayDecrypt(this.roadDtlAddr, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp()));
			} else {
				return StringEscapeUtils.unescapeHtml4(this.roadDtlAddr);
			}
		}
		return this.roadDtlAddr;
	}
	
	public String getPrclDtlAddr() {
		if(StringUtil.isNotEmpty(this.prclDtlAddr)) {
			if (StringUtils.endsWith(this.prclDtlAddr, "=")) {
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
				WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
				PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
				return StringEscapeUtils.unescapeHtml4(PetraUtil.twoWayDecrypt(this.prclDtlAddr, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp()));
			} else {
				return StringEscapeUtils.unescapeHtml4(this.prclDtlAddr);
			}
		}
		return this.prclDtlAddr;
	}
}