package biz.app.goods.validation;

import biz.app.attribute.model.AttributePO;
import biz.app.attribute.model.AttributeSO;
import biz.app.attribute.model.AttributeVO;
import biz.app.attribute.model.AttributeValuePO;
import biz.app.company.dao.CompanyDao;
import biz.app.company.model.CompanySO;
import biz.app.delivery.model.DeliveryChargePolicyPO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.model.DisplayGoodsPO;
import biz.app.goods.dao.GoodsBulkUploadDao;
import biz.app.goods.dao.GoodsPriceDao;
import biz.app.goods.dao.ItemDao;
import biz.app.goods.model.*;
import biz.app.st.dao.StDao;
import biz.app.st.model.StStdInfoVO;
import biz.app.system.model.CodeDetailVO;
import biz.app.tag.dao.TagDao;
import biz.app.tag.model.TagBasePO;
import biz.common.service.CacheService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.LogUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.util.ObjectUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.InvocationTargetException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.goods.validation
 * - 파일명		: GoodsValidation.java
 * - 작성일		: 2016. 5. 20.
 * - 작성자		: valueFactory
* - 설명			: 상품 일괄 업로드.. 상품 검증
 * </pre>
 */
@Slf4j
public class GoodsValidator {

	private GoodsBulkUploadDao goodsBulkUploadDao;
	private MessageSourceAccessor message;
	private CacheService cacheService;
	private GoodsPriceDao goodsPriceDao;
	private ItemDao itemDao;
	private StDao stDao;
	private CompanyDao companyDao;

	public GoodsValidator() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		ServletContext context = request.getSession().getServletContext();
		ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(context );

		message = ac.getBean(MessageSourceAccessor.class );
		cacheService = ac.getBean(CacheService.class );
		goodsBulkUploadDao = ac.getBean(GoodsBulkUploadDao.class );
		goodsPriceDao = ac.getBean(GoodsPriceDao.class );
		itemDao = ac.getBean(ItemDao.class );
		stDao = ac.getBean(StDao.class );
		companyDao = ac.getBean(CompanyDao.class );
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidator.java
	 * - 작성일		: 2016. 5. 23.
	 * - 작성자		: valueFactory
	 * - 설명			: 실패 메시지
	 * </pre>
	 * @param po
	 * @param failMsg
	 */
	public void setFailMsg (GoodsBulkUploadPO po, String failMsg ) {
		po.setSuccessYn(AdminConstants.COMM_YN_N );	// 실패
		if(StringUtil.isEmpty(po.getResultMessage()) ) {
			po.setResultMessage(failMsg );
		} else {
			String orgMsg = po.getResultMessage();
			po.setResultMessage(orgMsg + "\n" + failMsg );
		}
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidator.java
	 * - 작성일		: 2016. 5. 23.
	 * - 작성자		: valueFactory
	 * - 설명			: 코드값 검사
	 * </pre>
	 * @param grpCd
	 * @param dtlCd
	 * @return
	 */
	public String[] getGroupCode (String grpCd ) {
		return getGroupCode (grpCd, null, null, null, null, null );
	}
	public String[] getGroupCode (String grpCd, String usrDfn1Val, String usrDfn2Val, String usrDfn3Val, String usrDfn4Val, String usrDfn5Val ) {
		String[] rtnVal = null;
		List<CodeDetailVO> list = cacheService.listCodeCache(grpCd, usrDfn1Val, usrDfn2Val, usrDfn3Val, usrDfn4Val, usrDfn5Val);
		if(list != null && !list.isEmpty()) {
			rtnVal = new String[list.size()];
			for(int i = 0; i < list.size(); i++ ) {
				rtnVal[i] = list.get(i).getDtlCd();
			}
		}
		return rtnVal;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidator.java
	 * - 작성일		: 2016. 5. 23.
	 * - 작성자		: validateGoodsBase
	 * - 설명		: 코드값 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateGoodsBase (GoodsBulkUploadPO po ) {
		boolean rtnVal = true;

		// 넘어온 데이터가 없으면
		if(po == null ) {
			return false;
		}

		// 성공으로 하고.. 아래 검사시 오류건에 대해서 처리
		po.setSuccessYn(AdminConstants.COMM_YN_Y );

		// [필수]사이트, 업체명
		if(!validateStNmAndCompNm (po ) ) {
			rtnVal = false;
		}

		// [필수]상품명
		if(!validateGoodsName (po ) ) {
			rtnVal = false;
		}

		/** 표준코드 필수아님 변경. 2021-05-10 최용훈
		// [필수]표준코드
		if(!validateGoodsPrdStdCd (po ) ) {
			rtnVal = false;
		}
		 */

		if(po.getCompNo() != null) {
			// 자체상품코드 필수아님 유일값 아님 체크필요없음 20210309
			//if(!validateCompGoodsId (po) ) { rtnVal = false; }
			// [필수]업체명
			if(!validateCompNo (po ) ) {
				rtnVal = false;
			}
			// [필수]브랜드 번호
			if(!validateBndNm (po ) ) {
				rtnVal = false;
			}
			// [필수]배송비 정책 번호
			if(!validateDlvrcPlcNo (po ) ) {
				rtnVal = false;
			}
		}

		//모델명 필수아님

		// [필수]펫구분 코드 PET_GB_CD
		if(!validatePetGbNm (po ) ) {
			rtnVal = false;
		}
		// [필수]원산지
		if(!validateCtrOrgNm (po ) ) {
		    rtnVal = false;
		}
		// [필수]제조사
		if(!validateMmft (po ) ) {
			rtnVal = false;
		}
		/**
		 // 수입사 필수아님
		 if(!validateImporter (po ) ) {
		 rtnVal = false;
		 }
		 */
		// [필수]과세구분
		if(!validateTaxGbNm (po ) ) {
			rtnVal = false;
		}
		// [필수]노출여부
		if(!validateShowYn (po ) ) {
			rtnVal = false;
		}
		// [필수]웹 모바일 구분 validateWebMobileGbCd -> validateWebMobileGbNm
		if(!validateWebMobileGbNm (po ) ) {
			rtnVal = false;
		}
		// [필수]정상가
		if(!validateOrgSaleAmt (po ) ) {
			rtnVal = false;
		}
		// [필수]판매가
		if(!validateSaleAmt (po ) ) {
			rtnVal = false;
		}
		// [필수]매입가
		if(!validateSplAmt (po ) ) {
			rtnVal = false;
		}
		// [필수]재고 관리 여부
		if(!validateStkMngYn (po ) ) {
			rtnVal = false;
		}
		// 재고 수량 노출 여부 필수아님
		/*
		// 웹 재고 기본 수량 필수아님
		if(!validateWebStkQty (po ) ) {
			rtnVal = false;
		}
		// 최소주문수량 필수아님
		// 최대주문수량 필수아님
		*/
		// [필수]매입 업체명 
		if(!validatePhsCompNm (po) ) {
			rtnVal = false;
		}
		// [필수]샵링커 전송 여부
		if(!validateShoplinkerSndYn (po ) ) {
			rtnVal = false;
		}
		// [필수]성분 정보 연동 여부
		if(!validateIgdtInfoLnkYn (po ) ) {
			rtnVal = false;
		}

		// 무료 배송 여부 Y/N으로 세팅
		String freeDlvrYnMsg = validateYn(po.getFreeDlvrYn());
		if(StringUtils.isNotEmpty(freeDlvrYnMsg)) {
			setFailMsg(po, "[무료 배송 여부] " + freeDlvrYnMsg);
			rtnVal = false;
		} else {
			if(StringUtils.isNotEmpty(po.getFreeDlvrYn())) {
				po.setFreeDlvrYn(po.getFreeDlvrYn().trim().toUpperCase());
			} else {
				po.setFreeDlvrYn(CommonConstants.COMM_YN_N);
			}
		}
		/*
		// 무료 배송 여부 필수아님
		if(!validateFreeDlvrYn (po ) ) {
			rtnVal = false;
		}
		*/
		// 반품 가능 여부 Y/N으로 세팅
		String rtnPsbYnMsg = validateYn(po.getRtnPsbYn());
		if(StringUtils.isNotEmpty(rtnPsbYnMsg)) {
			setFailMsg(po, "[반품 가능 여부] " + rtnPsbYnMsg);
			rtnVal = false;
		} else {
			if(StringUtils.isNotEmpty(po.getRtnPsbYn())) {
				po.setRtnPsbYn(po.getRtnPsbYn().trim().toUpperCase());
			} else {
				po.setRtnPsbYn(CommonConstants.COMM_YN_N);
			}
		}

		//재고 수량 노출 Y/N으로 세팅
		String stkQtyShowYnMsg = validateYn(po.getStkQtyShowYn());
		if(StringUtils.isNotEmpty(stkQtyShowYnMsg)) {
			setFailMsg(po, "[재고 수량 노출] " + stkQtyShowYnMsg);
			rtnVal = false;
		} else {
			if(StringUtils.isNotEmpty(po.getStkQtyShowYn())) {
				po.setStkQtyShowYn(po.getStkQtyShowYn().trim().toUpperCase());
			} else {
				po.setStkQtyShowYn(CommonConstants.COMM_YN_N);
			}
		}

		//품절 상품 노출 Y/N으로 세팅
		String ostkGoodsShowYnMsg = validateYn(po.getOstkGoodsShowYn());
		if(StringUtils.isNotEmpty(ostkGoodsShowYnMsg)) {
			setFailMsg(po, "[품절 상품 노출] " + ostkGoodsShowYnMsg);
			rtnVal = false;
		} else {
			if(StringUtils.isNotEmpty(po.getOstkGoodsShowYn())) {
				po.setOstkGoodsShowYn(po.getOstkGoodsShowYn().trim().toUpperCase());
			} else {
				po.setOstkGoodsShowYn(CommonConstants.COMM_YN_N);
			}
		}

		// 재입고 알림 여부 Y/N으로 세팅
		String ioAlmYnMsg = validateYn(po.getIoAlmYn());
		if(StringUtils.isNotEmpty(ioAlmYnMsg)) {
			setFailMsg(po, "[재입고 알림 여부] " + ioAlmYnMsg);
			rtnVal = false;
		} else {
			if(StringUtils.isNotEmpty(po.getIoAlmYn())) {
				po.setIoAlmYn(po.getIoAlmYn().trim().toUpperCase());
			} else {
				po.setIoAlmYn(CommonConstants.COMM_YN_N);
			}
		}
		/*
		// 반품 가능 여부 필수아님
		if(!validateRtnPsbYn (po ) ) {
			rtnVal = false;
		}
	    */

		// [필수]상세설명 [PC, 전체]
		// 상세설명 [MOBILE] 필수아님
		if(!validateContent(po)) {
			rtnVal = false;
		}

		// 속성1 값 필수
		if(!validateAttr(po)) {
			rtnVal = false;
		}
		// 속성2 명 필수아님
		// 속성2 값 필수아님
		// 속성3 명 필수아님
		// 속성3 값 필수아님
		// 속성4 명 필수아님
		// 속성4 값 필수아님
		// 속성5 명 필수아님
		// 속성5 값 필수아님

		// [필수]이미지1 URL
		if(!validateImg1Url(po)) {
			rtnVal = false;
		}
		// 이미지2 ~ 이미지10 URL 필수아님 , BUT 자리수 체크
		if(!validateImgUrl(po)) {
			rtnVal = false;
		}
		
		// 배너이미지 URL
		/*if(!validateBannerImgUrl(po)) {
			rtnVal = false;
		}*/

		// 판매기간 설정여부 Y/N으로 설정
		String saleDtYnMsg = validateYn(po.getSaleDtYn());
		if(StringUtils.isNotEmpty(saleDtYnMsg)) {
			setFailMsg(po, "[판매기간 설정여부] " + saleDtYnMsg);
			rtnVal = false;
		} else {
			if(StringUtils.isNotEmpty(po.getSaleDtYn())) {
				po.setSaleDtYn(po.getSaleDtYn().trim().toUpperCase());
			} else {
				po.setSaleDtYn(CommonConstants.COMM_YN_N);
			}
		}

		// 판매기간 시작일시 - yyyy-mm-dd 00:00
		// 판매기간 종료일시 - yyyy-mm-dd 00:00
		// 판매기간 설정여부 N 일때 입력된 값에 상관 없이 9999-12-31 23:59:59로 입력
		if(!validateSaleDtm(po)) {
			//setFailMsg(po, "[판매기간 설정여부] " + saleDtYnMsg);
			rtnVal = false;
		}

		// [필수] 태그
		if(!validateTags(po)) {
			//setFailMsg(po, "[태그] 입력값 체크");
			rtnVal = false;
		}

		// 네이버쇼핑 노출여부 Y/N으로 설정
		String sndYnMsg = validateYn(po.getSndYn());
		if(StringUtils.isNotEmpty(sndYnMsg)) {
			setFailMsg(po, "[네이버쇼핑 노출여부] " + sndYnMsg);
			rtnVal = false;
		} else {
			if(StringUtils.isNotEmpty(po.getSndYn())) {
				po.setSndYn(po.getSndYn().trim().toUpperCase());
			}
			// 네이버 쇼핑
			validateNaver(po);
		}
		// 검색 태그 [구분자:|]
		//네이버 카테고리 ID 필수아님
		//가격비교 페이지 ID 필수아님
		// 상품 개별 SEO 설정 사용여부 Y/N으로 설정
		String pageYnMsg = validateYn(po.getPageYn());
		if(StringUtils.isNotEmpty(pageYnMsg)) {
			setFailMsg(po, "[SEO 사용여부] " + pageYnMsg);
			rtnVal = false;
		} else {
			if(StringUtils.isNotEmpty(po.getPageYn())) {
				po.setPageYn(po.getPageYn().trim().toUpperCase());
			}
			// SEO 설정
			//보안 진단. 불필요한 코드 (비어있는 IF문)
			/*if(!validateSeo(po)) {
				//rtnVal = false;
			}*/
		}
		// [필수] 전시 카테고리
		if(!validateCategory(po)) {
			rtnVal = false;
		}
		// 아이콘 코드 콤마로 구분하여 입력. 유효하지 않은 코드값 입력하지 않음.
		validateIcons(po);

		//사은품 가능여부
		String frbPsbYnMsg = validateYn(po.getFrbPsbYn());
		if(StringUtils.isNotEmpty(frbPsbYnMsg)) {
			setFailMsg(po, "[사은품 가능여부] " + frbPsbYnMsg);
			rtnVal = false;
		} else {
			if (StringUtils.isNotEmpty(po.getFrbPsbYn())) {
				po.setFrbPsbYn(po.getFrbPsbYn().trim().toUpperCase());
			}
		}
		//유통기한 관리여부
		String expMngYnMsg = validateYn(po.getExpMngYn());
		if(StringUtils.isNotEmpty(expMngYnMsg)) {
			setFailMsg(po, "[유통기한 관리여부] " + expMngYnMsg);
			rtnVal = false;
		} else {
			if (StringUtils.isNotEmpty(po.getExpMngYn())) {
				po.setExpMngYn(po.getExpMngYn().trim().toUpperCase());
			}
		}
		//유통기한 (월)
		if(!validateExpMonth(po)) {
			rtnVal = false;
		}
		//MD 추천 여부
		String mdRcomYnMsg = validateYn(po.getMdRcomYn());
		if(StringUtils.isNotEmpty(mdRcomYnMsg)) {
			setFailMsg(po, "[MD 추천 여부] " + mdRcomYnMsg);
			rtnVal = false;
		} else {
			if (StringUtils.isNotEmpty(po.getMdRcomYn())) {
				po.setMdRcomYn(po.getMdRcomYn().trim().toUpperCase());
			}
		}
		//MD 추천 메시지 필수 아님

		// [필수] 고시정보 [기타]로 고정되어 있음.
			if(!validateItemVal(po)) {
				rtnVal=false; 
			}
		
		//DONE FIXME 이건 실제 등록할때 처리한다
		// [필수] 매입처 고정
		/**
		 // 전시분류 번호
		 if(!validateDispClsfNo (po ) ) {
		 rtnVal = false;
		 }

		 // 공정위품목군
		 if(!validateNtfId (po ) ) {
		 rtnVal = false;
		 }

		 // 단품 관리 여부
		 if(!validateItemMngYn (po ) ) {
		 rtnVal = false;
		 }

		 // 단품 속성
		 if(!validateAttribute (po ) ) {
		 rtnVal = false;
		 }

		 // 이미지1 URL
		 if(!validateImg1Url(po)) {
		 rtnVal = false;
		 }
		 */
		LogUtil.log(po );

		return rtnVal;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품명 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateGoodsName (GoodsBulkUploadPO po ) {
		String goodsNm = null;
		String msg = "";
		String key = message.getMessage("column.goods_nm" );

		goodsNm = po.getGoodsNm();

		// NotNull
		msg = ValidationUtil.notBlank(goodsNm, key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		// Length(max=300)
		msg = ValidationUtil.length(goodsNm, key, 1, 50 );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2021. 5. 3.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품 표준코드 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateGoodsPrdStdCd(GoodsBulkUploadPO po ) {
		String msg = "";
		String key = message.getMessage("column.goods.strdCd" );

		String prdStdCd = po.getPrdStdCd();
		if(StringUtil.isNotEmpty(prdStdCd)) {
			prdStdCd = prdStdCd.trim();
		}

		// NotNull
		msg = ValidationUtil.notNull(prdStdCd, key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품 유형 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateGoodsTpCd (GoodsBulkUploadPO po ) {
		String goodsTpCd = null;
		String msg = "";
		String key = message.getMessage("column.goods_tp_cd" );

		goodsTpCd = po.getGoodsTpCd();

		// NotNull
		msg = ValidationUtil.notNull(goodsTpCd, key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		// Code
		String[] codes = getGroupCode(AdminConstants.GOODS_TP );
		msg = ValidationUtil.selective(goodsTpCd.trim(), key, codes );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		po.setGoodsTpCd(goodsTpCd.trim());

		return true;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 업체번호 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateCompNo (GoodsBulkUploadPO po ) {
		Long compNo = null;
		String msg = "";
		String key = message.getMessage("column.goods.comp_no" );

		compNo = po.getCompNo();

		if(goodsBulkUploadDao.checkGoodsCompNo(compNo) <= 0 ) {
			msg = String.format("<b>[%s]</b> 잘못된 업체정보 : [%s]", key, compNo);
			setFailMsg (po, msg );
			return false;
		}

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2021. 2. 8
	 * - 작성자		: valueFactory
	 * - 설명		: 업체명 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateCompNm(GoodsBulkUploadPO po) {
		String compNm = null;
		String msg = "";
		String key = message.getMessage("column.goods.comp_nm" );

		compNm = po.getCompNm();

		if(goodsBulkUploadDao.checkGoodsCompNm(compNm) <= 0 ) {
			msg = String.format("<b>[%s]</b> 잘못된 업체정보 : [%s]", key, compNm);
			setFailMsg (po, msg );
			return false;
		}
	

		return true;
	}

	public boolean validateStNmAndCompNm (GoodsBulkUploadPO po ) {
		String stNm = null;
		String msg = "";
		String key = message.getMessage("column.st" );
		StringBuilder st = new StringBuilder();

		stNm = po.getStNm();
		msg = ValidationUtil.notNull(stNm, key);
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		StStdInfoVO stStdInfoVO = goodsBulkUploadDao.getStStdInfo(po);
		if (stStdInfoVO == null) {
			setFailMsg (po, "<b>["+key + "]</b>의 데이터가 없습니다." );
			return false;
		}

		po.setStId(stStdInfoVO.getStId());
		st.append(stStdInfoVO.getStId() + "-" + stStdInfoVO.getStNm());

		if(StringUtil.isEmpty(stStdInfoVO.getCompNm())) {
			String compNmKey = message.getMessage("column.compNm" );
			setFailMsg (po, "<b>["+compNmKey + "]</b>의 데이터가 없습니다." );
			return false;
		}

		po.setCompNo(Long.parseLong(stStdInfoVO.getCompNo()));
		po.setSt(st.toString());
		return true;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 6. 23.
	 * - 작성자		: hongjun
	 * - 설명		: 사이트 ID 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateStId (GoodsBulkUploadPO po ) {
		String stIds = null;
		String msg = "";
		String key = message.getMessage("column.st" );
		StringBuilder st = new StringBuilder();

		stIds = po.getStIds();
		msg = ValidationUtil.notNull(stIds, key);
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		String[] arrStId = StringUtil.split(stIds, "," );
		for (String stId : arrStId) {
			msg = ValidationUtil.validInt(stId, message.getMessage("column.st_id" ));
			if(StringUtil.isNotEmpty(msg) ) {
				setFailMsg (po, msg );
				return false;
			}

			StStdInfoVO stStdInfoVO = stDao.getStStdInfo(Long.parseLong(stId));
			if (stStdInfoVO == null) {
				setFailMsg (po, key + "의 데이터가 없습니다." );
				return false;
			}

			if (StringUtils.isNotBlank(st.toString())) {
				st.append(", ");
			}
			st.append(stStdInfoVO.getStId() + "-" + stStdInfoVO.getStNm());

			int stMapCnt = 0;
			List<StStdInfoVO> listStStdInfoVO = companyDao.getStStdInfoById(po.getCompNo());
			for(StStdInfoVO stVO : listStStdInfoVO) {
				if (stVO.getStId().equals(stStdInfoVO.getStId()) && StringUtils.equalsIgnoreCase(CommonConstants.COMM_YN_Y, stVO.getUseYn())) {
					stMapCnt += 1;
				}
			}
			if (stMapCnt < 1) {
				setFailMsg (po,  String.format("<b>[%s]</b> 상품을 등록할 수 없음", key));
				return false;
			}
		}

		po.setSt(st.toString());
		return true;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2021. 2. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 자체 상품번호 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateCompGoodsId (GoodsBulkUploadPO po ) {
		String compGoodsId = null;
		//String msg = "";
		String key = message.getMessage("column.comp_goods_id" );

		compGoodsId = po.getCompGoodsId();

		if(compGoodsId != null ){
			// 중복된 업체 상품번호가 있는지 검사
			String goodsId = goodsBulkUploadDao.checkCompGoodsId(po );
			if(StringUtil.isNotEmpty(goodsId ) ) {
				// 검사 결과 같은 업체 상품번호가 동일 사이트에 동일한 업체번호로 등록되어 있으면 추가 등록 할 수 없다.
				setFailMsg (po,  String.format("<b class=\"error\">[%s]</b> 이미 등록된 코드 : [%s]", key, compGoodsId));
				return false;
			}
		}

		if(po.getCompGoodsIdCnt() > 1) {
			// 검사 결과 같은 업체 상품번호가 동일 사이트에 동일한 업체번호로 등록되어 있으면 추가 등록 할 수 없다.
			setFailMsg (po,  String.format("<b class=\"error\">[%s]</b> 중복 코드 : [%s]", key, compGoodsId));
			return false;
		}

		return true;
	}

	// 사이트ID 를  LONG 타입 배열로 변환한다.
	private Long[] getStIdArray(GoodsBulkUploadPO po){
		String[] arrStId = StringUtil.split(po.getStIds(), ",");
		Long[] stIds = new Long[arrStId.length];

		try {
			for (int idx=0; idx < arrStId.length; idx++) {
				stIds[idx] = Long.parseLong(arrStId[idx]);
			}
		} catch (NumberFormatException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}

		return stIds;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 브랜드 번호 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateBndNo (GoodsBulkUploadPO po ) {
		Long bndNo = null;
		String msg = "";
		String key = message.getMessage("column.bnd_no" );

		bndNo = po.getBndNo();

		if(bndNo != null ) {
			Long[] stIds = getStIdArray(po);
			po.setStIdArray(stIds);

			if(stIds.length != goodsBulkUploadDao.checkBndNo(po)) {
				msg = String.format("<b>[%s]</b> 사용할 수 없는 브랜드", key);
				setFailMsg (po, msg );
				return false;
			}
		}

		return true;
	}
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 브랜드 명 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateBndNm (GoodsBulkUploadPO po ) {
		String bndNm = null;
		String msg = "";
		String key = message.getMessage("column.bnd_nm" );

		// NotNull
		bndNm = po.getBndNm();
		msg = ValidationUtil.notNull(bndNm, key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		po.setBndNm(bndNm.trim());
		Long bndNo = goodsBulkUploadDao.checkBndNm(po);

		if( bndNo ==  null) {
			msg = String.format("<b>[%s]</b> 사용할 수 없음", key);
			setFailMsg (po, msg );
			return false;
		} else {
			po.setBndNo(bndNo);
		}

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsValidator.java
	 * - 작성일	: 2021. 2. 8.
	 * - 작성자 	: valfac
	 * - 설명 	: 펫 구분 코드 유효성 체크
	 * </pre>
	 *
	 * @param po
	 */
	public boolean validatePetGbNm(GoodsBulkUploadPO po ) {
		String petGbNm = null;
		String msg = "";
		String key = "애완동물 종류";

		petGbNm = po.getPetGbNm();

		if(StringUtil.isNotBlank(petGbNm)) {
			List<CodeDetailVO> details = cacheService.listCodeCache(AdminConstants.PET_GB, true, null, null, null, null, null);
			Optional<CodeDetailVO> optional = details.stream().filter(d -> po.getPetGbNm().equals(d.getDtlNm())).findFirst();
			if(optional.isPresent()) {
				CodeDetailVO codeDetailVO = optional.get();
				po.setPetGbCd(codeDetailVO.getDtlCd());
				return true;
			} else {
				msg = String.format("<b>[%s]</b> 사용할 수 없음", key);
				setFailMsg (po, msg );
				return false;
			}
		}
		setFailMsg (po, String.format("<b>[%s]</b> 정보 없음", key));
		return false;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명			: 전시분류 번호 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateDispClsfNo (GoodsBulkUploadPO po ) {
		String msg = "";
		String key = message.getMessage("column.disp_clsf_no" );

		if (StringUtils.isEmpty(po.getDispClsfNos())) {
			msg = String.format("<b>[%s]</b> 필수입력 항목", key);
			setFailMsg (po, msg );

			return false;
		}

		List<DisplayGoodsPO> displayGoodsPOList = null;
		displayGoodsPOList = getDisplayGoodsPOList(po.getDispClsfNos());

		// 업체에 할당된 전시분류번호 조회
		CompanySO company = new CompanySO();
		company.setCompNo(po.getCompNo());
		List<DisplayCategoryVO> compDispClsfNoArray = companyDao.pageCompDispMap(company);

		if (! isValidDispClsfNo(displayGoodsPOList, compDispClsfNoArray)) {
			msg = String.format("<b>[%s]</b> 사용할 수 없음", key);
			setFailMsg (po, msg );

			return false;
		}

		return true;
	}

	private boolean isValidDispClsfNo(List<DisplayGoodsPO> displayGoodsPOList, List<DisplayCategoryVO> compDispClsfNoArray) {
		List<Long> compDispClsfNos = new ArrayList<>();

		// 업체에 매핑된 전시분류번호를 모아놓음
		for (DisplayCategoryVO compDispClsf : compDispClsfNoArray) {
			compDispClsfNos.add(compDispClsf.getDispClsfNo());
		}

		boolean validDispClsfNo = true;
		for (DisplayGoodsPO dispGoodsPO : displayGoodsPOList) {
			validDispClsfNo = compDispClsfNos.contains(dispGoodsPO.getDispClsfNo());

			if (! validDispClsfNo) {
				break;
			}
		}

		return validDispClsfNo;
	}

	private List<DisplayGoodsPO> getDisplayGoodsPOList(String stDispClsfNosArray) {
		List<DisplayGoodsPO> displayGoodsPOList = new ArrayList<>();

		String[] stDispClsfNos = StringUtils.split(stDispClsfNosArray, AdminConstants.GOODS_BULK_CARET_DELIMETER);

		for(String dispClsfNosArray : stDispClsfNos) {
			String[] dispClsfNos = Arrays.stream(StringUtils.split(StringUtils.deleteWhitespace(dispClsfNosArray), AdminConstants.GOODS_BULK_COMMA_DELIMETER)).distinct().toArray(String[]::new);

			for(int idx = 0, length = dispClsfNos.length; idx < length; idx++) {
				DisplayGoodsPO displayGoods = new DisplayGoodsPO();
				displayGoods.setDispClsfNo(Long.parseLong(StringUtils.trim(dispClsfNos[idx])));
				displayGoods.setDispPriorRank(idx + 1L);
				displayGoods.setDlgtDispYn(idx == 0 ? CommonConstants.COMM_YN_Y : CommonConstants.COMM_YN_N);

				displayGoodsPOList.add(displayGoods);
			}
		}

		return displayGoodsPOList;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 원산지 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateCtrOrgNm (GoodsBulkUploadPO po ) {
		String ctrOrgNm = null;
		String msg = "";
		String key = message.getMessage("column.ctr_org" );

		ctrOrgNm = po.getCtrOrgNm();

		// NotNull
		msg = ValidationUtil.notNull(ctrOrgNm, key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		List<CodeDetailVO> details = cacheService.listCodeCache("ORIGIN_CD", true, null, null, null, null, null);
		Optional<CodeDetailVO> optional = details.stream().filter(d -> po.getCtrOrgNm().trim().equals(d.getDtlNm())).findFirst();
		if(optional.isPresent()) {
			CodeDetailVO codeDetailVO = optional.get();
			po.setCtrOrg(codeDetailVO.getDtlNm());
		} else {
			msg = String.format("<b>[%s]</b> 사용할 수 없음", key);
			setFailMsg (po, msg );
			return false;
		}

		return true;
	}

	public boolean validateCtrOrg (GoodsBulkUploadPO po ) {
		String ctrOrg = null;
		String msg = "";
		String key = message.getMessage("column.ctr_org" );

		ctrOrg = po.getCtrOrg();

		// NotNull
		msg = ValidationUtil.notNull(ctrOrg, key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		return true;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 제조사 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateMmft (GoodsBulkUploadPO po ) {
		String mmft = null;
		String msg = "";
		String key = message.getMessage("column.mmft" );

		mmft = po.getMmft();

		// NotNull
		msg = ValidationUtil.notBlank(mmft, key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 수입사 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateImporter(GoodsBulkUploadPO po) {
		String importer = null;
		String msg = "";
		String key = message.getMessage("column.importer" );

		importer = po.getImporter();

		// NotNull
		msg = ValidationUtil.notNull(importer, key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		return true;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 과세 구분코드 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateTaxGbCd (GoodsBulkUploadPO po ) {
		String taxGbCd = null;
		String msg = "";
		String key = message.getMessage("column.tax_gb_cd" );

		taxGbCd = po.getTaxGbCd();

		// NotNull
		msg = ValidationUtil.notNull(taxGbCd, key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		// Code
		String[] codes = getGroupCode(AdminConstants.TAX_GB );
		msg = ValidationUtil.selective(taxGbCd.trim(), key, codes );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		po.setTaxGbCd(taxGbCd.trim());

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 과세 구분명 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateTaxGbNm(GoodsBulkUploadPO po) {
		String taxGbNm = null;
		String msg = "";
		String key = message.getMessage("column.tax_gb_cd" );

		taxGbNm = po.getTaxGbNm();

		// NotNull
		msg = ValidationUtil.notNull(taxGbNm, key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		List<CodeDetailVO> details = cacheService.listCodeCache(AdminConstants.TAX_GB, true, null, null, null, null, null);
		Optional<CodeDetailVO> optional = details.stream().filter(d -> po.getTaxGbNm().trim().equals(d.getDtlNm())).findFirst();
		if(optional.isPresent()) {
			CodeDetailVO codeDetailVO = optional.get();
			po.setTaxGbCd(codeDetailVO.getDtlCd());
		} else {
			msg = String.format("<b>[%s]</b> 사용할 수 없음", key);
			setFailMsg (po, msg );
			return false;
		}

		return true;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명			: 노출여부 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateShowYn (GoodsBulkUploadPO po ) {
		String showYn = null;
		String msg = "";
		String key = message.getMessage("column.show_yn" );

		showYn = po.getShowYn();

		// NotNull
		msg = ValidationUtil.notBlank(showYn, key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		// Code
		String[] codes = getGroupCode(AdminConstants.COMM_YN );
		msg = ValidationUtil.selective(showYn.trim().toUpperCase(), key, codes );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		po.setShowYn(showYn.trim().toUpperCase());

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2021. 2. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 웹 모바일 구분코드 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateWebMobileGbNm (GoodsBulkUploadPO po ) {
		String webMobileGbNm = null;
		String msg = "";
		String key = message.getMessage("column.web_mobile_gb_cd" );

		webMobileGbNm = po.getWebMobileGbNm();

		// NotNull
		msg = ValidationUtil.notNull(webMobileGbNm, key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		// Code
		List<CodeDetailVO> details = cacheService.listCodeCache(AdminConstants.WEB_MOBILE_GB, true, null, null, null, null, null);
		Optional<CodeDetailVO> optional = details.stream().filter(d -> d.getDtlNm().equals(po.getWebMobileGbNm().trim().toUpperCase())).findFirst();
		if(optional.isPresent()) {
			CodeDetailVO codeDetailVO = optional.get();
			po.setWebMobileGbCd(codeDetailVO.getDtlCd());
		} else {
			msg = String.format("<b>[%s]</b> 사용할 수 없음", key);
			setFailMsg (po, msg );
			return false;
		}

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명			: 웹 모바일 구분코드 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateWebMobileGbCd (GoodsBulkUploadPO po ) {
		String webMobileGbCd = null;
		String msg = "";
		String key = message.getMessage("column.web_mobile_gb_cd" );

		webMobileGbCd = po.getWebMobileGbCd();

		// NotNull
		msg = ValidationUtil.notNull(webMobileGbCd, key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		// Code
		String[] codes = getGroupCode(AdminConstants.WEB_MOBILE_GB );
		msg = ValidationUtil.selective(webMobileGbCd.trim().toUpperCase(), key, codes );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		po.setWebMobileGbCd(webMobileGbCd.trim().toUpperCase());

		return true;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명			: 업체 배송정책번호 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateDlvrcPlcNo (GoodsBulkUploadPO po ) {
		Long dlvrcPlcNo = null;
		String msg = "";
		String key = message.getMessage("column.dlvrc_plc_no" );

		dlvrcPlcNo = po.getDlvrcPlcNo();

		DeliveryChargePolicyPO dcp = new DeliveryChargePolicyPO();
		dcp.setCompNo(po.getCompNo());
		dcp.setDlvrcPlcNo(dlvrcPlcNo);

		if(goodsBulkUploadDao.checkDlvrcPlcNo(dcp) <= 0 ) {
			msg = String.format("<b>[%s]</b> 잘못된 배송정책 번호 : [%s]", key, (StringUtil.isEmpty(dlvrcPlcNo))? "없음": dlvrcPlcNo);
			setFailMsg (po, msg );
			return false;
		}

		return true;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명			: 무료 배송여부 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateFreeDlvrYn (GoodsBulkUploadPO po ) {
		String freeDlvrYn = null;
		String msg = "";
		String key = message.getMessage("column.free_dlvr_yn" );

		freeDlvrYn = po.getFreeDlvrYn();

		// NotNull
		msg = ValidationUtil.notNull(freeDlvrYn, key );
		if(StringUtil.isNotEmpty(msg) ) {
			freeDlvrYn = AdminConstants.COMM_YN_N;
			po.setFreeDlvrYn(freeDlvrYn );
		}

		// Code
		String[] codes = getGroupCode(AdminConstants.COMM_YN );
		msg = ValidationUtil.selective(freeDlvrYn.trim().toUpperCase(), key, codes );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		po.setFreeDlvrYn(freeDlvrYn.trim().toUpperCase());

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명			: 반품 가능여부 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateRtnPsbYn (GoodsBulkUploadPO po ) {
		String rtnPsbYn = null;
		String msg = "";
		String key = message.getMessage("column.rtn_psb_yn" );

		rtnPsbYn = po.getRtnPsbYn();

		// NotNull
		msg = ValidationUtil.notNull(rtnPsbYn, key );
		if(StringUtil.isNotEmpty(msg) ) {
			rtnPsbYn = AdminConstants.COMM_YN_N;
			po.setRtnPsbYn(rtnPsbYn );
		}

		// Code
		String[] codes = getGroupCode(AdminConstants.COMM_YN );
		msg = ValidationUtil.selective(rtnPsbYn.trim().toUpperCase(), key, codes );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		po.setRtnPsbYn(rtnPsbYn.trim().toUpperCase());

		return true;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명			: 재고 관리여부 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateStkMngYn (GoodsBulkUploadPO po ) {
		String stkMngYn = null;
		String msg = "";
		String key = message.getMessage("column.stk_mng_yn" );

		stkMngYn = po.getStkMngYn();

		// NotNull
		msg = ValidationUtil.notBlank(stkMngYn, key );
		if(StringUtil.isNotEmpty(msg) ) {
			//stkMngYn = AdminConstants.COMM_YN_N;
			//po.setStkMngYn(stkMngYn );
			setFailMsg (po, msg );
			return false;
		}

		// Code
		String[] codes = getGroupCode(AdminConstants.COMM_YN );
		msg = ValidationUtil.selective(stkMngYn.trim().toUpperCase(), key, codes );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		po.setStkMngYn(stkMngYn.trim().toUpperCase());

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 23.
	 * - 작성자		: valueFactory
	 * - 설명		: 기본 웹 재고 수량 검사, 재고관리여부 Y 일 때 필수
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateWebStkQty (GoodsBulkUploadPO po ) {
		boolean isValid = true;
		Long webStkQty = null;
		String msg = "";
		String key = message.getMessage("column.web_stk_qty" );

		webStkQty = po.getWebStkQty();

		if (StringUtils.equalsIgnoreCase(CommonConstants.COMM_YN_Y, po.getStkMngYn())
				&& (StringUtil.isEmpty(webStkQty) || webStkQty < 0 )) {
			// NotNull
			msg = String.format("<b>[%s]</b> 체크", key);
			setFailMsg (po, msg );
			isValid = false;
		}

		return isValid;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 샵링커 전송 여부 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateShoplinkerSndYn(GoodsBulkUploadPO po) {
		String shoplinkerSndYn = null;
		String msg = "";
		String key = message.getMessage("column.goods.shoplinkerSndYn" );
		shoplinkerSndYn = po.getShoplinkerSndYn();

		// NotNull
		msg = ValidationUtil.notBlank(shoplinkerSndYn, key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}
		// Code
		String[] codes = getGroupCode(AdminConstants.COMM_YN );
		msg = ValidationUtil.selective(shoplinkerSndYn.trim().toUpperCase(), key, codes );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		po.setShoplinkerSndYn(shoplinkerSndYn.trim().toUpperCase());

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 성분 정보 연동 여부 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateIgdtInfoLnkYn(GoodsBulkUploadPO po) {
		String igdtInfoLnkYn = null;
		String msg = "";
		String key = message.getMessage("column.goods.twc.igdtInfoLnkYn" );
		igdtInfoLnkYn = po.getIgdtInfoLnkYn();
		// NotNull
		msg = ValidationUtil.notBlank(igdtInfoLnkYn, key );
		if(StringUtil.isNotEmpty(msg) ) {
			//igdtInfoLnkYn = AdminConstants.COMM_YN_N;
			//po.setIgdtInfoLnkYn(igdtInfoLnkYn );
			setFailMsg (po, msg );
			return false;
		}

		// Code
		String[] codes = getGroupCode(AdminConstants.COMM_YN );
		msg = ValidationUtil.selective(igdtInfoLnkYn.trim().toUpperCase(), key, codes );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		po.setIgdtInfoLnkYn(igdtInfoLnkYn.trim().toUpperCase());

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세설명 [PC] 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateContent(GoodsBulkUploadPO po) {
		String content = null;
		String msg = "";
		String key = message.getMessage("column.goods_content_pc" );

		if(StringUtil.isNotEmpty(po.getWebMobileGbCd())) {
			if(po.getWebMobileGbCd().equals(AdminConstants.WEB_MOBILE_GB_20)) {
				content = po.getContentMobile();
			} else {
				content = po.getContentPc();
				// NotNull
				msg = ValidationUtil.notBlank(content, key );
				if(StringUtil.isNotEmpty(msg) ) {
					setFailMsg (po, msg );
					return false;
				}
			}
		}

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명			: 단품 관리여부 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateItemMngYn (GoodsBulkUploadPO po ) {
		String itemMngYn = null;
		String msg = "";
		String key = message.getMessage("column.item_mng_yn" );

		itemMngYn = po.getItemMngYn();

		// NotNull
		msg = ValidationUtil.notNull(itemMngYn, key );
		if(StringUtil.isNotEmpty(msg) ) {
			itemMngYn = AdminConstants.COMM_YN_N;
			po.setItemMngYn(itemMngYn );
		}

		// Code
		String[] codes = getGroupCode(AdminConstants.COMM_YN );
		msg = ValidationUtil.selective(itemMngYn.trim().toUpperCase(), key, codes );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		po.setItemMngYn(itemMngYn.trim().toUpperCase());

		return true;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 23.
	 * - 작성자		: valueFactory
	 * - 설명			: 판매가 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateSaleAmt (GoodsBulkUploadPO po ) {
		Long saleAmt = null;
		String msg = "";
		String key = message.getMessage("column.sale_prc" );

		saleAmt = po.getSaleAmt();

		// NotNull
		if(StringUtil.isEmpty(saleAmt) || saleAmt < 0 ) {
			msg = String.format("<b>[%s]</b> 잘못된 입력값", key);
			setFailMsg (po, msg );
			return false;
		}

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 23.
	 * - 작성자		: valueFactory
	 * - 설명			: 공급금액 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateSplAmt (GoodsBulkUploadPO po ) {
		Long splAmt = null;
		String msg = "";
		String key = message.getMessage("column.spl_prc" );

		splAmt = po.getSplAmt();

		// NotNull
		if(StringUtil.isEmpty(splAmt) || splAmt < 0 ) {
			msg = String.format("<b>[%s]</b> 잘못된 입력값", key);
			setFailMsg (po, msg );
			return false;
		}

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 정상가 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateOrgSaleAmt(GoodsBulkUploadPO po) {
		Long saleAmt = null;
		String msg = "";
		String key = message.getMessage("column.goods.org_sale_prc" );

		saleAmt = po.getOrgSaleAmt();

		// NotNull
		if(StringUtil.isEmpty(saleAmt) || saleAmt < 0 ) {
			msg = String.format("<b>[%s]</b> 잘못된 입력값", key);
			setFailMsg (po, msg );
			return false;
		}

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 23.
	 * - 작성자		: valueFactory
	 * - 설명			: 원가 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateCostAmt(/* GoodsBulkUploadPO po */) {
		//Long costAmt = null;
		//String msg = "";
		//String key = message.getMessage("column.cost_prc" );

		//costAmt = po.getCostAmt();

		// NotNull
		/* COST_AMT 컬럼 삭제 로 인해 주석 처리함
		 * if(StringUtil.isEmpty(costAmt) || costAmt < 0 ) {
			msg = String.format("잘못된 [%s]", key);
			setFailMsg (po, msg );
			return false;
		}*/

		return true;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 23.
	 * - 작성자		: valueFactory
	 * - 설명			: 수수료율 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateCmsRate (GoodsBulkUploadPO po ) {
		Double cmsRate = null;
		String msg = "";
		String key = message.getMessage("column.cms_rate" );

		cmsRate = po.getCmsRate();

		// NotNull
		if(cmsRate == null ) {
			msg = String.format("<b>[%s]</b> 잘못된 입력값", key);
			setFailMsg (po, msg );
			return false;
		}

		msg = ValidationUtil.digitRange(cmsRate, key, 0, 100 );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		return true;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 23.
	 * - 작성자		: valueFactory
	 * - 설명			: 고시 아이디 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateNtfId (GoodsBulkUploadPO po ) {
		String ntfId = null;
		String msg = "";
		String key = message.getMessage("column.goods.ntf_id" );

		ntfId = po.getNtfId();

		// NotNull
		msg = ValidationUtil.notNull(ntfId, key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		// Code
		List<NotifyItemVO> ntfList = goodsBulkUploadDao.checkNtfId(ntfId );
		if(ntfList == null || ntfList.isEmpty()) {
			msg = String.format("<b>[%s]</b> 잘못된 입력값", key);
			setFailMsg (po, msg );
			return false;
		}

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2021. 2. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 단품 속성 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateAttr(GoodsBulkUploadPO po) {
		String msg = "";
		BeanUtilsBean.getInstance().getConvertUtils().register(false, true, 0 );

		/** 속성 명 */
		String attr1Nm = po.getAttr1Nm();
		String attr1Val = po.getAttr1Val();

		msg = "[속성1] 필수";
		// NotNull
		msg = ValidationUtil.notBlank(attr1Nm, msg );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		//속성명은 있는데 속성값이 없다면 에러
		if(StringUtil.isBlank(attr1Val)) {
			msg = "[속성1] 체크";
			setFailMsg (po, msg);
			return false;
			
		} else {
			if (StringUtils.contains(attr1Val.trim(),  AdminConstants.GOODS_BULK_ATTR_VAL_DELIMETER)) {
				setFailMsg (po, "[" + message.getMessage("column.attr1_val" ) + "] 값에 특수문자 \"/\"는 사용할 수 없습니다." );
				return false;
			}
		}

		String attr2Nm = po.getAttr2Nm();
		String attr3Nm = po.getAttr3Nm();
		String attr4Nm = po.getAttr4Nm();
		String attr5Nm = po.getAttr5Nm();
		Long attr1No = null;
		Long attr2No = null;
		Long attr3No = null;
		Long attr4No = null;
		Long attr5No = null;
		/** 속성 값 */

		String attr2Val = po.getAttr2Val();
		String attr3Val = po.getAttr3Val();
		String attr4Val = po.getAttr4Val();
		String attr5Val = po.getAttr5Val();

		boolean flag = true, flag1 = true, flag2 = true, flag3 = true, flag4 = true, flag5 = true;

		//다른 속성이 있는데 앞 속성이 없다면 에러
		if(
				(StringUtil.isEmpty(attr1Nm) && (StringUtil.isNotEmpty(attr2Nm) || StringUtil.isNotEmpty(attr3Nm) || StringUtil.isNotEmpty(attr4Nm) || StringUtil.isNotEmpty(attr5Nm)))
						|| ((StringUtil.isNotEmpty(attr1Nm) && StringUtil.isEmpty(attr2Nm)) && (StringUtil.isNotEmpty(attr3Nm) || StringUtil.isNotEmpty(attr4Nm) || StringUtil.isNotEmpty(attr5Nm)))
						|| ((StringUtil.isNotEmpty(attr1Nm) && StringUtil.isEmpty(attr2Nm) && StringUtil.isEmpty(attr3Nm)) && (StringUtil.isNotEmpty(attr4Nm) || StringUtil.isNotEmpty(attr5Nm)))
						|| ((StringUtil.isNotEmpty(attr1Nm) && StringUtil.isEmpty(attr2Nm) && StringUtil.isEmpty(attr3Nm) && StringUtil.isEmpty(attr4Nm)) && (StringUtil.isNotEmpty(attr5Nm)))
		) {
			msg = "[속성] 값 입력시 앞 속성은 필수";
			setFailMsg (po, msg);
			flag = false;
		}

		//속성명은 있는데 속성값이 없다면 에러
		if(StringUtil.isEmpty(attr2Nm) && StringUtil.isEmpty(attr2Val)) {
			flag2 = false;
		} else if(StringUtil.isNotEmpty(attr2Nm) && StringUtil.isEmpty(attr2Val)
				|| StringUtil.isNotEmpty(attr1Val) && StringUtil.isEmpty(attr1Nm) ) {
			msg = "[속성2] 체크";
			setFailMsg (po, msg);
			flag = false;
			flag2 = false;
		} else {
			if (StringUtils.contains(attr2Val.trim(),  AdminConstants.GOODS_BULK_ATTR_VAL_DELIMETER)) {
				setFailMsg (po, "[" + message.getMessage("column.attr2_val" ) + "] 값에 특수문자 \"/\"는 사용할 수 없습니다." );
				flag = false;
				flag5 = false;
			}
		}

		//속성명은 있는데 속성값이 없다면 에러
		if(StringUtil.isEmpty(attr3Nm) && StringUtil.isEmpty(attr3Val)) {
			flag3 = false;
		} else if(StringUtil.isNotEmpty(attr3Nm) && StringUtil.isEmpty(attr3Val)
				|| StringUtil.isNotEmpty(attr3Val) && StringUtil.isEmpty(attr3Nm) ) {
			msg = "[속성3] 체크";
			setFailMsg (po, msg);
			flag = false;
			flag3 = false;
		} else {
			if (StringUtils.contains(attr3Val.trim(),  AdminConstants.GOODS_BULK_ATTR_VAL_DELIMETER)) {
				setFailMsg (po, "[" + message.getMessage("column.attr3_val" ) + "] 값에 특수문자 \"/\"는 사용할 수 없습니다." );
				flag = false;
				flag5 = false;
			}
		}

		//속성명은 있는데 속성값이 없다면 에러
		if(StringUtil.isEmpty(attr4Nm) && StringUtil.isEmpty(attr4Val)) {
			flag4 = false;
		} else if(StringUtil.isNotEmpty(attr4Nm) && StringUtil.isEmpty(attr4Val)
				|| StringUtil.isNotEmpty(attr4Val) && StringUtil.isEmpty(attr4Nm) ) {
			msg = "[속성4] 체크";
			setFailMsg (po, msg);
			flag = false;
			flag4 = false;
		} else {
			if (StringUtils.contains(attr4Val.trim(),  AdminConstants.GOODS_BULK_ATTR_VAL_DELIMETER)) {
				setFailMsg (po, "[" + message.getMessage("column.attr4_val" ) + "] 값에 특수문자 \"/\"는 사용할 수 없습니다." );
				flag = false;
				flag5 = false;
			}
		}

		//속성명은 있는데 속성값이 없다면 에러
		if(StringUtil.isEmpty(attr5Nm) && StringUtil.isEmpty(attr5Val)) {
			flag5 = false;
		} else if(StringUtil.isNotEmpty(attr5Nm) && StringUtil.isEmpty(attr5Val)
				|| StringUtil.isNotEmpty(attr5Val) && StringUtil.isEmpty(attr5Nm) ) {
			msg = "[속성5] 체크";
			setFailMsg (po, msg);
			flag = false;
			flag5 = false;
		} else {
			if (StringUtils.contains(attr5Val.trim(),  AdminConstants.GOODS_BULK_ATTR_VAL_DELIMETER)) {
				setFailMsg (po, "[" + message.getMessage("column.attr5_val" ) + "] 값에 특수문자 \"/\"는 사용할 수 없습니다." );
				flag = false;
				flag5 = false;
			}
		}

		//setFailMsg (po, message.getMessage("column.attr1_val" ) + "의  값에 특수문자 \"/\"는 사용할 수 없습니다." );
		if(flag) {
			//중복 속성이 있는지 체크
			List<String> dupList = new ArrayList<>();

			if(flag1) {
				String attrNm = attr1Nm.trim();
				dupList.add(attrNm.trim());
			}

			if(flag2) {
				String attrNm = attr2Nm.trim();
				if(dupList.stream().filter(s -> s.equals(attrNm)).findAny().orElse(null) == null) {
					dupList.add(attrNm);
				} else {
					setFailMsg (po, String.format("<b>[%s]</b> 중복", message.getMessage("column.attr2_no" )));
					flag2 = false;
				}
			}

			if(flag3) {
				String attrNm = attr3Nm.trim();
				if(dupList.stream().filter(s -> s.equals(attrNm)).findAny().orElse(null) == null) {
					dupList.add(attrNm);
				} else {
					setFailMsg (po, String.format("<b>[%s]</b> 중복", message.getMessage("column.attr3_no" )));
					flag3 = false;
				}
			}

			if(flag4) {
				String attrNm = attr4Nm.trim();
				if(dupList.stream().filter(s -> s.equals(attrNm)).findAny().orElse(null) == null) {
					dupList.add(attrNm);
				} else {
					setFailMsg (po, String.format("<b>[%s]</b> 중복", message.getMessage("column.attr4_no" )));
					flag4 = false;
				}
			}

			if(flag5) {
				String attrNm = attr5Nm.trim();
				if(dupList.stream().filter(s -> s.equals(attrNm)).findAny().orElse(null) == null) {
					dupList.add(attrNm);
				} else {
					setFailMsg (po, String.format("<b>[%s]</b> 중복", message.getMessage("column.attr5_no" )));
					flag4 = false;
				}
			}

			if(flag1) {
				attr1No = goodsBulkUploadDao.getAttributeByNm(attr1Nm);
				po.setAttr1No(attr1No);
				if(attr1No == null) {
					setFailMsg (po, String.format("<b>[%s]</b> 해당 속성 없음", message.getMessage("column.attr1_no" )));
					flag1 = false;
				}
			}

			if(flag2) {
				attr2No = goodsBulkUploadDao.getAttributeByNm(attr2Nm);
				po.setAttr2No(attr2No);
				if(attr2No == null) {
					setFailMsg (po, String.format("<b>[%s]</b> 해당 속성 없음", message.getMessage("column.attr2_no" )));
					flag2 = false;
				}
			}

			if(flag3) {
				attr3No = goodsBulkUploadDao.getAttributeByNm(attr3Nm);
				po.setAttr3No(attr3No);
				if(attr3No == null) {
					setFailMsg (po, String.format("<b>[%s]</b> 해당 속성 없음", message.getMessage("column.attr3_no" )));
					flag3 = false;
				}
			}

			if(flag4) {
				attr4No = goodsBulkUploadDao.getAttributeByNm(attr4Nm);
				po.setAttr4No(attr4No);
				if(attr4No == null) {
					setFailMsg (po, String.format("<b>[%s]</b> 해당 속성 없음", message.getMessage("column.attr4_no" )));
					flag4 = false;
				}
			}

			if(flag5) {
				attr5No = goodsBulkUploadDao.getAttributeByNm(attr5Nm);
				po.setAttr5No(attr5No);
				if(attr5No == null) {
					setFailMsg (po, String.format("<b>[%s]</b> 해당 속성 없음", message.getMessage("column.attr5_no" )));
					flag5 = false;
				}
			}
		}

		return flag;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2016. 5. 23.
	 * - 작성자		: valueFactory
	 * - 설명			: 단품 속성 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateAttribute (GoodsBulkUploadPO po ) {
		String msg = "";
		BeanUtilsBean.getInstance().getConvertUtils().register(false, true, 0 );

		String itemMngYn = null;
		itemMngYn = po.getItemMngYn();
		if(AdminConstants.COMM_YN_N.equals(itemMngYn) || StringUtil.isNotEmpty(po.getGoodsId()) ) {	// 단품관리 하지 않음
			return true;
		}

		String attr1No = Long.toString(po.getAttr1No());
		String attr1Nm = null;
		String attr1Vals = null;
		String attr2No = Long.toString(po.getAttr2No());
		String attr2Nm = null;
		String attr2Vals = null;
		String attr3No = Long.toString(po.getAttr3No());
		String attr3Nm = null;
		String attr3Vals = null;
		String attr4No = Long.toString(po.getAttr4No());
		String attr4Nm = null;
		String attr4Vals = null;
		String attr5No = Long.toString(po.getAttr5No());
		String attr5Nm = null;
		String attr5Vals = null;

//		attr1Nm = po.getAttr1Nm();
//		attr2Nm = po.getAttr2Nm();
//		attr3Nm = po.getAttr3Nm();
//		attr4Nm = po.getAttr4Nm();
//		attr5Nm = po.getAttr5Nm();

		List<AttributePO> attributePOList = new ArrayList<>();
		List<AttributeValuePO> attributeValuePOList = new ArrayList<>();
		List<ItemAttrHistPO> itemAttrHistPOList = new ArrayList<>();

		// 첫번째 속성은 반드시 존재 해야함
		msg = ValidationUtil.validInt(attr1No, message.getMessage("column.attr1_no" ) );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		// 1번 속성
		if(StringUtil.isNotEmpty(attr1No) ) {
			//attr1Vals = po.getAttr1Vals();
			msg = ValidationUtil.notNull(attr1Vals, message.getMessage("column.attr1_val" ) );
			if(StringUtil.isNotEmpty(msg) ) {
				setFailMsg (po, msg );
				return false;
			}

			AttributeSO so = new AttributeSO();
			so.setAttrNo(Long.parseLong(attr1No));
			AttributeVO vo = itemDao.getAttribute(so);
			if (vo == null) {
				setFailMsg (po, message.getMessage("column.attr1_no" ) + "의 데이터가 없습니다." );
				return false;
			}

			if (StringUtils.contains(attr1Vals,  AdminConstants.GOODS_BULK_ATTR_VAL_DELIMETER)) {
				setFailMsg (po, message.getMessage("column.attr1_val" ) + "의  값에 특수문자 \"/\"는 사용할 수 없습니다." );
				return false;
			}

			po.setAttr1Nm(vo.getAttrNm());
			AttributePO attributePO = new AttributePO();
			attributePO.setAttrNo(vo.getAttrNo() );
			attributePO.setAttrNm(vo.getAttrNm() );
			attributePO.setUseYn(AdminConstants.COMM_YN_Y );
			attributePOList.add(attributePO );

			String[] attrVal = StringUtil.split(attr1Vals, "," );
			if(attrVal != null && attrVal.length > 0 ) {
				for(int i = 0; i < attrVal.length; i++ ) {
					AttributeValuePO attributeValuePO = new AttributeValuePO();
					attributeValuePO.setAttrNo(vo.getAttrNo() );
					attributeValuePO.setAttrValNo((i + 1L) );
					attributeValuePO.setAttrVal(attrVal[i] );
					attributeValuePO.setUseYn(AdminConstants.COMM_YN_Y );
					attributeValuePOList.add(attributeValuePO );

					// itemAttrHistPOList
					ItemAttrHistPO itemAttrHistPO = new ItemAttrHistPO();
					itemAttrHistPO.setAttr1No(vo.getAttrNo() );
					itemAttrHistPO.setAttr1Nm(attr1Nm );
					itemAttrHistPO.setAttr1ValNo((i + 1L) );
					itemAttrHistPO.setAttr1Val(attrVal[i] );
					itemAttrHistPO.setUseYn(AdminConstants.COMM_YN_Y );
					itemAttrHistPOList.add(itemAttrHistPO );

				}
			}
		}

		// 2번 속성
		if(StringUtil.isNotEmpty(attr2No) ) {
			msg = ValidationUtil.validInt(attr2No, message.getMessage("column.attr2_no" ) );
			if(StringUtil.isNotEmpty(msg) ) {
				setFailMsg (po, msg );
				return false;
			}

			//attr2Vals = po.getAttr2Vals();
			msg = ValidationUtil.notNull(attr2Vals, message.getMessage("column.attr2_val" ) );
			if(StringUtil.isNotEmpty(msg) ) {
				setFailMsg (po, msg );
				return false;
			}

			AttributeSO so = new AttributeSO();
			so.setAttrNo(Long.parseLong(attr2No));
			AttributeVO vo = itemDao.getAttribute(so);
			if (vo == null) {
				setFailMsg (po, message.getMessage("column.attr2_no" ) + "의 데이터가 없습니다." );
				return false;
			}

			if (StringUtils.contains(attr2Vals,  AdminConstants.GOODS_BULK_ATTR_VAL_DELIMETER)) {
				setFailMsg (po, message.getMessage("column.attr2_val" ) + "의  값에 특수문자 \"/\"는 사용할 수 없습니다." );
				return false;
			}

			po.setAttr2Nm(vo.getAttrNm());
			AttributePO attributePO = new AttributePO();
			attributePO.setAttrNo(vo.getAttrNo() );
			attributePO.setAttrNm(vo.getAttrNm() );
			attributePO.setUseYn(AdminConstants.COMM_YN_Y );
			attributePOList.add(attributePO );

			String[] attrVal = StringUtil.split(attr2Vals, "," );
			if(attrVal != null && attrVal.length > 0 ) {
				List<ItemAttrHistPO> temp = new ArrayList<>();
				temp.addAll(itemAttrHistPOList );
				itemAttrHistPOList.clear();

				for(int i = 0; i < attrVal.length; i++ ) {
					AttributeValuePO attributeValuePO = new AttributeValuePO();
					attributeValuePO.setAttrNo(vo.getAttrNo() );
					attributeValuePO.setAttrValNo((i + 1L) );
					attributeValuePO.setAttrVal(attrVal[i] );
					attributeValuePO.setUseYn(AdminConstants.COMM_YN_Y );
					attributeValuePOList.add(attributeValuePO );

					// itemAttrHistPOList
					for (ItemAttrHistPO hist : temp ) {
						ItemAttrHistPO dest = new ItemAttrHistPO();
						try {
							BeanUtils.copyProperties(dest, hist );
						} catch (IllegalAccessException | InvocationTargetException e) {
							log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
							throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
						}

						dest.setAttr2No(vo.getAttrNo() );
						dest.setAttr2Nm(attr2Nm );
						dest.setAttr2ValNo((i + 1L) );
						dest.setAttr2Val(attrVal[i] );
						itemAttrHistPOList.add(dest );
					}
				}
			}
		}

		// 3번 속성
		if(StringUtil.isNotEmpty(attr3No) ) {
			msg = ValidationUtil.validInt(attr3No, message.getMessage("column.attr3_no" ) );
			if(StringUtil.isNotEmpty(msg) ) {
				setFailMsg (po, msg );
				return false;
			}

			//attr3Vals = po.getAttr3Vals();
			msg = ValidationUtil.notNull(attr3Vals, message.getMessage("column.attr3_val" ) );
			if(StringUtil.isNotEmpty(msg) ) {
				setFailMsg (po, msg );
				return false;
			}

			AttributeSO so = new AttributeSO();
			so.setAttrNo(Long.parseLong(attr3No));
			AttributeVO vo = itemDao.getAttribute(so);
			if (vo == null) {
				setFailMsg (po, message.getMessage("column.attr3_no" ) + "의 데이터가 없습니다." );
				return false;
			}

			if (StringUtils.contains(attr3Vals,  AdminConstants.GOODS_BULK_ATTR_VAL_DELIMETER)) {
				setFailMsg (po, message.getMessage("column.attr3_val" ) + "의  값에 특수문자 \"/\"는 사용할 수 없습니다." );
				return false;
			}

			po.setAttr3Nm(vo.getAttrNm());
			AttributePO attributePO = new AttributePO();
			attributePO.setAttrNo(vo.getAttrNo() );
			attributePO.setAttrNm(vo.getAttrNm() );
			attributePO.setUseYn(AdminConstants.COMM_YN_Y );
			attributePOList.add(attributePO );

			String[] attrVal = StringUtil.split(attr3Vals, "," );
			if(attrVal != null && attrVal.length > 0 ) {
				List<ItemAttrHistPO> temp = new ArrayList<>();
				temp.addAll(itemAttrHistPOList );
				itemAttrHistPOList.clear();

				for(int i = 0; i < attrVal.length; i++ ) {
					AttributeValuePO attributeValuePO = new AttributeValuePO();
					attributeValuePO.setAttrNo(vo.getAttrNo() );
					attributeValuePO.setAttrValNo((i + 1L) );
					attributeValuePO.setAttrVal(attrVal[i] );
					attributeValuePO.setUseYn(AdminConstants.COMM_YN_Y );
					attributeValuePOList.add(attributeValuePO );

					// itemAttrHistPOList
					for (ItemAttrHistPO hist : temp ) {
						ItemAttrHistPO dest = new ItemAttrHistPO();
						try {
							BeanUtils.copyProperties(dest, hist );
						} catch (IllegalAccessException | InvocationTargetException e) {
							log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
							throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
						}

						dest.setAttr3No(vo.getAttrNo() );
						dest.setAttr3Nm(attr3Nm );
						dest.setAttr3ValNo((i + 1L) );
						dest.setAttr3Val(attrVal[i] );
						itemAttrHistPOList.add(dest);
					}
				}
			}
		}

		// 4번 속성
		if(StringUtil.isNotEmpty(attr4No) ) {
			msg = ValidationUtil.validInt(attr4No, message.getMessage("column.attr4_no" ) );
			if(StringUtil.isNotEmpty(msg) ) {
				setFailMsg (po, msg );
				return false;
			}

			//attr4Vals = po.getAttr4Vals();
			msg = ValidationUtil.notNull(attr4Vals, message.getMessage("column.attr4_val" ) );
			if(StringUtil.isNotEmpty(msg) ) {
				setFailMsg (po, msg );
				return false;
			}

			AttributeSO so = new AttributeSO();
			so.setAttrNo(Long.parseLong(attr4No));
			AttributeVO vo = itemDao.getAttribute(so);
			if (vo == null) {
				setFailMsg (po, message.getMessage("column.attr4_no" ) + "의 데이터가 없습니다." );
				return false;
			}

			if (StringUtils.contains(attr4Vals,  AdminConstants.GOODS_BULK_ATTR_VAL_DELIMETER)) {
				setFailMsg (po, message.getMessage("column.attr4_val" ) + "의  값에 특수문자 \"/\"는 사용할 수 없습니다." );
				return false;
			}

			po.setAttr4Nm(vo.getAttrNm());
			AttributePO attributePO = new AttributePO();
			attributePO.setAttrNo(vo.getAttrNo() );
			attributePO.setAttrNm(vo.getAttrNm() );
			attributePO.setUseYn(AdminConstants.COMM_YN_Y );
			attributePOList.add(attributePO );

			String[] attrVal = StringUtil.split(attr4Vals, "," );
			if(attrVal != null && attrVal.length > 0 ) {
				List<ItemAttrHistPO> temp = new ArrayList<>();
				temp.addAll(itemAttrHistPOList );
				itemAttrHistPOList.clear();

				for(int i = 0; i < attrVal.length; i++ ) {
					AttributeValuePO attributeValuePO = new AttributeValuePO();
					attributeValuePO.setAttrNo(vo.getAttrNo() );
					attributeValuePO.setAttrValNo((i + 1L) );
					attributeValuePO.setAttrVal(attrVal[i] );
					attributeValuePO.setUseYn(AdminConstants.COMM_YN_Y );
					attributeValuePOList.add(attributeValuePO );

					// itemAttrHistPOList
					for (ItemAttrHistPO hist : temp ) {
						ItemAttrHistPO dest = new ItemAttrHistPO();
						try {
							BeanUtils.copyProperties(dest, hist );
						} catch (IllegalAccessException | InvocationTargetException e) {
							log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
							throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
						}
						dest.setAttr4No(vo.getAttrNo());
						dest.setAttr4Nm(attr4Nm );
						dest.setAttr4ValNo((i + 1L) );
						dest.setAttr4Val(attrVal[i] );
						itemAttrHistPOList.add(dest );
					}
				}
			}
		}

		// 5번 속성
		if(StringUtil.isNotEmpty(attr5No) ) {
			msg = ValidationUtil.validInt(attr5No, message.getMessage("column.attr5_no" ) );
			if(StringUtil.isNotEmpty(msg) ) {
				setFailMsg (po, msg );
				return false;
			}

			//attr5Vals = po.getAttr5Vals();
			msg = ValidationUtil.notNull(attr5Vals, message.getMessage("column.attr5_val" ) );
			if(StringUtil.isNotEmpty(msg) ) {
				setFailMsg (po, msg );
				return false;
			}

			AttributeSO so = new AttributeSO();
			so.setAttrNo(Long.parseLong(attr5No));
			AttributeVO vo = itemDao.getAttribute(so);
			if (vo == null) {
				setFailMsg (po, message.getMessage("column.attr5_no" ) + "의 데이터가 없습니다." );
				return false;
			}

			if (StringUtils.contains(attr5Vals,  AdminConstants.GOODS_BULK_ATTR_VAL_DELIMETER)) {
				setFailMsg (po, message.getMessage("column.attr5_val" ) + "에 특수문자 \"/\"는 사용할 수 없습니다." );
				return false;
			}

			po.setAttr5Nm(vo.getAttrNm());
			AttributePO attributePO = new AttributePO();
			attributePO.setAttrNo(vo.getAttrNo() );
			attributePO.setAttrNm(vo.getAttrNm() );
			attributePO.setUseYn(AdminConstants.COMM_YN_Y );
			attributePOList.add(attributePO );

			String[] attrVal = StringUtil.split(attr5Vals, "," );
			if(attrVal != null && attrVal.length > 0 ) {
				List<ItemAttrHistPO> temp = new ArrayList<>();
				temp.addAll(itemAttrHistPOList );
				itemAttrHistPOList.clear();

				for(int i = 0; i < attrVal.length; i++ ) {
					AttributeValuePO attributeValuePO = new AttributeValuePO();
					attributeValuePO.setAttrNo(vo.getAttrNo() );
					attributeValuePO.setAttrValNo((i + 1L) );
					attributeValuePO.setAttrVal(attrVal[i] );
					attributeValuePO.setUseYn(AdminConstants.COMM_YN_Y );
					attributeValuePOList.add(attributeValuePO );

					// itemAttrHistPOList
					for (ItemAttrHistPO hist : temp ) {
						ItemAttrHistPO dest = new ItemAttrHistPO();
						try {
							BeanUtils.copyProperties(dest, hist );
						} catch (IllegalAccessException | InvocationTargetException e) {
							log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
							throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
						}

						dest.setAttr5No(vo.getAttrNo() );
						dest.setAttr5Nm(attr5Nm );
						dest.setAttr5ValNo((i + 1L) );
						dest.setAttr5Val(attrVal[i] );
						itemAttrHistPOList.add(dest );
					}
				}
			}
		}

		po.setAttributePOList(attributePOList );
		po.setAttributeValuePOList(attributeValuePOList );
		po.setItemAttrHistPOList(itemAttrHistPOList );

		return true;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2017. 5. 22.
	 * - 작성자		: hongjun
	 * - 설명			: 이미지1 URL 속성 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateImg1Url (GoodsBulkUploadPO po ) {
		String img1Url = null;
		String msg = "";
		String key = message.getMessage("column.img1_url" );
		img1Url = po.getImg1Url();
		
		
		if("오프라인".equals(po.getWebMobileGbNm())) { // 웹 모바일이 오프라인인 경우 필수값 아님
			return true;
		}
		// NotNull
		msg = ValidationUtil.notBlank(img1Url, key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		if(img1Url.length() > 100) {
			setFailMsg (po, "["+key+"]"+ " 입력값 길이 100자리 초과");
			return false;
		}
	
		return true;
	}

	public boolean validateImgUrl (GoodsBulkUploadPO po ) {
		String img2Url = po.getImg2Url();
		if(StringUtils.isNotEmpty(img2Url) && img2Url.length() > 100) {
			setFailMsg (po, "["+message.getMessage("column.img2_url" )+"]"+ " 입력값 길이 100자리 초과");
			return false;
		}

		String img3Url = po.getImg3Url();
		if(StringUtils.isNotEmpty(img3Url) && img3Url.length() > 100) {
			setFailMsg (po, "["+message.getMessage("column.img3_url" )+"]"+ " 입력값 길이 100자리 초과");
			return false;
		}

		String img4Url = po.getImg4Url();
		if(StringUtils.isNotEmpty(img4Url) && img4Url.length() > 100) {
			setFailMsg (po, "["+message.getMessage("column.img4_url" )+"]"+ " 입력값 길이 100자리 초과");
			return false;
		}

		String img5Url = po.getImg5Url();
		if(StringUtils.isNotEmpty(img5Url) && img5Url.length() > 100) {
			setFailMsg (po, "["+message.getMessage("column.img5_url" )+"]"+ " 입력값 길이 100자리 초과");
			return false;
		}

		String img6Url = po.getImg6Url();
		if(StringUtils.isNotEmpty(img6Url) && img6Url.length() > 100) {
			setFailMsg (po, "["+message.getMessage("column.img6_url" )+"]"+ " 입력값 길이 100자리 초과");
			return false;
		}

		String img7Url = po.getImg7Url();
		if(StringUtils.isNotEmpty(img7Url) && img7Url.length() > 100) {
			setFailMsg (po, "["+message.getMessage("column.img7_url" )+"]"+ " 입력값 길이 100자리 초과");
			return false;
		}

		String img8Url = po.getImg8Url();
		if(StringUtils.isNotEmpty(img8Url) && img8Url.length() > 100) {
			setFailMsg (po, "["+message.getMessage("column.img8_url" )+"]"+ " 입력값 길이 100자리 초과");
			return false;
		}

		String img9Url = po.getImg9Url();
		if(StringUtils.isNotEmpty(img9Url) && img9Url.length() > 100) {
			setFailMsg (po, "["+message.getMessage("column.img9_url" )+"]"+ " 입력값 길이 100자리 초과");
			return false;
		}

		String img10Url = po.getImg10Url();
		if(StringUtils.isNotEmpty(img10Url) && img10Url.length() > 100) {
			setFailMsg (po, "["+message.getMessage("column.img10_url" )+"]"+ " 입력값 길이 100자리 초과");
			return false;
		}

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2021. 2. 26.
	 * - 작성자		: valfac
	 * - 설명		: 배너 속성 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateBannerImgUrl(GoodsBulkUploadPO po ) {
		String imgUrl = null;
		String msg = "";
		String key = message.getMessage("column.bnr_img_path" );
		imgUrl = po.getBannerImgUrl();

		// NotNull
		msg = ValidationUtil.notNull(imgUrl, key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		if(imgUrl.length() > 100) {
			setFailMsg (po, "["+key+"]"+ " 입력값 길이 100자리 초과");
			return false;
		}

		return true;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidator.java
	 * - 작성일		: 2016. 5. 25.
	 * - 작성자		: valueFactory
	 * - 설명			: 공정위 품목군
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateNotify (GoodsBulkUploadPO po ) {
		boolean rtnVal = true;
		String itemVal = null;
		String key = null;
		String msg = "";
		String goodsId = po.getGoodsId();
		String ntfId = po.getNtfId();

		// 성공으로 하고.. 아래 검사시 오류건에 대해서 처리
		po.setSuccessYn(AdminConstants.COMM_YN_Y );

		// 상품정보 검사
		key = message.getMessage("column.goods_id" );
		if(goodsBulkUploadDao.checkGoodsId(goodsId) <= 0 ) {
			msg = String.format("<b>[%s]</b> 잘못된 입력값", key);
			setFailMsg (po, msg );
			return false;
		}

		// 고시정보 검사
		GoodsBulkUploadSO so = new GoodsBulkUploadSO();
		so.setNtfId(ntfId );
		List<NotifyItemVO> notifyItemVOList = goodsBulkUploadDao.listNotifyItem(so );

		int colsCnt = 0;
		if(notifyItemVOList != null && !notifyItemVOList.isEmpty()) {
			colsCnt = notifyItemVOList.size();

			for (int i = 0; i < colsCnt; i++ ) {
				if(i == 0 ) { itemVal = po.getItemVal1(); }
				else if(i == 1 ) { itemVal = po.getItemVal2(); }
				else if(i == 2 ) { itemVal = po.getItemVal3(); }
				else if(i == 3 ) { itemVal = po.getItemVal4(); }
				else if(i == 4 ) { itemVal = po.getItemVal5(); }
				else if(i == 5 ) { itemVal = po.getItemVal6(); }
				else if(i == 6 ) { itemVal = po.getItemVal7(); }
				else if(i == 7 ) { itemVal = po.getItemVal8(); }
				else if(i == 8 ) { itemVal = po.getItemVal9(); }
				else if(i == 9 ) { itemVal = po.getItemVal10(); }
				else if(i == 10 ) { itemVal = po.getItemVal11(); }
				else if(i == 11 ) { itemVal = po.getItemVal12(); }
				else if(i == 12 ) { itemVal = po.getItemVal13(); }
				else if(i == 13 ) { itemVal = po.getItemVal14(); }
				else if(i == 14 ) { itemVal = po.getItemVal15(); }
				else if(i == 15 ) { itemVal = po.getItemVal16(); }
				else if(i == 16 ) { itemVal = po.getItemVal17(); }
				else if(i == 17 ) { itemVal = po.getItemVal18(); }
				else if(i == 18 ) { itemVal = po.getItemVal19(); }
				else if(i == 19 ) { itemVal = po.getItemVal20(); }

				key = notifyItemVOList.get(i).getItemNm();
				// NotNull
				msg = ValidationUtil.notNull(itemVal, key );
				if(StringUtil.isNotEmpty(msg) ) {
					setFailMsg (po, msg );
					rtnVal = false;
				}
			}
		}

		return rtnVal;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidator.java
	 * - 작성일		: 2016. 5. 26.
	 * - 작성자		: valueFactory
	 * - 설명			: 재고 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateStock (GoodsBulkUploadPO po ) {
		boolean rtnVal = true;
		String key = null;
		String msg = "";

		String goodsId = po.getGoodsId();
		//Long itemNo = po.getItemNo();

		// 성공으로 하고.. 아래 검사시 오류건에 대해서 처리
		po.setSuccessYn(AdminConstants.COMM_YN_Y );

		// 상품 재고 정보 조회
		GoodsBaseVO goodsBaseVO = null;
		goodsBaseVO = goodsBulkUploadDao.checkGoodsBase(goodsId );

		key = message.getMessage("column.goods_id" );
		if(goodsBaseVO == null ) {
			msg = String.format("<b>[%s]</b> 잘못된 입력값", key);
			setFailMsg (po, msg );
			return false;
		}

		po.setGoodsNm(goodsBaseVO.getGoodsNm() );

		// 재고 관리 하지 않는 상품
		if(AdminConstants.COMM_YN_N.equals(goodsBaseVO.getStkMngYn()) ) {
			msg = "재고 관리 하지 않음";
			setFailMsg (po, msg );
			return false;
		}

		// 단품명 조회
		ItemVO itemVO = null;
		ItemSO iso = new ItemSO();
		iso.setItemNo(po.getItemNo());
		iso.setGoodsId(po.getGoodsId());
		itemVO = itemDao.getItem(iso);

		key = message.getMessage("column.item_no" );
		if(itemVO == null ) {
			msg = String.format("<b>[%s]</b> 잘못된 입력값", key);
			setFailMsg (po, msg );
			return false;
		}

		po.setItemNm(itemVO.getItemNm() );

		return rtnVal;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidator.java
	 * - 작성일		: 2016. 6. 3.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 가격 검사.
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validatePrice (GoodsBulkUploadPO po ) {
		boolean rtnVal = true;
		String key = null;
		String msg = "";
		Timestamp sysDatetime = DateUtil.getTimestamp();
		String[] codes = null;

		// 성공으로 하고.. 아래 검사시 오류건에 대해서 처리
		po.setSuccessYn(AdminConstants.COMM_YN_Y );

		// 기본적인 세팅
		po.setChangeFutureYn(AdminConstants.COMM_YN_Y );

		String goodsId = po.getGoodsId();
		// 상품이 존재 하는지 검사..
		key = message.getMessage("column.goods_id" );
		if(goodsBulkUploadDao.checkGoodsId(goodsId ) <= 0 ) {
			msg = String.format("<b>[%s]</b> 잘못된 입력값", key );
			setFailMsg (po, msg );
			return false;
		}

		// 등록된 세일 시작일자가.. 현재 일자보다 나중인지 체크..
		key = message.getMessage("column.sale_strt_dtm" );
		if(po.getSaleStrtDtm() == null || sysDatetime.after(po.getSaleStrtDtm() ) ) {
			msg = String.format("<b>[%s]</b> 잘못된 입력값", key );
			setFailMsg (po, msg );
			return false;
		}

		// 종료일자가 시작일자보다 뒤어야 한다.
		key = message.getMessage("column.sale_end_dtm" );
		if(po.getSaleEndDtm() == null || po.getSaleStrtDtm().after(po.getSaleEndDtm()) ) {
			msg = String.format("<b>[%s]</b> 잘못된 입력값", key );
			setFailMsg (po, msg );
			return false;
		}

		// 상품 현재 가격 정보 조회 [등록일 기준으로.. ]
		GoodsPriceSO goodsPriceSO = new GoodsPriceSO();
		goodsPriceSO.setGoodsId(goodsId );
		goodsPriceSO.setSysDatetime(po.getSaleStrtDtm() );	// 엑셀에 등록된 시작일자 기준으로 해서..
		GoodsPriceVO goodsPriceVO = goodsPriceDao.checkGoodsPriceHistory(goodsPriceSO );
		if(goodsPriceVO == null ) {
			msg = "[상품 가격] 이 존재하지 않습니다.";
			setFailMsg (po, msg );
			return false;
		}

		// 해당 기간에 세일이 진행되면..
		/*if(AdminConstants.GOODS_AMT_TP_20.equals(goodsPriceVO.getGoodsAmtTpCd()) ) {
			msg = String.format("상품이 해당 기간중 세일진행 예정입니다." );
			setFailMsg (po, msg );
			return false;
		}*/

		// 상품 가격 구분 코드
		codes = getGroupCode(AdminConstants.GOODS_AMT_TP );
		key = message.getMessage("column.goods_amt_tp_cd" );
		String goodsAmtTpCd = po.getGoodsAmtTpCd();
		msg = ValidationUtil.selective(goodsAmtTpCd.trim(), key, codes );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		po.setGoodsAmtTpCd(goodsAmtTpCd.trim());

		// 가격인하 이거나.. 가격변경이면..
		// 종료일자를 9999-12-31 23:59:59 로 변경
		log.debug("########## 종료일자를 9999-12-31 23:59:59 로 변경 ");
		po.setSaleEndDtm(DateUtil.getTimestamp(CommonConstants.COMMON_END_DATE, CommonConstants.COMMON_DATE_FORMAT) );

		// 원가
//		if(!validateCostAmt (po ) ) {
//			rtnVal = false;
//		}

		// 공급가
//		if(!validateSplAmt (po ) ) {
//			rtnVal = false;
//		}

		// 수수료율
//		if(!validateCmsRate (po ) ) {
//			rtnVal = false;
//		}

		return rtnVal;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsValidator.java
	 * - 작성일	: 2021. 1. 14.
	 * - 작성자 	: valfac
	 * - 설명 		: 가격 변경 valid check
	 * </pre>
	 *
	 * @param po
	 */
	public void validatePriceUpdate(GoodsPricePO po) {

		GoodsPriceSO so = new GoodsPriceSO();
		so.setSysDatetime(DateUtil.getTimestamp());
		so.setGoodsId(po.getGoodsId() );

		// 현재 가격정보 조회
		GoodsPriceVO currentPrice = goodsPriceDao.checkGoodsPriceHistory(so);

		if (ObjectUtils.isEmpty(currentPrice)) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		if(StringUtil.isEmpty(po.getGoodsId())) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		// 현재시간보다 이전 시간의 경우 변경 불가능... (유통기한 임박할인)
		if(StringUtils.equals(po.getGoodsAmtTpCd(), CommonConstants.GOODS_AMT_TP_40)
				&& !DateUtil.isPeriod(DateUtil.getTimestampToString(DateUtil.getTimestamp(), "yyyyMMdd"), DateUtil.getTimestampToString(new Timestamp(po.getExpDt().getTime())), 8)) {
			throw new CustomException(ExceptionConstants.ERROR_GOODS_EXP_DT);
		}
		
		// 신규 가격 시작일이 현재+30분보다 빠를 수 없습니다... 30분 체크 -> 20210531 실시간 가격 변경으로 삭제
		/*if(!DateUtil.isPeriod(DateUtil.addMin("yyyyMMddHHmmss", 30), DateUtil.getTimestampToString(po.getSaleStrtDtm(), "yyyyMMddHHmmss"), 14)) {
			throw new CustomException(ExceptionConstants.ERROR_GOODS_SALE_STRT_DTM_ADD);
		}*/

		// 진행중인  현재 가격이 상품 금액 유형 코드가 일반이 아닌 경우 수정 불가 TODO 기획 확인 필요.
//		if(!StringUtils.equals(currentPrice.getGoodsAmtTpCd(), CommonConstants.GOODS_AMT_TP_10) && currentPrice.getSaleEndDtm().compareTo(po.getSaleStrtDtm()) > 0 ) {
//			throw new CustomException(ExceptionConstants.ERROR_GOODS_AMT_TP_10);
//		}
	}

	public boolean validateSaleDtm(GoodsBulkUploadPO po) {
		String msg = "";

		DateFormat dt = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		dt.setLenient(false);

		//판매기간 설정 여부가 N일 경우
		//판매기간 종료일시 : 입력된 값에 상관 없이 9999-12-31 23:59:59로 입력
		if(AdminConstants.COMM_YN_Y.equals(po.getSaleDtYn())) {
			if(po.getSaleStrtDtm() == null) {
				msg = String.format("<b>[%s]</b> 입력값 없음", "판매기간 시작일시" );
				setFailMsg (po, msg );
				return false;
			}

			if(po.getSaleEndDtm() != null) {
				if(!DateUtil.isPeriod(DateUtil.getTimestampToString(po.getSaleStrtDtm(), "yyyyMMddHHmmss"), DateUtil.getTimestampToString(po.getSaleEndDtm(), "yyyyMMddHHmmss"), 14)) {
					msg = String.format("<b>[%s]</b> 종료시간이 시작시간보다 이전", "판매기간" );
					setFailMsg (po, msg );
					return false;
				}
			}
		}
		
		if(AdminConstants.COMM_YN_N.equals(po.getSaleDtYn())) {
			po.setSaleStrtDtm(DateUtil.getTimestamp());
			po.setSaleEndDtm(DateUtil.getTimestamp(CommonConstants.COMMON_END_DATE, CommonConstants.COMMON_DATE_FORMAT));
		} else {
			//TODO[상품, 이하정, 20210226] 판매기간 종료일시 - 체크 필요한가?
		}
		return true;
	}

	public String validateYn(String yn) {
		String msg = "";

		if(StringUtil.isEmpty(yn)) {

		} else if(StringUtils.equalsIgnoreCase(yn, AdminConstants.COMM_YN_N) || StringUtils.equalsIgnoreCase(yn, AdminConstants.COMM_YN_Y)){

		} else {
			msg = "Y/N으로 입력";
		}

		return msg;
	}
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsValidator.java
	 * - 작성일	: 2021. 2. 26.
	 * - 작성자 	: valfac
	 * - 설명 	: 태그 valid check
	 * </pre>
	 * 명칭으로 입력받은 태그명을 조회하여 값이 있을 경우 태그코드 값으로 변환
	 * 없을 경우 신규로 입력하여 신규 태그 코드 값 생성하여 입력
	 * @param po
	 */
	public boolean validateTags(GoodsBulkUploadPO po) {
		String[] tagsNos = null;
		String msg = "";
		String key = message.getMessage("column.tag" );

		// NotNull
		msg = ValidationUtil.notBlank(po.getTagsNm(), key );
		if(StringUtil.isNotEmpty(msg) ) {
			setFailMsg (po, msg );
			return false;
		}

		return true;
	}

	public boolean validateNaver(GoodsBulkUploadPO po) {
		boolean result = true;
		String failMsg = (StringUtil.isNotEmpty(po.getResultMessage())) ? po.getResultMessage() : "";

		if(AdminConstants.COMM_YN_N.equals(po.getSndYn())) {
			// 수입 및 제작 여부
			//po.setGoodsSrcNm("");
			//po.setGoodsSrcCd("");
			// 판매 방식 구분
			//po.setSaleTpNm("");
			//po.setSaleTpCd("");
			// 주요사용연령대
			//po.setStpUseAgeNm("");
			//po.setStpUseAgeCd("");
			// 주요사용성별
			//po.setStpUseGdNm("");
			//po.setStpUseGdCd("");

		} if(AdminConstants.COMM_YN_Y.equals(po.getSndYn())) {
			// 수입 및 제작 여부
			List<CodeDetailVO> goodsSrcCds = cacheService.listCodeCache(AdminConstants.GOODS_SRC, true, null,null, null, null, null);
			String srcCdNm = po.getGoodsSrcNm();
			String srcCd = StringUtils.isNotEmpty(srcCdNm) ? goodsSrcCds.stream().filter(p -> p.getDtlNm().equals(srcCdNm.trim())).findFirst().map(p-> p.getDtlCd()).orElse(null) : null;
			if(StringUtils.isEmpty(srcCd)) {
				po.setGoodsSrcNm("<p class=\"warning\">" + (StringUtils.isEmpty(srcCdNm) ? "필수" : srcCdNm) + "</p>");
				failMsg += "<p class=\"warning\">[네이버쇼핑-수입 및 제작 여부] 유효하지 않음</p>";
				result = false;
			}
			// 판매 방식 구분
			List<CodeDetailVO> saleTpCds = cacheService.listCodeCache(AdminConstants.SALE_TP, true, null,null, null, null, null);
			String saleTpCdNm = po.getSaleTpNm();
			String saleTpCd = StringUtils.isNotEmpty(saleTpCdNm) ? saleTpCds.stream().filter(p -> p.getDtlNm().equals(saleTpCdNm.trim())).findFirst().map(p-> p.getDtlCd()).orElse(null) : null;
			if(StringUtils.isEmpty(saleTpCd)) {
				po.setSaleTpNm("<p class=\"warning\">" + (StringUtils.isEmpty(saleTpCdNm) ? "필수" : saleTpCdNm) + "</p>");
				failMsg += "<p class=\"warning\">[네이버쇼핑-판매 방식 구분] 유효하지 않음</p>";
				result = false;
			}
			// 주요사용연령대
			List<CodeDetailVO> stpUseAgeCds = cacheService.listCodeCache(AdminConstants.STP_USE_AGE, true, null,null, null, null, null);
			String stpUseAgeCdNm = po.getStpUseAgeNm();
			String stpUseAgeCd = StringUtils.isNotEmpty(stpUseAgeCdNm) ? stpUseAgeCds.stream().filter(p -> p.getDtlNm().equals(stpUseAgeCdNm.trim())).findFirst().map(p-> p.getDtlCd()).orElse(null) : null;
			if(StringUtils.isEmpty(stpUseAgeCd)) {
				po.setStpUseAgeNm("<p class=\"warning\">" + (StringUtils.isEmpty(stpUseAgeCdNm) ? "필수" : stpUseAgeCdNm) + "</p>");
				failMsg += "<p class=\"warning\">[네이버쇼핑-주요사용연령대] 유효하지 않음</p>";
				result = false;
			}
			// 주요사용성별
			List<CodeDetailVO> stpUseGdCds = cacheService.listCodeCache(AdminConstants.STP_USE_GD, true, null,null, null, null, null);
			String stpUseGdCdNm = po.getStpUseGdNm();
			String stpUseGdCd = StringUtils.isNotEmpty(stpUseGdCdNm) ? stpUseGdCds.stream().filter(p -> p.getDtlNm().equals(stpUseGdCdNm.trim())).findFirst().map(p-> p.getDtlCd()).orElse(null) : null;
			if(StringUtils.isEmpty(stpUseGdCd)) {
				po.setStpUseGdNm("<p class=\"warning\">" + (StringUtils.isEmpty(stpUseGdCdNm) ? "필수" : stpUseGdCdNm) + "</p>");
				failMsg += "<p class=\"warning\">[네이버쇼핑-주요사용성별] 유효하지 않음</p>";
				result = false;
			}

			if(!result) {
				failMsg += "<b class=\"warning\">[네이버쇼핑 노출여부] 미노출 처리됨</b>";
				po.setSndYn(AdminConstants.COMM_YN_N);
			} else {
				//srcCd
				po.setGoodsSrcCd(srcCd);
				//saleTpCd
				po.setSaleTpCd(saleTpCd);
				//stpUseAgeCd
				po.setStpUseAgeCd(stpUseAgeCd);
				//stpUseGdCd
				po.setStpUseGdCd(stpUseGdCd);
			}

			po.setResultMessage(failMsg );
		}

		return true;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsValidator.java
	 * - 작성일	: 2021. 2. 26.
	 * - 작성자 	: valfac
	 * - 설명 	: SEO valid check
	 *  SEO 설정 Y인 경우
	 *  필수 - SEO 타이틀
	 *  필수 - SEO 메타태그 작성자
	 *  필수 - SEO 메타태그 설명
	 *  3개중 하나라도 누락되는 경우 SEO 설정 사용여부를 N 으로 처리하고 SEO 정보 입력하지 않음
	 * </pre>
	 *
	 * @param po
	 */
	public boolean validateSeo(GoodsBulkUploadPO po) {
		boolean result = true;
		String failMsg = (StringUtil.isNotEmpty(po.getResultMessage())) ? po.getResultMessage() : "";

		if(AdminConstants.COMM_YN_Y.equals(po.getPageYn())) {
			if(StringUtils.isEmpty(po.getPageTtl())){
				po.setPageTtl("<p class=\"warning\">필수</p>");
				failMsg += "<p class=\"warning\">[SEO-타이틀] 필수값 누락</p>";
				result = false;
			}

			if(StringUtils.isEmpty(po.getPageAthr())){
				po.setPageAthr("<p class=\"warning\">필수</p>");
				failMsg += "<p class=\"warning\">[SEO-작성자] 필수값 누락</p>";
				result = false;
			}

			if(StringUtils.isEmpty(po.getPageDscrt())){
				po.setPageDscrt("<p class=\"warning\">필수</p>");
				failMsg += "<p class=\"warning\">[SEO-설명] 필수값 누락</p>";
				result = false;
			}

			if(!result){

				// 필수값
				po.setPageYn(AdminConstants.COMM_YN_N);
				//po.setPageTtl("");
				//po.setPageAthr("");
				//po.setPageDscrt("");
				//po.setPageKwd("");

				failMsg += "<b class=\"warning\">[SEO 사용여부] 필수값 누락 - 미사용 처리됨</b>";
				po.setResultMessage(failMsg );
			}
		}

		return result;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsValidator.java
	 * - 작성일	: 2021. 2. 26.
	 * - 작성자 	: valfac
	 * - 설명 	: 전시 카테고리 valid check
	 * </pre>
	 *
	 * @param po
	 */
	public boolean validateCategory(GoodsBulkUploadPO po) {
		Long cateCdL = null;
		String cateNmL = po.getCateNmL();
		Long cateCdM = null;
		String cateNmM = po.getCateNmM();
		Long cateCdS = null;
		String cateNmS = po.getCateNmS();

		if(StringUtils.isEmpty(cateNmL)) {
			setFailMsg(po, "<b>[전시카테고리-대분류]</b> 필수");
			return false;

		} else {
			HashMap dispMap = goodsBulkUploadDao.checkGoodsDisplayByNm(1, null, cateNmL);
			if(dispMap != null) {
				cateCdL = Long.valueOf((Integer) dispMap.get("dispClsfNo"));
				po.setCateCdL(cateCdL);
			} else {
				setFailMsg(po, "<b>[전시카테고리-대분류]</b> 잘못된 입력값");
				return false;
			}
		}

		if(StringUtils.isEmpty(cateNmM)) {
			setFailMsg(po, "<b>[전시카테고리-중분류]</b> 필수");
			return false;
		} else {
			HashMap dispMap = goodsBulkUploadDao.checkGoodsDisplayByNm(2, cateCdL, cateNmM);
			if(dispMap != null) {
				cateCdM = Long.valueOf((Integer) dispMap.get("dispClsfNo"));
				po.setCateCdM(cateCdM);
			} else {
				setFailMsg(po, "<b>[전시카테고리-중분류]</b> 잘못된 입력값");
				return false;
			}
		}

		if(StringUtils.isEmpty(cateNmS)) {
			setFailMsg(po, "<b>[전시카테고리-소분류]</b> 필수");
			return false;
		} else {
			HashMap dispMap = goodsBulkUploadDao.checkGoodsDisplayByNm(3, cateCdM, cateNmS);
			if(dispMap != null) {
				cateCdS = Long.valueOf((Integer) dispMap.get("dispClsfNo"));
				po.setCateCdS(cateCdS);
			} else {
				setFailMsg(po, "<b>[전시카테고리-소분류]</b> 잘못된 입력값");
				return false;
			}
		}

		return true;
	}

	public void validateIcons(GoodsBulkUploadPO po) {
		if(StringUtils.isNotEmpty(po.getIcons())) {
			String[] icons = po.getIcons().split(",");

			List<CodeDetailVO> codeDetailVOS = cacheService.listCodeCache(AdminConstants.GOODS_ICON, true, null, null, null, null, null) ;
			List<String> result = Arrays.asList(icons).stream().filter(p -> codeDetailVOS.stream().anyMatch(vo -> p.trim().equals(vo.getDtlCd()))).collect(Collectors.toList());
			//result
			po.setIcons(result.stream().collect(Collectors.joining(",")));

		} else {
			po.setIconStrtDtm(null);
			po.setIconEndDtm(null);
		}

		if(StringUtils.isNotEmpty(po.getIconStrtDtm()) ) {
			boolean iconStrtDtmFlag = DateUtil.isDate(po.getIconStrtDtm());
			if(!iconStrtDtmFlag) {
			//아이콘 시작기간(기간제용)
				setFailMsg(po, "<b>[아이콘 종료기간(기간제용)]</b> 잘못된 날짜");
				po.setIconStrtDtm(null);
			} else {
				String iconStrtDtm = DateUtil.removeFormat(po.getIconStrtDtm());
				po.setIconStrtDtm(DateUtil.getTimestampToString(DateUtil.getTimestamp(iconStrtDtm, "yyyyMMdd"), "yyyy-MM-dd"));
			}
		}
		if(StringUtils.isNotEmpty(po.getIconEndDtm()) ) {
			boolean iconEndDtmFlag = DateUtil.isDate(po.getIconEndDtm());
			if(!iconEndDtmFlag) {
				//아이콘 종료기간(기간제용)
				setFailMsg(po, "<b>[아이콘 종료기간(기간제용)]</b> 잘못된 날짜");
				po.setIconEndDtm(null);
			} else {
				String iconEndDtm = DateUtil.removeFormat(po.getIconEndDtm());
				po.setIconEndDtm(DateUtil.getTimestampToString(DateUtil.getTimestamp(iconEndDtm, "yyyyMMdd"), "yyyy-MM-dd"));
			}
		}

	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsValidator.java
	 * - 작성일	: 2021. 2. 26.
	 * - 작성자 	: valfac
	 * - 설명 	: 유통기한 valid check
	 * </pre>
	 *
	 * @param po
	 */
	public boolean validateExpMonth(GoodsBulkUploadPO po) {
		if(AdminConstants.COMM_YN_Y.equals(po.getExpMngYn())) {
			int expMonth = 0;
			try {
				expMonth = Integer.parseInt(po.getExpMonth());
			} catch (NumberFormatException e) {
				setFailMsg(po, "<b>[유통기한]</b> 숫자만 입력가능");
				return false;
			}

			if(expMonth < 0) {
				setFailMsg(po, "<b>[유통기한]</b> 양수만 가능");
				return false;
			}

			if(expMonth > 36) {
				setFailMsg(po, "<b>[유통기한]</b> 36개월까지만 가능");
				return false;
			}
		}
		return true;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2021. 8. 3
	 * - 작성자		: valueFactory
	 * - 설명		: 매입업체명 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validatePhsCompNm(GoodsBulkUploadPO po) {
		String phsCompNm = null;
		String msg = "";
		String key = message.getMessage("column.goods.phsCompNo" );
		
		if(po.getCompNo() == null) {
			return false;
		}
		long compNo = po.getCompNo();
		int compTpCd = goodsBulkUploadDao.checkGoodsCompTpCd(compNo);
		//10 자사, 20 위탁 
		
		phsCompNm = po.getPhsCompNm();
		
		 //등록된 매입업체가 아닐경우 메시지, false 처리
		if(compTpCd==10) {
			if(StringUtil.isNotBlank(phsCompNm)) {
				if(goodsBulkUploadDao.checkGoodsPhsCompNm(phsCompNm) <= 0 ) {
					msg = String.format("<b>[%s]</b> 잘못된 매입업체정보 : [%s]", key, phsCompNm);
					setFailMsg (po, msg );
					return false;
				}
				long goodsPhsCompNo = goodsBulkUploadDao.getGoodsPhsCompNo(phsCompNm);
				po.setPhsCompNo(goodsPhsCompNo);
			}
		}else {
		po.setPhsCompNm(po.getCompNm());
		po.setPhsCompNo(po.getCompNo());
		}
		return true;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsValidatior.java
	 * - 작성일		: 2021. 8. 3
	 * - 작성자		: valueFactory
	 * - 설명		: 	고시정보 검사
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateItemVal(GoodsBulkUploadPO po) {
		String[] itemVals = new String[5];
		String msg = "";
		String key = message.getMessage("column.goods.notifyInfo" );
		
		itemVals[0] = po.getItemVal1();
		itemVals[1] = po.getItemVal2();
		itemVals[2] = po.getItemVal3();
		itemVals[3] = po.getItemVal4();
		itemVals[4] = po.getItemVal5();
		
		// NotNull
		for(int i=0; i<itemVals.length; i++) {
			msg = ValidationUtil.notBlank(itemVals[i], key );
			if(StringUtil.isNotEmpty(msg) ) {
				setFailMsg (po, msg );
				return false;			
			}
		}
		return true;
	}
}
