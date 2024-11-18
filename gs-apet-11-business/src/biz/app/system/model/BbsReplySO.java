package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class BbsReplySO extends BaseSearchVO<BbsReplySO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 글 번호 */
	private Long lettNo;

	/** 게시판 아이디 */
	private String bbsId;

	/** 게시판 구분 코드 */
	private Long bbsGbNo;

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
	
	/** story 검색조건 */
	private String searchType;
	
	/** story 검색어 */
	private String searchWord;
	

}