package biz.app.banner.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BannerSO extends BaseSearchVO<BannerSO> {
	
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 배너 번호*/
	private Long bnrNo;
	
	/** 사이트 아이디*/
	private Long stId;
	
	/** 사용 여부 */
	private String useYn;
	
	/** 배너 ID */
	private String bnrId;
	
	/** 배너 제목 */
	private String bnrTtl;
	
	/** 검색어*/
	private String searchVal;
	
	/** 배너 타입별 코드 */
	private String bnrTpCd;
	
	/** 등록 기간*/
	private Timestamp regStrtDtm;
	private Timestamp regEndDtm;
	
}
