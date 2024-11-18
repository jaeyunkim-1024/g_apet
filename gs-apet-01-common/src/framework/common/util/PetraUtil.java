package framework.common.util;

import java.util.Properties;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;

/**
 * 암호화/복호화 Util 클래스
 * 
 * @author valueFactory
 */
@Component
@Slf4j
public class PetraUtil extends Thread {

	@Autowired
	private Properties bizConfig;
	
	@SuppressWarnings("static-access")
	@PostConstruct
	public void init() {
		try {
			sinsiway.PcaSessionPool.initialize(bizConfig.getProperty("petra.init.conf"), "");
		} catch (Exception e) {
			petraResultLog(e);
		}
	}

	/**
	 *
	 *
	 * @param strTarget 대상 문자열
	 * @param userId   userId
	 * @return 단방향 암호화 값
	 */
	public String oneWayEncrypt(String strTarget, String userId, String clientIp) {
		String retValue = null;

		if (strTarget == null || "".equals(strTarget)) {
			retValue = strTarget;
		} else {

			try {
				sinsiway.PcaSession session = sinsiway.PcaSessionPool.getSession(clientIp, userId, CommonConstants.PETRA_CLIENT_PROGRAM);
				retValue = session.encrypt(Integer.valueOf(CommonConstants.PETRA_ONE_WAY), strTarget);
			} catch (Exception e) {
				petraResultLog(e);
			}
		}
		return retValue;
	}

	/**
	 *
	 *
	 * @param strTarget 대상 문자열
	 * @param userId   userId
	 * @return 양방향 암호화 값
	 */
	public String twoWayEncrypt(String strTarget, String userId, String clientIp) {
		String retValue = null;

		if (strTarget == null || "".equals(strTarget)) {
			retValue = strTarget;
		} else {

			try {
				sinsiway.PcaSession session = sinsiway.PcaSessionPool.getSession(clientIp, userId, CommonConstants.PETRA_CLIENT_PROGRAM);
				retValue = session.encrypt(Integer.valueOf(CommonConstants.PETRA_TWO_WAY), strTarget);
			} catch (Exception e) {
				petraResultLog(e);
			}
		}
		return retValue;
	}

	/**
	 *
	 *
	 * @param strTarget 대상 문자열
	 * @param userId	userId
	 * @return 양방향 복호화 값
	 */
	public String twoWayDecrypt(String strTarget, String userId, String clientIp) {
		String retValue = null;

		if (strTarget == null || "".equals(strTarget)) {
			retValue = strTarget;
		} else {

			try {
				sinsiway.PcaSession session = sinsiway.PcaSessionPool.getSession(clientIp, userId, CommonConstants.PETRA_CLIENT_PROGRAM);
				retValue = session.decrypt(Integer.valueOf(CommonConstants.PETRA_TWO_WAY), strTarget);
			} catch (Exception e) {
				petraResultLog(e);
			}
		}
		return retValue;
	}

	/**
	 * Exception throw type
	 * @param strTarget
	 * @param userId
	 * @param clientIp
	 * @return
	 * @throws Exception
	 */
	public String twoWayDecryptByThrow(String strTarget, String userId, String clientIp) throws Exception {
		String retValue = null;

		if (strTarget == null || "".equals(strTarget)) {
			retValue = strTarget;
		} else {

			try {
				sinsiway.PcaSession session = sinsiway.PcaSessionPool.getSession(clientIp, userId, CommonConstants.PETRA_CLIENT_PROGRAM);
				retValue = session.decrypt(Integer.valueOf(CommonConstants.PETRA_TWO_WAY), strTarget);
			} catch (Exception e) {
				throw e;
			}
		}
		return retValue;
	}

	private static void petraResultLog(Exception e) {
		switch (e.getMessage().split("\\[-")[1].substring(0, e.getMessage().split("\\[-")[1].length() - 1)) {
			case "30101":
				log.error("지원하지 않는 key size", e);
				break;
			case "30102":
				log.error("지원하지 않는 암호 모드", e);
				break;
			case "30103":
				log.error("지원하지 않는 암호 방식", e);
				break;
			case "30105":
				log.error("암호 헤더 보다 작은 암호 데이터", e);
				break;
			case "30106":
				log.error("지원하지 않는 해쉬 길이", e);
				break;
			case "30107":
				log.error("길이가 맞지 않는 암호 데이터", e);
				break;
			case "30108":
				log.error("잘못된 Base64 encoding", e);
				break;
			case "30109":
				log.error("ARIA key 생성 실패", e);
				break;
			case "30110":
				log.error("잘못된 암호 시작 위치", e);
				break;
			case "30111":
				log.error("잘못된 암호 매개변수 값", e);
				break;
			case "30112":
				log.error("Open SSL 함수 호출 실패", e);
				break;
			case "30113":
				log.error("소프트포럼 함수 호출 실패", e);
				break;
			case "30114":
				log.error("잘못된 initial vector 종류", e);
				break;
			case "30301":
				log.error("암호 권한 없음", e);
				break;
			case "30302":
				log.error("존재하지 않는 API session ID", e);
				break;
			case "30303":
				log.error("잘못된 host name", e);
				break;
			case "30304":
				log.error("Socket 호출 실패", e);
				break;
			case "30305":
				log.error("Key Server 혹은 Agent 접속 실패", e);
				break;
			case "30306":
				log.error("Socket Write 실패", e);
				break;
			case "30307":
				log.error("Socket Read 실패", e);
				break;
			case "30308":
				log.error("Out 버퍼 공간 부족", e);
				break;
			case "30309":
				log.error("API 세션 풀 lock 실패", e);
				break;
			case "30310":
				log.error("Key Server 세션 풀 lock 실패", e);
				break;
			case "30311":
				log.error("초기화된 Key Server 세션 없음", e);
				break;
			case "30312":
				log.error("가용한 Key Server 세션 없음", e);
				break;
			case "30313":
				log.error("Key Server 세션 풀 corruption", e);
				break;
			case "30316":
				log.error("API 초기화 파일 파싱 에러", e);
				break;
			case "30317":
				log.error("API 초기화 파일 IO 에러", e);
				break;
			default:
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE_SKIPPED, e);
				break;
		}
	}
}
