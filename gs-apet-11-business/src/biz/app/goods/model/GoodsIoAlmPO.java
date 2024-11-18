package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

/**
 * <pre>
 * - 프로젝트명 : 11.business
 * - 패키지명   : biz.app.goods.model
 * - 파일명     : GoodsIoAlmPO.java
 * - 작성일     : 2021. 03. 24.
 * - 작성자     : valfac
 * - 설명       : 재입고 알림 대상 상품 PO
 * </pre>
 */

@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class GoodsIoAlmPO extends BaseSysVO {

	/* 상품 아이디 */
	private String goodsId;

	/* 재고 배치 일시 */
	private Timestamp stkBtchDtm;

	/* 발송 완료 여부 */
	private String sndCpltYn;

	/* 재고 수량 */
	private int stkQty;

	//시스템등록자, 시스템등록일시 등록

}
