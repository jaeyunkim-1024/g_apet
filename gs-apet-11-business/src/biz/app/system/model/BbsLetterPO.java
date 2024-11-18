package biz.app.system.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class BbsLetterPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 글 번호 */
	private Long lettNo;

	/** 게시판 아이디 */
	private String bbsId;

	/** 게시판 구분 코드 */
	private Long bbsGbNo;

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
	private Long sysDelrNo;

	/** 시스템 삭제 일시 */
	private Timestamp sysDelDtm;

	/** 시스템 삭제 사유 */
	private String sysDelRsn;

	/** 추천 여부 */
	private String rcomYn;

	/** 이미지 경로 */
	private String imgPath;

	/** 파일 목록 */
	private String arrFileStr;
	
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
	
	/** GOODS 사용 여부 */
	private String goodsUseYn;
	
	/** 상품 아이디 */
	private String[] arrGoodsId;
	
	/**이력저장 시 쓸 구분코드*/
	private String histGb;
	
	/** 게시 상태코드 - 공지사항*/
	private String bbsStatCd;
	/** 알림발송여부  -공지사항*/
	private String almSndYn;
	/** POC 구분 - 공지사항*/
	private String[] arrPocGb; 
	/** POC 구분 - 공지사항 -for 다중 list */
	private List<Map<String,Object>> listPocGb;  
	/** 공지 시작 일자- 공지사항*/
	private Timestamp bbsStrtDtm;
	/** 공지 종료 일자 - 공지사항*/
	private Timestamp bbsEndDtm;
	/** 상단고정여부 - 공지사항*/
	private String topFixYn;
	/** 앱링크 - 공지사항*/
	private String appLnk;
	/** 웹링크 - 공지사항*/
	private String webLnk;
	/** 이력seq - 공지사항*/
	private Long bbsLettHistSeq;
	
	private String fileName;
	
	private String filePath;

}