package biz.app.settlement.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.sql.Timestamp;

@Data
@EqualsAndHashCode(callSuper=false)
public class GsPntHistSO extends BaseSearchVO<GsPntHistSO> implements Serializable {

	/** 원거래번호 */
	private String ordNo;

	/** 거래번호 */
	private String dealNo;
	
	/** 거래구분 */
	private String dealGbCd;

	/** 적립사용구분 */
	private String saveUseGbCd;
	
	/** 회원번호 */
	private String mbrNo;
	
	/** 포인트 회원 번호 */
	private String gspntNo;
	
	/** 포인트 금액 */
	private Long pnt;

	/* 시스템 등록 일시 : Start */
	private Timestamp sysRegDtmStart;
	
	/* 시스템 등록 일시 : End */
	private Timestamp sysRegDtmEnd;
	
	/* 엑셀 해더 */
	private String[] headerName;
	
	/* 엑셀 필드 */
	private String[] fieldName;
}
