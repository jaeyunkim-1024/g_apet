package biz.app.counsel.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CounselSO extends BaseSearchVO<CounselSO> {

	private static final long serialVersionUID = 1L;


	/** 상담 경로 코드 */
	private String	cusPathCd;

	/** 상담 상태 코드 */
	private String	cusStatCd;

	/** 기간별 검색 */
	private Long period;

	/** 상담 접수 일시 : Start */
	private Timestamp cusAcptDtmStart;

	/** 상담 접수 일시 : End */
	private Timestamp cusAcptDtmEnd;

	/**  주문 번호 */
	private String	ordNo;

	/** 문의자 명 */
	private String eqrrNm;

	/** 문의자 로그인 아이디 */
	private String loginId;

	/** 문의자 전화 */
	private String eqrrTel;

	/** 문의자 휴대폰 */
	private String eqrrMobile;

	/** 상담 상태 코드 : Array */
	private String[] arrCusStatCd;

	/** 상담 유형 코드 : Array */
	private String[] arrCusTpCd;
	
	/** 상담 카테고리1 코드 */
	private String cusCtg1Cd;

	/** 상담 카테고리2 코드 */
	private String cusCtg2Cd;

	/** 상담 카테고리3 코드 */
	private String cusCtg3Cd;
	
	/** 내용*/
	private String content;
	
	/** 파일 넘버*/
	private Long flNo;

	/** 사이트 ID */
	private Long 	stId;

	/** 회원구분 */
	private String memberYn;

	/** 상담 번호 */
	private Long cusNo;

	/** 회원 번호 */
	private Long mbrNo;

	/** 상담 당당자 번호 */
	private Long cusChrgNo;

	/** 상담 담당자 이름 */
	private String cusChrgNm;
	
	/** 상담 처리자 번호 */
	private String cusPrcsrNo;
	
	/** 상담 처리자 이름 */
	private String cusPrcsrNm;
	
	/** 상담 완료자 이름 */
	private String cusCpltrNm;

	/** 이메일 */
	private String eqrrEmail;

}
