package biz.app.banner.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BannerPO extends BaseSysVO {
	
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 배너번호 */
	private Long bnrNo;
	
	/** 배너 ID */
	private String bnrId;
	
	/** 배너 제목 */
	private String bnrTtl;
	
	/** 사이트 ID */
	private Long stId;
	
	/** 사용 여부 */
	private String useYn;
	
	/** 배너 이미지 코드 */
	private String bnrImgCd;
	
	/** 배너 이미지 명 */
	private String bnrImgNm;
	
	/** 배너 이미지 경로 */
	private String bnrImgPath;
	
	/** 배너 이미지 URL */
	private String bnrImgUrl;
	
	/** 배너 모바일 이미지 코드 */
	private String bnrMobileImgCd;
	
	/** 배너 모바일 이미지 명 */
	private String bnrMobileImgNm;
	
	/** 배너 모바일 이미지 경로 */
	private String bnrMobileImgPath;
	
	/** 배너 모바일 이미지 URL */
	private String bnrMobileImgUrl;
	
	/** 배너 LINK URL */
	private String bnrLinkUrl;
	
	/** 배너 타입별 코드 */
	private String bnrTpCd;

}
