package biz.app.order.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import biz.app.pay.model.PayBaseVO;
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
* - 파일명		: OrderBaseVO.java
* - 작성일		: 2017. 1. 23.
* - 작성자		: snw
* - 설명			: 주문 기본 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderBaseVO extends BaseSysVO implements Serializable {
	/** 주문 번호 */
	private String ordNo;

	/** 사이트 ID */
	private Long stId;

	/** 사이트 명 */
	private String stNm;

	/** 회원 번호 */
	private Long mbrNo;

	/** 회원 명 */
	private String mbrNm;

	/** 주문상세 갯수 */
	private Integer ordDtlCnt;

	/** 주문 상태 코드 */
	private String ordStatCd;

	/** 주문 매체 코드 */
	private String ordMdaCd;

	/** 채널 ID */
	private Long chnlId;

	/** 채널 명 */
	private String chnlNm;

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

	/** 주 결제 수단 코드 */
	private String payMeansCd;

	/** 배송비 변경 가능 여부 */
	private String dlvraChgPsbYn;

	/** 주문 취소 여부 */
	private String ordCancelYn;

	/** 주문 취소 가능 여부 */
	private String ordCancelPsbYn;

	/** 반품 진행 중 여부 */
	private String allClaimIngRtnYn;
	
	/** 배송 처리 유형 코드 */
	private String dlvrPrcsTpCd;

	/** 주문자노출여부 */
	private String ordrShowYn;
	
	/** 취소가능여부 */
	private String cncPsbYn;
	
	/** 결제정보 */
	private PayBaseVO payBaseVO;
	
	/** 주문 상세 List VO */
	private List<OrderDetailVO> orderDetailListVO;
	
	/** 업체별 List */
	private List<OrderCompanyVO> OrderCompanyListVO;
	
	private String payStatCd;
	
	/** 주문 삭제 Flag */
	private String ordDeleteFlg;

	/** 미입금 취소 여부를 확인 하기 위한 용도 */
	private String clmRsnCd;
	
	/** MP 연동 이력 번호 */
	private Long mpLnkHistNo;
	
	public String getOrdNm() {
		if(StringUtil.isNotEmpty(this.ordNm) && org.apache.commons.lang3.StringUtils.endsWith(this.ordNm, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordNm, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordNm;
	}
	
	public String getOrdrTel() {
		if(StringUtil.isNotEmpty(this.ordrTel) && org.apache.commons.lang3.StringUtils.endsWith(this.ordrTel, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordrTel, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordrTel;
	}

	public String getOrdrMobile() {
		if(StringUtil.isNotEmpty(this.ordrMobile) && org.apache.commons.lang3.StringUtils.endsWith(this.ordrMobile, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordrMobile, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordrMobile;
	}
	
	public String getOrdrEmail() {
		if(StringUtil.isNotEmpty(this.ordrEmail) && org.apache.commons.lang3.StringUtils.endsWith(this.ordrEmail, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordrEmail, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordrEmail;
	}
	
	public String getOrdrId() {
		if(StringUtil.isNotEmpty(this.ordrId) && org.apache.commons.lang3.StringUtils.endsWith(this.ordrId, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordrId, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordrId;
	}
}