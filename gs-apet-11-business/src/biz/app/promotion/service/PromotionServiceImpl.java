package biz.app.promotion.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.brand.model.BrandBaseVO;
import biz.app.company.model.CompanyBaseVO;
import biz.app.promotion.dao.PromotionDao;
import biz.app.promotion.model.DisplayPromotionTreeVO;
import biz.app.promotion.model.ExhibitionVO;
import biz.app.promotion.model.PromotionBasePO;
import biz.app.promotion.model.PromotionBaseVO;
import biz.app.promotion.model.PromotionFreebiePO;
import biz.app.promotion.model.PromotionFreebieVO;
import biz.app.promotion.model.PromotionSO;
import biz.app.promotion.model.PromotionTargetPO;
import biz.app.promotion.model.PromotionTargetVO;
import biz.app.st.model.StStdInfoPO;
import biz.app.st.model.StStdInfoVO;
import framework.admin.constants.AdminConstants;
import framework.admin.util.JsonUtil;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 사이트 ServiceImpl
 * @author		snw
 * @since		2015.06.11
 */
@Slf4j
@Service
@Transactional
public class PromotionServiceImpl implements PromotionService {

	@Autowired
	private PromotionDao promotionDao;

	/*
	@Autowired
	private BizService bizService;
	*/
	@Override
	@Transactional(readOnly=true)
	public List<PromotionBaseVO> pagePromotionGift(PromotionSO so) {
		so.setPrmtKindCd(AdminConstants.PRMT_KIND_20);
		return promotionDao.pagePromotion(so);
	}

	@Override
	public PromotionBaseVO getPromotionGift(PromotionSO so) {
		so.setPrmtKindCd(AdminConstants.PRMT_KIND_20);
		return promotionDao.getPromotion(so);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public void insertPromotionGift(PromotionBasePO po) {
		po.setPrmtStatCd(AdminConstants.PRMT_STAT_10);
		po.setPrmtKindCd(AdminConstants.PRMT_KIND_20);
		po.setRvsMrgPmtYn("N");
		int result = promotionDao.insertPromotionBase(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 사이트와 이벤트  매핑정보 등록
		if (po.getStId() != null && po.getStId().length > 0) {
			for (Long stId : po.getStId()) {
				StStdInfoPO stStdInfoPO = new StStdInfoPO();
				stStdInfoPO.setStId(stId);
				stStdInfoPO.setPrmtNo(po.getPrmtNo());

				result = promotionDao.insertStGiftMap(stStdInfoPO);

				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}

		JsonUtil jsonUtil = new JsonUtil();

		if(StringUtil.isNotBlank(po.getPromotionTargetStr())) {
			List<PromotionTargetPO> list = jsonUtil.toArray(PromotionTargetPO.class, po.getPromotionTargetStr());

			if(list != null && !list.isEmpty()) {
				for(PromotionTargetPO promotionTargetPO : list) {
					promotionTargetPO.setPrmtNo(po.getPrmtNo());
					result = promotionDao.insertPromotionTarget(promotionTargetPO);
					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			} else {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		if(StringUtil.isNotBlank(po.getPromotionFreebieStr())) {
			List<PromotionFreebiePO> list = jsonUtil.toArray(PromotionFreebiePO.class, po.getPromotionFreebieStr());

			if(list != null && !list.isEmpty()) {
				for(PromotionFreebiePO promotionFreebiePO : list) {
					promotionFreebiePO.setPrmtNo(po.getPrmtNo());
					result = promotionDao.insertPromotionFreebie(promotionFreebiePO);
					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			} else {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public void updatePromotionGift(PromotionBasePO po) {
		po.setPrmtKindCd(AdminConstants.PRMT_KIND_20);
		po.setRvsMrgPmtYn("N");
		int result = promotionDao.updatePromotionBase(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 사이트와 이벤트  매핑정보 삭제 후 재등록
		promotionDao.deleteStGiftMap(po);

		if (po.getStId() != null && po.getStId().length > 0) {
			for (Long stId : po.getStId()) {
				StStdInfoPO stStdInfoPO = new StStdInfoPO();
				stStdInfoPO.setStId(stId);
				stStdInfoPO.setPrmtNo(po.getPrmtNo());

				result = promotionDao.insertStGiftMap(stStdInfoPO);

				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}

		int cnt = 0;
		JsonUtil jsonUtil = new JsonUtil();
		if(StringUtil.isNotBlank(po.getPromotionTargetDelStr())) {
			List<PromotionTargetPO> list = jsonUtil.toArray(PromotionTargetPO.class, po.getPromotionTargetDelStr());

			if(list != null && !list.isEmpty()) {
				for(PromotionTargetPO promotionTargetPO : list) {
					result = promotionDao.deletePromotionTarget(promotionTargetPO);
					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			} else {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		if(StringUtil.isNotBlank(po.getPromotionTargetStr())) {
			List<PromotionTargetPO> list = jsonUtil.toArray(PromotionTargetPO.class, po.getPromotionTargetStr());

			if(list != null && !list.isEmpty()) {

				for(PromotionTargetPO promotionTargetPO : list) {
					promotionTargetPO.setPrmtNo(po.getPrmtNo());
					cnt = promotionDao.selectPromotionTargetCheck(promotionTargetPO);
					if(cnt > 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}

					result = promotionDao.insertPromotionTarget(promotionTargetPO);
					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			} else {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		/*if(StringUtil.isNotBlank(po.getPromotionFreebieDelStr())) {
			List<PromotionFreebiePO> list = jsonUtil.toArray(PromotionFreebiePO.class, po.getPromotionFreebieDelStr());

			if(list != null && list.size() > 0) {
				for(PromotionFreebiePO promotionFreebiePO : list) {
					result = promotionDao.deletePromotionFreebie(promotionFreebiePO);
					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			} else {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}*/

		PromotionFreebiePO deleteFreebiePO  = new PromotionFreebiePO();
		deleteFreebiePO.setPrmtNo(po.getPrmtNo());
		promotionDao.deletePromotionFreebie(deleteFreebiePO);

		if(StringUtil.isNotBlank(po.getPromotionFreebieStr())) {
			List<PromotionFreebiePO> list = jsonUtil.toArray(PromotionFreebiePO.class, po.getPromotionFreebieStr());

			if(list != null && !list.isEmpty()) {



				for(PromotionFreebiePO promotionFreebiePO : list) {
					promotionFreebiePO.setPrmtNo(po.getPrmtNo());
					// 2017.01.25, 이성용, 사용하지 않는 로직을 삭제함.
					//cnt = promotionDao.selectPromotionFreebieCheck(promotionFreebiePO);
					//if(cnt > 0) {
					//	throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					//}
					result = promotionDao.insertPromotionFreebie(promotionFreebiePO);
					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			} else {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

	}

	@Override
	public List<PromotionTargetVO> listPromotionTarget(PromotionSO so) {
		so.setPrmtAplGbCd(AdminConstants.PRMT_APL_GB_10);
		List<StStdInfoVO> stStdList = promotionDao.listStStdInfoByPromotion(so);
		so.setStStdList(stStdList);

		return promotionDao.listPromotionTarget(so);
	}

	@Override
	public List<PromotionFreebieVO> listPromotionFreebie(PromotionSO so) {
		so.setPrmtAplGbCd(AdminConstants.PRMT_APL_GB_10);
		List<StStdInfoVO> stStdList = promotionDao.listStStdInfoByPromotion(so);
		so.setStStdList(stStdList);

		return promotionDao.listPromotionFreebie(so);
	}


	@Override
	@Transactional(readOnly=true)
	public List<PromotionBaseVO> pagePromotionBase(PromotionSO so) {
		return promotionDao.pagePromotionBase(so);
	}

	@Override
	@Transactional(readOnly=true)
	public PromotionBaseVO getPromotionBase(PromotionSO so) {
		return promotionDao.getPromotionBase(so);
	}

	/**
	 * 가격할인 프로모션
	 * 상품 리스트
	 */
	@Override
	@Transactional(readOnly=true)
	public List<PromotionTargetVO> listPromotionGoods(PromotionSO so) {
		so.setPrmtAplGbCd(AdminConstants.PRMT_APL_GB_10);
		List<StStdInfoVO> stStdList = promotionDao.listStStdInfoByPromotion(so);
		so.setStStdList(stStdList);

		return promotionDao.listPromotionGoods(so);
	}
	/**
	 * 가격할인 프로모션
	 * 제외 상품 리스트
	 */
	@Override
	@Transactional(readOnly=true)
	public List<PromotionTargetVO> listPromotionGoodsEx(PromotionSO so) {
		so.setPrmtAplGbCd(AdminConstants.PRMT_APL_GB_10);
		List<StStdInfoVO> stStdList = promotionDao.listStStdInfoByPromotion(so);
		so.setStStdList(stStdList);
		return promotionDao.listPromotionGoodsEx(so);
	}

	/**
	 * 가격할인 프로모션
	 * 기획전 전시카테고리 트리
	 */
	@Override
	@Transactional(readOnly=true)
	public List<DisplayPromotionTreeVO> listPromotionDisplayTree(PromotionSO so) {
		return promotionDao.listPromotionDisplayTree(so);
	}
	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.promotion.service
	* - 파일명      : PromotionServiceImpl.java
	* - 작성일      : 2017. 2. 17.
	* - 작성자      : valuefctory 권성중
	* - 설명      :  가격할인  전시분류 리스트
	* </pre>
	*/
	@Override
	public List<DisplayPromotionTreeVO> listPromotionShowDispClsf (Long prmtNo ) {
		return promotionDao.listPromotionShowDispClsf(prmtNo);
	}

	/**
	 * 가격할인 프로모션 등록
	 */
	@Override
	public void insertPromotion(PromotionBasePO po) {
		//po.setPrmtNo(bizService.getSequence(AdminConstants.SEQUENCE_PROMOTION_BASE_SEQ));
		po.setPrmtKindCd(AdminConstants.PRMT_KIND_10);

		int result = promotionDao.insertPromotionBase(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 사이트와 쿠폰의 매핑정보 등록
		if (po.getStId() != null && po.getStId().length > 0) {
			for (Long stId : po.getStId()) {
				StStdInfoPO stStdInfoPO = new StStdInfoPO();
				stStdInfoPO.setStId(stId);
				stStdInfoPO.setPrmtNo(po.getPrmtNo());

				result = promotionDao.insertStPromotionMap(stStdInfoPO);
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}

		log.debug("=============★======"+po.getPrmtTgCd() );
		if(AdminConstants.PRMT_TG_20.equals(po.getPrmtTgCd())){

			if(po.getArrGoodsId() != null && po.getArrGoodsId().length > 0){
				for(String goodsId : po.getArrGoodsId()) {
					PromotionTargetPO promotionTargetPO = new PromotionTargetPO();
					promotionTargetPO.setPrmtNo(po.getPrmtNo());
					promotionTargetPO.setGoodsId(goodsId);

					result = promotionDao.insertPromotionTarget(promotionTargetPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		} else if(AdminConstants.PRMT_TG_30.equals(po.getPrmtTgCd())) {
			if(po.getArrDispClsfNo() != null && po.getArrDispClsfNo().length > 0){
				for(Long dispClsfNo : po.getArrDispClsfNo()) {
					PromotionTargetPO promotionTargetPO = new PromotionTargetPO();
					promotionTargetPO.setPrmtNo(po.getPrmtNo());
					promotionTargetPO.setDispClsfNo(dispClsfNo);

					result = promotionDao.insertPromotionTarget(promotionTargetPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		} else if(AdminConstants.PRMT_TG_40.equals(po.getPrmtTgCd())) {
			if(po.getArrExhbtNo() != null && po.getArrExhbtNo().length > 0){
				for(Long exhbtNo : po.getArrExhbtNo()) {
					PromotionTargetPO promotionTargetPO = new PromotionTargetPO();
					promotionTargetPO.setPrmtNo(po.getPrmtNo());
					promotionTargetPO.setExhbtNo(exhbtNo);

					result = promotionDao.insertPromotionTarget(promotionTargetPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}else if(AdminConstants.PRMT_TG_50.equals(po.getPrmtTgCd())) {
			if(po.getArrCompNo() != null && po.getArrCompNo().length > 0){
				for(Long compNo : po.getArrCompNo()) {
					PromotionTargetPO promotionTargetPO = new PromotionTargetPO();
					promotionTargetPO.setPrmtNo(po.getPrmtNo());
					promotionTargetPO.setCompNo(compNo);

					result = promotionDao.insertPromotionTarget(promotionTargetPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}else if(AdminConstants.PRMT_TG_60.equals(po.getPrmtTgCd())
				&& po.getArrBndNo() != null && po.getArrBndNo().length > 0) {
			for(Long bndNo : po.getArrBndNo()) {
				PromotionTargetPO promotionTargetPO = new PromotionTargetPO();
				promotionTargetPO.setPrmtNo(po.getPrmtNo());
				promotionTargetPO.setBndNo(bndNo);

				result = promotionDao.insertPromotionTarget(promotionTargetPO);

				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}

		// 프로모션 적용 대상이 카테고리나 기획전일 때 제외 상품이 있으면 등록함.
		if (hasExcludedGoods(po)) {
			for(String goodsId : po.getArrGoodsExId()) {
				PromotionTargetPO promotionTargetPO = new PromotionTargetPO();
				promotionTargetPO.setPrmtNo(po.getPrmtNo());
				promotionTargetPO.setGoodsId(goodsId);

				result = promotionDao.insertPromotionExTarget(promotionTargetPO);

				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
	}
	/**
	 * 가격할인 프로모션 수정
	 */
	@Override
	public void updatePromotion(PromotionBasePO po) {

		po.setPrmtKindCd(AdminConstants.PRMT_KIND_10);

		PromotionSO so = new PromotionSO();
		so.setPrmtNo(po.getPrmtNo());

		PromotionBaseVO vo = getPromotionBase(so);

		if(vo == null) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_GROUP_DUPLICATION_FAIL);
		}

		int result = promotionDao.updatePromotionBase(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		/*
		 * 사이트정보는 수정할 수 없으므로 매핑테이블 관련 작업은 하지 않도록 주석처리 함.
		 *
		// 사이트와 프로모션  매핑정보 삭제 후 재등록
		result = promotionDao.deleteStGiftMap(po);
		// 사이트와 프로모션의 매핑정보 등록
		if (po.getStId() != null && po.getStId().length > 0) {
			for (Long stId : po.getStId()) {
				StStdInfoPO stStdInfoPO = new StStdInfoPO();
				stStdInfoPO.setStId(stId);
				stStdInfoPO.setPrmtNo(po.getPrmtNo());

				result = promotionDao.insertStPromotionMap(stStdInfoPO);
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
		*/

		PromotionTargetPO targetPO = new PromotionTargetPO();
		targetPO.setPrmtNo(po.getPrmtNo());
		//targetPO.setAplSeq(po.getAplSeq());

		promotionDao.deletePromotionTarget(targetPO);

		if(AdminConstants.PRMT_TG_20.equals(po.getPrmtTgCd())){

			if(po.getArrGoodsId() != null && po.getArrGoodsId().length > 0){
				for(String goodsId : po.getArrGoodsId()) {
					PromotionTargetPO promotionTargetPO = new PromotionTargetPO();
					promotionTargetPO.setPrmtNo(po.getPrmtNo());
					promotionTargetPO.setGoodsId(goodsId);

					result = promotionDao.insertPromotionTarget(promotionTargetPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		} else if(AdminConstants.PRMT_TG_30.equals(po.getPrmtTgCd())) {
			if(po.getArrDispClsfNo() != null && po.getArrDispClsfNo().length > 0){
				for(Long dispClsfNo : po.getArrDispClsfNo()) {
					PromotionTargetPO promotionTargetPO = new PromotionTargetPO();
					promotionTargetPO.setPrmtNo(po.getPrmtNo());
					promotionTargetPO.setDispClsfNo(dispClsfNo);

					result = promotionDao.insertPromotionTarget(promotionTargetPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		} else if(AdminConstants.PRMT_TG_40.equals(po.getPrmtTgCd())) {
			if(po.getArrExhbtNo() != null && po.getArrExhbtNo().length > 0){
				for(Long exhbtNo : po.getArrExhbtNo()) {
					PromotionTargetPO promotionTargetPO = new PromotionTargetPO();
					promotionTargetPO.setPrmtNo(po.getPrmtNo());
					promotionTargetPO.setExhbtNo(exhbtNo);

					result = promotionDao.insertPromotionTarget(promotionTargetPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}else if(AdminConstants.PRMT_TG_50.equals(po.getPrmtTgCd())) {
			if(po.getArrCompNo() != null && po.getArrCompNo().length > 0){
				for(Long compNo : po.getArrCompNo()) {
					PromotionTargetPO promotionTargetPO = new PromotionTargetPO();
					promotionTargetPO.setPrmtNo(po.getPrmtNo());
					promotionTargetPO.setCompNo(compNo);

					result = promotionDao.insertPromotionTarget(promotionTargetPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}else if(AdminConstants.PRMT_TG_60.equals(po.getPrmtTgCd())
				&& po.getArrBndNo() != null && po.getArrBndNo().length > 0) {
			for(Long bndNo : po.getArrBndNo()) {
				PromotionTargetPO promotionTargetPO = new PromotionTargetPO();
				promotionTargetPO.setPrmtNo(po.getPrmtNo());
				promotionTargetPO.setBndNo(bndNo);

				result = promotionDao.insertPromotionTarget(promotionTargetPO);

				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}

		// 프로모션 적용 대상이 카테고리나 기획전일 때 제외 상품이 있으면 삭제 후 재 등록함.
		if (hasExcludedGoods(po)) {
			// 프로모션 적용 제외 대상 상품 삭제
			promotionDao.deletePromotionExTarget(po);

			for(String goodsId : po.getArrGoodsExId()) {
				PromotionTargetPO promotionTargetPO = new PromotionTargetPO();
				promotionTargetPO.setPrmtNo(po.getPrmtNo());
				promotionTargetPO.setGoodsId(goodsId);

				result = promotionDao.insertPromotionExTarget(promotionTargetPO);

				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}

	}

	// 프로모션 적용 대상이 카테고리나 기획전일 때 제외 상품이 있는지 확인
	private boolean hasExcludedGoods(PromotionBasePO po) {

		return (AdminConstants.PRMT_TG_30.equals(po.getPrmtTgCd())
				|| AdminConstants.PRMT_TG_40.equals(po.getPrmtTgCd())
				|| AdminConstants.PRMT_TG_50.equals(po.getPrmtTgCd())
				|| AdminConstants.PRMT_TG_60.equals(po.getPrmtTgCd())
				)
				&& (po.getArrGoodsExId() != null && po.getArrGoodsExId().length > 0);
	}
	/**
	 * 가격할인프로모션 삭제
	 * @param po
	 */
	@Override
	public void deletePromotion(PromotionBasePO po) {
		PromotionSO so = new PromotionSO();
		so.setPrmtNo(po.getPrmtNo());

		PromotionBaseVO vo = getPromotionBase(so);

		if(vo == null) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_GROUP_DUPLICATION_FAIL);
		}

		// 사이트와 프로모션  매핑정보 삭제
		promotionDao.deleteStGiftMap(po);

		// 타겟삭제
		PromotionTargetPO targetPO = new PromotionTargetPO();
		targetPO.setPrmtNo(po.getPrmtNo());
		promotionDao.deletePromotionTarget(targetPO);

		//제외상품 삭제
		promotionDao.deletePromotionExTarget(po);

		//프로모션 베이스 삭제
		int result = promotionDao.deletePromotionBase(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_COUPON_DELETE);
		}
	}

	@Override
	@Transactional(readOnly=true)
	public List<CompanyBaseVO> listPromotionTargetCompNo(PromotionSO so) {
		return promotionDao.listPromotionTargetCompNo(so);
	}

	@Override
	@Transactional(readOnly=true)
	public List<BrandBaseVO> listPromotionTargetBndNo(PromotionSO so) {
		return promotionDao.listPromotionTargetBndNo(so);
	}

	@Override
	@Transactional(readOnly=true)
	public List<ExhibitionVO> listPromotionTargetExhbtNo(PromotionSO so) {
		return promotionDao.listPromotionTargetExhbtNo(so);
	}
}