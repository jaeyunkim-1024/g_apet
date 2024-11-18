package biz.app.settlement.model;

import framework.common.model.BaseSysVO;
import framework.common.util.StringUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.sql.Timestamp;

@Data
@EqualsAndHashCode(callSuper=false)
public class GsPntHistVO extends BaseSysVO implements Serializable {
	/** Excel NO */
	private Long excelNo;
	
	/** GS_PNT_HIST_NO */
	private Long gsPntHistNo;
	
	/** 원거래번호 */
	private String ordNo;

	/** 거래번호 */
	private String dealNo;
	
	/** 거래구분 */
	private String dealGbCd;

	/** 적립사용구분 */
	private String saveUseGbCd;
	
	/** 회원번호 */
	private Long mbrNo;
	
	/** 포인트 회원 번호 */
	private String gspntNo;
	
	/* 거래일시 */
	private Timestamp dealDtm;
	
	/** 총결제금액 */
	private String payAmt;
	
	/* 포인트 거래일시 */
	private Timestamp sysRegDtm;
	
	/** 포인트 사용 */
	private Long pntUse;
	
	/** 포인트 적립 */
	private Long pntSave;
	
	/** 포인트 취소 */
	private Long pntCncl;
	
	/** 총 포인트 사용 */
	private Long totalPntUse;
	
	/** 총 포인트 적립 */
	private Long totalPntSave;
	
	/** 총 포인트 취소 */
	private Long totalPntCncl;
	
	/** rowIndex */
	private Long rowIndex;
	
	public Long getPayAmt() {
		return (StringUtil.isNotBlank(this.payAmt))?Long.parseLong(this.payAmt):0;
	}
	
	public String getMbrNo() {
		return (mbrNo == null)?"": String.valueOf(this.mbrNo);
	}
}
