package biz.app.order.model;



import java.net.URLDecoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.util.Base64Utils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import biz.app.claim.model.ClaimDetailVO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.order.util.OrderUtil;
import framework.common.constants.CommonConstants;
import framework.common.model.BaseSysVO;
import framework.common.util.PetraUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model
* - 파일명		: OrderDetailVO.java
* - 작성일		: 2017. 1. 31.
* - 작성자		: snw
* - 설명			: 주문 상세 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDetailVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;

	/** 주문 상세 상태 코드 */
	private String ordDtlStatCd;

	/** 주문 상세 상태 코드 이름 */
	private String ordDtlStatCdNm;

	/** 상품 아이디 */
	private String goodsId;
	
	/** 묶음 상품 아이디 */
	private String pakGoodsId;

	/** 상품 명 */
	private String goodsNm;

	/** 반품 가능 여부 */
	private String rtnPsbYn;
	
	/** 단품 번호 */
	private Long itemNo;

	/** 단품 명 */
	private String itemNm;

	/** 딜 상품 아이디 */
	private String dealGoodsId;

	/** 전시 분류 번호 */
	private Long dispClsfNo;

	/** 전시 분류 명 */
	private String dispClsfNm;

	/** 업체상품 아이디 */
	private String compGoodsId;

	/** 업체단품 아이디 */
	private String compItemId;

	/** 상품 가격 번호 */
	private Long 	goodsPrcNo;
	
	/** 주문 수량 */
	private Integer ordQty;

	/** 총 주문 잔여 수량 */
	private Integer totalRmnOrdQty;

	/** 교환 수량 */
	private Integer clmExcQty;
	
	/** 취소 수량 */
	private Integer cncQty;

	/** 반품 수량 */
	private Integer rtnQty = 0;

	/** 반품 진행 수량 */
	private Integer rtnIngQty = 0;

	/** 반품 완료 수량 */
	private Integer rtnCpltQty = 0;
	
	/** 잔여 주문 수량 */
	private Integer rmnOrdQty = 0;

	/** 반품 진행 여부 */
	private String rtnIngYn;
	
	/** 유효 주문 수량 */
	private Integer vldOrdQty;
	
	/** 클레임 교환 진행 수량 */
	private Integer	clmExcIngQty = 0;
	
	/** 클레임 교환 완료 수량 */
	private Integer	clmExcCpltQty;

	/** 클레임 진행 여부 */
	private String	clmIngYn;

	/** 판매 금액 */
	private Long saleAmt;

	/** 결제 금액 */
	private Long payAmt;

	/** 원결제합계금액 */
	private Long orgPayTotAmt;
	
	/** 결제 수단 */
	private String payMeansCd;

	/** 수수료 */
	private Long cms;

	/** 상품수수료율 */
	private Double goodsCmsnRt;

	/** 과세 구분 코드 */
	private String taxGbCd;

	/** MD 사용자 번호 */
	private Long 	mdUsrNo;
	
	/** 부여 적립금 */
	private Long ordSvmn;

	/** 적립금 유효기간 코드 */
	private String svmnVldPrdCd;
	
	/** 적립금 유효기간 */
	private Integer svmnVldPrd;
	
	/** 무료 배송 여부 */
	private String	freeDlvrYn;

	/** 핫 딜 여부 */
	private String	hotDealYn;

	/** 배송비 번호 */
	private Long dlvrcNo;

	/** 배송 번호 */
	private Long dlvrNo;

	/** 주문 배송지 번호 */
	private Long ordDlvraNo;

	/** 업체 번호 */
	private Long compNo;

	/** 상위 업체 번호 */
	private Long upCompNo;

	/** 회원 번호 */
	private Long mbrNo;

	/** 상품 평가 등록 여부 */
	private String goodsEstmRegYn;
	
	/** 상품 평가 등록 번호 */
	private String goodsEstmNo;
	
	/** 상품 평가 구분 PLG:펫로그, NOR:일반후기 */
	private String goodsEstmTp;

	/** 외부 주문 상세 번호 */
	private String outsideOrdDtlNo;

	/** 주문기본정보 */
	private OrderBaseVO orderBaseVO;
	
	public String getOrderDtlCodeName() {
		if( ordDtlStatCd != null &&
			( 	CommonConstants.ORD_DTL_STAT_130.equals(ordDtlStatCd)
			||	CommonConstants.ORD_DTL_STAT_140.equals(ordDtlStatCd)
			)
		   ) {
			return CommonConstants.ORD_DTL_STAT_140;
		}else{
			return ordDtlStatCd;
		}
	}
	
	private ClaimDetailVO claimDetailVO;
	
	/** 주문 상세에 대한 클레임 목록 */
	private List<ClaimDetailVO> claimDetailList;
	
	/** 주문 상품에 대한 연관상품 목록 */
	private List<GoodsBaseVO> relatedGoodsList;

	
	/**********************
	 * 적용혜택 정보
	 **********************/
	private Long prmtDcAmt;
	
	private Long cpDcAmt;
	
	private Long cartCpDcAmt;
	
	private Long totCpDcAmt;
	
	private Long totCartCpDcAmt;
	
	private Long totDcAmt;
	
	private String cpNm;
	
	private String cartCpNm;
	
	/**********************
	 * 기타
	 **********************/

	/** 업체 명 */
	private String compNm;

	/** 상품 대표이미지 순번 */
	private Integer imgSeq;

	/** 상품 대표이미지 경로 */
	private String imgPath;

	/** 상품 반전 이미지 경로 */
	private String rvsImgPath;

	/** 단품 추가 금액 */
	private Long addSaleAmt;

	/** 상품 브랜드 명 */
	private String bndNm;
	
	/** 상품 브랜드 코드명 **/
	private String cdBndNmKo;
	
	/** 상품 브랜드 한글명 */
	private String bndNmKo;
	
	/** 상품 브랜드 영문명 */
	private String bndNmEn;
	

	/** 재고 관리여부 */
	private String stkMngYn;

	/** 웹재고 수량 */
	private Integer webStkQty;
	
	/** 1:1 문의 번호 */
	private Long cusNo;

	/**********************
	 *
	 **********************/

	private Long 	aplAmt;


	// Derived Attribute
	/** 배송완료일자+7일과 현재일자 비교 */
	private String compareDtmYn;



//	//--------------------------------------------------
//
//	/** 주문자명  -> 구매영수증에서 쓰므로  삭제 하지 마시오*/
	private String ordNm;
//
//
//
 	/** 주문 상세 상태 명 */
  	private String ordDtlStatNm;
  	
	/** 업체 구분 코드 */
  	private String compGbCd;

//
//	private String compGbCd;
//
//
//
//
//
//
//
//	/* 총 결제금액  -> 구매영수증에서 쓰므로  삭제 하지 마시오 */
	private Long payAmtTotal;
//
//
//	// 여기 정리 필요
//	private String realDlvrAmt;

	/** 계좌 번호 */
	private String acctNo;

	/** 은행 코드 */
	private String bankCd;

	/** 예금주 명 */
	private String ooaNm;

	/** 적용 수량 */
	private Integer aplQty;

	/** 배송비 취소 여부 */
	private String cncTn;

	/** 원주문의 원 배송비 */
	private Long orgDlvrAmt ;

	/** 원주문의 실제 배송비 */
	private Long realDlvrAmt ;

	/** 남은주문의 원 배송비 */
	private Long afterOrgDlvrAmt ;

	/** 남은 주문의 실제 배송비 */
	private Long afterRealDlvrAmt ;

	/** 잔여 결제금액 */
	private Long rmnPayAmt;

	/** 적용혜택 유형코드 */
	private String aplBnftTpCd;

	/** 적용혜택 유형코드 */
	private String aplBnftGbCd;

	/** 상품의 배송비정책.기본택배사 코드 */
	private String dftHdcCd;
	
	/** 대표 송장번호 */
	private String dftInvNo;
	
	/** 택배사 ,로 구분 */
	private String hdcCdNm;
	
	/** 송장번호 */
	private String invNoNm;
	
	/** 클레임 번호 */
	private String clmNo;
	
	/** 클레임 상세번호 */
	private Integer clmDtlSeq;

	private String clmTpCd;

	/** 클레임 상세 상태 코드 */
	private String clmStatCd;

	/** 클레임 상세 상태 코드 */
	private String clmDtlStatCd;

	/** 배송비 정책 번호 */
	private Long dlvrcPlcNo;

	/** 단품 관리 여부 */
	private String itemMngYn;

	/** 반품 진행 중 여부 */
	private String allClaimIngRtnYn;
	
	/** 배송 완료 사진 url*/
	private String dlvrCpltPlcUrl;
	
	/** 상품 구성 유형 */
	private String goodsCstrtTpCd;
	
	/** 배송 처리 유형 */
	private String dlvrPrcsTpCd;
	
	/** 제작 상품 여부 */
	private String mkiGoodsYn;
	
	/** 사전예약 여부 */
	private String rsvGoodsYn;
	
	/** 사은품 여부 */
	private String frbGoodsYn;
	
	/** 묶음 상품 여부 */
	private String pakGoodsYn;
	
	/** 배송 SMS */
	private String dlvrSms;
	
	/** 배송 완료 여부 */
	private String dlvrCpltYn;
	
	/** 제작 상품 옵션 내용 */
	private String mkiGoodsOptContent;
	
	/** TWC 티켓 번호 */
	private String twcTckt;
	
	/** 클레임 상세 구분*/
	private String clmDtlTpCd;
	
	/** 클레임 기본/상태 구분 및 상세 클레임 상세 구분*/
	private String clmTpStatDtlStatCd;	
	
	/** 배송지시일자  */
	private String dlvrCmdDtm;
	
	/** 배송지시일자요일 */
	private String dlvrCmdDtmWeek;
	
	/** 배송완료일자  */
	private String dlvrCpltDtm;
	
	/** 배송완료일자요일 */
	private String dlvrCpltDtmWeek;
	
	/** 송장번호 */
	private String dlvrInvNo;
	
	/** 사은품 */
	private String subGoodsNm;
	
	/** 재고 수량 */
	private Integer stkQty = 0;
	
	/** 입금대기 은행 */
	private String ordBankInfo;	
	
	/** 배송예정일자  */
	private String ordDt;
	
	/** 배송예정일자요일 */
	private String ordDtWeek;
	
	/** 발급 예정 포인트 */
	private Integer isuSchdPnt;	

	/** 묶음상품 옵션 명 */
	private String optGoodsNm;
	
	/** 옵션상품 옵션 명 */
	private String pakItemNm;

	/** 주문 가능 상태 */
	private String salePsbCd;
	
	/** 클레임 대상 수량 */
	private Integer clmTgQty;
	
	/** 원 클레임 번호 */
	private String orgClmNo;
	
	/** 원 클레임 상세번호 */
	private Integer orgClmDtlSeq;
	
	private Boolean claimAccept;
	
	/** 카테고리 */
	private String dispCtgPath;
	
	public String getOrdNm() {
		if(StringUtil.isNotEmpty(this.ordNm) && StringUtils.endsWith(this.ordNm, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordNm, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordNm;
	}
	
	public String getOoaNm() {
		if(StringUtil.isNotEmpty(this.ooaNm) && StringUtils.endsWith(this.ooaNm, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ooaNm, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ooaNm;
	}
	
	public String getAcctNo() {
		if(StringUtil.isNotEmpty(this.acctNo) && StringUtils.endsWith(this.acctNo, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.acctNo, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.acctNo;
	}
	
	public String getOrdBankInfo() {
		if(StringUtil.isNotEmpty(this.ordBankInfo) && StringUtils.indexOf(this.ordBankInfo, "=") > -1) {
			String[] ordBankInfoArr = this.ordBankInfo.split("\\|");
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			String acctNum = "";
			if(ordBankInfoArr.length > 2) {
				acctNum = PetraUtil.twoWayDecrypt(ordBankInfoArr[1], CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
				return ordBankInfoArr[0] + "|" + acctNum  + "|" + ordBankInfoArr[2];
			} else {
				if (ordBankInfoArr.length == 1) {
					acctNum = PetraUtil.twoWayDecrypt(ordBankInfoArr[0], CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
					return acctNum;
				} else {
					if (ordBankInfoArr[1].indexOf("=") > -1) {
						acctNum = PetraUtil.twoWayDecrypt(ordBankInfoArr[1], CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
						return ordBankInfoArr[0] + "|" + acctNum;
					} else {
						acctNum = PetraUtil.twoWayDecrypt(ordBankInfoArr[0], CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
						return acctNum + "|" + ordBankInfoArr[1];
					}
				}
			}
		}
		return this.ordBankInfo;
	}

}