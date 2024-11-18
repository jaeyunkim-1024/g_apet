package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class BbsBasePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 게시판 아이디 */
	private String bbsId;

	/** 게시판 명 */
	private String bbsNm;

	/** 게시판 유형 코드 */
	private String bbsTpCd;

	/** 업로드 확장자 */
	private String uploadExt;

	/** 첨부 파일 수 */
	private Long atchFlCnt;

	/** 구분 사용 여부 */
	private String gbUseYn;

	/** 비밀 사용 여부 */
	private String scrUseYn;

	/** 파일 사용 여부 */
	private String flUseYn;

	/** 사이트 ID */
	private Integer stId;
	
	
	/** 게시판 이미지경로 */
	private String bbsImgPath;
	
	/** 게시판 설명 */
	private String bbsDscrt;
	
	/** 업체 번호(FK) */
	private String compNo;
	
	

}