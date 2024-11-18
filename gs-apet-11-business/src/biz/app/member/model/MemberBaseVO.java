package biz.app.member.model;

import framework.common.constants.CommonConstants;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberBaseVO extends BaseSysVO  implements Cloneable{
	
	@Override
	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;

	/** 회원 명 */
	private String mbrNm;

	/** 초대 url*/
	private String rcomUrl;

	/** 초대 코드*/
	private String rcomCd;

	/** 펫 로그 URL*/
	private String petLogUrl;

	/*닉네임*/
	private String nickNm;

	/** 회원 상태 코드 */
	private String mbrStatCd;

	/** 회원 상태 코드 */
	private String mbrStatNm;

	/** 로그인 아이디 */
	private String loginId;

	/** 추천 회원 로그인 아이디 */
	private String rcomLoginId;

	/** GS 아이디*/
	private String gsLoginId;

	/** 추천 회원 이름 */
	private String rcomMbrNm;

	/** 비밀번호 */
	private String pswd;

	/** 전화 */
	private String tel;

	/** 휴대폰 */
	private String mobile;

	/** 이메일 */
	private String email;

	/** 비밀번호 초기화 여부 */
	private String pswdInitYn;

	/** 로그인 실패 수 */
	private Long loginFailCnt;

	/** 생일 */
	private String birth;

	/** 인증 여부*/
	private String ctfYn;

	/** 인증 방법 코드 */
	private String ctfMtdCd;

	/** 인증 코드 */
	private String ctfCd;

	/** 이메일 수신 여부 */
	private String emailRcvYn;
	/** 이메일 수신 동의/거부 일시 */
	private Timestamp emailRcvDt;

	/** SMS 수신 여부 */
	private String smsRcvYn;
	/** SMS 수신 동의/거부 일시 */
	private Timestamp smsRcvDt;

	/** 적립금 잔여 금액 */
	private Long svmnRmnAmt;

	/** 예치금 잔여 금액 */
	private Long blcRmnAmt;

	/** 성별 구분 코드 */
	private String gdGbCd;

	/** 성별 구분 코드 */
	private String gdGbNm;

	/** 국적 구분 코드 */
	private String ntnGbCd;

	/** 국적 구분 코드 */
	private String ntnGbNm;

	/** 인증 요청 번호 */
	private String ctfReqNo;

	/** 가입 경로 코드 */
	private String joinPathCd;

	/** 회원 등급 코드 */
	private String mbrGrdCd;

	/** 회원 구분 코드 */
	private String mbrGbCd;

	/** 회원 구분 코드 */
	private String mbrGbNm;

	/** 회원 등급 명 */
	private String mbrGrdNm;

	/** 비밀번호 변경 일시 */
	private Timestamp pswdChgDtm;

	/*통신사 코드 */
	private String mobileCd;

	/*통신사 코드 */
	private String mobileNm;

	/** 가입 일시 */
	private Timestamp joinDtm;

	/** 은행 코드 */
	private String bankCd;

	/** 계좌 번호 */
	private String acctNo;

	/** 계좌 인증 여부 */
	private String acctCtfYn;

	/** 이메일 아이디 */
	private String	emailId;

	/** 이메일 주소 */
	private String	emailAddr;

	/** 쿠폰 수 */
	private Integer cpCnt;

	/** 최종 로그인 */
	private Timestamp lastLoginDtm;

	/** 구주소 우편번호*/
	private String postNoNew;

	/**신주소 우편 번호*/
	private String postNoOld;

	/** 기본 배송지 - 도로명주소 */
	private String roadAddr;

	/** 기본 배송지 - 도로명 상세 주소 */
	private String roadDtlAddr;

	/** 기본 배송지 - 도로명주소 */
	private String mbrDftDlvrRoadAddress;

	/** 기본 배송지 - 도로명주소 */
	private String prclAddr;

	/** 기본 배송지 - 도로명 상세 주소 */
	private String prclDtlAddr;

	/** 기본 배송지 - 구 지번주소 */
	private String mbrDftDlvrPrclAddress;

	//-- BATCH 추가
	/** 적립금 유효 일시 */
	private Timestamp vldDtm;

	/** 잔여 금액 */
	private Long rmnAmt;

	/** 사이트 아이디 */
	private Long stId;

	/** 사이트 명 */
	private String stNm;

	/** 카트에 담긴 상품수 */
	private Long cartGoodsCnt;
	
	/** 펫 스쿨 여부*/
	private String petSchlYn;


	/** 이력 시작 일시 */
	private Timestamp histStrtDtm;
	/** 수정자 IP */
	private String updrIp;
	/* 이력 번호=rownum */
	private String histNo;
	
	/** 회원 탈퇴 사유 코드 */
	private String mbrLevRsnCd;
	/** 회원 탈퇴 내용 */
	private String mbrLevContent;
	/** 회원 탈퇴 일시 */
	private Timestamp mbrLevDtm;
	/** 재 가입 가능 일자 */
	private String reJoinPsbDt; 
	/** 휴면 적용 일시 */
	private Timestamp dormantAplDtm;

	/** 마스킹 해제*/
	private String maskingUnlock = CommonConstants.COMM_YN_N;

	/** 반려 동물 간략 정보*/
	private String petSimpleInfo;

	/** 반려 동물 수*/
	private Integer petBaseCnt;

	/** 관심 태그*/
	private String tags;

	/** GS 포인트 연계 번호(=gs 고객 번호)*/
	private String gsptNo;

	/** GS 포인트 연계 여부 */
	private String gsptUseYn;

	/** GS 포인트 연계 상태 코드 */
	private String gsptStateCd;

	/** GS포인트 연계 시작 일시*/
	private Timestamp gsptStartDtm;

	/** GS 포인트 연계 종료 일시*/
	private Timestamp gsptEndDtm;

	/** 알림 수신 여부*/
	private String almRcvYn;
	
	/** 혜택 정보 수신 여부*/
	private String bnfInfoRcvYn;

	/** 혜택 정보 수신 동의/거부 일시 */
	private Timestamp bnfInfoRcvDtm;

	/** 푸시 수신 여부*/
	private String pushRcvYn;

	/** 푸시 수신 동의/거부 일시*/
	private Timestamp pushRcvDtm;

	private Long rowIndex;
	
	/** 최근 결제 완료일시 - 회원목록 팝업에서 쓸 것*/
	private Timestamp payCpltDtm ;
	
	/** sns로그인 채널id*/
	private String joinPath;

	/** CI 인증값*/
	private String ciCtfVal;

	/** DI 인증값*/
	private String diCtfVal;
	
	/** 디바이스 토큰*/
	private String deviceToken;
	
	/** 디바이스 타입 코드*/
	private String deviceTpCd;

	/** 정보성 수신 여부*/
	private String infoRcvYn;

	/** 마케팅 수신 여부*/
	private String mkngRcvYn;
	
	/** 로그인 경로 코드*/
	private String loginPathCd;

	/****************************
	 * 회원 목록 조회 - 주문 정보
	 ****************************/
	/*해당 회원 총 주문 금액*/
	private Long ordAmt;
	/*해당 회원 총 주문 건수*/
	private Long ordCnt;
	/*해당 회원 주문 접수 일자*/
	private Timestamp ordAcptDtm;
	
	/** 대표 펫 구분코드*/
	private String petGbCd;

	/****************************
	 * 이벤트 참여/당첨 조회
	 ****************************/
	 /** 참여 번호*/
	private Long joinNo;

	/** 당첨 번호 */
	private Long winNo;

	/** 보상명*/
	private String rewardNm;


	/****************************
	 * GSR 응답 값
	 ****************************/
	/** 응답 코드*/
	private String resultCode;

	/** 응답 메세지*/
	private String resultMessage;
	
	/** 회원 반려동물 코드 */
	private String dlgtPetGbCd;

	/** 프로필 이미지*/
	private String prflImg;
	
	/** 펫 등록 여부 */
	private String petRegYn;

	/** 강성 고객 여부*/
	private String dffcMbrYn;

	/** 카드 개수*/
	private Integer cardCnt;

	/** GSR  포인트*/
	private String point;
	
	
	/** 펫로그 회원 여부를 결정하는 회원회사번호*/
	private Integer bizNo;
	
	/** 회원 반려동물 목록 스트링*/
	private String petNos;
	
	/** sns회원 상태*/
	private String snsStatCd;
	/** sns 식별자*/
	private String snsUuid;
	
	/**로그인 시 아이디 저장 여부*/
	private String keepYn;

	/** GS 분리 보관 여부(Y 면 분리보관 중, N이면 아님 ) */
	private Boolean isSeparateYn;

	/** 분리 보관 해제 메세지*/
	private String separateNotiMsg;

	/** 소셜 로그인 */
	private String snsLnkNm;
	
	/** 소셜 로그인 코드*/
	private String snsLnkCd;
	
	/** 구매횟수 */
	private int buyCnt;
	
	private String pstInfoAgrYn;

	/** 서로 관계 카운트 */
	private Long rltCnt;

	private Long rowNum;
	
	/** 마케팅 수신 이력 변경 시점 */
	private Timestamp mkngRcvYnHistDtm;

	/** 정보성 수신 정보 변경 시점 */
	private Timestamp infoRcvYnHistDtm;
	
	private String maskingAddr;

	private Long migMemno;
	
	/** 마케팅 수신여부 변경일 */
	private Timestamp mkngRcvUpdDtm;
	
	/** 알림 수신여부 변경일 */
	private Timestamp almRcvUpdDtm;

	/** CRM 회원 정상,삭제,휴면 여부 */
	private String custDelYn;
	
	/** SEO 정보 번호 */
	private Long seoInfoNo;
	
	/** 우주멤버십 등록 이력 카운트 */
	private Integer sktmpCnt;
	
}