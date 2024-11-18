package biz.app.contents.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class ApetContentsPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 영상 ID */
	private String vdId;

	/** 영상 구분 코드 */
	private String vdGbCd;

	/** 타입 코드 */
	private String tpCd;
	
	/** 썸네일 자동 여부 */
	private String thumAutoYn;

	/** 시리즈 번호 */
	private Long srisNo;

	/** 시즌 번호 */
	private Long sesnNo;

	/** 파일 번호 */
	private Long flNo;
	
	/** 전시 여부 */
	private String dispYn;

	/** 제목 */
	private String ttl;

	/** 내용 */
	private String content;
	
	/** 음악 저작권 */
	private String crit;

	/** 영상 타입 코드 */
	private String vdTpCd;

	/** 조회수 */
	private Long hits;
	
	/** 펫 구분 코드 */
	private String petGbCd;
		
	/** 교육용 컨텐츠 카테고리 L 코드 */
	private String eudContsCtgLCd;	
	
	/** 교육용 컨텐츠 카테고리 M 코드 */
	private String eudContsCtgMCd;
	
	/** 교육용 컨텐츠 카테고리 S 코드 */
	private String eudContsCtgSCd;
	
	/** 난이도 코드 */
	private String lodCd;

	/** 준비물 코드 */
	private String prpmCd;
}