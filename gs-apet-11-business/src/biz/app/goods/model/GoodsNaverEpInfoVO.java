package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsNaverEpInfoVO.java
* - 작성일	: 2021. 1. 18.
* - 작성자	: valfac
* - 설명 		: 상품 네이버 EP 정보 VO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class GoodsNaverEpInfoVO extends BaseSysVO {
	
	/** 상품 아이디 */
	private String goodsId;
	
	/** 전송 여부 */
	private String sndYn;
	
    /** 상품 출처 코드 */
	private String goodsSrcCd;
	
	/** 판매_유형_코드 */
	private String saleTpCd;
	
	/** 주요 사용 연령대 코드 */
	private String stpUseAgeCd;
	
	/** 주요 사용 성별 코드 */
	private String stpUseGdCd;
	
	/** 속성 정보 */
	private String attrInfo;
	
    /** 검색 태그 */
	private String srchTag;
	
	/** 네이버 카테고리 ID */
	private String naverCtgId;
	
	/** 가격 비교 페이지 ID */
	private String prcCmprPageId;
}
