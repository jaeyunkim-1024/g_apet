package biz.app.order.model;

import framework.common.constants.CommonConstants;
import framework.common.model.BaseSysVO;
import framework.common.util.PetraUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderMsgVO extends BaseSysVO implements Serializable {
	/** 주문 번호 */
	private String ordNo;
	
	/** 주문자 */
	private String ordNm;
	
	/** 주문자 핸드폰 번호 */
	private String ordrMobile;
	
	/** 회원번호 */
	private Long mbrNo;
	
	/** 상품명 */
	private String goodsNm;
	
	/** 클레임 번호 */
	private String clmNo;
	
	/** 주문당 상품수 */
	private int extraOrdCnt;
	
	/** 주문접수일시 */
	private Timestamp ordAcptDtm;
	
	/** 주문완료일시 */
	private Timestamp ordCpltDtm;
	
	/** 지불금액 */
	private Long payAmt;
	
	/** 은행명 */
	private String bankNm;
	
	/** 계좌번호 */
	private String acctNo;
	
	/** 예금예정일자 */
	private String dpstSchdDt;
	
	/** 배송지 도로명 주소 */
	private String roadAddr;
	
	/** 택배사 이름 */
	private String hdcCdNm;
	
	/** 송장번호 */
	private String invNoNm;
	
	/** 결제수단명 */
	private String payMeansNm;
	
	/** 클레임 접수 일 */
	private Timestamp clmAcptDtm;
	
	/** 클레임 금액 */
	private Long clmPayAmt ;
	
	/** 클레임 회수지 도로명 주소 */
	private String clmRtnaRoadAddr;
	
	/** 클레임 배송지 도로명 주소 */
	private String clmRoadAddr;
	
	/** 주문 날짜 체크 (3일이내) */
	private Boolean isOrderDtmCheck;
	
	/** 업체별 주문건수 */
	private Integer compOrdCnt;
	
	/** 업체 번호 */
	private Long compNo;
	
	/** 주문 수집 문자 알림 코드 */
	private String ordCletCharAlmCd;
	
	/** 휴대폰 */
	private String mobile;
	
	/** 결제 수단 코드 */
	private String payMeansCd;
	
	/** 결제 상태 */
	private String payStatCd;
	
	/** 결제 번호 */
	private Long payNo;

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