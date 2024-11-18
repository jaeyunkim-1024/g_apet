package biz.app.st.model;


import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class StStdInfoVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사이트 ID */
	private Long stId;

	/** 사이트 명 */
	private String stNm;

	/** 사이트 URL */
	private String stUrl;
	
	/** 사이트 MO URL */
	private String stMoUrl;
	
	/** 대표이메일 */
	private String dlgtEmail;
	
	/** 사이트 약어 */
	private String stSht;

	/** 사용 여부 */
	private String useYn;

	/** 업체 번호 */
	private String compNo;

	/** 업체 명 */
	private String compNm;

	/** 업체 상태 */
	private String compStatCd;

	/** 로고 이미지 */
	private String logoImgPath;

	/** 고객 센터 번호 */
	private String csTelNo;

	/** 체크yn */
	private String checkedYn;

	/** 수수료 율 */
	private Double cmsRate;
	/** 상품 아이디 */
	private String goodsId;

}