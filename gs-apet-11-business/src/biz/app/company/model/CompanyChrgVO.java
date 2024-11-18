package biz.app.company.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompanyChrgVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 업체 담당자 번호 */
	public Long compPicNo;
	
	/** 업체 번호 */
	public Long compNo;
	
	/** 담당자 유형 코드 */
	public String picTpCd;
	
	/** 담당자 부서 */
	public String picDpm;
	
	/** 담당자 이름 */
	public String picNm;
	
	/** 담당자 전화번호 */
	public String picTelno;
	
	/** 담당자 유대폰 */
	public String picMobile;
	
	/** 담당자 이메일 */
	public String picEmail;
	
	/** 담당자 메모 */
	public String picMemo;
	
	/** 담당자 주문내역수신여부 */
	public String picAlmRcvYn;
	
	/** 삭제 일시 */
	public Timestamp delDtm;
}
