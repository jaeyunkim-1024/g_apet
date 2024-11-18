package biz.app.goods.model;

import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsEstmQstCtgMapVO.java
* - 작성일	: 2021. 2. 15.
* - 작성자	: valfac
* - 설명 		: 상품 평가 항목
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
@SuppressWarnings("serial")
public class GoodsEstmQstVO extends BaseSysVO{

	private static final long serialVersionUID = 1L;

	/** 평가 문항 번호 */
	private Long estmQstNo;
	
	/** 문항 분류 */
	private String qstClsf;
	
	/** 문항 내용 */
	private String qstContent;
	
	/** 답변 유형 코드 */
	private String rplTpCd;
	
	/** 사용유무 */
	private String useYn;

	/** 항목 번호 */
	private Long estmItemNo;

	/** 항목 내용 */
	private String itemContent;
	
	/** 전시 분류 번호 */
	private Long dispClsfNo;
	
	/** 전시 카테고리 패스 */
	private String dispCtgNoPath;

	/** 평가 수 */
	private Integer estmCnt;

	/** 평가 평균 */
	private Integer estmAvg;
	/** 평가 총합 */
	private Integer estmTotal;

	/* 상품 번호 */
	private String goodsId;

	private List<GoodsEstmQstVO> estmQstVOList;
	
	/*최다 선택 평가 번호 */
	private Long maxQst;
	
	/** 평가 문항 답변 번호 */
	private Long estmRplNo;
	
	/** 상품 유형 코드 */
	private String goodsCstrtTpCd;
}
