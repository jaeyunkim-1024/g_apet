package biz.app.estimate.model;

import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EstimatePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 견적 번호 */
	private Integer estmNo;
	
	/** 견적 일자 */
	private String estmDt;
	
	/** 대상 명 */
	private String tgNm;
	
	/** 전화 */
	private String tel;
	
	/** 이메일 */
	private String email;
	
	/** 배송 요청 일자 */
	private String dlvrReqDt;
	
	/** 설치 장소 */
	private String istPlc;
	
	/** 회원 번호 */
	private Integer mbrNo;
	
	/** 견적 상품 */
	private List<EstimateGoodsPO> estimateGoodsPO;

}