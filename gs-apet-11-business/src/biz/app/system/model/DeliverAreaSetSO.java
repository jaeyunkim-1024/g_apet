package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DeliverAreaSetSO extends BaseSearchVO<DeliverAreaSetSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 아이디 */
	private Integer areaId;

	/** 지역명 */
	private String areaName;

	/** 출고창고아이디 */
	private String outgoStorageId;

	/** AS창고1 */
	private String asStorageId1;

	/** AS창고2 */
	private String asStorageId2;

	/** 지역코드 */
	private String areaCd;

	/** 우편번호 타입 */
	private String zipType;
}