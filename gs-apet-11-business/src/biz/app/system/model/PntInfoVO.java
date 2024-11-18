package biz.app.system.model;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import framework.common.constants.CommonConstants;
import framework.common.model.BaseSysVO;
import framework.common.util.MaskingUtil;
import framework.common.util.PetraUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PntInfoVO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	/** 포인트 번호 */
	private Long pntNo;
	
	/** 포인트 유형 코드 */
	private String pntTpCd;

	/** 적립률 */
	private Double saveRate;

	/** 추가 적립률 */
	private Double addSaveRate;
	
	/** 사용율 */
	private Double useRate;
	
	/** 연동 상품 코드 */
	private String ifGoodsCd;
	
	/** 대체 연동 상품 코드 */
	private String altIfGoodsCd;
	
	/** 포인트 프로모션 구분 코드 */
	private String pntPrmtGbCd;
	
	/** 최대 적립 포인트 */
	private Integer maxSavePnt;
	
	/** 적용 시작 일시 */
	private Timestamp aplStrtDtm;
	
	/** 적용 종료 일시 */
	private Timestamp aplEndDtm;
	
	/** 사용 여부 */
	private String useYn;
	
	/** 회원 노출용 카드 번호 */
	private String viewCardNo;
	
	/** 카드 번호 */
	private String cardNo;
	
	public String getCardNo() {
		if(StringUtil.isNotEmpty(this.cardNo)) {
			if (StringUtils.endsWith(this.cardNo, "=")) {
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
				WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
				PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
				return PetraUtil.twoWayDecrypt(this.cardNo, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
			}
		}
		return this.cardNo;
	}
	
	public String getViewCardNo() {
		if(StringUtil.isNotEmpty(this.cardNo)) {
			if (StringUtils.endsWith(this.cardNo, "=")) {
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
				WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
				PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
				return MaskingUtil.getCard(PetraUtil.twoWayDecrypt(this.cardNo, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp()));
			}
		}
		return MaskingUtil.getCard(this.cardNo);
	}
}