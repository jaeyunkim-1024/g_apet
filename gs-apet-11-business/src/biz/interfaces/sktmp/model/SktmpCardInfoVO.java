package biz.interfaces.sktmp.model;

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

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model
 * - 파일명		: SktmpCardInfoVO.java
 * - 작성일		: 2021. 08. 06.
 * - 작성자		: hjh
 * - 설명		: SKTMP 카드 정보 VO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class SktmpCardInfoVO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** rowIndex */
	private Integer rowIndex;
	
	/** 카드 정보 번호 */
    private Long cardInfoNo;
    
    /** 회원 번호 */
    private Long mbrNo;
    
    /** 카드 번호 */
    private String cardNo;
    
    /** PIN 번호 */
    private String pinNo;
    
    /** 사용 여부 */
    private String useYn;

    /** 기본 여부 */
    private String dfltYn;
    
    /** 정렬 순서 */
    private Integer sortSeq;
    
    /** 회원 노출용 카드 번호 */
	private String viewCardNo;
    
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
    
    public String getPinNo() {
		if(StringUtil.isNotEmpty(this.pinNo)) {
			if (StringUtils.endsWith(this.pinNo, "=")) {
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
				WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
				PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
				return PetraUtil.twoWayDecrypt(this.pinNo, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
			}
		}
		return this.pinNo;
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
