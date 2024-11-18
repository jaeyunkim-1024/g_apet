package biz.app.order.model;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import biz.app.claim.model.ClaimDetailVO;
import framework.common.constants.CommonConstants;
import framework.common.util.PetraUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명		: gs-apet-11-business
 * - 패키지명		: biz.app.order.model
 * - 파일명		: OrderDlvrListVO.java
 * - 작성일		: 2021. 04. 16.
 * - 작성자		: sorce
 * - 설명			: 주문/배송 리스트를 위한 객체
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDlvrStatVO {
	/** 주문배송단계 */
	private String forceDtlStat;
	
	/** 주문배송단계 */
	private String ordDtlStatCd;
	
	private String dlvrInvNo;
	
	/** 클레임단계 */
	private String clmTpCd;
	
	/** 클레임 상태 코드 */
	private String clmStatCd;
	
	/** 클레임상세 단계 */
	private String clmDtlStatCd;
	
	/** 택배 구분 코드 */
	private String dlvrPrcsTpCd;
	
	/** company 구분코드 */
	private String compGbCd;
	
	/** 배송예상 완료일 표시  */
	private String dlvrCpltDtm;

	private String dlvrCpltDtmWeek;

	private String ordDt;

	private String ordDtWeek;
	
	/** 입금은행 안내 정보 */
	private String ordBankInfo;
	
	private String ordBankNum;
	
	private String ordBankCmplDtm;
	
	/** 주문상세 */
	private List<OrderDetailVO> orderDetailListVO;
	
	/** 클레임리스트 */
	private List<OrderDetailVO> claimDetailListVO;
	
	private String cdClmNo;
	
	/** FO 리스트 교환 노출 상태를 표시위해 추가 */
	private String viewClmDtlStatCd;
	
	public String getOrdBankNum() {
		if(StringUtil.isNotEmpty(this.ordBankNum) && StringUtils.endsWith(this.ordBankNum, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordBankNum, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordBankNum;
	}
	
	public String getOrdBankInfo() {
		if(StringUtil.isNotEmpty(this.ordBankInfo) && StringUtils.indexOf(this.ordBankInfo, "=") > -1) {
			String[] ordBankInfoArr = this.ordBankInfo.split("\\|");
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			String acctNum = "";
			if(ordBankInfoArr.length > 2) {
				acctNum = PetraUtil.twoWayDecrypt(ordBankInfoArr[1], CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
				return ordBankInfoArr[0] + "|" + acctNum  + "|" + ordBankInfoArr[2];
			} else {
				if (ordBankInfoArr.length == 1) {
					acctNum = PetraUtil.twoWayDecrypt(ordBankInfoArr[0], CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
					return acctNum;
				} else {
					if (ordBankInfoArr[1].indexOf("=") > -1) {
						acctNum = PetraUtil.twoWayDecrypt(ordBankInfoArr[1], CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
						return ordBankInfoArr[0] + "|" + acctNum;
					} else {
						acctNum = PetraUtil.twoWayDecrypt(ordBankInfoArr[0], CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
						return acctNum + "|" + ordBankInfoArr[1];
					}
				}
			}
		}
		return this.ordBankInfo;
	}

}