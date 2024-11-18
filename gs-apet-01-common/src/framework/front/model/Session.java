package framework.front.model;

import framework.common.constants.CommonConstants;
import lombok.Data;

/**
 * Front Session
 * 
 * @author valueFactory
 * @since 2016. 05. 04.
 */
@Data
public class Session {

	private String	sessionId;
	private Long	mbrNo;
	private String	mbrNm;
	private String	loginId;
	private String	sessionIp;
	private String	certifyYn;		// 인증여부
	private String	reqUri;			// 현재 Uri
	private String	noMemOrdNo;		// 비회원 주문번호
	private String	noMemCheckCd;	// 비회원 주문의 체크코드
	private String keepYn;			// 로그인 유지 여부
	private String petGbCd ; 		//펫 구분 코드
	private String gsptNo ;			//gs포인트 번호
	private String mbrGbCd;			//회원 구분코드
	private String mbrGrdCd;		//회원 등급코드
	private String nickNm;			//닉네임
	private String accurateRate;  	//적립율
	private String accurateValidity; //적립 유효기간
	private String loginPathCd ; 	//로그인 경로
	private Integer bizNo ; 		//회사번호 - 이걸로 펫로그파트너 회원 여부 구분
	private String petNos; 	//펫 리스트
	private String petLogUrl; 		//펫로그 url - 펫로그 회원인 경우
	private String tagYn;  		//관심태그 설정 여부
	private String infoRcvYn;	/** 정보성 수신 여부 */
	private String almRcvYn;	/** 알림 수신 여부 */
	private String prflImg;		/** 프로필 이미지*/
	private Long dispClsfNo;	/** 전시분류번호*/
	private String expire = "";		/** 세션 만료 시간 */
	private String env; //환경값
	private String pstInfoAgrYn;	/** 위치 정보 동의 여부 */
	private Long migMemno;

	private OrderParam order = new OrderParam();
	
	/**
	 * 주문관련 세션
	 */
	@Data
	public class OrderParam {
		private String		orderType;
		private String[]	cartIds;
		private String[] cartGoodsCpInfos;
		private String cartYn;
	}
	
	/**
	 * 로그인 확인 FUNCTION
	 */
	public boolean isLogin() {
		return !CommonConstants.NO_MEMBER_NO.equals(this.mbrNo);
	}
	
	
}