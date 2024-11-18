package biz.app.settlement.model;

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
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.settlement.model
* - 파일명		: SettlementListExcelVO.java
* - 작성일		: 2021. 3. 19.
* - 작성자		: pse
* - 설명			: 정산 목록 엑셀 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class SettlementListExcelVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/****************************
	 * 주문 정보
	 ****************************/

	/** 주문 번호 */
	private String ordNo;
	
	/** 주문 상세 순번 */
	private Integer ordDtlSeq;
	
	/** 회원 번호 */
	private Long mbrNo;
	
	/** 주문자 명 */
	private String ordNm;
	
	/** 주문자 회원 명 */
//	private String mbrNm;
	
	/** 주문자 이메일 */
	private String ordrEmail;
	
	/** 주문자 휴대폰 */
	private String ordrMobile;
	
	/** 주문자 ID */
	private String ordrId;
	
	/** 주문자 로그인 아이디 */
//	private String loginId;
	
	/** 회원 등급 명 */
	private String mbrGrdNm;
	
	/** 업체 구분 코드 */
	private String compGbCd;
	
	/** 업체 구분 명 10:자사 20:위탁 */
	private String compGbNm;
	
	/** 매입 업체 명 */
	private String phsCompNm;
	
	/** 상품 아이디 / 상품 코드 */
	private String goodsId;
	
	/** 단품 번호 / 자체 상품 코드 */
	private Long itemNo;
	
	/** 상품 구성 유형 */
	private String goodsCstrtTpCd;
	
	/** 상품 구성 유형 */
	private String goodsCstrtTpNm;
	
	/** 상품 명 */
	private String goodsNm;
	
	/** 단품 명 */
	private String itemNm;

	/** 주문 상세 상태 코드 */
	private String ordDtlStatCd;

	/** 주문 상세 상태 코드 이름 */
	private String ordDtlStatCdNm;
	
	/** 매입가 */
	private Long splAmt;
	
	/** 총 매입가 */
	private Long splAmtTot;
	
	/** 정상가 */
	private int    orgSaleAmt;
	
	/** 판매가 */
	private int    saleAmt;
	
	/** 상품 할인 금액 : 정상가 - 판매가*/
	private Long prmtDcAmt;
	
	/** 상품 쿠폰 할인 금액 */
	private Long cpDcAmt;
	
	/** 장바구니 쿠폰 할인 금액 */
	private Long cartCpDcAmt;
	
	/** 결제 금액 : 판매가 - 상품쿠폰 - 장바구니쿠폰*/
	private Long payAmt;
	
	/** 주문 수량 */
	private Integer ordQty;
	
	/** 취소 수량 */
	private Integer cncQty;

	/** 반품 수량 */
	private Integer rtnQty;
	
	/** 교환 수량 */
	private Integer excQty;
	
	/** 클레임 교환 진행 수량 */
	private Integer	clmExcIngQty = 0;
	
	/** 상품 총 할인 합계 금액 */
	private Long prmtDcSumAmt;
	
	/** 상품쿠폰 할인 합계 금액 */
	private Long cpSumAmt;
	
	/** 장바구니 쿠폰 할인 합계 금액 */
	private Long cartCpSumAmt;
	
	/** 쿠폰할인 합계 금액 */
	private Long cpDcSumAmt;
	
	/** 결제 합계 금액 */
	private Long paySumAmt;
	
	/** 정산 금액 */
	private Long stlAmt;

	/** 총 정산 금액 */
	private Long stlAmtTot;
	
	/** 배송비 번호 */
	private Long dlvrcNo;
	
	/** 원 배송비*/
	private Long orgDlvrAmt;
	
	/** 배송비 할인*/
	private Long dlvrcCpDcAmt;
	
	/** 실 배송비*/
	private Long realDlvrAmt;
	
	/** 실 배송비*/
	private String realDlvrAmtString;
	
	/** 교환 배송비*/
	private Long excDlvrAmt;
	
	/** 반품 배송비*/
	private Long rtnDlvrAmt;
	
	/** 결제방법 */
	private String payMeansNm;
	
	/** 은행 코드 */
	private String bankNm;
	
	/** 계좌 번호 */
	private String acctNo;

	/** 예금주 명 */
	private String ooaNm;
	
	/** 현금 영수증 여부 */
	private String cashRctNo;
	
	/** 승인 결과 코드 */
	private String 	cfmRstCd;
	
	/** 거래 번호 */
	private String 	dealNo;
	
	/** 승인 번호 */
	private String 	cfmNo;
	
	/** 주문 접수 일시 */
	private Timestamp ordAcptDtm;
	
	/** 구매 확정 일시 */
	private Timestamp purConfDtm;
	
	/** 정산 상태 코드 **/
	private String ordCclStatCd;
	
	/** 정산 완료 일시 */
	private Timestamp ordCclCpltDtm;
	
	/** 결제 완료 일시 */
	private String payCpltDtm;
	
	/** 결제 완료 일시 - 가상계좌 */
	private String payCpltDtmVirtualAccount;
	
	/** 수취인 명 */
	private String	adrsNm;
	
	/** 수취인 휴대폰 */
	private String mobile;
	
	/** 우편번호 신 */
	private String 	postNoNew;
	
	/** 도로명 주소 */
	private String	roadAddr;

	/** 도로명 상세 주소 */
	private String	roadDtlAddr;
	
	/** 환불 금액 */
	private Long rfdAmt;
	
	/** 현금 환불 금액 */
	private Long cashRefundAmt;
	
	/** 카드 환불 금액 */
	private Long cardRefundAmt;
	
	/** 간편결제 환불 금액 */
	private Long payRefundAmt;
	
	/** 환불 추가 배송비 */
	private Long clmDlvrcAmt;
	
	/** 클레임 사유 코드 */
	private String clmRsnCd;
	
	/** 클레임 사유(귀책) */
	private String clmRsnNm;

	/** 클레임 사유 내용 */
	private String clmRsnContent;
	
	/** 환불 은행 코드 */
	private String refundBankCd;

	/** 환불 계좌 번호 */
	private String refundAcctNo;

	/** 환불 예금주 명 */
	private String refundOoaNm;

	/** 클레임 접수 일시 */
	private Timestamp clmAcptDtm;
	
	/** 클레임 완료 일시 */
	private Timestamp clmCpltDtm;
	
	/** 모델명 */
	private String	mdlNm;
	
	/** 카테고리 */
	private String	category;
	
	/** 브랜드명 한글 */
	private String	bndNmKo;
	
	/** 제조사 */
	private String	mmft;
	
	/** 원산지 */
	private String	ctrOrg;
	
	/** 사은품 명 */
	private String	subGoodsNm;
	
	/** 배송 처리 유형 명 */
	private String dlvrPrcsTpNm;
	
	/** 배송 번호 */
	private Long dlvrNo;
	
	/** 택배사 코드 */
	private String hdcCd;
	
	/** 택배사 이름 */
	private String hdcNm;
	
	/** 송장 번호 */
	private String invNo;
	
	/** 배송 메모 */
 	private String dlvrMemo;
 	
 	/** 배송 요청사항 */
 	private String dlvrDemand;
 	
 	/** 배송 지시 일시 */
	private Timestamp dlvrCmdDtm;
	
	/** 배송 완료 일시 */
	private Timestamp dlvrCpltDtm;
	
	/** 회원 마케팅 수신동의 여부*/
 	private String mkngRcvYn;
	
 	/** 사용된 쿠폰 명*/
 	private String cpNm;
 	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	/** 잔여 주문 수량 */
	private Integer rmnOrdQty;

	/** 반품 진행 수량 */
	private Integer rtnIngQty = 0;

	/** 반품 완료 수량 */
	private Integer rtnCpltQty = 0;

	/** 유효 주문 수량 */
	private Integer vldOrdQty;
	
	/** 클레임 진행 여부 */
	private String	clmIngYn;

	/** 사이트 ID */
	private Long stId;

	/** 사이트 명 */
	private String stNm;

	/** 주문 상태 코드 */
	private String ordStatCd;

	/** 주문 매체 코드 */
	private String ordMdaCd;

	/** 채널 ID */
	private Integer chnlId;

	/** 채널 ID */
	private String chnlNm;

	/** 주문 완료 일시 */
	private Timestamp ordCpltDtm;
	
	/** 송장 등록 일시 */
	private Timestamp ooCpltDtm;

	/** 주문자 전화 */
	private String ordrTel;
	
	/** 외부 주문 번호 */
	private String outsideOrdNo;

	/** 업체 번호 */
	private Long compNo;
	
	/** 업체 명 */
	private String compNm;

	/** 전화 */
	private String	tel;
 	/** */
 	private List<SettlementListExcelVO> orderDetalListVO;

 	/** ROWSPAN */
 	private Integer ordDlvNum;
 	/** ROWSPAN */
 	private Integer ordDlvCnt;
 	
 	/** 주문상세 갯수 */
	private Integer ordDtlCnt;
	
 	/** 업체상품 아이디 */
	private String compGoodsId;

	/** 업체단품 아이디 */
	private String compItemId;
	
	/** 전시 분류 번호 */
	private Long dispClsfNo;
	
	/** 주문 배송지 번호 */
	private Long OrdDlvraNo;
	
	/** 배송 처리 유형 */
	private String dlvrPrcsTpCd;
	
	/** 제작 상품 여부 */
	private String mkiGoodsYn;
	
	/** 사전예약 여부 */
	private String rsvGoodsYn;
	
	/** 사은품 여부 */
	private String frbGoodsYn;
	
	/** 묶음 상품 여부 */
	private String pakGoodsYn;
	
	/** 사업자 번호 */
	private String bizNo;
	
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
	
	public String getRefundOoaNm() {
		if(StringUtil.isNotEmpty(this.refundOoaNm) && StringUtils.endsWith(this.refundOoaNm, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.refundOoaNm, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.refundOoaNm;
	}
	
	public String getRefundAcctNo() {
		if(StringUtil.isNotEmpty(this.refundAcctNo) && StringUtils.endsWith(this.refundAcctNo, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.refundAcctNo, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.refundAcctNo;
	}
}