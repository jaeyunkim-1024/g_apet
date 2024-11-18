package biz.app.system.model;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class ZipcodeMappingPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 순번 */
	private Integer seq;

	/** 5자리우편번호 */
	private String zipcode;

	/** 시도 */
	private String sido;

	/** 구분 */
	private String gugun;

	/** 동 */
	private String dong;

	/** 리 */
	private String ri;

	/** 번지 */
	private String bunji;

	/** 6자리우편번호 */
	private String postcode;

	/** 직배송여부 */
	private String areaYn;

	/** 직배송지역 */
	private String areaId;

	/** 우편번호구분 */
	private String mappingCd;

	/** 우편번호 그리드 */
	private List<ZipcodeMappingPO> zipCodePOList;
}