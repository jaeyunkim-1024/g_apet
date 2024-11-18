package biz.app.system.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BbsLetterVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 글 번호 */
	private Long lettNo;

	/** 게시판 아이디 */
	private String bbsId;

	/** 게시판 구분 코드 */
	private Long bbsGbNo;
	
	/** 게시판 구분 명*/
	private String bbsGbNm;

	/** 사이트 구분 코드 */
	private String showGbCd;

	/** 제목 */
	private String ttl;

	/** 내용 */
	private String content;

	/** 조회수 */
	private Long hits;

	/** 파일 번호 */
	private Long flNo;

	/** 비밀 여부 */
	private String scrYn;

	/** 공개 여부 */
	private String openYn;

	/** 시스템 삭제 여부 */
	private String sysDelYn;

	/** 시스템 삭제자 번호 */
	private Integer sysDelrNo;

	/** 시스템 삭제 일시 */
	private Timestamp sysDelDtm;

	/** 시스템 삭제 사유 */
	private String sysDelRsn;

	/** 추천 여부 */
	private String rcomYn;

	/** 이미지 경로 */
	private String imgPath;

	/** 댓글 수 */
	private Integer bbsReplyCnt;

	/** 사용자정의1 */
	private String usrDfn1Val;
	/** 사용자정의2 */
	private String usrDfn2Val;
	/** 사용자정의3 */
	private String usrDfn3Val;
	/** 사용자정의4 */
	private String usrDfn4Val;
	/** 사용자정의5 */
	private String usrDfn5Val;
	
	/** 게시판유형코드 */
	private String bbsTpCd;
	/** 전시우선순위*/
	private String dispPriorRank;
	
	/** 글 페이징 값 - 공지사항 */
	private String faqPage;
	/** 게시 상태코드  -공지사항 */
	private String bbsStatCd;
	/** 공지 시작 일자- 공지사항*/
	private Timestamp bbsStrtDtm;
	/** 공지 종료 일자 - 공지사항*/
	private Timestamp bbsEndDtm;
	/** 알림발송여부  -공지사항*/
	private String almSndYn;
	/** 알림발송날짜 -공지사항*/
	private Timestamp almSndDtm;
	/** POC 구분 - 공지사항*/
	private String pocGbCd;
	
	/** 공지기간 문자열*/
	private String bbsDtm;
	/** 상단고정여부 - 공지사항*/
	private String topFixYn;
	/** 앱링크 - 공지사항*/
	private String appLnk;
	/** 웹링크 - 공지사항*/
	private String webLnk;
	
	private String stringRegDtm;
	private int intervalDay;
	
	private String filePath;
	
	private String fileName;
}
