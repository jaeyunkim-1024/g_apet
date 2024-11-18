package biz.app.order.model.interfaces;

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
* - 패키지명		: biz.app.order.model
* - 파일명		: OrderListVO.java
* - 작성일		: 2017. 3. 9.
* - 작성자		: snw
* - 설명			: 주문 목록 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderListVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/****************************
	 * 주문 정보
	 ****************************/

	/** 주문 번호 */
	private String ordNo;

	/** 사이트 ID */
	private Long stId;

	/** 사이트 명 */
	private String stNm;

	/** 회원 번호 */
	private Long mbrNo;

	/** 주문 상태 코드 */
	private String ordStatCd;

	/** 주문 매체 코드 */
	private String ordMdaCd;

	/** 채널 ID */
	private Integer chnlId;

	/** 채널 ID */
	private String chnlNm;

	/** 주문자 명 */
	private String ordNm;

	/** 주문자 ID */
	private String ordrId;

	/** 주문 접수 일시 */
	private Timestamp ordAcptDtm;

	/** 주문 완료 일시 */
	private Timestamp ordCpltDtm;

	/** 주문자 전화 */
	private String ordrTel;

	/** 주문자 휴대폰 */
	private String ordrMobile;

	/** 주문자 이메일 */
	private String ordrEmail;
	
	/** 외부 주문 번호 */
	private String outsideOrdNo;
	
	/** 주문 상품 수 */
	private Integer ordDtlCnt;
	
	/*************************
	 * 주문 상세 정보
	 *************************/

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;

	/** 주문 상세 상태 코드 */
	private String ordDtlStatCd;

	/** 주문 상세 상태 코드 이름 */
	private String ordDtlStatCdNm;

	/** 상품 아이디 */
	private String goodsId;

	/** 업체 상품 번호 */
	private String compGoodsId;
	
	/** 상품 명 */
	private String goodsNm;

	/** 단품 번호 */
	private Long itemNo;

	/** 업체 단품 번호 */
	private String compItemId;
	
	/** 카테고리 */
	private String dispClsfNo; 
	
	/** 단품 명 */
	private String itemNm;

	/** 주문 수량 */
	private Integer ordQty;

	/** 취소 수량 */
	private Integer cncQty;

	/** 반품 수량 */
	private Integer rtnQty;

	/** 잔여 주문 수량 */
	private Integer rmnOrdQty;

	/** 클레임 진행 여부 */
	private String	clmIngYn;

	/** 판매 금액 */
	private Long saleAmt;

	/** 결제 금액 */
	private Long payAmt;

	/** 결제 합계 금액 */
	private Long paySumAmt;

	/** 업체 번호 */
	private Long compNo;
	
	/** 배송번호 */
	private Integer dlvrNo;

	/** 배송비 번호 */
	private Long dlvrcNo;
	
	/** 주문배송지 번호 */
	private Long ordDlvraNo;
	
	/****************************
	 * 배송지 정보
	 ****************************/

	/** 수취인 명 */
	private String	adrsNm;

	/** 전화 */
	private String	tel;

	/** 휴대폰 */
	private String	mobile;

	/** 도로명 주소 */
	private String	roadAddr;

	/** 도로명 상세 주소 */
	private String	roadDtlAddr;

	/****************************
	 * 사은품 정보
	 ****************************/
	
	/** 주문 상세 순번 */
	private String frbOrdDtlSeq;
	
	/** 상품 아이디 */
	private String frbGoodsId;
	
	/** 적용수량 */
	private String frbAplQty;
	
	/****************************
	 * 결제 정보
	 ****************************/
	
	/** 결제번호 */
	private Long payNo;
	
	/**결제수단코드 */
	private String payMeansCd;
	
	/** 결제완료일 */
	private Timestamp payCpltDtm;
	
	/** 결제금액 */
	private Long payAmt2;
	
	/****************************
	 * 적용해택
	 ****************************/

	private Integer aplOrdDtlSeq;
	
	private Long aplBenefitNo;
	
	private String  aplBnftGbCd;
	
	private String aplBnftTpCd;
	
	private String aplBenefitNm;
	
	private Long aplAmt;
	
	private Long aplCompBdnAmt;
	
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
	
	public String getOrdrEmail() {
		if(StringUtil.isNotEmpty(this.ordrEmail) && StringUtils.endsWith(this.ordrEmail, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordrEmail, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordrEmail;
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
	
	public String getOrdrId() {
		if(StringUtil.isNotEmpty(this.ordrId) && StringUtils.endsWith(this.ordrId, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordrId, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordrId;
	}
}