package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsBulkUploadSO extends BaseSearchVO<GoodsBulkUploadSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String uploadGb;
	private String ntfId;

}
