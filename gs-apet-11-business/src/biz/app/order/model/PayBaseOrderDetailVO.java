package biz.app.order.model;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.constants.CommonConstants;
import framework.common.model.BaseSysVO;
import framework.common.util.PetraUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;

@Data
@EqualsAndHashCode(callSuper=false)
public class PayBaseOrderDetailVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 결제 번호 */
	private Integer payNo;

	/** 원 결제 번호 */
	private Long orgPayNo;

	/** 주문 클레임 구분 코드 */
	private String ordClmGbCd;

	/** 주문 번호 */
	private String ordNo;

	/** 클레임 번호 */
	private String clmNo;

	/** 결제 연동 코드 */
	private String payLnkCd;

	/** 결제 수단 코드 */
	private String payMeansCd;

	/** 결제 상태 코드 */
	private String payStatCd;

	/** 결제 완료 일시 */
	private Timestamp payCpltDtm;

	/** 결제 금액 */
	private Long payAmt;

	/** 회원 번호 */
	private Integer mbrNo;

	/** 상점아이디 */
	private String strId;

	/** 거래 번호 */
	private String dealNo;

	/** 승인 번호 */
	private String cfmNo;

	/** 승인 일시 */
	private Timestamp cfmDtm;

	/** 승인 결과 코드 */
	private String cfmRstCd;

	/** 승인 결과 메세지 */
	private String cfmRstMsg;

	/** 카드사 코드 */
	private String cardcCd;

	/** 은행 코드 */
	private String bankCd;

	/** 계좌 번호 */
	private String acctNo;

	/** 예금주 명 */
	private String ooaNm;

	/** 입금자 명 */
	private String dpstrNm;

	/** 입금 예정 일자 */
	private String dpstSchdDt;

	/** 입금 예정 금액 */
	private Long dpstSchdAmt;

	/** 입금 확인 메세지 */
	private String dpstCheckMsg;

	/** 결제 조정 금액 */
	private Long payAdjustAmt;

	/** 총 판매금액 */
	private Long saleAmtTotal;

	/** 총 결제금액 */
	private Long payAmtTotal;

	/** 총 배송비 */
	private Long dlvrAmtTotal;

	/** 총 적립금 */
	private Long svmnDcAmtTotal;

	/** 총 쿠폰할인 */
	private Long cpDcTotal;

	/** 총 가격할인 금액 */
	private Long promotionDcTotal;
	
	/** 총 혜택 금액 */
	private Long aplBnftAmtTotal;
	
	/** MEMO */
	private String memo;
	
	/** 주문 상태 코드 */
	private String ordStatCd;
	
	
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
	
	public String getDpstrNm() {
		if(StringUtil.isNotEmpty(this.dpstrNm) && StringUtils.endsWith(this.dpstrNm, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.dpstrNm, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.dpstrNm;
	}
}