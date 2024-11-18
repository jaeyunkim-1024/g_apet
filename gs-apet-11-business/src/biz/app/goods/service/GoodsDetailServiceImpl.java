package biz.app.goods.service;

import biz.app.contents.model.ApetContentsGoodsMapSO;
import biz.app.contents.model.VodVO;
import biz.app.delivery.model.DeliveryChargePolicySO;
import biz.app.delivery.model.DeliveryChargePolicyVO;
import biz.app.display.model.DisplayBannerVO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.goods.dao.GoodsDetailDao;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.promotion.model.CouponBaseVO;
import biz.app.promotion.model.ExhibitionThemeGoodsSO;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.enums.SearchApiSpec;
import framework.common.exception.CustomException;
import framework.common.util.SearchApiUtil;
import framework.common.util.StringUtil;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.goods.service
 * - 파일명		: GoodsDetailServiceImpl.java
 * - 작성일		: 2021. 3. 11.
 * - 작성자		: valfac
 * - 설명		: 상품 상세 서비스
 * </pre>
 */
@Service("goodsDetailService")
public class GoodsDetailServiceImpl implements GoodsDetailService {

	@Autowired private GoodsDetailDao goodsDetailDao;

	@Autowired private SearchApiUtil searchApiUtil;

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDetailServiceImpl.java
	 * - 작성일		: 2021. 3. 11.
	 * - 작성자		: valfac
	 * - 설명		: 상품 카테고리 lnb
	 * </pre>
	 * @return List
	 */
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List<DisplayCategoryVO> listShopCategories() {
		return goodsDetailDao.listShopCategories();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDetailServiceImpl.java
	 * - 작성일		: 2021. 3. 11.
	 * - 작성자		: valfac
	 * - 설명		: 상품 상세 정보
	 * </pre>
	 * @return List
	 */
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public GoodsBaseVO getGoodsDetail(GoodsBaseSO so) {
		String adminYn = goodsDetailDao.selectAdminByNo(so);
		so.setAdminYn(adminYn);
		return goodsDetailDao.getGoodsDetail(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDetailServiceImpl.java
	 * - 작성일		: 2021. 3. 11.
	 * - 작성자		: valfac
	 * - 설명		: 상품 묶음, 세트, 묶음옵션 상품 목록 조회
	 * </pre>
	 * @return List
	 */
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List listGoodsCstrt(GoodsBaseSO so) {
		return goodsDetailDao.listGoodsCstrt(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDetailServiceImpl.java
	 * - 작성일		: 2021. 3. 11.
	 * - 작성자		: valfac
	 * - 설명		: 상품 가격 조회
	 * </pre>
	 * @return List
	 */
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List listGoodsPrices(String goodsId) {
		return goodsDetailDao.listGoodsPrices(goodsId);
	}
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDetailServiceImpl.java
	 * - 작성일		: 2021. 3. 15.
	 * - 작성자		: valfac
	 * - 설명		: 상품 기획전 목록 조회
	 * </pre>
	 * @return List
	 */
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List listGoodsExhibited(String goodsId, String webMobileGbCd) {
		ExhibitionThemeGoodsSO exhibitionThemeGoodsSO = new ExhibitionThemeGoodsSO();
		exhibitionThemeGoodsSO.setGoodsId(goodsId);
		exhibitionThemeGoodsSO.setWebMobileGbCd(webMobileGbCd);
		return goodsDetailDao.listGoodsExhibited(exhibitionThemeGoodsSO);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDetailServiceImpl.java
	 * - 작성일		: 2021. 3. 11.
	 * - 작성자		: valfac
	 * - 설명		: 상품 사은품 목록
	 * </pre>
	 * @return List
	 */
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List listGoodsGifts(String goodsId, String goodsCstrtTpCd) {
		return goodsDetailDao.listGoodsGifts(goodsId, goodsCstrtTpCd);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDetailServiceImpl.java
	* - 작성일	: 2021. 3. 15.
	* - 작성자 	: valfac
	* - 설명 		: 연관 영상 페이지 조회
	* </pre>
	*
	* @param so
	* @return
	*/
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List<VodVO> pageContentsGoods(ApetContentsGoodsMapSO so, Long mbrNo, Long stId) {
		
		so.setDispYn(CommonConstants.COMM_YN_Y);	
		so.setVdGbCd(CommonConstants.VD_GB_20);	
		so.setContsTpCd(CommonConstants.CONTS_TP_10);	
		so.setSort("ACGM.SYS_REG_DTM");	
		so.setOrder("DESC");	
		
		List<VodVO> list = goodsDetailDao.pageContentsGoods(so);
		
		//추천일치율
		if (!CommonConstants.NO_MEMBER_NO.equals(mbrNo)) {
	        list.stream().forEach( v -> {
	        	try {
	        		Double rate = getGoodsRecommendRate(stId, v.getVdId(), mbrNo, CommonConstants.SEO_SVC_TV);
	        		v.setRate(rate.toString());
				} catch (Exception e) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
	        });
	        
		}
		
		return list;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDetailServiceImpl.java
	 * - 작성일		: 2021. 3. 11.
	 * - 작성자		: valfac
	 * - 설명		: 상품 쿠폰 조회
	 * </pre>
	 * @return List
	 */
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List listGoodsCoupon(GoodsBaseSO so) {
		List<CouponBaseVO> list = goodsDetailDao.listGoodsCoupon(so);
		list.stream().forEach(v->{
			String nt = v.getNotice();
			nt = StringEscapeUtils.unescapeHtml(nt);
			nt = nt.replaceAll("<p>","").replaceAll("&nbsp;","").replaceAll("</p>","<br>").replaceAll("</br>","<br>");
			if(StringUtil.isEmpty(nt.replaceAll(" <br>","").replaceAll("<br>","").replaceAll("\\s*","").trim())){
				v.setNotice(null);
			}else{
				String[] nts = nt.split("<br>");
				v.setNotice(nt);
				v.setNotices(nts);
			}
		});
		return goodsDetailDao.listGoodsCoupon(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDetailServiceImpl.java
	 * - 작성일		: 2021. 3. 15.
	 * - 작성자		: valfac
	 * - 설명		: 상품 일치율 조회
	 * </pre>
	 * @param stId
	 * @param goodsId
	 * @param webMobileGbCd
	 * @param mbrNo
	 * @return List
	 */
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public double getGoodsRecommendRate(Long stId, String contentId, Long mbrNo, String index) throws Exception {
		String strRate = "";
		if(mbrNo != CommonConstants.NO_MEMBER_NO && StringUtils.isNotEmpty(contentId)) {
			Map<String,String> requestParam1 = new HashMap<String,String>();
			requestParam1.put("INDEX", index); // TV/LOG/SHOP
			requestParam1.put("MBR_NO", String.valueOf(mbrNo));
			requestParam1.put("CONTENT_ID", String.valueOf(contentId)); // 상품번호/펫로그번호/영상번호
			String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMENDRATE, requestParam1);
			if(res != null) {
				ObjectMapper objectMapper = new ObjectMapper();
				Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
				Map<String, Object> statusMap = (Map)resMap.get("STATUS");
				if( statusMap.get("CODE").equals(200) ) {
					Map<String, Object> dataMap = (Map)resMap.get("DATA");
					if( (int)dataMap.get("TOTAL") > 0 ) {
						Map<String, Object> items = (Map)dataMap.get("ITEM");
						strRate = String.valueOf(items.get("RATE"));
					}
				}
			}
		}
		return NumberUtils.isNumber(strRate) ? Double.parseDouble(strRate) : 0;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDetailServiceImpl.java
	 * - 작성일		: 2021. 3. 15.
	 * - 작성자		: valfac
	 * - 설명		: 업체 배송 정보
	 * </pre>
	 * @param so
	 * @return DeliveryChargePolicyVO vo
	 */
	@Override
	public DeliveryChargePolicyVO getDeliveryChargePolicy(DeliveryChargePolicySO so) { return goodsDetailDao.selectDeliveryChargePolicy(so); }

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDetailServiceImpl.java
	 * - 작성일		: 2021. 4. 22.
	 * - 작성자		: valfac
	 * - 설명		: 상품 상세 공지 배너 목록
	 * </pre>
	 * @param dispCornNo
	 * @return List
	 */
	@Override
	public List<DisplayBannerVO> listDisplayBannerContents(Long dispCornNo) {
		return goodsDetailDao.listDisplayBannerContents(dispCornNo);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDetailServiceImpl.java
	 * - 작성일		: 2021. 6. 15.
	 * - 작성자		: valfac
	 * - 설명		: 상품이 현재 사은품으로 매핑되어 있는지 체크
	 * </pre>
	 * @param goodsId
	 * @return string
	 */
	@Override
	public String getGoodsGiftYn(String goodsId) {
		return goodsDetailDao.selectGoodsGiftYn(goodsId);
	}

	@Override
	public GoodsBaseVO getGoodsShareInfo(GoodsBaseSO so) {
		return goodsDetailDao.getGoodsShareInfo(so);
	}
}
