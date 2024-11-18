package biz.app.claim.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.model
* - 파일명		: ClaimDetailSO.java
* - 작성일		: 2017. 3. 6.
* - 작성자		: snw
* - 설명			: 클레임 상세 Search Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ClaimDetailSO extends BaseSearchVO<ClaimDetailSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 클레임 번호 */
	private String	clmNo;
	
	/** 클레임 번호(배열) */
	private Object[]	arrClmNo;

	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;

	/** 클레임 상세 유형 코드 */
	private String clmDtlTpCd;

	private Long mbrNo;

	/** 클레임 상세 순번(배열) */
	private Integer[] arrClmDtlSeq;
	
	/** 배송 번호 */
	private Long dlvrNo;
	
	/** 주문 번호 */
	private String 	ordNo;
	
	/** 주문 상세 순번 */
	private Integer 	ordDtlSeq;
	
	/** 업체 번호 */
	private Long compNo;

	/** 상위 업체 번호 */
	private Long upCompNo;

	/** 클레임상태 40 이 아니다  */
	private Boolean clmStatNot40 = Boolean.FALSE;
	
	/** 클레임상세상태 40 이 아니다  */
	private Boolean clmDtlTpCdNot40 = Boolean.FALSE;


	/** 사유 이미지 PATH */
	private String rsnImgPath;
	
	/** 주문삭제 여부 */
	private String ordrShowYn;
	
	/** 클레임의 클레임 여부 */
	private String clmChainYn;
	/** 클레임의 클레임 대표만 노출여부 */
	private String clmChainReprsntYn=null;
	
	/** 장바구니 세팅 여부 */
	private Boolean isCartReSet;
}