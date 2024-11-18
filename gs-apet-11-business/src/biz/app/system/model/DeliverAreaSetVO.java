package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DeliverAreaSetVO extends BaseSysVO {

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

	// 추가
	/** 출고창고명 */
	private String outgoStorageNm;

	/** AS창고명1 */
	private String asStorageNm1;

	/** AS창고명2 */
	private String asStorageNm2;

	/** 창고 번호 */
	private Integer whsNo;

	/** 창고 코드 */
	private String whsCd;

	/** 창고명 */
	private String whsNm;

	/** 창고 유형 */
	private String whsTp;

	/** 창고 유형명 */
	private String whsTpNm;

	/** 전화 */
	private String tel;

	/** 상태 코드 */
	private String statCd;

	/** 주소 */
	private String addr;

	/** 관계 창고  */
	private String rltnWhs;

	/** 관계 창고(명) */
	private String rltnWhsNm;

	/** 지역구분 */
	private String areaGbCd;

	/** 책임자 */
	private String managerNm;

	/** 책임자연락처 */
	private String managerTel;

	/**  책임자e-mail */
	private String managerEmail;

}