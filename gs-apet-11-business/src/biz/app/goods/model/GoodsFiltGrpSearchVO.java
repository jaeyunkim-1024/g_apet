package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.*;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsFiltGrpVO.java
* - 작성일	: 2020. 12. 29.
* - 작성자	: valfac
* - 설명 		: 상품 필터 그룹 VO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class GoodsFiltGrpSearchVO extends BaseSysVO {
	@JsonProperty("FILT_GRP_NO")
	private Long filtGrpNo;			/* 필터 그룹 번호 	*/
	@JsonProperty("FILT_GRP_SHOW_NM")
	private String filtGrpShowNm;	/* 필터 그룹 노출명 	*/

	// 필터 검색 기능 ////////////////////////////////////////////////////////////////////////////////////////
	@JsonProperty("FILT_ATTRS")
	private List<GoodsFiltAttrSearchVO> filtAttrs;	/* 필터 그룹 노출명 	*/
}
