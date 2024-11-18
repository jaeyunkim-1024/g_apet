package biz.app.delivery.model;

import java.sql.Timestamp;
import java.util.List;

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
 *
* <pre>
* - 프로젝트명   : 11.business
* - 패키지명   : biz.app.delivery.model
* - 파일명      : DeliveryListVO.java
* - 작성일      : 2017. 3. 9.
* - 작성자      : valuefactory 권성중
* - 설명      :   BO 배송목록
* </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class DeliveryListVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 배송 번호 */
	private Long dlvrNo;
	/** 주문 클레임 구분 코드 */
	private String ordClmGbCd;
	/** 배송 구분 코드 */
	private String dlvrGbCd;
	/** 배송 유형 코드 */
	private String dlvrTpCd;
	/** 배송 처리 유형 코드 */
	private String dlvrPrcsTpCd;
	/** 배송 처리 유형 명 */
	private String dlvrPrcsTpNm;
	/** 택배사 코드 */
	private String hdcCd;
	/** 송장 번호 */
	private String invNo;


	/** 주문 완료 일시 */
	private Timestamp ordCpltDtm;
	/** 배송 지시 일시 */
	private Timestamp dlvrCmdDtm;
	/** 배송 완료 일시 */
	private Timestamp dlvrCpltDtm;
	/** 배송 지연일 */
	private Long dlvrDelayDays;
	/** 출고 완료 일시 */
	private Timestamp ooCpltDtm;
	/** 주문 번호 */
	private String ordNo;
	/** 주문 상세 순번 */
	private Long ordDtlSeq;
	/** 주문 상세 상태 코드 */
	private String ordDtlStatCd;
	/** 클레임 상세 순번 */
	private String clmDtlSeq;
	/** 클레임 번호 */
	private String clmNo;
	/** 클레임 유형 코드 */
	private String clmTpCd;
	/** 클레임 상세 상태 코드 */
	private String clmDtlStatCd;
	/** 클레임 사유 명 */
	private String clmRsnNm;
	/** 클레임 사유 내용 */
	private String clmRsnContent;
	/** 상품 명 */
	private String goodsNm;
	/** 상품 아이디 */
	private String goodsId;
	/** 상품 구성 유형 */
	private String goodsCstrtTpNm;
	/** 사은품 명 */
	private String subGoodsNm;
	/** 단품 명 */
	private String itemNm;
	/** 단품 번호 */
	private Long itemNo;
	/** 업체 번호 */
	private Long compNo;
	/** 업체 구분코드 */
	private String compGbCd;
	/** 업체 유형코드 */
	private String compTpCd;
	/** 업체 명 */
	private String compNm;
	/** 상위 업체 번호 */
	private Long upCompNo;
	/** 업체 구분 */
	private String compGbNm;
	/** 매입 업체 명*/
	private String phsCompNm;
	/** 판매 금액 */
	private Long saleAmt;
	/** 결제 금액 */
	private Long payAmt;
	/** 배송 수량 */
 	private Long ordQty;
 	/** 클레임 수량 */
 	private Long clmQty;
 	/** 실 배송비 */
 	private Long realDlvrAmt;
 	/** 회수배송비 */
 	private Long rtnRealDlvrAmt;
	/** 수취인 명 */
	private String adrsNm;
	/** 전화 */
	private String tel;
	/** 휴대폰 */
	private String mobile;
	/** 우편 번호 신 */
	private String postNoNew;
	/** 도로 주소 */
	private String roadAddr;
	/** 도로 상세 주소 */
	private String roadDtlAddr;
	/** 우편 번호 구 */
	private String postNoOld;
	/** 지번 주소 */
	private String prclAddr;
	/** 지번 상세 주소 */
	private String prclDtlAddr;
 	/** 배송 메모 */
 	private String dlvrMemo;

 	/**  ROWSPAN */
 	private Integer ordDtlRowNum;
 	/**  ROWSPAN */
 	private Integer ordDtlCnt;
 	/**  TOTAL COUNT */
 	private Integer totalCnt;

	/** 사이트 ID */
	private Long stId;
	/** 사이트 명 */
	private String stNm;

	/** 상품의 배송비정책.기본택배사 코드 */
	private String dftHdcCd;
	
	/** 주문자 회원 번호    */
	private String mbrNo;
	/** 주문자명    */
	private String ordNm;
	/** 주문자아이디    */
	private String ordrId;
	/** 주문자 휴대폰    */
	private String ordrMobile;
	/** 공급사 구분 */
	private String compTpNm;

	private String excelDlvrNo;

	public String getExcelDlvrNo() {
		return excelDlvrNo = this.getDlvrNo().toString();
	}

	public void setExcelDlvrNo(String excelDlvrNo) {
		this.excelDlvrNo = excelDlvrNo;
	}

 	/** 배송일련번호 */
 	private List<DeliveryListVO> deliveryDetailList;

	public String getOrdNm() {
		if(StringUtil.isNotEmpty(this.ordNm) && StringUtils.endsWith(this.ordNm, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordNm, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordNm;
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
	
	public String getOrdrId() {
		if(StringUtil.isNotEmpty(this.ordrId) && StringUtils.endsWith(this.ordrId, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordrId, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordrId;
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