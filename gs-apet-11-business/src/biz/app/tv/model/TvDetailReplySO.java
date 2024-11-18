package biz.app.tv.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.model
 * - 파일명		: TvDetailReplySO.java
 * - 작성일		: 2021. 01. 19. 
 * - 작성자		: hjh
 * - 설 명		: 펫TV 상세 댓글 Search Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class TvDetailReplySO extends BaseSearchVO<TvDetailReplySO> {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 영상 ID */
	private String vdId;
	
	/** 펫TV 댓글 태그 명 */
	private String tagNm;
	
	/** 펫TV 댓글 순번 */
	private Long aplySeq;

}
