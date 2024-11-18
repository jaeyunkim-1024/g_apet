package biz.app.shop.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

import biz.app.company.model.CompanyPolicySO;
import framework.common.model.BaseSearchVO;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class ShopEnterSO extends BaseSearchVO<ShopEnterVO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 입점문의번호 */
	private Integer seNo;
	/** 업체 명 */
	private String compNm;
	
	/** 대표자 명 */
	private String ceoNm;
	
	/** 사업자 번호 */
	private String bizNo;
	
	/** 담당자 명 */
	private String picNm;
	
	/** 담당자 부서 */
	private String picDpm;
	
	/** 담당자 이메일 */
	private String picEmail;
	
	/** 담당자 휴대폰 */
	private String picMobile;
	
	/** 브랜드 명 */
	private String bndNm;
	
	/** 입점 상품 유형 코드 */
	private String seGoodsTpCd;
	
	/** 입점 판매 유형 코드 */
	private String seSaleTpCd;
	
	/** 입점 물류 유형 코드 */
	private String seDstbTpCd;
	
	/** 파일 번호 */
	private Integer flNo;
	
	/** 입점 상태 코드 */
	private String seStatCd;
	
	/** 입점 희망 카테고리 번호 */
	private Integer seHopeCtgNo;
	
	/** 입점 희망 카테고리 */
	private String seHopeCtgNm;
	
	/** 등록일시 시작 */
	private Timestamp strtDtm;

	/** 등록일시 종료 */
	private Timestamp endDtm;
}