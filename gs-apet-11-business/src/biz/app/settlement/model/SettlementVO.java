package biz.app.settlement.model;

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
public class SettlementVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 정산 번호 */
	private Integer stlNo;

	/** 정산 월 */
	private String stlMonth;

	/** 정산 차수 */
	private Integer stlOrder;

	/** 업체 번호 */
	private Integer compNo;
	
	/** 원 업체 번호 */
	private Integer orgCompNo;
	
	/** 업체 명 */
	private String compNm;	

	/** 업체 구분 */
	private String compGbNm;
	
	/** 사이트 id */
	private Integer stId;
	
	/** 사이트 */
	private String stNm;		

	/** 정산 시작 일자 */
	private String stlStrtDt;

	/** 정산 마감 일자 */
	private String stlEndDt;
	
	/** 정산 기간 */
	private String stlTerm;	
	
	/** 사용자 번호 */
	private Long mdUsrNo;

	/** 판매 금액 */
	private Long saleAmt;

	/** 중개자 수수료 */
	private Long brkrCms;

	/** 입점사 판매 대금 */
	private Long compSaleAmt;

	/** 할인 공제 금액 */
	private Long dcAmt;
	
	/** 중개자 부담 할인 금액 */
	private Long brkrBdnDcAmt;
	
	/** 입점사 부담 할인 금액 */
	private Long compBdnDcAmt;

	/** 환불 공제 금액 */
	private Long rfdAmt;

	/** 중개자 환불 수수료 */
	private Long brkrRfdCms;

	/** 입점사 환불 대금 */
	private Long compRfdAmt;

	/** 판매 배송비 */
	private Long ordDlvrc;
	
	/** 클레임 배송비 */
	private Long clmDlvrc;

	/** 마진 금액 */
	private Long mrgAmt;
	
	/** 업체 정산 금액 */
	private Long compStlAmt;
	
	/** 반품 유보율 */
	private Double rtnRsrvRate;

	/** 반품 유보금 */
	private Long rtnRsrvAmt;

	/** 전회차 반품 유보금 */
	private Long preRtnRsrvAmt;
	
	/** 실 정산 금액 */
	private Long realStlAmt;	
	
	/** 정산 상태 코드 */
	private String stlStatCd;

	/** 지급 상태 코드 */
	private String pvdStatCd;

	/** 은행명 */
	private String bankNm;
	
	/** 계좌번호 */
	private String acctNo;

	/** 예금주 */
	private String ooaNm;
	
	
	/** 집계 일자 */
	private String totalDt;
	
	/** 상세 순번 */
	private Integer dtlSeq;	

	/** 정산 주문 유형 코드 */
	private String stlOrdTpCd;
	
	/** 정산 주문 유형  */
	private String stlOrdTpNm;
	
	/** 주문 번호 */
	private String ordNo;	
	
	/** 주문 상세 순번 */
	private Integer ordDtlSeq;	
	
	/** 클레임 번호 */
	private String clmNo;	
	
	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;
	
	/** 주문자 이름 */
	private String ordNm;
	
	/** 주문자 아이디 */
	private String ordrId;
	
	/** 접수 일시 */
	private Timestamp acptDtm;	

	/** 상품 아이디 */
	private String goodsId;
	
	/** 상품 명 */
	private String goodsNm;		
	
	/** 단품 번호 */
	private Integer itemNo;	
	
	/** 단품 명 */
	private String itemNm;
	
	/** 정산 대상 수량 */
	private Integer stlTgQty;		
	
	/** 적립금 사용 금액  */
	private Long svmnUseAmt;
	
	/** 배송비  */
	private Long dlvrc;	

	/** 배송비 할인 금액  */
	private Long dlvrcDcAmt;	
	
	/** 결제 금액  */
	private Long payAmt;	
	
	/** 결제 수단 코드  */
	private Long payMeansCd;
	
	/** 결제 수단  */
	private String payMeansNm;
	
	/** 가격 할인 자사 부담금 */
	private Long prmtBrkrBdnDcAmt;	
	
	/** 가격 할인 업체 부담금 */
	private Long prmtCompBdnDcAmt;
	
	/** 상품 쿠폰 할인 자사 부담금 */
	private Long gcBrkrBdnDcAmt;	
	
	/** 상품 쿠폰 할인 자사 부담금 */
	private Long gcCompBdnDcAmt;
	
	/** 장바구니 쿠폰 할인 자사 부담금 */
	private Long ccBrkrBdnDcAmt;	
	
	/** 장바구니 쿠폰 할인 업체 부담금 */
	private Long ccCompBdnDcAmt;
	
	/** 배송비 쿠폰 할인 자사 부담금 */
	private Long dcBrkrBdnDcAmt;

	/** 배송비 쿠폰 할인 업체 부담금 */
	private Long dcCompBdnDcAmt;
	
	/** 수수료 율 */
	private Double cmsRate;
	
	/** 판매 마진 금액 */
	private Long saleMrgAmt;
	
	/** 실 마진 금액 */
	private Long realMrgAmt;
	
	/** 상품 전체 금액  */
	private Long saleTotAmt;

	/** 가격 할인 총액  */
	private Long prmtBdnDcTotAmt;

	/** 상품 쿠폰 할인 총액  */
	private Long gcBdnDcTotAmt;
	
	/** 장바구니 쿠폰 할인 총액  */
	private Long ccBdnDcTotAmt;
	
	/** 배송비 쿠폰 할인 총액  */
	private Long dcBdnDcTotAmt;
	
	/** 자사 할인 총액  */
	private Long brkrDcTotAmt;

	/** 업체 할인 총액  */
	private Long compDcTotAmt;
	
	/** 판매 정산 총액  */
	private Long saleSetAmt;
	
	/** 업체 판매 할인 공제  */
	private Long compSaleDcAmt;
	
	/** 총 배송비  */
	private Long dlvrcTotAmt;
	
	/** 업체 배송비 할인 금액 */
	private Long compBdnDlvrcDcAmt; 
	
	/** 최종 정산 금액  */
	private Long setTotAmt;
	
	/** 정산 상태  */
	private String stlStatNm;
	
	/** 지급 상태  */
	private String pvdStatNm;
	
	/** MD 이름  */
	private String mdUsrNm;
	
	/** 페이지 구분 코드 */
	private String pageGbCd;

	/** 세금계산서 엑셀 출력 */
	private String taxType;
	private String dcgBizNo;
	private String dcgBizNo2;
	private String dcgCompNm;
	private String dcgCeoNm;
	private String dcgPrclAddr;
	private String dcgBiz;
	private String dcgBizTp;
	private String dcgDlgtEmail;
	private String provAmt;	
	private String provTaxAmt;	
	private String bizNo;
	private String col1;
	private String ceoNm;
	private String prclAddr;
	private String biz;
	private String bizTp;
	private String dlgtEmail;
	private String col2;
	private String provAmt1;	
	private String provTaxAmt1;
	private String col3;
	private String stlEndDay;
	private String item;
	private String col4;
	private String col5;
	private String col6;
	private String col7;
	private String col8;
	private String col9;
	private String col10;
	private String col11;
	private String col12;
	private String col13;
	private String col14;
	private String col15;
	private String col16;
	private String col17;
	private String col18;
	private String col19;
	private String col20;
	private String col21;
	private String col22;
	private String col23;
	private String col24;
	private String col25;
	private String col26;
	private String col27;
	private String col28;
	private String col29;
	private String col30;
	private String col31;
	private String col32;
	private String col33;
	private String col34;
	private String col35;
	private String rcptGb;

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
