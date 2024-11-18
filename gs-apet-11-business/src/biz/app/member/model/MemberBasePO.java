package biz.app.member.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberBasePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;

	/** 사이트 아이디 */
	private Long stId;

	/** 사이트 명 */
	private String stNm;

	/** 회원 명 */
	private String mbrNm;

	/** 회원 닉네임*/
	private String nickNm;

	/** 펫로그 URL */
	private String petLogUrl;

	/** 회원 구분 코드 */
	private String mbrGbCd;
	
	/** 회원 등급 코드 */
	private String mbrGrdCd;

	/** 생일 */
	private String birth;

	/** 성별 구분 코드 */
	private String gdGbCd;

	/** 국적 구분 코드 */
	private String ntnGbCd;

	/** 가입 경로 코드 */
	private String joinPathCd;

	/** 가입 환경 코드 */
	private String joinEnvCd;

	/** 인증여부 */
	private String ctfYn;

	/** 인증 방법 코드 */
	private String ctfMtdCd;

	/** 인증 코드 */
	private String ctfCd;

	/** 인증 요청 번호 */
	private String ctfReqNo;

	/** CI 인증값 */
	private String ciCtfVal;

	/** DI 인증값 */
	private String diCtfVal;

	/** 회원 상태 코드 */
	private String mbrStatCd;

	/** 로그인 아이디 */
	private String loginId;

	/** 전화 */
	private String tel;

	/** 휴대폰 */
	private String mobile;

	/** 기존 핸드폰 번호 */
	private String orgMobile;
	
	/** 휴대폰번호 배열 */
	private String[] mobileArr;

	/** 통신사코드 */
	private String mobileCd;

	/** 이메일 */
	private String email;

	/** 추천인 아이디 */
	private String rcomLoginId;

	/** 가입 시, 입력한 추천인 코드*/
	private String frdRcomKey;
	
	/** 추천인 코드 - 추천인url로 들어온 경우 */
	private String rcomCode;

	/** 추천인 코드 - 추천인url로 들어온 경우 */
	private String myRcomKey;

	/** 적립금 잔여 금액 */
	private Long svmnRmnAmt;

	/** 비밀번호 */
	private String pswd;

	/* 새 비밀번호 */
	private String newPswd;

	/** 비밀번호 초기화 여부 */
	private String pswdInitYn;

	/** 은행 코드 */
	private String bankCd;

	/** 계좌 번호 */
	private String acctNo;

	/** 계좌 인증 여부 */
	private String acctCtfYn;
	/** 이력 시작 일시 */
	private Timestamp histStrtDtm;
	/** 수정자 IP */
	private String updrIp;

	/** 로그인 실패 수 */
	private Long loginFailCnt;


	/** 예치금 잔여 금액 */
	private Long blcRmnAmt;


	/** 최종로그인 일시 */
	private Timestamp lastLoginDtm;
	
	/** 비밀번호 변경 일시 */
	private Timestamp pswdChgDtm;

	/** 가입 일시 */
	private Timestamp joinDtm;

	/** 회원 탈퇴 사유 코드 */
	private String mbrLevRsnCd;

	/** 회원 탈퇴 내용 */
	private String mbrLevContent;

	/** 회원 번호 */
	private Long[] arrMbrNo;
	
	/** 개인정보 처리방침 번호 */
	private String policyNo;

	/** 이용약관 번호 */
	private String termsNo;
	
	/** sns로그인여부 */
	private String snsYn;
	
	/** 회원가입시 쓸 성별*/
	private String gender;
	
	/** 프로필 이미지*/
	private String prflImg;

	/** 프로필 이미지(변경 전)*/
	private String orgPrflImg;

	/** GS 연계 번호*/
	private String gsptNo;

	/** GS포인트 사용여부*/
	private String gsptUseYn;

	/** GS포인트 상태코드*/
	private String gsptStateCd;

	/** GS포인트 시작일자*/
	private Timestamp gsptStartDtm;

	/** GS포인트 종료일자*/
	private Timestamp gsptStopDtm;

	/** 디바이스 토큰*/
	private String deviceToken;

	/** 정보성 수신 여부 */
	private String infoRcvYn;

	/** 마케팅 수신 여부 */
	private String mkngRcvYn;

	/** 강성 회원 여부 */
	private String dffcMbrYn;
	/** 펫스쿨 여부*/
	private String petSchlYn;
	/** 펫로그소개 */
	private String petLogItrdc;
	/** 추천url*/
	private String rcomUrl;
	
	/** 회원 반려동물 코드 */
	private String dlgtPetGbCd;
	
	/** 로그인 경로 코드*/
	private String loginPathCd;
	
	/** 디바이스 타입 코드*/
	private String deviceTpCd;

	/** 펫로그  short URL */
	private String petLogSrtUrl;

	/** 프로필 파일 이름*/
	private String prflNm;
    
    /** 위치정보 동의 여부*/
    private String pstInfoAgrYn;	
    
    /** 알림 수신 여부 */
    private String almRcvYn;

    /** 변경 주체 코드*/
    private String chgActrCd;

    private Integer resultCnt;

    /** 기기 구분 코드 */
    private String deviceGb;
    
    /** petlogurl 삭제 플래그 */
    private String petLogUrlDeleteYn;
    
    /** 구매 횟수 증가 */
    private String buyCntAdd;
    /** 구매 횟수 */
    private int buyCnt;
    
    
    /** 설정 약관에서 사용 */
    private String termsCd;
    
    private String agreeYn;
    
    private Long chgHistNo;

    /** 빌링정보 삭제 여부 */
    private String removeBillYn;

	/** 초대 코드*/
	private String rcomCd;

	/** 회원 정보 변경 일시 */
	private Timestamp modDtm;
	
	/** 비밀번호 변경 예정 일시 */
	private Timestamp pswdChgScdDtm;

	/** 간편 비밀 번호 */
	private String simpScrNo;
	
	/** 빌링 입력 실패 횟수 */
	private Double billInputFailCnt;
	
	/** 회원 탈퇴 일시 */
	private Timestamp mbrLevDtm;
	
	/** 재 가입 가능 일자 */
	private String reJoinPsbDt;
	
    /** 휴면 적용 일시 */
	private Timestamp dormantAplDtm;
	
	/** 휴면 해제 일시 */
	private Timestamp dormantRlsDtm;

	/** 휴면 해제 여부  */
	private String dormantRlsYn = "N";

	/** 회원 사용 정지 일시 */
	private Timestamp mbrStopDtm;
	
	private String snsLnkCd ;
	
	private String mktRcvYn ;
	
	/** 마케팅 수신여부 변경일 */
	private Timestamp mkngRcvUpdDtm;
	
	/** 알림 수신여부 변경일 */
	private Timestamp almRcvUpdDtm;
}