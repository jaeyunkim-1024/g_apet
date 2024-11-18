package biz.app.brand.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
@Data
@EqualsAndHashCode(callSuper=false)
@JsonIgnoreProperties(ignoreUnknown = true)
public class BrandBaseSearchVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 브랜드 번호 */
	@JsonProperty("BND_NO")
	private Integer bndNo;

	/** 브랜드 명 국문 */
	@JsonProperty("BND_NM_KO")
	private String bndNmKo;

	@JsonProperty("DOC_COUNT")
	private Long docCount;

}