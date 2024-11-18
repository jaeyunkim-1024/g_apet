package biz.app.delivery.model;

import java.sql.Timestamp;

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
* - 패키지명		: biz.app.delivery.model
* - 파일명		: DeliveryVO.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: snw
* - 설명			: 배송 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class DeliveryVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;
	
	/** 배송 번호 */
	private Long dlvrNo;

	/** 주문 배송지정보 */
	private Integer ordDlvrNo;

	/** 주문 클레임 구분 코드 */
	private String ordClmGbCd;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;
	
	/** 주문 상세 순번 목록 */
	private String ordDtlSeqs;

	/** 클레임 번호 */
	private String clmNo;

	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;

	/** 배송 처리 유형 코드 */
	private String dlvrPrcsTpCd;

	/** 택배사 코드 */
	private String hdcCd;

	/** 배송비정책의 기본 택배사 코드 */
	private String dftHdcCd;

	/** 송장 번호 */
	private String invNo;

	/** 배송정책번호 */
	private Integer dlvrcPlcNo;

	/** 우편 번호 구 */
	private String postNoOld;

	/** 우편 번호 신 */
	private String postNoNew;

	/** 도로 주소 */
	private String roadAddr;

	/** 도로 상세 주소 */
	private String roadDtlAddr;

	/** 지번 주소 */
	private String prclAddr;

	/** 지번 상세 주소 */
	private String prclDtlAddr;

	/** 전화 */
	private String tel;

	/** 휴대폰 */
	private String mobile;

	/** 이메일 */
	private String email;

	/** 수취인 명 */
	private String adrsNm;

	/** 배송 메모 */
	private String dlvrMemo;

	/** 직배송아이디 */
	private Integer areaId;

	/** 배송 희망 일자 */
	private String dlvrHopeDt;

	/** 클레임상세상태 */
	private String clmDtlStatCd;

	/** 주문상세상태 */
	private String ordDtlStatCd;

	/** 배송 구분 코드	    */
	private String dlvrGbCd;
	/** 배송 유형 코드	    */
	private String dlvrTpCd;
	/** 주문 배송지 번호	    */
	private Long OrdDlvraNo;
	/** 배송 지시 일시 */
	private Timestamp dlvrCmdDtm;
	/** 배송 완료 일시 */
	private Timestamp dlvrCpltDtm;
	/** 출고 완료 일시 */
	private Timestamp ooCpltDtm;

	/** 배송 수량 */
 	private Long ordQty; 
 	
 	/** 굿스플로 배송고유코드 */
 	private String itemUniqueCode;

 	/** 채널 ID */
	private Long chnlId;
	
 	/** 외부 주문 상세 번호 */
	private String outsideOrdDtlNo;

	/** CIS 출고 여부 */
	private String cisOoYn;
	/** CIS 출고 번호 */
	private String cisOoNo;
	/** CIS 택배사 코드 */
	private String cisHdcCd;
	/** CIS 송장 번호 */
	private String cisInvNo;
	/** CIS 배송 완료 사진 URL */
	private String cisDlvrCpltPicUrl;
	/** CIS 배송 완료 여부 */
	private String cisDlvrCpltYn;
	/** CIS 배송 SMS */
	private String cisDlvrSms;	
	
	/** 배송완료 여부 */
	private String dlvrCpltYn;
	
	/** 업체구분코드*/
	private String compGbCd;
	
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
}