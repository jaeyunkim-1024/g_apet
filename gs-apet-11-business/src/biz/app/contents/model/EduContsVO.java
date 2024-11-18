package biz.app.contents.model;

import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EduContsVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** rownum */
	private Long rowIndex;

	/** 영상 ID */
	private String vdId;
	
	/** 제목 */
	private String ttl;
	
	/** 내용 */
	private String content;
	
	/** 썸네일 자동 여부 */
	private String thumAutoYn;
	
	/** 스텝 */
	private Long step;
	
	/** 카테고리 */
	private String category;
	
	/** 난이도 */
	private String lodCd;
	
	/** 준비물 */
	private String prpmCd;
	
	/** 공유 수 */
	private Long shareCnt;
	
	/** 조회수 */
	private Long hits;
	
	/** 좋아요 수 */
	private Long likeCnt;
	
	/** 댓글 수 */
	private Long replyCnt;
	
	/** 전시 여부 */
	private String dispYn;
	
	/** 펫 구분 코드 */
	private String petGbCd;
	
	/** 교육용 컨텐츠 카테고리_L_코드 */
	private String eudContsCtgLCd;
	
	/** 교육용 컨텐츠 카테고리_M_코드 */
	private String eudContsCtgMCd;
	
	/** 교육용 컨텐츠 카테고리_S_코드 */
	private String eudContsCtgSCd;
	
	/** 펫 구분 코드 */
	private Long flNo;
	
	/** 코드 */
	private String code;
	
	/** 첨부파일 */
	private List<ApetAttachFileVO> fileList;
	
	/** 태그 */
	private List<ApetContentsTagMapVO> tagList;
	
	/** 상품 */
	private List<ApetContentsGoodsMapVO> goodsList;
	
	/** 상세 */
	private List<ApetContentsDetailVO> detailList;
	
	/** 컨텐츠 구성 */
	private List<ApetContentsConstructVO> cnstrList;
	
	/** 대표 썸네일 */
	private String thumPath;
	
	/** 이력 저장 번호 */
	private Long histNo;
	
	/** 영상 구분 코드 */
	private String vdGbCd;
	
	private String tpCd;
	private Long srisNo;
	private Long sesnNo;
	private String crit;
	private String vdTpCd;
	
	/** 단축URL */
	private String srtUrl;
}