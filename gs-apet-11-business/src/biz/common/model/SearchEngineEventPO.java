package biz.common.model;

import java.io.Serializable;

import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.common.model
* - 파일명		: SearchEngineEventPO.java
* - 작성일		: 2021. 01. 22.
* - 작성자		: KKB
* - 설명		: 클릭이벤트 전송 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class SearchEngineEventPO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	/** 이벤트 구분 */
	private String logGb = "ACTION"; // SEARCH, ACTION
	
	/** 회원 번호 */
	private String mbr_no;
	
	/** 요청구분 */
	private String section;
	
	/** 콘텐츠/상품 번호 */
	private String content_id;
	
	/** 액션 */
	private String action;
	
	/** element_id */
	private String element_id;
	
	/** 검색어 */
	private String keyword;
	
	/** 현재 URL */
	private String url;
	
	/** 타겟 URL */
	private String targetUrl;
	
	/** 경도 */
	private String litd;
	
	/** 위도 */
	private String lttd;
	
	/** 지번 주소 */
	private String prclAddr;
	
	/** 도로 주소 */
	private String roadAddr;
	
	/** 우편번호 */
	private String postNoNew;
	
	/** timestamp */
	private String timestamp;
	
	/** 카테고리 종류 */
	private String index;
	
	/** IOS, Android, 등등 */
	private String agent;
	
	public String getTimestamp() {	// 값이 없을 경우 현재 시간 입력
		return (StringUtil.isBlank(this.timestamp))?DateUtil.getNowDateTime():this.timestamp;
	}

}