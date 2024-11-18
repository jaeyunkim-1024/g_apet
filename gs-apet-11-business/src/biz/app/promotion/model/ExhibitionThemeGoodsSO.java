package biz.app.promotion.model;

import java.util.List;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.promotion.model
* - 파일명		: ExhibitionThemeGoodsSO.java
* - 작성일		: 2017. 06. 15.
* - 작성자		: wyjeong
* - 설명		:
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ExhibitionThemeGoodsSO extends BaseSearchVO<ExhibitionThemeGoodsSO> {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 테마 번호 */
	private Long thmNo;
	
	/** 기획전 번호 */
	private Long exhbtNo;
	
	/** 사이트 아이디 */
	private Long stId;
	
	/** 웹 모바일 구분 코드 */
	private String webMobileGbCd;
	private List<String> webMobileGbCds;
	
	/** BEST 전시코너 */
	private Long dispCornNoBest;
	
	/** 회원번호 */
	private Long mbrNo;
	
	/** 상품아이디 */
	private String goodsId;

}