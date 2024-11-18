package biz.app.promotion.model;

import java.util.List;

import biz.app.goods.model.GoodsDispVO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.promotion.model
* - 파일명		: ExhibitionThemeVO.java
* - 작성일		: 2017. 5. 31.
* - 작성자		: hongjun
* - 설명		:
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ExhibitionThemeVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 테마 번호 */
	private Long thmNo;
	
	/** 기획전 번호 */
	private Long exhbtNo;
	
	/** 테마 명 */
	private String thmNm;
	
	/** 리스트 타입 코드 */
	private String listTpCd;
	
	/** 전시 여부 */
	private String dispYn;
	
	/** 테마 명 노출 여부 */
	private String thmNmShowYn;
	
	/** 업체 번호 */
	private Long compNo;
	
	/** 업체 명 */
	private String compNm;

	/** 전시 우선 순위 */
	private Integer dispPriorRank;
	
	/** 테마별 상품 목록 */
	List<ExhibitionThemeGoodsVO> goodsList;
	
	/** 기획전 구분 코드 */
	private String exhbtGbCd;
	
	/** 웹 모바일 구분 코드 */
	private String webMobileGbCd;
	
	/** 테마 삭제 여부 */
	private String delyn;
	
	/** 테마 상품 */
	private List<GoodsDispVO> exhibitionGoods;
	
	/** 테마 상품개수 */
	private int ehbCnt;
	
	/** 기획전 승인 상태 코드 */
	private String exhbtStatCd;
}