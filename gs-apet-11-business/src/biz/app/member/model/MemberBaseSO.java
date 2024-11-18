package biz.app.member.model;

import biz.app.pet.model.PetBaseVO;
import framework.common.constants.CommonConstants;
import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberBaseSO extends BaseSearchVO<MemberBaseSO> {

	/** UID */
	private static final long serialVersionUID = 1L;


	/** 사이트 아이디 */
	private Long stId;

	/** 인증 코드 */
	private String ctfCd;

	/** 로그인 아이디 */
	private String loginId;

	/** 추천 회원 로그인 아이디 */
	private String rcomLoginId;
	
	/** 추천 코드*/
	private String rcomUrl;

	private String rcomCd;

	/** 회원 번호 */
	private Long mbrNo;

	/** 회원번호 여러개 입력 파라미터 */
	private String mbrNoArea;

	/** 회원번호 여러개 구분*/
	private String[] mbrNos;


	/** 회원 명 */
	private String mbrNm;

	/** 회원 상태 코드 */
	private String mbrStatCd;


	/** 비밀번호 */
	private String pswd;

	/** 전화 */
	private String tel;

	/** 휴대폰 */
	private String mobile;

	/** 휴대폰 array */
	private String[] mobileNos;

	/** 이메일 */
	private String email;

	/** 비밀번호 초기화 여부 */
	private String pswdInitYn;

	/** 로그인 실패 수 */
	private Long loginFailCnt;

	/** 생일 */
	private String birth;

	/** 인증 방법 코드 */
	private String ctfMtdCd;

	/** 인증 여부 */
	private String ctfYn;


	/** 이메일 수신 여부 */
	private String emailRcvYn;

	/** SMS 수신 여부 */
	private String smsRcvYn;

	/** 적립금 잔여 금액 */
	private Long svmnRmnAmt;

	/** 예치금 잔여 금액 */
	private Long blcRmnAmt;

	/** 성별 구분 코드 */
	private String gdGbCd;

	/** 국적 구분 코드 */
	private String ntnGbCd;

	/** 인증 요청 번호 */
	private String ctfReqNo;

	/** 가입 경로 코드 */
	private String joinPathCd;

	/** 가입 환경 코드 */
	private String joinEnvCd;

	/** 가입 환경2 */
	private String[] joinEnvCds;

	/** 회원 등급 코드 */
	private String mbrGrdCd;

	/** 비밀번호 변경 일시 */
	private Timestamp pswdChgDtm;

	/** 가입 일시 */
	private Timestamp joinDtm;

	private Long startSvmnRmnAmt;

	private Long endSvmnRmnAmt;

	private Long startPayAmt;

	private Long endPayAmt;

	private Long startAge;

	private Long endAge;

	private String maskingUnlock = CommonConstants.COMM_YN_N;

	private List<PetBaseVO> petList;

	private String recommandGbCd;
	
	/** 회원 구분 코드*/
	private String mbrGbCd;
	
	/** 검색 시작 날짜*/
	private String searchDtmStart;
	
	/** 검색 종료 날짜*/
	private String searchDtmEnd;
	
	/** 회원 반려동물 등록 - 회원목록 팝업에서 쓸 것 */
	private String petRegYn;
	
	/** 검색유형 */
	private String searchType;

	/** 검색어 */
	private String searchWord;
	
	/** 인증코드*/
	private String ciCtfVal;
	
	/** sns로긴 시 식별자*/ 
	private String snsUuid;
	
	private String gender;
	
	/** 회원 닉네임*/
	private String nickNm;
	
	/** 펫 스쿨 여부*/
	private String petSchlYn;

	 /** GS 연계 번호*/
	private String gsptNo;

	/*SNS 연동 코드 */
	private String snsLnkCd;

	/*반려동물 구분 코드*/
	private String petGbCd;

	/*펫 로그 등록 여부*/
	private String petLogRegsiterYn;

	/*주문 접수 시작 일시*/
	private Timestamp ordAcptStrtDtm;
	/*주문 접수 종료 일시*/
	private Timestamp ordAcptEndDtm;

	/*생일 시작 일시*/
	private String birthStrtDtm;
	/*생일 종료 일시*/
	private String birthEndDtm;

	/*가입 시작 일시*/
	private Timestamp joinStrtDtm;
	/*가입 종료 일시*/
	private Timestamp joinEndDtm;

	/*최종 그인 기준 날짜*/
	private Timestamp lastLoginDtm;

	/*휴면 해제 시작 일시*/
	private Timestamp dorantRlsStrtDtm ;
	/*휴면 해제 종료 일시*/
	private Timestamp dorantRlsEndDtm;

	/*최종 로그인 시작 일시*/
	private Timestamp lastLoginStrtDtm ;
	/*최종 로그인 종료 일시*/
	private Timestamp lastLoginEndDtm;

	/*정회원 전환 시작 일시*/
	private Timestamp gsptStartStrtDtm  ;
	/*정회원 전환 종료 일시*/
	private Timestamp gsptStartEndDtm ;

	/*방문 시작 일시*/
	private Timestamp visitStrtDtm;
	/*방문 종료 일시*/
	private Timestamp visitEndDtm;

	/*방문 횟수 시작 값*/
	private Integer visitStrtCnt;
	/*방문 횟수 종료 값*/
	private Integer visitEndCnt;

	/** 주문 건수 검색 시작 일자 */
	private Timestamp ordCntAcptStrtDtm;
	/** 주문 건수 검색 종료 일자 */
	private Timestamp ordCntAcptEndDtm;

	/*주문 건수 검색 시작 값*/
	private Integer ordCntStrtVal;
	/*주문 건수 검색 종료 깂*/
	private Integer ordCntEndVal;
	
	/** 주문 금액 검색 시작 일자 */
	private Timestamp ordAmtAcptStrtDtm;
	/** 주문 금액 검색 종료 일자 */
	private Timestamp ordAmtAcptEndDtm;
	
	/*주문 금액 검색 시작 값*/
	private Integer ordAmtStrtVal;
	/*주문 금액 검색 종료 값*/
	private Integer ordAmtEndVal;

	/** DI 인증값*/
	private String diCtfVal;

	/**이벤트 번호*/
	private Long eventNo;
	
	/** 회원 반려동물 코드 */
	private String dlgtPetGbCd;

	/** 내가 팔로잉 한 사람*/
	private Long mbrNoFollowed;

	/** 펫 로그 등록 시작 일자 */
	private Timestamp petLogSysRegStrtDtm;

	/** 펫 로그 등록 종료 일자 */
	private Timestamp petLogSysRegEndDtm;

	/** 펫 로그 연관 태그 이름 */
	private String petLogTagNm;

	/** 마케팅 수신 여부 */
	private String mkngRcvYn;

	/** 회원 목록 - 관심 태그 검색(구분자 ,)*/
	private String tagNm;
	private String tagNms[];
	private String tagNos[];

	/** 알림 수신동의 여부 (정보성)*/
	private String infoRcvYn;


	/*************************  BO - 회원 상세 검색 조건 */

	private String isSearch;

	/** 조건 전체 select 여부 */
	private String allSearchYn;

	/** 휴면 전환 예정일 */
	private Integer dormantAplDay;

	/** 장기 미 로그인 */
	private Integer lastLoginDay;
	
	private String isNotSearch;

	/*****************************************************/
	
	/** 값이 있을 경우 엑셀다운용으로 페이징처리 안함*/
	private String isExcelDown = "N";


}