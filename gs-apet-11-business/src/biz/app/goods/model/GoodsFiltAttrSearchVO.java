package biz.app.goods.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsFiltAttrVO.java
* - 작성일	: 2020. 12. 30.
* - 작성자	: valfac
* - 설명 		: 상품 필터 속성 VO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class GoodsFiltAttrSearchVO extends BaseSysVO {
	@JsonProperty("FILT_ATTR_SEQ")
	private Long filtAttrSeq;	/* 필터 속성 순번 */
	@JsonProperty("FILT_ATTR_NM")
	private String filtAttrNm;	/* 필터 속성 명 	*/
}
