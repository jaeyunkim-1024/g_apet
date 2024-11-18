package biz.app.tv.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.model
 * - 파일명		: TvDetailVO.java
 * - 작성일		: 2021. 01. 19. 
 * - 작성자		: LDS
 * - 설 명		: 펫TV 상세 연관상품 Value Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class TvDetailGoodsVO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 영상ID */
	private String vdId;
	
	/** 상품ID */
	private String goodsId;
	
	/** 상품명 */
	private String goodsNm;

	/** 콘텐츠 제목 */
	private String ttl;

	/** 상품상태코드 */
	private String goodsStatCd;
	
	/** 상품유형코드 */
	private String goodsTpCd;
	
	/** 상품 원 판매금액 */
	private Long orgSaleAmt;
	
	/** 상품 판매금액 */
	private Long saleAmt;
	
	/** 상품 이미지순번 */
	private Long imgSeq;
	
	/** 상품 이미지경로 */
	private String imgPath;

	/** 영상길이 */
	private int vdLnth;
	/** 좋아요 개수 */
	private int likeCnt;
	/** 영상 시청 횟수 */
	private int playCnt;

	/** 썸네일 이미지 경로 */
	private String phyPath;

}
