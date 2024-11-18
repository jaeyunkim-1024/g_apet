package biz.app.counsel.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.counsel.model
* - 파일명		: CounselPO.java
* - 작성일		: 2016. 3. 24.
* - 작성자		: phy
* - 설명		:
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class CounselPO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	/** 상담 번호 */
	private Long		cusNo;
	
	/** 알림 수신 여부 */
	private String 		pstAgrYn;
	
	/** 상담 경로 코드 */
	private String		cusPathCd;	 
	
	/** 상담 상태 코드 */
	private String		cusStatCd;	 
	
	/** 상담 유형 코드 */
	private String		cusTpCd;	 

	/** 응답 구분 코드 */
	private String	respGbCd;	 

	/** 통화자 구분 코드 */
	private String	callGbCd;	 

	/** 문의자 명 */
	private String		eqrrNm;		 
	
	/** 문의자 전화 */
	private String		eqrrTel;	 

	/** 문의자 휴대폰 */
	private String		eqrrMobile;	 

	/** 문의자 이메일 */
	private String		eqrrEmail;	 

	/** 제목 */
	private String		ttl;		 

	/** 내용 */
	private String		content;	 

	/** 파일 번호 */
	private Long 	flNo;		 

	/** 문의자 회원 번호 */
	private Long		eqrrMbrNo;	 

	/** 상담 카테고리1 코드 */
	private String		cusCtg1Cd;	 

	/**  상담 카테고리2 코드 */
	private String		cusCtg2Cd;	

	/** 상담 카테고리3 코드 */
	private String		cusCtg3Cd;	 

	/** 상담 접수 일시 */
	private Timestamp	cusAcptDtm;	 

	/** 상담 취소 일시 */
	private Timestamp	cusCncDtm;	 

	/** 상담 완료 일시 */
	private Timestamp	cusCpltDtm;	 

	/** 상담 접수자 번호 */
	private Long		cusAcptrNo;	 

	/** 상담 취소자 번호 */
	private Long		cusCncrNo;	 

	/** 상담 완료자 번호 */
	private Long		cusCpltrNo;	 

	/** 상담 담당자 번호 */
	private Long		cusChrgNo;	 
	
	/** 파일명 */
	private String[] orgFlNms;
	
	/** 파일경로 */
	private String[] phyPaths;
	
	/** 파일사이즈 */
	private Long[] flSzs;
	
	/** 사이트 아이디 */
	private Long stId;
	
	/** 주문 번호 */
	private String		ordNo;		 

	/** 주문 상세 순번 목록 */
	private Integer[] 	ordDtlSeqs;	 
	
	private Long[] 	delLen;	 
	
}
