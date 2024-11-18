package biz.app.pet.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetInclRecodeVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 펫 번호 */
	private Integer petNo;
	
	/** 접종 번호 */
	private Integer inclNo;
	
	/** 접종 구분 코드 */
	private String inclGbCd;
	
	/** 접종 종류 코드 */
	private String inclKindCd;

	/** 접종 명 */
	private String inclNm;

	/** 항목 명 */
	private String itemNm;

	/** 접종일 */
	private String inclDt;

	/** 추가 접종 코드 */
	private String addInclCd;

	/** 다음 접종 예정일 */
	private String addInclDt;

	/** 진료 병원 명 */
	private String trmtHsptNm;

	/** 이미지 경로 */
	private String imgPath;

	/** 알람 설정 여부 */
	private String almSetYn;

	/** 접종 증명서 여부 */
    private String Ctfc;

	/** 특이사항 */
    private String memo;
    
    private Integer intervalDay;
}
