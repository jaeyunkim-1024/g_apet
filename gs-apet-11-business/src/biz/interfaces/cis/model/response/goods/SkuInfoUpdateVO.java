package biz.interfaces.cis.model.response.goods;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import framework.cis.model.response.shop.GoodsResponse;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명 : business
 * - 패키지명   : biz.interfaces.cis.model.response.goods
 * - 파일명     : SkuInfoUpdateVO.java
 * - 작성일     : 2021. 02. 01.
 * - 작성자     : lhj01
 * - 설명       :
 * </pre>
 */

@Data
@EqualsAndHashCode(callSuper = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class SkuInfoUpdateVO extends GoodsResponse<Void> {
}
