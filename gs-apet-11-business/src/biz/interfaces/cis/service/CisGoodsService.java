package biz.interfaces.cis.service;

import java.util.HashMap;
import java.util.List;

import biz.app.brand.model.BrandBasePO;
import biz.app.goods.model.SkuInfoSO;
import biz.app.goods.model.SkuInfoVO;
import biz.app.statistics.model.GoodsSO;
import biz.interfaces.cis.model.request.goods.SkuInfoInsertPO;
import biz.interfaces.cis.model.request.goods.SkuInfoUpdatePO;
import biz.interfaces.cis.model.response.goods.CisBrandVO;
import biz.interfaces.cis.model.response.goods.SkuInfoInsertVO;
import biz.interfaces.cis.model.response.goods.SkuInfoUpdateVO;
import biz.interfaces.cis.model.response.goods.StockUpdateVO;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.interfaces.cis.service
* - 파일명 	: CisGoodsService.java
* - 작성일	: 2021. 2. 19.
* - 작성자	: valfac
* - 설명 		: CIS 상품 서비스
* </pre>
*/
public interface CisGoodsService {

	/**
	 * CIS 단품 등록/수정할 데이터 조회
	 * @param so
	 * @return
	 * @throws Exception
	 */
	List<SkuInfoVO> getStuInfoListForSend(SkuInfoSO so);
	
	/**
	 * 상품 일괄 등록 CIS용 조회
	 * @param so
	 * @return
	 * @throws Exception
	 */
	SkuInfoVO getInfoForBulkCisSend(GoodsSO so);

	/**
	 * CIS 상품 등록/수정할 데이터 조회
	 * @param so
	 * @return
	 * @throws Exception
	 */
	List<SkuInfoVO> getPrdtInfoListForSend(SkuInfoSO so);

	/**
	 * CIS 단품 재고 조회
	 * @param allYn
	 * @return
	 * @throws Exception
	 */
	StockUpdateVO getGoodsStockList(String allYn) throws Exception;

	/**
	 * CIS 전송
	 * @param skuInfoSO
	 * @return
	 * @throws Exception
	 */
	HashMap sendClsGoods(SkuInfoSO skuInfoSO);
	HashMap sendClsGoods(String sendType, String goodsCstrtTpCd, List<SkuInfoVO> list);

	/**
	 * CIS 단품 등록
	 * @param po
	 * @return
	 * @throws Exception
	 */
	SkuInfoInsertVO insertSkuInfo(SkuInfoInsertPO po) throws Exception;

	/**
	 * CIS 단품 수정
	 * @param po
	 * @return
	 * @throws Exception
	 */
	SkuInfoUpdateVO updateSkuInfo(SkuInfoUpdatePO po, String batchYn) throws Exception;
	
	/**
	 * CIS 브랜드 등록/수정
	 * @param po
	 * @return
	 * @throws Exception
	 */
	CisBrandVO sendBrand(BrandBasePO po, String type) throws Exception;
}
