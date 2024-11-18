package biz.app.shop.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ShopEnterFileSO extends BaseSearchVO<ShopEnterFileSO> {

	private static final long serialVersionUID = 1L;

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front area
	//-------------------------------------------------------------------------------------------------------------------------//

	/** 입점문의번호 */
	private Integer seNo;

}
