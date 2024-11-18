package biz.app.company.model;

import java.util.List;

import biz.app.goods.model.GoodsListVO;
import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompanySO extends BaseSearchVO<CompanySO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 번호 */
	private Long compNo;

	/** 상위 업체 번호 */
	private Long upCompNo;

	/** 업체 명 */
	private String compNm;

	/** 사업자 번호 */
	private String bizNo;

	/** 업체 상태 코드 */
	private String compStatCd;

	/** 대표자 명 */
	private String ceoNm;

	/** 업체 구분 코드 */
	private String compGbCd;

	/** 업체 유형 코드 */
	private String compTpCd;

	/** 배송비 정책 번호 */
	private Long dlvrcPlcNo;

	/** 사이트 아이디 */
	private Long stId;

	/** 관리자여부 : 조회위해 추가함.*/
	private String adminYn;

	/** 상위업체/하위업체 조회 구분 : 조회위해 추가함. 상위:UP, 하위:SB */
	private String searchCompanyGb;

	/** MD 사용자 번호 */
	private Long mdUsrNo;

	/** 업체 CS 담당 사용자 명  */
	private String csChrgNm;

	/** 업체 CS 담당 사용자 전화번호 */
	private String csChrgTel;

	/** 업체 정산 담당 사용자 명  */
	private String stlChrgNm;

	/** 업체 정산 담당 사용자 전화번호 */
	private String stlChrgTel;

	/** 승인여부 */
	private String cfmYn;

	/** API KEY */
	private String apiKey;

	/** 브랜드 이름, 업체검색 팝업에서 브랜드 이름으로 검색할 때만 사용함. */
	private String bndNm;

	/** 카테고리삭제여부 **/
	private String delYn;

	/** 사이트사용여부 **/
	private String useYn;

	private List<GoodsListVO>	goodsList;
	
	/** 팝업 파라미터 */
	private String readOnlyCompStatCd;
	
	private String selectKeyOnlyCompStatCd;
	
	private String excludeCompStatCd;
	
	private String readOnlyCompTpCd;
	
	private String selectKeyOnlyCompTpCd;
	
	private String excludeCompTpCd;
	
	private List<Long> stIds;
	
	/** CIS 등록 여부 */
	private String cisRegYn;
	
	private String usrGrpCd;
	
	

}