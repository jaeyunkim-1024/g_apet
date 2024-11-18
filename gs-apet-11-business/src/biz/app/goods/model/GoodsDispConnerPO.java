package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;


/***
 * <pre>
 * - 프로젝트명 : 11.business
 * - 패키지명   : biz.app.goods.model
 * - 파일명     : GoodsDispConnerPO.java
 * - 작성일     : 2021. 03. 04.
 * - 작성자     : valfac
 * - 설명       : 공지 배너 PO
 * </pre>
 */

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class GoodsDispConnerPO extends GoodsListVO {

	/** 전시 번호 */
	private Long dispClsfNo;
	/** 전시 코너 번호 */
	private Long dispCornNo;
	/** 전시 분류 코너 번호 */
	private Long dispClsfCornNo;

}
