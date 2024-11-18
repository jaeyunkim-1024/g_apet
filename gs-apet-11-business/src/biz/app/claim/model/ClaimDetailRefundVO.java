package biz.app.claim.model;

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
public class ClaimDetailRefundVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 클레임 번호 */
	private String clmNo;

	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;

	/** 클레임 상세 유형 코드 */
	private String clmDtlTpCd;

	/** 클레임 상세 상태 코드 */
	private String clmDtlStatCd;

	/** 클레임 상세 노출 상태 코드, 사용자에게 보여줄 상태 코드 */
	private String clmDtlGrpStatCd;

	/** 클레임 유형 코드 */
	private String clmTpCd;

	/** 클레임 사유 코드 */
	private String clmRsnCd;

	/** 클레임 사유 내용 */
	private String clmRsnContent;
	
	/** 클레임 거부 이유 내용 */
	private String clmDenyRsnContent;

	/** 클레임 상태 코드 */
	private String clmStatCd;

	/** 클레임 수정 일자 */
	private Timestamp clmSysUpdDtm;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;

	/** 상품 아이디 */
	private String goodsId;
	
	/** 묶음 상품 아이디 */
	private String pakGoodsId;

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

	/** 판매 금액 */
	private Long saleAmt;

	/** 주문 수량 */
	private Long ordQty;

	/** 결제 금액 */
	private Long payAmt;

	/** 클레임 수량 */
	private Long clmQty;

	/** 공급 금액 */
	private Long splAmt;

	/** 상품수수료율 */
	private Double goodsCmsnRt;

	/** 업체 번호 */
	private Long compNo;

	/** 배송비 번호 */
	private Integer dlvrcNo;

	/** 배송지 번호 */
	private Integer dlvraNo;

	/** 배송 번호 */
	private Integer dlvrNo;

	/** 회원 번호 */
	private Integer mbrNo;

	/** 클레임 완료 일시 */
	private Timestamp clmCpltDtm;
	
	/** 회수지 번호 */
	private Long rtrnaNo;

	//========================================================================================
	// PAY_CASH_REFUND
	//========================================================================================

	/** 현금 환불 번호 */
	private Integer refundCashRfdNo;

	/** 결제 번호 */
	private Integer refundPayNo;

	/** 클레임 번호 */
//	private String refundClmNo;

	/** 클레임 상세 순번 */
//	private Integer refundClmDtlSeq;

	/** 환불 유형 코드 */
	private String refundRfdTpCd;

	/** 환불 상태 코드 */
	private String refundRfdStatCd;

	/** 은행 코드 */
	private String refundBankCd;

	/** 계좌 번호 */
	private String refundAcctNo;
	
	/** 예금주 명 */
	private String refundOoaNm;
	
	/** 원 주문 결제 카드사 코드 */
	private String orgCardcCd;
	
	/** 원 주문 결제 카드 번호 */
	private String orgCardNo;
	
	/** 원 주문 결제 은행 코드 */
	private String orgBankCd;

	/** 원 주문 결제 계좌 번호 */
	private String orgAcctNo;
	
	/** 원 주문 결제 예금주 명 */
	private String orgOoaNm;

	/** 예정 금액 */
	private Long refundSchdAmt;

	/** 환불 금액 */
	private Long refundRfdAmt;

	/** 수수료 금액 */
	private Long refundCmsAmt;

	/** 예정 일자 */
	private String refundSchdDt;

	/** SMS 전송 여부 */
	private String refundSmsSndYn;

	/** 처리 응답 코드 */
	private String refundPrcsRspsCd;

	/** 처리 응답 내용 */
	private String refundPrcsRspsContent;

	/** 접수 일시 */
	private Timestamp refundAcptDtm;

	/** 대기 일시 */
	private Timestamp refundStbDtm;

	/** 처리 일시 */
	private Timestamp refundPrcsDtm;

	/** 에러 일시 */
	private Timestamp refundErrDtm;

	/** 완료 일시 */
	private Timestamp refundCpltDtm;

	/** 접수자 번호 */
	private Integer refundAcptrNo;

	/** 접수자명 */
	private String refundAcptrNm;

	/** 대기자 번호 */
	private Integer refundStbrNo;

	/** 처리자 번호 */
	private Integer refundPrcsrNo;

	/** 처리자명 */
	private String refundPrcsrNm;

	/** 완료자 번호 */
	private Integer refundCpltrNo;

	/** 완료자명 */
	private String refundCpltrNm;

	/** 메모 */
	private String refundMemo;

	/** 외부 클레임 상세 번호 */
	private String outsideCmDtlNo;

	/** 상품 이미지 순번 */
	private String imgSeq;

	/** image 경로 */
	private String imgPath;

	/** 반전 image 경로 */
	private String rvsImgPath;

	/** 브랜드명 국문 */
	private String bndNmKo;

	/** 주문 접수 일시 */
	private Timestamp ordAcptDtm;

	/** 업체 명 */
	private String compNm;

	/** 주문 상세 상태 코드 */
	private String ordDtlStatCd;

	/** 결제수단코드 */
	private String payMeansCd;

	/** 외부 클레임 상세 번호 */
	private String	outsideClmDtlNo;

	/** 결제 번호 */
	private Long payNo;

	/** 결제 금액 */
	private Long payMeanAmt;

	/** 프로모션 할인 금액 */
	private Long prmtDcAmt;
	
	public String getRefundAcctNo() {
		if(StringUtil.isNotEmpty(this.refundAcctNo) && StringUtils.endsWith(this.refundAcctNo, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.refundAcctNo, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.refundAcctNo;
	}
	
	public String getRefundOoaNm() {
		if(StringUtil.isNotEmpty(this.refundOoaNm) && StringUtils.endsWith(this.refundOoaNm, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.refundOoaNm, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.refundOoaNm;
	}
}