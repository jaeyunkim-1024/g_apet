package framework.cis.model.response.shop;

import lombok.Data;

import java.util.List;

/**
 * <pre>
 * - 프로젝트명 : 01.common
 * - 패키지명   : framework.cis.model.response.shop
 * - 파일명     : GoodsResponse.java
 * - 작성일     : 2021. 02. 01.
 * - 작성자     : lhj01
 * - 설명       :
 * </pre>
 */

@Data
public class GoodsResponse<T> {
	/** 호출 아이디 */
	private String callId;

	/** 결과 코드 */
	private String resCd;

	/** 결과 메시지 */
	private String resMsg;
	
	/** 상품 코드 */
	private String prdtCd;

	/** 상품 번호(CIS 관리번호) */
	private Integer prdtNo;
	
	/** 단품 코드 */
	private String skuCd;
	
	/** 단품 번호(CIS 관리번호) */
	private Integer skuNo;

	/** 응답 itemList */
	private List<T> itemList;
}
