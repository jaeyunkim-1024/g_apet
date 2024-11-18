package biz.app.goods.service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import biz.app.goods.dao.GoodsDtlInqrHistDao;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsDtlInqrHistPO;
import biz.app.goods.model.GoodsDtlInqrHistSO;
import biz.app.goods.model.GoodsDtlInqrHistVO;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.CookieSessionUtil;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsDtlInqrHistServiceImpl.java
* - 작성일	: 2021. 3. 9.
* - 작성자	: valfac
* - 설명 		:
* </pre>
*/
@Transactional
@Service("goodsDtlInqrHistService")
public class GoodsDtlInqrHistServiceImpl implements GoodsDtlInqrHistService {

	@Autowired
	private GoodsDtlInqrHistDao goodsDtlInqrHistDao;


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
	@Override
	public void deleteOldGoodsDtlInqrHist(GoodsDtlInqrHistSO so) {
		GoodsDtlInqrHistPO po = new GoodsDtlInqrHistPO();
		po.setMbrNo(so.getMbrNo());
		goodsDtlInqrHistDao.deleteOldGoodsDtlInqrHist(po);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistServiceImpl.java
	* - 작성일	: 2021. 3. 9.
	* - 작성자 	: valfac
	* - 설명 	: 최근 본 상품 목록 DB 조회
	* </pre>
	*
	* @param so
	* @return
	*/
	@Override
	public List<GoodsBaseVO> listGoodsDtlInqrHist(GoodsDtlInqrHistSO so) {
		return goodsDtlInqrHistDao.pageGoodsDtlInqrHist(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsDtlInqrHistServiceImpl.java
	 * - 작성일	: 2021. 3. 9.
	 * - 작성자 	: valfac
	 * - 설명 		: 최근 본 상품 조회
	 * </pre>
	 *
	 * @param po
	 * @return
	 */
	@Override
	@Transactional(readOnly=true)
	public GoodsDtlInqrHistVO getGoodsDtlInqrHist(GoodsDtlInqrHistPO po) {
		return goodsDtlInqrHistDao.getGoodsDtlInqrHist(po);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistServiceImpl.java
	* - 작성일	: 2021. 3. 15.
	* - 작성자 	: valfac
	* - 설명 		: 로그인 시 최근 본 상품 등록
	* </pre>
	*
	* @param mbrNo
	* @param recentGoods
	* @return
	*/
	@Override
	public int setGoodsDtlInqrHist(Long mbrNo, List<GoodsBaseVO> listCookie) {
		Timestamp timestamp = DateUtil.getTimestamp();
		int insertCnt = 0;
		if(StringUtil.isNotEmpty(listCookie)) {
			for (GoodsBaseVO vo : listCookie) {
				GoodsDtlInqrHistPO po = new GoodsDtlInqrHistPO();
				po.setGoodsId(vo.getGoodsId());
				po.setMbrNo(mbrNo);
				po.setSysRegrNo(mbrNo);
				po.setSysUpdrNo(mbrNo);    // DUPLICATE 처리로 추가함.
				po.setSysRegDtm((vo.getSysRegDtm() != null ? vo.getSysRegDtm() : timestamp));
				po.setSysUpdDtm((vo.getSysRegDtm() != null ? vo.getSysRegDtm() : timestamp));
				insertCnt += this.insertGoodsDtlInqrHist(po);
			}
		}
		return insertCnt;
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistServiceImpl.java
	* - 작성일	: 2021. 3. 9.
	* - 작성자 	: valfac
	* - 설명 		: 최근 본 상품 등록
	* </pre>
	*
	* @param po
	* @return
	*/
	@Override
	public int insertGoodsDtlInqrHist(GoodsDtlInqrHistPO po) {
		
		int result = goodsDtlInqrHistDao.insertGoodsDtlInqrHist(po);
		
		if(result < 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		return result;
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistServiceImpl.java
	* - 작성일	: 2021. 3. 9.
	* - 작성자 	: valfac
	* - 설명 		: 최근 본 상품 삭제
	* </pre>
	*
	* @param po
	* @return
	*/
	@Override
	public int deleteGoodsDtlInqrHist(GoodsDtlInqrHistPO po) {
		
		if(StringUtils.isEmpty(po.getGoodsId())) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		int result = goodsDtlInqrHistDao.deleteGoodsDtlInqrHist(po);
		
		if(result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		return result;
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistServiceImpl.java
	* - 작성일	: 2021. 3. 9.
	* - 작성자 	: valfac
	* - 설명 		: 최근 본 상품 수정
	* </pre>
	*
	* @param po
	* @return
	*/
	@Override
	public int updateGoodsDtlInqrHist(GoodsDtlInqrHistPO po) {
		
		int result = goodsDtlInqrHistDao.updateGoodsDtlInqrHist(po);
		
		if(result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		return result;
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistServiceImpl.java
	* - 작성일	: 2021. 3. 15.
	* - 작성자 	: valfac
	* - 설명 	: 현재 본 상품 DB 세팅
	* </pre>
	*
	* @param mbrNo
	* @param goods
	* @param goodsImgMap
	* @param cookieKey
	*/
	@Override
	public void setRecentGoods(Long mbrNo, GoodsBaseVO goods) {
		GoodsDtlInqrHistPO histPO = new GoodsDtlInqrHistPO();
		histPO.setGoodsId(goods.getGoodsId());
		histPO.setMbrNo(mbrNo);
		histPO.setSysRegrNo(mbrNo);
		histPO.setSysUpdrNo(mbrNo);
		histPO.setSysRegDtm(DateUtil.getTimestamp());
		histPO.setSysUpdDtm(DateUtil.getTimestamp());
		insertGoodsDtlInqrHist(histPO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistServiceImpl.java
	* - 작성일	: 2021. 3. 15.
	* - 작성자 	: valfac
	* - 설명 		: 최근 본 상품
	* </pre>
	*
	* @param so
	* @return
	*/
	@Override
	@Transactional(readOnly=true)
	public GoodsBaseVO getOneGoodsDtlInqrHist(GoodsDtlInqrHistSO so) {
		
		List<GoodsBaseVO> listGoodsDtlHist = listGoodsDtlInqrHist(so);
		
		GoodsBaseVO goodsDtlHist = new GoodsBaseVO();
		 
		if(!CollectionUtils.isEmpty(listGoodsDtlHist)) {
			goodsDtlHist = listGoodsDtlHist.get(0);
		}
		
		return goodsDtlHist;
	}

	/**
	 * 상품 상세 쿠키 정보 호출 함수.
	 * @param recentGoods
	 * @return
	 */
	@Override
	public List<GoodsBaseVO> listGoodsCookie(String recentGoods) {
		String[] recentGoodsArray = null;
		List<GoodsBaseVO> cookieGoodsList = null;
		GoodsBaseVO cookieGoods = null;

		if (org.apache.commons.lang3.StringUtils.isNotEmpty(recentGoods)) {
			recentGoodsArray = recentGoods.split("@@@");
			if (!ArrayUtils.isEmpty(recentGoodsArray)) {

				cookieGoodsList = new ArrayList<>();

				for (String goods : recentGoodsArray) {
					String[] goodsInfo = goods.split(":::");
					cookieGoods = new GoodsBaseVO();

					cookieGoods.setGoodsId(goodsInfo[0]);
					cookieGoods.setGoodsNm(goodsInfo[1]);
					cookieGoods.setSaleAmt(Long.valueOf(goodsInfo[2]));
					if(!goodsInfo[3].equals("null")){
						cookieGoods.setOrgSaleAmt(Long.valueOf(goodsInfo[3]));
					}
					if(!goodsInfo[4].equals("null")){
						cookieGoods.setImgSeq(Integer.valueOf(goodsInfo[4]));
					}
					if(!goodsInfo[5].equals("null")){
						cookieGoods.setImgPath(goodsInfo[5]);
					}
					if(goodsInfo.length >= 7){
						if(!goodsInfo[6].equals("null")){
							cookieGoods.setSysRegDtm(DateUtil.getTimestamp(goodsInfo[6], CommonConstants.COMMON_DATE_FORMAT));
						}
					}

					cookieGoodsList.add(cookieGoods);
				}
			}
		}

		return cookieGoodsList;
	}
	

}