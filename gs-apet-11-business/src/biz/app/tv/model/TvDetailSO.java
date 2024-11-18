package biz.app.tv.model;

import java.util.List;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.model
 * - 파일명		: TvDetailSO.java
 * - 작성일		: 2021. 01. 19. 
 * - 작성자		: LDS
 * - 설 명		: 펫TV 상세 Search Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class TvDetailSO extends BaseSearchVO<TvDetailSO> {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 사이트 아이디 */
	private Long stId;

	/** 회원 번호 */
	private Long mbrNo;

	/** 세션 아이디 */
	private String ssnId;
	
	/** 웹 모바일 구분 코드 */
	private String webMobileGbCd;
	
	/** 영상ID */
	private String vdId;
	
	/** 시리즈번호 */
	private Long srisNo;
	
	/** 시즌번호 */
	private Long sesnNo;
	
	/** 정렬 코드 */
	private String sortCd = "";

	/** 상품 아이디 */
	private String goodsId;
	
	/** 진입목록 구분 */
	private String listGb = "";
	
	/**  */
	private String jsonData;
	
	/** 중복제거 vdId*/
	private List<String> dupleVdIds;
	
	/** 시리즈 반복여부(임시컬럼 추후 삭제) */
	private String repeatYn;
	
	/** 추천영상의 VD_ID 목록 */
	private List<String> vdIdList;
	
	/** 시리즈 정렬순서 */
	private Long srisSeq;
	
}
