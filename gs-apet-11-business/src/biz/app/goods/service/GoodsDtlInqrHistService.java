package biz.app.goods.service;

import java.util.List;
import java.util.Map;

import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsDtlInqrHistPO;
import biz.app.goods.model.GoodsDtlInqrHistSO;
import biz.app.goods.model.GoodsDtlInqrHistVO;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsDtlInqrHistService.java
* - 작성일	: 2021. 3. 9.
* - 작성자	: valfac
* - 설명 		: 최근 본 상품
* </pre>
*/
public interface GoodsDtlInqrHistService {


	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsDtlInqrHistServiceImpl.java
	 * - 작성일	: 2021. 4. 9.
	 * - 작성자 	: valfac
	 * - 설명 	: 본지 오래된 상품 삭제
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	void deleteOldGoodsDtlInqrHist(GoodsDtlInqrHistSO so);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistService.java
	* - 작성일	: 2021. 3. 9.
	* - 작성자 	: valfac
	* - 설명 		: 최근 본 상품 리스트
	* </pre>
	*
	* @param so
	* @return
	*/
	List<GoodsBaseVO> listGoodsDtlInqrHist(GoodsDtlInqrHistSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsDtlInqrHistService.java
	 * - 작성일	: 2021. 3. 9.
	 * - 작성자 	: valfac
	 * - 설명 		: 최근 본 상품 조회
	 * </pre>g
	 *
	 * @param so
	 * @return
	 */
	GoodsDtlInqrHistVO getGoodsDtlInqrHist(GoodsDtlInqrHistPO po);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistServiceImpl.java
	* - 작성일	: 2021. 3. 15.
	* - 작성자 	: valfac
	* - 설명 	: 로그인 시 최근 본 상품 등록
	* </pre>
	*
	* @param mbrNo
	* @param recentGoods
	* @return
	*/
	int setGoodsDtlInqrHist(Long mbrNo, List<GoodsBaseVO> listCookie);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistService.java
	* - 작성일	: 2021. 3. 9.
	* - 작성자 	: valfac
	* - 설명 		: 최근 본 상품 등록
	* </pre>
	*
	* @param po
	* @return
	*/
	int insertGoodsDtlInqrHist(GoodsDtlInqrHistPO po);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistService.java
	* - 작성일	: 2021. 3. 9.
	* - 작성자 	: valfac
	* - 설명 		: 최근 본 상품 수정
	* </pre>
	*
	* @param po
	* @return
	*/
	int updateGoodsDtlInqrHist(GoodsDtlInqrHistPO po);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistService.java
	* - 작성일	: 2021. 3. 9.
	* - 작성자 	: valfac
	* - 설명 		: 최근 본 상품 삭제
	* </pre>
	*
	* @param po
	* @return
	*/
	int deleteGoodsDtlInqrHist(GoodsDtlInqrHistPO po);
	
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistService.java
	* - 작성일	: 2021. 3. 15.
	* - 작성자 	: valfac
	* - 설명 	: 최근 본 상품 세팅
	* </pre>
	*
	* @param mbrNo
	* @param goods
	*/
	void setRecentGoods(Long mbrNo, GoodsBaseVO goods);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistService.java
	* - 작성일	: 2021. 3. 15.
	* - 작성자 	: valfac
	* - 설명 		: 최근 본 상품
	* </pre>
	*
	* @param so
	* @return
	*/
	GoodsBaseVO getOneGoodsDtlInqrHist(GoodsDtlInqrHistSO so);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistService.java
	* - 작성일	: 2021. 3. 15.
	* - 작성자 	: valfac
	* - 설명 		: 최근 본 상품 쿠키 목록
	* </pre>
	*
	* @param recentGoods
	* @return
	*/
	List<GoodsBaseVO> listGoodsCookie(String recentGoods);
	
}