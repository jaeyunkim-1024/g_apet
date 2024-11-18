package biz.app.counsel.model;

import java.sql.Timestamp;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import biz.app.order.model.OrderDetailVO;
import biz.common.model.AttachFileVO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.counsel.model
* - 파일명		: CounselVO.java
* - 작성일		: 2016. 3. 24.
* - 작성자		: phy
* - 설명		:
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class CounselVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상담 번호 */
	private Long 	cusNo;

	/** 상담 경로 코드 */
	private String 	cusPathCd;

	/** 상담 상태 코드 */
	private String 	cusStatCd;

	/** 상담 유형 코드 */
	private String	cusTpCd;	 

	/** 응답 구분 코드 */
	private String	respGbCd;	 

	/** 통화자 구분 코드 */
	private String	callGbCd;	 
	
	/** 문의자 명 */
	private String 	eqrrNm;

	/** 문의자 전화 */
	private String 	eqrrTel;

	/** 문의자 휴대폰 */
	private String 	eqrrMobile;

	/** 문의자 이메일 */
	private String 	eqrrEmail;

	/** 문의자 회원 번호 */
	private Long eqrrMbrNo;

	/** 문의자 로그인 아이디 */
	private String loginId;

	/** 제목 */
	private String ttl;

	/** 내용 */
	private String content;

	/** 파일 번호 */
	private Long flNo;

	/** 상담 카테고리1 코드 */
	private String cusCtg1Cd;

	/** 상담 카테고리2 코드 */
	private String cusCtg2Cd;

	/** 상담 카테고리3 코드 */
	private String cusCtg3Cd;

	/** 상담 접수 일시 */
	private Timestamp cusAcptDtm;

	/** 상담 취소 일시 */
	private Timestamp cusCncDtm;

	/** 상담 완료 일시 */
	private Timestamp cusCpltDtm;

	/** 상담 담당자 번호 */
	private Long		cusChrgNo;	 

	/** 상담 접수자 번호 */
	private Long cusAcptrNo;

	/** 상담 취소자 번호 */
	private Long cusCncrNo;

	/** 상담 완료자 번호 */
	private Long cusCpltrNo;

	/** 상담 담당자 번호 */
	private String	cusChrgNm;	 
	
	/** 상담 접수자 번호 */
	private String cusAcptrNm;

	/** 상담 취소자 번호 */
	private String cusCncrNm;

	/** 상담 완료자 번호 */
	private String cusCpltrNm;

	/** 주문 번호 */
	private String ordNo;
	
	/** 그룹코드  상세 명 */
	private String dtlNm;
	
	/** 답변 상태 명 */
	private String statCdNm;
	
	/** 알림 수신 여부 */
	private String pstAgrYn;
	
	/** 정봅성 수신 동의 여부 */
	private String infoRcvYn;
	
	/** 주문정보 */
	private List<OrderDetailVO> ordList;
	
	/*******************
	 * 사이트 정보
	 *******************/
	/** 사이트 ID */
	private Long stId;

	/** 사이트 명 */
	private String stNm;

	/*******************
	 * 첨부파일
	 *******************/

	private List<AttachFileVO> fileList;






	//////////////////////////////////////////////////////////







	/** 처리 번호 */
	private Long prcsNo;

	/** 상담 번호 */
	private Long cusNo2;

	/** 처리 내용 */
	private String prcsContent;

	/** 상담 회신 코드 */
	private String cusRplCd;

	/** 회신 헤더 내용 */
	private String rplHdContent;

	/** 회신 내용 */
	private String rplContent;

	/** 회신 푸터 내용 */
	private String rplFtContent;

	/** 파일 번호 */
	private Integer flNo2;

	/** 상담 처리 일시 */
	private Timestamp 	cusPrcsDtm;

	/** 상담 처리자 번호 */
	private Integer cusPrcsrNo;

	/** 처리 번호 카운트 */
	private Integer prcsNoCnt;

	/** 처리 번호 일련번호 */
	private Integer prcsNoRowNum;

	/** 문의자 회원 번호 */
	private String eqrrMbrId;

	/** 첨부파일 경로 */
	private String phyPath;

	/** 첨부파일 list */
	private List<CounselFileVO> phyPathList;

	/** 이미지 경로 배열 */
	private String[] phyPaths;
	/** 이미지 번호 배열 */
	private Long[] seqs;


	/** 답변완료 건수 */
	private Integer answerCount;
	/** 답변대기 건수 */
	private Integer waitCount;

	public boolean getMemberOK() {
		return StringUtils.equals("비회원", loginId) ? false : true;
	}

	private String newYn;

	private Long rowNum;
}
