package biz.app.shop.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

import biz.app.counsel.model.CounselFileVO;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class ShopEnterVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 입점 번호 */
	private Integer seNo;
	
	/** 업체 명 */
	private String compNm;
	
	/** 대표자 명 */
	private String ceoNm;
	
	/** 사업자 번호 */
	private String bizNo;
	
	/** 우편 번호 신 */
	private String postNoNew;
	
	/** 도로 주소 */
	private String roadAddr;
	
	/** 도로 상세 주소 */
	private String roadDtlAddr;
	
	/** 담당자 명 */
	private String picNm;
	
	/** 담당자 부서 */
	private String picDpm;
	
	/** 담당자 이메일 */
	private String picEmail;
	
	/** 담당자 휴대폰 */
	private String picMobile;
	
	/** 웹 사이트 */
	private String webSt;
	
	/** SNS */
	private String sns;
	
	/** 브랜드 명 */
	private String bndNm;
	
	/** 업체 소개 */
	private String compItrdc;
	
	/** 상품 소개 */
	private String goodsItrdc;
	
	/** 상품 가격대 */
	private String goodsPrcRng;
	
	/** 주요 고객 */
	private String stpCust;
	
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
	
	/** 카테고리 이름 */
	private String ctgNm;
	
	/** 입점 희망 카테고리 */
	private String seHopeCtgNm;

	/** 파일명 */
	private String[] orgFlNms;
	
	/** 파일경로 */
	private String[] phyPaths;
	
	/** 파일사이즈 */
	private Long[] flSzs;
	
	/** 첨부파일 list */
	private List<ShopEnterFileVO> phyPathList;
	
}