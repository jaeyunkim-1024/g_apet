package biz.app.sample.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SampleVO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	private String bizNo;
	private String bsnItm;
	private String chrgNm;
	private String ownrCd;
	private String chrgCelNo;
	private String chrgTelNo;
	private String prntTpCd;
	private String stlCdtCd;
	private String ceoNm;
	private String telNo;
	private String zipcode;
	private String prntCd;
	private String trdStatCd;
	private String incmReadTm;
	private String bsnCdt;
	private String faxNo;
	private String chrgEmail;
	private String statCd;
	private String addr;
	private String addrDtl;
	private String prntNm;

}