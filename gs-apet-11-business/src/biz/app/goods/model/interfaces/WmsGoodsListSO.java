package biz.app.goods.model.interfaces;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.goods.model.interface
* - 파일명		: WmsGoodsListSO.java
* - 작성일		: 2017. 8 25.
* - 작성자		: hjko
* - 설명			: 상품 목록  SO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class WmsGoodsListSO extends BaseSearchVO<WmsGoodsListSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	private Long stId;

	/** 업체 번호 */
	private Long compNo;

	/** 시스템 수정 일시 : Start */
	private Timestamp sysUpdDtmStart;

	/** 시스템 수정 일시 : End */
	private Timestamp sysUpdDtmEnd;

}