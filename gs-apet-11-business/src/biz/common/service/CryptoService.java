package biz.common.service;

import java.util.Properties;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.util.PetraUtil;
import framework.common.util.RequestUtil;
import framework.front.util.FrontSessionUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명		: gs-apet-11-business
 * - 패키지명		: biz.common.service
 * - 파일명		: CryptoServiceImpl.java
 * - 작성일		: 2021. 03. 21.
 * - 작성자		: sorce
 * - 설명			: mybatis에서 사용할 암호화 복호화 서비스
 * </pre>
 */
@Slf4j
@Service
public class CryptoService {
	
	@Autowired private PetraUtil PetraUtil;
	
	@Autowired private Properties webConfig;
	
	/* (non-Javadoc)
	 * @see biz.common.service.BizService#twoWayDecrypt(java.lang.String)
	 */
	public String twoWayDecrypt(String strTarget) {
		
		String userId = getPetraUserId();
		String clientIp = null;
		if (!StringUtils.equals(CommonConstants.PROJECT_GB_BATCH, webConfig.getProperty("project.gb"))) {
			clientIp = RequestUtil.getClientIp();
		}
		return PetraUtil.twoWayDecrypt(strTarget, userId, clientIp);
	}

	/* (non-Javadoc)
	 * @see biz.common.service.BizService#twoWayDecrypt(java.lang.String, java.lang.Object)
	 */
	public String twoWayDecrypt(String strTarget, Object userId) {
		String clientIp = null;
		if (!StringUtils.equals(CommonConstants.PROJECT_GB_BATCH, webConfig.getProperty("project.gb"))) {
			clientIp = RequestUtil.getClientIp();
		}
		log.debug("userId================"+userId);
		return PetraUtil.twoWayDecrypt(strTarget, String.valueOf(userId), clientIp);
	}

	/* (non-Javadoc)
	 * @see biz.common.service.CryptoService#twoWayEncrypt(java.lang.String)
	 */
	public String twoWayEncrypt(String strTarget) {
		String userId = getPetraUserId();
		String clientIp = null;
		if (!StringUtils.equals(CommonConstants.PROJECT_GB_BATCH, webConfig.getProperty("project.gb"))) {
			clientIp = RequestUtil.getClientIp();
		}
		return PetraUtil.twoWayEncrypt(strTarget, userId, clientIp);
	}

	/* (non-Javadoc)
	 * @see biz.common.service.CryptoService#twoWayEncrypt(java.lang.String, java.lang.Object)
	 */
	public String twoWayEncrypt(String strTarget, Object userId) {
		String clientIp = null;
		if (!StringUtils.equals(CommonConstants.PROJECT_GB_BATCH, webConfig.getProperty("project.gb"))) {
			clientIp = RequestUtil.getClientIp();
		}
		return PetraUtil.twoWayEncrypt(strTarget, String.valueOf(userId), clientIp);
	}

	public String oneWayEncrypt(String strTarget) {
		String userId = getPetraUserId();
		String clientIp = null;
		if (!StringUtils.equals(CommonConstants.PROJECT_GB_BATCH, webConfig.getProperty("project.gb"))) {
			clientIp = RequestUtil.getClientIp();
		}
		return PetraUtil.oneWayEncrypt(strTarget, userId, clientIp);
	}
	
	public String oneWayEncrypt(String strTarget, Object userId) {
		String clientIp = null;
		if (!StringUtils.equals(CommonConstants.PROJECT_GB_BATCH, webConfig.getProperty("project.gb"))) {
			clientIp = RequestUtil.getClientIp();
		}
		return PetraUtil.oneWayEncrypt(strTarget, String.valueOf(userId), clientIp);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: getPetraUserId
	 * - 작성일		: 2021. 03. 21.
	 * - 작성자		: sorce
	 * - 설명			: 세션에서 사용자아이디 추출
	 * </pre>
	 * @return
	 */
	public String getPetraUserId() {
		String userId = null;
		if(StringUtils.equals(CommonConstants.PROJECT_GB_ADMIN, webConfig.getProperty("project.gb"))) {
			Session session = AdminSessionUtil.getSession();
			if (session == null) {
				userId = "NonLoginUser";
			} else {
				userId = String.valueOf(session.getUsrNo());
			}
		} else if (StringUtils.equals(CommonConstants.PROJECT_GB_BATCH, webConfig.getProperty("project.gb"))){
			userId = String.valueOf(CommonConstants.COMMON_BATCH_USR_NO);
		}else {
			userId = String.valueOf(FrontSessionUtil.getSession().getMbrNo());
		}
		return userId;
	}
}