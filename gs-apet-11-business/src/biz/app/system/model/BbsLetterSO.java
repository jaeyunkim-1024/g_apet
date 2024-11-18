package biz.app.system.model;

import java.util.List;
import java.util.Map;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BbsLetterSO extends BaseSearchVO<BbsLetterSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 글 번호 */
	private Long lettNo;

	/** 게시판 아이디 */
	private String bbsId;

	/** 게시판 구분 코드 */
	private String bbsGbNo;

	/** 사이트 아이디 */
	private Long stId;

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

	/** 삭제 여부 */
	private String sysDelYn;

	/** 추천 여부 */
	private String rcomYn;

	/** 검색유형 */
	private String searchType;

	/** 검색어 */
	private String searchWord;

	/** 업체 번호 */
	private Long compNo;
	
	/** 검색 시작 날짜*/
	private String searchDtmStart;
	
	/** 검색 종료 날짜*/
	private String searchDtmEnd;

	/** 게시 상태코드 - 공지사항*/
	private String bbsStatCd;
	/** 알림발송여부  -공지사항*/
	private String almSndYn;
	
	/** POC 구분 - 공지사항*/
	private String[] arrPocGb; 

	/** POC 구분 - 공지사항 -for 다중 검색 */
	private List<Map<String,Object>> listPocGb;  
	/** 날짜 검색 유형  - 공지사항*/
	private String dateType;
	
	private String sysRegrNm;
	
	/* FO/BO 구분*/
	private String siteGubun;
	
	/** 게시판 구분 명*/
	private String bbsGbNm;
	
}