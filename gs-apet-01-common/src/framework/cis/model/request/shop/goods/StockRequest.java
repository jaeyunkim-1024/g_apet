package framework.cis.model.request.shop.goods;

import framework.cis.model.request.ApiRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명 : 01.common
 * - 패키지명   : framework.cis.model.request.shop
 * - 파일명     : StockRequest.java
 * - 작성일     : 2021. 01. 27.
 * - 작성자     : lhj01
 * - 설명       :
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class StockRequest extends ApiRequest {

	private String allYn;

}