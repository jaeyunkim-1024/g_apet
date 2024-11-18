package biz.app.goods.service;

import biz.app.goods.dao.GoodsBaseDao;
import biz.app.goods.dao.GoodsBulkDao;
import biz.app.goods.model.*;
import biz.interfaces.cis.model.request.goods.SkuInfoInsertPO;
import biz.interfaces.cis.service.CisGoodsService;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명     : biz.app.goods.service
 * - 파일명		: GoodsBulkServiceImpl.java
 * - 작성일		: 2021. 1. 11.
 * - 작성자		: lhj01
 * - 설명	    : 상품 가격 목록
 * </pre>
 */
@Service("goodsBulkService")
public class GoodsBulkServiceImpl implements GoodsBulkService {

	@Autowired private CisGoodsService cisGoodsService;

	@Autowired private GoodsBulkDao goodsBulkDao;

	@Autowired private GoodsBaseDao goodsBaseDao;

	@Override
	@Transactional(readOnly=true)
	public List<GoodsBulkPriceVO> pageGoodsBulkPrice(GoodsBaseSO so) {
		return goodsBulkDao.pageGoodsBulkPrice(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 패키지명 	: biz.app.goods.service
	 * - 파일명 	: GoodsBulkServiceImpl.java
	 * - 작성일	: 2021. 1. 12.
	 * - 작성자	: valfac
	 * - 설명 	: 상품 변경
	 * </pre>
	 */
	@Transactional(rollbackFor=Exception.class)
	public boolean updateGoods(String goodsUpdateGb, GoodsBasePO po) {
		//String goodsCstrtTpCd = goodsBulkDao.updateGoodsBatch(goodsUpdateGb, po );
		HashMap<String, Object> params = goodsBulkDao.updateGoodsBatch(goodsUpdateGb, po );

		Integer cisNo = (Integer) params.get("cisNo");
		Integer updateCnt = (Integer) params.get("updateCnt");
		String goodsCstrtTpCd = (String) params.get("goodsCstrtTpCd");

		boolean result = true;

		//DB 변경 count > 0
		if(updateCnt > 0) {
			if(cisNo == null) {
				//보안 진단. 불필요한 코드 (비어있는 IF문)
				if(!AdminConstants.GOODS_BULK_UPDATE_REMOVE.equals(goodsUpdateGb)) {
					if(AdminConstants.GOODS_BULK_UPDATE_STAT.equals(goodsUpdateGb) ||
							AdminConstants.GOODS_BULK_UPDATE_APPR.equals(goodsUpdateGb)){
						if(AdminConstants.GOODS_CSTRT_TP_ITEM.equals(goodsCstrtTpCd)) {
							//cisNo 가 없을 경우 수정하지 못한다
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
					}
				}
			} else {
				//웹모바일 일괄 변경은 cis 전송 하지 않는다
				if(!StringUtils.equals(goodsUpdateGb, AdminConstants.GOODS_BULK_UPDATE_DEVICE) && StringUtils.equals(goodsCstrtTpCd, CommonConstants.GOODS_CSTRT_TP_ITEM)) {
					SkuInfoSO skuInfoSO = new SkuInfoSO();
					skuInfoSO.setGoodsId(po.getGoodsId());
					skuInfoSO.setBatchYn(CommonConstants.COMM_YN_N);
					skuInfoSO.setGoodsCstrtTpCd(goodsCstrtTpCd);
					skuInfoSO.setSendType("update");

					List<SkuInfoVO> list = cisGoodsService.getStuInfoListForSend(skuInfoSO);

					HashMap cisResult = cisGoodsService.sendClsGoods(skuInfoSO.getSendType(), skuInfoSO.getGoodsCstrtTpCd(), list);
					HashMap resultMsgMap = (HashMap) cisResult.get(skuInfoSO.getGoodsId());
					//CIS 응답코드
					String resCd = (String) resultMsgMap.keySet().toArray()[0];

					//보안 진단. 불필요한 코드 (비어있는 IF문)
					if(!resCd.equalsIgnoreCase(CommonConstants.CIS_API_SUCCESS_CD)) {
						throw new CustomException(ExceptionConstants.ERROR_CIS_ERROR);
					}
				}
			}
		} else {
			result = false;
		}

		/**
		 * CIS 연동 제품의 경우, ITEM, ATTR 의 경우 던진다
		 * GOODS_BULK_UPDATE_REMOVE 삭제의 경우 cisNO 가 없을 경우 cis 연동하지 않는다
		 * 상태값 변경의 경우 ITEM, ATTR의 경우 던진다
		 */
		/**
		 * GOODS_BULK_UPDATE_STAT       상품 상태
		 * GOODS_BULK_UPDATE_APPR       상품 승인
		 * GOODS_BULK_UPDATE_REMOVE     상품 삭제
		 */

		/**
		 * GOODS_BULK_UPDATE_REMOVE 삭제의 경우 cisNO 가 없을 경우 cis 연동하지 않는다
		 * GOODS_BULK_UPDATE_DEVICE 웹모바일 일괄변경의 경우 cis 연동하지 않는다
		 */

		return result;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 패키지명 	: biz.app.goods.service
	 * - 파일명 	: GoodsBulkServiceImpl.java
	 * - 작성일	: 2021. 3. 29.
	 * - 작성자	: valfac
	 * - 설명 	: 상품 베스트 배치
	 * </pre>
	 */
	@Override
	public int callGoodsBestProc(String argBaseDt) {
		return goodsBulkDao.callGoodsBestProc(argBaseDt);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 패키지명 	: biz.app.goods.service
	 * - 파일명 	: GoodsBulkServiceImpl.java
	 * - 작성일	: 2021. 4. 7.
	 * - 작성자	: valfac
	 * - 설명 	: 상품 판매기간 종료
	 * </pre>
	 */
	@Override
	public int callGoodsStatProc() {
		return goodsBulkDao.callGoodsStatProc();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 패키지명 	: biz.app.goods.service
	 * - 파일명 	: GoodsBulkServiceImpl.java
	 * - 작성일	: 2021. 5. 25.
	 * - 작성자	: valfac
	 * - 설명 	: 상품 전체 카테고리 전시 순위 집계 배치
	 * </pre>
	 */
	@Override
	public int callGoodsDispAllCtgProc() {
		return goodsBulkDao.callGoodsDispAllCtgProc();
	}

	@Override
	public HashMap sendGoodsCis() {

		HashMap resultMap = new HashMap();

		int productTotal = 0;
		int productSuccess = 0;
		int productFail = 0;


		SkuInfoSO skuInfoSO = new SkuInfoSO();
		skuInfoSO.setBatchYn("M"); //배치 YN 자체를 돌리면 안된다.전체 상품 기준이기 때문에
		skuInfoSO.setSendType("insert");
		skuInfoSO.setGoodsCstrtTpCd(CommonConstants.GOODS_CSTRT_TP_ITEM);
		List<SkuInfoVO> list = cisGoodsService.getStuInfoListForSend(skuInfoSO);
		productTotal += list.size();

		SkuInfoInsertPO po = null;
		for (SkuInfoVO vo : list) {
			try {
				String goodsId = vo.getSkuCd();
				List<SkuInfoVO> sendList = Arrays.asList(vo);
				HashMap result = cisGoodsService.sendClsGoods(skuInfoSO.getSendType(), skuInfoSO.getGoodsCstrtTpCd(), sendList);
				HashMap resultMsgMap = (HashMap) result.get(goodsId);

				//CIS 응답코드
				String resCd = (String) resultMsgMap.keySet().toArray()[0];
				//CIS 응답메세지

				if(!resCd.equalsIgnoreCase(CommonConstants.CIS_API_SUCCESS_CD)) {
					String resultMsg = (String) resultMsgMap.get(resCd);
					productFail ++;
				}else {
					Integer cisNo = (Integer) resultMsgMap.get(resCd);
					goodsBaseDao.updateGoodsCisNo(cisNo, goodsId);
					productSuccess ++;
				}

			} catch (Exception e) {
				productFail ++;
			}
		}

		resultMap.put("result", "SUCCESS");
		resultMap.put("productTotal", productTotal);
		resultMap.put("productSuccess", productSuccess);
		resultMap.put("productFail", productFail);

		return resultMap;
	}
}
