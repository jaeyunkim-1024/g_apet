package biz.app.company.model;

import java.util.List;

import biz.app.brand.model.CompanyBrandPO;
import biz.app.display.model.DisplayCategoryPO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompanyBasePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 번호 */
	private Long compNo;

	/** 상위 업체번호 */
	private Long upCompNo;

	/** 업체 명 */
	private String compNm;

	/** 사업자 번호 */
	private String bizNo;

	/** 업체 상태 코드 */
	private String compStatCd;

	/** 대표자 명 */
	private String ceoNm;

	/** 업태 */
	private String bizCdts;

	/** 종목 */
	private String bizTp;

	/** 업체 구분 코드 */
	private String compGbCd;

	/** 업체 유형 코드 */
	private String compTpCd;

	/** 팩스 */
	private String fax;

	/** 전화 */
	private String tel;

	/** 우편 번호 구 */
	private String postNoOld;

	/** 우편 번호 신 */
	private String postNoNew;

	/** 도로 주소 */
	private String roadAddr;

	/** 도로 상세 주소 */
	private String roadDtlAddr;

	/** 지번 주소 */
	private String prclAddr;

	/** 지번 상세 주소 */
	private String prclDtlAddr;

	/** 대표 브랜드 번호 */
	private Long dlgtBndNo;

	/** MD 사용자번호 */
	private Long mdUsrNo;

	/** MD 사용자 명  */
	private String mdUsrNm;

	/** 업체 CS 담당 사용자 명  */
	private String csChrgNm;

	/** 업체 CS 담당 사용자 전화번호 */
	private String csChrgTel;

	/** 업체 정산 담당 사용자 명  */
	private String stlChrgNm;

	/** 업체 정산 담당 사용자 전화번호 */
	private String stlChrgTel;

	/** 은행 코드 */
	private String bankCd;

	/** 계좌 번호 */
	private String acctNo;

	/** 예금주 명 */
	private String ooaNm;

	/** 비고 */
	private String bigo;

	/** 대표이메일 */
	private String dlgtEmail;

	/** 사이트 정보 */
	private Long[] stId;

	/** API KEY */
	private String apiKey;
	
	/** IP 일련 번호 */
	private Long ipSeq;
	
	/** 허용 IP */
	private String pmtIp;

	/** 업체 정산 주기 */
	private String cclTermCd;
	
	/** CIS 등록 여부 */
	private String cisRegYn;
	
	/** 사업자 등록증 이미지 패스 */
	private String bizLicImgPath;
	
	/** 사업자 등록증 이미지 패스 tmep */
	private String bizLicImgPathTemp;
	
	/** 업체 이력테이블 번호 */
	private Long compDftHistNo;
	


	/** 전시 카테고리 */
	private List<DisplayCategoryPO> displayCategoryPOList;

	/** 업체 브랜드 번호 목록  */
	private List<CompanyBrandPO> companyBrandPOList;
	
	/** 업체 계좌 */
	private List<CompAcctPO> compAcctPOList;
	
	/** 업체 담당자 */
	private List<CompanyChrgPO> companyChrgPOList;
	
	private String cisRegNo;
	
	/** 입고리드타임 */
	private String incmReadTm;	
	
	/** 주문 수집 문자 알림 코드 */
	private String ordCletCharAlmCd;

}