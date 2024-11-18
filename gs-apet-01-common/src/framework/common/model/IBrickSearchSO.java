package framework.common.model;

import java.util.List;

import lombok.Data;

@Data
public class IBrickSearchSO {
	
	/** 검색어 */
	private String KEYWORD;
	
	/** 검색 대상서비스 */
	private String INDEX;
	
	/** 검색범위 특정 */
	private String TARGET_INDEX;
	
	/** 필터 검색범위 특정 */
	private String TARGET_NAME;
	
	/** 정렬기준 */
	private String SORT;
	
	/** 필터 정렬기준 */
	private String BND_SORT;
	
	/** Page */
	private String FROM;
	
	/** 요청건수 */
	private String SIZE;
	
	/** 펫 구분 코드 */
	private String PET_GB_CD[];
	
	/** 필터 유형 */
	private List<IBrickSearchFilterSO> FILTER;
	
	/** 브랜드 번호 */
	private String BND_NO[];
	
	/** 웹 모바일 구분 값 */
	private String WEB_MOBILE_GB_CD;
	
	/** 카테고리*/
	private String CATEGORY;
}
