package biz.app.claim.model;

import java.sql.Timestamp;
import java.util.List;

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

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.model
* - 파일명		: ClaimBaseVO.java
* - 작성일		: 2017. 3. 7.
* - 작성자		: snw
* - 설명			: 클레임 기본 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ClaimBaseVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 클레임 번호 */
	private String clmNo;

	/** 사이트 ID */
	private Long stId;

	/** 사이트 명 */
	private String stNm;

	/** 주문 번호 */
	private String ordNo;

	/** 원 클레임 번호 */
	private String orgClmNo;

	/** 회원 번호 */
	private Long mbrNo;

	private String ordNm;

	private String ordrId;

	private String ordrEmail;

	private String ordrTel;

	private String ordrMobile;

	/** 클레임 유형 코드 */
	private String clmTpCd;

	/** 주문 상태 코드 */
	private String ordStatCd;

	/** 클레임 상태 코드 */
	private String clmStatCd;

	/** 주문 매체 코드 */
	private String ordMdaCd;

	/** 채널 아이디 */
	private Long		chnlId;

	/** 맞교환 여부 */
	private String	swapYn;
	
	/** 채널 명 */
	private String 	chnlNm;

	/** 접수 일시 */
	private Timestamp acptDtm;

	/** 완료 일시 */
	private Timestamp cpltDtm;

	/** 취소 일시 */
	private Timestamp cncDtm;

	/** 접수자 번호 */
	private Integer acptrNo;

	/** 취소자 번호 */
	private Integer cncrNo;

	/** 완료자 번호 */
	private Integer cpltrNo;
	
	/** 배송지 번호 */
	private Long dlvraNo;

	/** 회수지 번호 */
	private Long rtrnaNo;
	
	/** 배송 처리 유형 코드 */
	private String dlvrPrcsTpCd;

	//========================================================================================
	// PAY_BASE
	//========================================================================================

	/** 결제 번호 */
	private Integer payNo;

	/** 결제 수단 코드 */
	private String payMeansCd;
	
	/** 결제 상태 코드 */
	private String payStatCd;

	/** 결제 금액 */
	private Long payAmt;

	/** 결제 완료 일시 */
	private Timestamp payCpltDtm;

	//========================================================================================
	// PAY_CASH_REFUND
	//========================================================================================

	/** 현금 환불 번호 */
	private Integer refundCashRfdNo;

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

	/** 환불 완료 일시 */
	private Timestamp claimRefundCpltDtm;

	/** 환불 금액 */
	private Long claimRefundAmt;









	/** 클레임 상세(교환/반품/AS) List VO */
	private List<ClaimDetailVO> claimDetailListVO;

	/** 클레임 상세(환불) List VO */
	private List<ClaimDetailRefundVO> claimDetailRefundListVO;

	/** 접수자 명 */
	private String acptrNm;

	/** 취소자 명 */
	private String cncrNm;

	/** 완료자 명 */
	private String cpltrNm;


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
	
	public String getOrdrId() {
		if(StringUtil.isNotEmpty(this.ordrId) && StringUtils.endsWith(this.ordrId, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordrId, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordrId;
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