package biz.app.order.model;

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

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDetailCsVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;

	/** 주문 상세 상태 코드 */
	private String ordDtlStatCd;

	/** 주문 상세 상태 코드 */
	private String ordDtlStatCdNm;

	/** 상품 아이디 */
	private String goodsId;

	/** 상품 명 */
	private String goodsNm;

	/** 단품 번호 */
	private Integer itemNo;

	/** 단품 명 */
	private String itemNm;



	/** 딜 상품 아이디 */
	private String dealGoodsId;

	/** 전시 분류 번호 */
	private String dispClsfNo;

	/** 업체 상품 번호 */
	private String compGoodsNo;

	/** 업체 단품 번호 */
	private String compItemNo;

	/** 판매 금액 */
	private Long saleAmt;

	/** 주문 수량 */
	private Long ordQty;

	/** 주문 수량 */
	private Long cncQty;

	/** 결제 금액 */
	private Long payAmt;

	/** 공급 금액 */
	private Long splAmt;

	/** 상품수수료율 */
	private Double goodsCmsnRt;

	/** 상품 쿠폰 할인 금액 */
	private Long goodsCpDcAmt;

	/** 배송비 쿠폰 할인 금액 */
	private Long dlvrcCpDcAmt;

	/** 조립비 쿠폰 할인 금액 */
	private Long asbcCpDcAmt;

	/** 장바구니 쿠폰 할인 금액 */
	private Long cartCpDcAmt;

	/** 적립금 할인 금액 */
	private Long svmnDcAmt;

	/** 결제 번호 */
	private Integer payNo;

	/** 배송비 번호 */
	private Integer dlvrcNo;

	/** 조립비 번호 */
	private Integer asbcNo;

	/** 업체 번호 */
	private Long compNo;

	/** 업체 명 */
	private String compNm;

	/** 업체 계약 번호 */
	private String compContrNo;

	/** 회원 번호 */
	private Integer mbrNo;

	/** 배송 희망 일자 */
	private String dlvrHopeDt;

	/** 상품 준비 일시 */
	private Timestamp goodsPrpDtm;

	/** 출고 지시 일시 */
	private Timestamp ooCmdDtm;

	/** 출고 완료 일시 */
	private Timestamp ooCpltDtm;

	/** 배송 완료 일시 */
	private Timestamp dlvrCpltDtm;

	/** 상품 평가 등록 여부 */
	private String goodsEstmRegYn;

	/** 브랜드명 국문 */
	private String bndNmKo;

	//===============================================================
	// Counsel
	//===============================================================
	/** 상담 번호 */
	private Integer cusNo;

	/** 문의자 회원 번호 */
	private Integer eqrrMbrNo;

	/** 상담 상태 코드 */
	private String cusStatCd;

	/** 내용 */
	private String content;

	/** 문의자 명 */
	private String eqrrNm;

	/** 문의자 전화 */
	private String eqrrTel;

	/** 상담 경로 코드 */
	private String cusPathCd;

	/** 제목 */
	private String ttl;

	/** 파일 번호 */
	private Integer flNo;

	/** 문의자 이메일 */
	private String eqrrEmail;

	/** 문의자 휴대폰 */
	private String eqrrMobile;

	/** 주문 상세 순번 */
//	private Long ordDtlSeq;

	/** 주문 번호 */
//	private String ordNo;

	/** 상품 아이디 */
//	private String goodsId;

	/** 클레임 번호 */
	private String clmNo;

	/** 클레임 상세 순번 */
	private Long clmDtlSeq;

	/** 상담 카테고리1 코드 */
	private String cusCtg1Cd;

	/** 상담 카테고리2 코드 */
	private String cusCtg2Cd;

	/** 상담 카테고리3 코드 */
	private String cusCtg3Cd;

	/** 상담 접수 일시 */
	private Timestamp cusAcptDtm;

	/** 상담 취소 일시 */
	private Timestamp cusCncDtm;

	/** 상담 완료 일시 */
	private Timestamp cusCpltDtm;

	/** 상담 접수자 번호 */
	private Integer cusAcptrNo;

	/** 상담 취소자 번호 */
	private Integer cusCncrNo;

	/** 상담 완료자 번호 */
	private Integer cusCpltrNo;

	/** 상담 접수자 이름 */
	private String cusAcptrNm;

	/** 상담 취소자 이름 */
	private String cusCncrNm;

	/** 상담 완료자 이름 */
	private String cusCpltrNm;

	/** 주문 접수 일시 */
	private Timestamp ordAcptDtm;
	/** 주문자 ID */
	private String ordrId;
	/** 주문자 명 */
	private String ordNm;
	/** 회원 명 */
	private String mbrNm;

	/** 주문 완료 일시 */
	private Timestamp ordCpltDtm;
	/** 사이트 ID */
	private Long stId;

	/** 사이트 명 */
	private String stNm;


	/** 주문 번호 카운트 */
	private Integer ordDtlCnt;

	/** 주문 번호 일련번호 */
	private Integer ordDtlRowNum;

	public String getOrdNm() {
		if(StringUtil.isNotEmpty(this.ordNm) && StringUtils.endsWith(this.ordNm, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordNm, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordNm;
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