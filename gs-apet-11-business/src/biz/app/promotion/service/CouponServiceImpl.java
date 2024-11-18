package biz.app.promotion.service;

import biz.app.brand.model.BrandBaseVO;
import biz.app.company.model.CompanyBaseVO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.member.model.MemberCouponVO;
import biz.app.promotion.dao.CouponDao;
import biz.app.promotion.dao.CouponIssueDao;
import biz.app.promotion.model.*;
import biz.app.st.model.StStdInfoPO;
import biz.app.st.model.StStdInfoVO;
import biz.common.service.BizService;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.util.FrontSessionUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.*;

/**
 * 사이트 ServiceImpl
 * @author		snw
 * @since		2015.06.11
 */
@Slf4j
@Service
@Transactional
public class CouponServiceImpl implements CouponService {

	@Autowired
	private CouponDao couponDao;
	
	@Autowired
	private CouponIssueDao couponIssueDao;

	@Autowired
	private BizService bizService;

	@Autowired
	private CouponIssueService couponIssueService;

	@Override
	@Transactional(readOnly=true)
	public List<CouponBaseVO> pageCouponBase(CouponSO so) {
		return couponDao.pageCouponBase(so);
	}

	@Override
	@Transactional(readOnly=true)
	public CouponBaseVO getCouponBase(CouponSO so) {
		return couponDao.getCouponBase(so);
	}

	@Override
	public void insertCoupon(CouponBasePO po) {
		
		// 쿠폰 지급 방식 코드입력 경우(쿠폰코드 중복 체크)
		if(AdminConstants.CP_PVD_MTH_50.equals(po.getCpPvdMthCd())) {
			//쿠폰 코드 없을 시 최초 등록
			String isuSrlNo = Optional.ofNullable(po.getCpCd()).orElseThrow(()->new CustomException(ExceptionConstants.ERROR_COUPON_CD_DATA));
			CouponIssueSO ciso = new CouponIssueSO();
			ciso.setIsuSrlNo(isuSrlNo);
			CouponIssueVO couponIssue = couponIssueService.getCouponIssue(ciso);
			if(couponIssue != null) {
				//쿠폰 코드일 때는 시리얼 번호로 coupon_issue
				CouponIssuePO isuSrlNoCp = new CouponIssuePO();
				isuSrlNoCp.setIsuSrlNo(isuSrlNo);
				if(Integer.compare(couponIssueDao.getCouponIssueCnt(isuSrlNoCp),0) != 0){
					throw new CustomException(ExceptionConstants.ERROR_COUPON_SAME_DOWNLOAD); // 발급중인 쿠폰과 쿠폰코드가 동일입니다.
				}
			}
		}
		
		po.setCpNo(bizService.getSequence(AdminConstants.SEQUENCE_COUPON_BASE_SEQ));

		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		if(ftpImgUtil.tempFileCheck(po.getCpImgPathnm())){
			String filePath = ftpImgUtil.uploadFilePath(po.getCpImgPathnm(), AdminConstants.COUPON_IMAGE_PATH + FileUtil.SEPARATOR + po.getCpNo());
			ftpImgUtil.upload(po.getCpImgPathnm(), filePath);
			po.setCpImgPathnm(filePath);
		}

		int result = couponDao.insertCouponBase(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 회원 등급 코드 등록
		String[] arrMbrGrdCd = po.getArrMbrGrdCd();
		for(String mbrGrdCd : arrMbrGrdCd) {
			po.setMbrGrdCd(mbrGrdCd);
			couponDao.insertCouponMbrGrd(po);
		}

		// 사이트와 쿠폰의 매핑정보 등록
		if (po.getStId() != null && po.getStId().length > 0) {
			for (Long stId : po.getStId()) {
				StStdInfoPO stStdInfoPO = new StStdInfoPO();
				stStdInfoPO.setStId(stId);
				stStdInfoPO.setCpNo(po.getCpNo());

				result = couponDao.insertStCouponMap(stStdInfoPO);
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}

		// 쿠폰 지급 방식 난수입력 경우
		if(AdminConstants.CP_PVD_MTH_20.equals(po.getCpPvdMthCd())) {
			if(po.getCpIsuQty() > 0) {
				for(int i=0; i < po.getCpIsuQty(); i++){
					try {
						String uuid = UUID.randomUUID().toString().replace("-", "").substring(0, 16).toUpperCase();
						CouponIssuePO couponIssuePO = new CouponIssuePO();
						couponIssuePO.setIsuSrlNo(uuid);
						couponIssuePO.setCpNo(po.getCpNo());
						result = couponDao.insertCouponIssue(couponIssuePO);
						if(result == 0) {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
					} catch (Exception e){
						i--;
						log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					}
				}
			} else {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
		// 쿠폰 지급 방식 코드입력 경우
		else if(AdminConstants.CP_PVD_MTH_50.equals(po.getCpPvdMthCd())) {
			try {
				CouponIssuePO couponIssuePO = new CouponIssuePO();
				couponIssuePO.setIsuSrlNo(po.getCpCd());
				couponIssuePO.setCpNo(po.getCpNo());
				result = couponDao.insertCouponIssue(couponIssuePO);
				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			} catch (Exception e){
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}
		}

		if(AdminConstants.CP_TG_20.equals(po.getCpTgCd())){
			if(po.getArrGoodsId() != null && po.getArrGoodsId().length > 0){
				for(String goodsId : po.getArrGoodsId()) {
					CouponTargetPO couponTargetPO = new CouponTargetPO();
					couponTargetPO.setCpNo(po.getCpNo());
					couponTargetPO.setGoodsId(goodsId);

					result = couponDao.insertCouponTarget(couponTargetPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		} else if(AdminConstants.CP_TG_30.equals(po.getCpTgCd())) {
			if(po.getArrDispClsfNo() != null && po.getArrDispClsfNo().length > 0){
				for(Long dispClsfNo : po.getArrDispClsfNo()) {
					CouponTargetPO couponTargetPO = new CouponTargetPO();
					couponTargetPO.setCpNo(po.getCpNo());
					couponTargetPO.setDispClsfNo(dispClsfNo);

					result = couponDao.insertCouponTarget(couponTargetPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}

		} else if(AdminConstants.CP_TG_40.equals(po.getCpTgCd())) {
			if(po.getArrExhbtNo()  != null && po.getArrExhbtNo().length > 0){
				for(Long exhbtNo : po.getArrExhbtNo()) {
					CouponTargetPO couponTargetPO = new CouponTargetPO();
					couponTargetPO.setCpNo(po.getCpNo());
					couponTargetPO.setExhbtNo(exhbtNo);

					result = couponDao.insertCouponTarget(couponTargetPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}else if(AdminConstants.CP_TG_50.equals(po.getCpTgCd())) {
			if(po.getArrCompNo() != null && po.getArrCompNo().length > 0){
				for(Long compNo : po.getArrCompNo()) {
					CouponTargetPO couponTargetPO = new CouponTargetPO();
					couponTargetPO.setCpNo(po.getCpNo());
					couponTargetPO.setCompNo(compNo);

					result = couponDao.insertCouponTarget(couponTargetPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}else if(AdminConstants.CP_TG_60.equals(po.getCpTgCd())
				&& po.getArrBndNo() != null && po.getArrBndNo().length > 0) {
			for(Long bndNo : po.getArrBndNo()) {
				CouponTargetPO couponTargetPO = new CouponTargetPO();
				couponTargetPO.setCpNo(po.getCpNo());
				couponTargetPO.setBndNo(bndNo);

				result = couponDao.insertCouponTarget(couponTargetPO);

				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}

		// 쿠폰 적용 대상이 카테고리나 기획전일 때 제외 상품이 있으면 등록함.
		if (hasExcludedGoods(po)) {
			for(String goodsId : po.getArrGoodsExId()) {
				CouponTargetPO couponTargetPO = new CouponTargetPO();
				couponTargetPO.setCpNo(po.getCpNo());
				couponTargetPO.setGoodsId(goodsId);

				result = couponDao.insertCouponExTarget(couponTargetPO);

				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
	}

	// 쿠폰 적용 대상이 카테고리나 기획전일 때 제외 상품이 있는지 확인
	private boolean hasExcludedGoods(CouponBasePO po) {

		return (AdminConstants.CP_TG_30.equals(po.getCpTgCd())
				|| AdminConstants.CP_TG_40.equals(po.getCpTgCd())
				|| AdminConstants.CP_TG_50.equals(po.getCpTgCd())
				|| AdminConstants.CP_TG_60.equals(po.getCpTgCd())
				)
				&& (po.getArrGoodsExId() != null && po.getArrGoodsExId().length > 0);
	}

	@Override
	public void updateCoupon(CouponBasePO po) {
		CouponSO so = new CouponSO();
		so.setCpNo(po.getCpNo());

		CouponBaseVO vo = Optional.ofNullable(getCouponBase(so)).orElseThrow(()->new CustomException(ExceptionConstants.ERROR_CODE_GROUP_DUPLICATION_FAIL));

		//COUPON_ISSUE TABLE 초기화 작업 추가 - 09.02 kjy01
		String orgCpPvdMthCd = vo.getCpPvdMthCd();
		String newCpPvdMthCd = po.getCpPvdMthCd();
		String cpStatCd = vo.getCpStatCd();
		
		// 쿠폰 지급 방식 코드입력 경우(쿠폰코드 중복 체크)
		if(AdminConstants.CP_PVD_MTH_50.equals(newCpPvdMthCd)) {
			//쿠폰 코드 없을 시 최초 등록
			String isuSrlNo = Optional.ofNullable(po.getCpCd()).orElseThrow(()->new CustomException(ExceptionConstants.ERROR_COUPON_CD_DATA));
			CouponIssueSO ciso = new CouponIssueSO();
			ciso.setIsuSrlNo(isuSrlNo);
			CouponIssueVO couponIssue = couponIssueService.getCouponIssue(ciso);
			//쿠폰 코드일 때는 시리얼 번호로 coupon_issue
			CouponIssuePO isuSrlNoCp = new CouponIssuePO();
			isuSrlNoCp.setCpNo(po.getCpNo());
			isuSrlNoCp.setIsuSrlNo(isuSrlNo); 

			if(couponIssue != null) {
				if(Integer.compare(couponIssueDao.getCouponIssueCnt(isuSrlNoCp),0) != 0){
					throw new CustomException(ExceptionConstants.ERROR_COUPON_SAME_DOWNLOAD); // 발급중인 쿠폰과 쿠폰코드가 동일입니다.
				}
			}

			if(AdminConstants.CP_STAT_10.equals(vo.getCpStatCd())) {
				try {
					// 쿠폰코드 삭제
					couponIssueDao.deleteCouponCode(isuSrlNoCp);

					int result = couponDao.insertCouponIssue(isuSrlNoCp);
					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				} catch (Exception e){
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				}
			}
		}
		/*
			쿠폰 상태 : 승인 전
			쿠폰 지급 유형 : 난수 혹은 코드입력이 였다가 그외의 것으로 변경 시
		 */
		String[] arr = new String[]{CommonConstants.CP_PVD_MTH_20,CommonConstants.CP_PVD_MTH_50};
		HashSet<String> set = new HashSet<>(Arrays.asList(arr));

		//COUPON_ISSUE TABLE 초기화 여부
		/*
			CASE 1 : 난수 -> 코드입력
			CASE 2 : 코드 입력 -> 난수
			CASE 3 : 난수,코드 입력 -> 그외 ( 다운로드,수동,자동 )
		 */
		boolean case1 = StringUtil.equals(orgCpPvdMthCd,CommonConstants.CP_PVD_MTH_20) && StringUtil.equals(newCpPvdMthCd,CommonConstants.CP_PVD_MTH_50);
		boolean case2 = StringUtil.equals(orgCpPvdMthCd,CommonConstants.CP_PVD_MTH_50) && StringUtil.equals(newCpPvdMthCd,CommonConstants.CP_PVD_MTH_20);
		boolean case3 = set.contains(orgCpPvdMthCd) && !set.contains(newCpPvdMthCd);

		if(StringUtil.equals(cpStatCd,CommonConstants.CP_STAT_10) && (case1 || case2 || case3)){
			if(!AdminConstants.CP_PVD_MTH_50.equals(newCpPvdMthCd)) {
				couponDao.deleteCouponIssue(po);
			}

			if(case1 || case2){
				vo.setCpIsuQty(null);
			}
		}

		//새로 바뀌는 발급 수량이 무한일 경우, cpIsuQty = null로 초기화
		if(StringUtil.equals(po.getCpIsuCd(),CommonConstants.CP_ISU_10)){
			po.setCpIsuQty(null);
		}

		int result = couponDao.updateCouponBase(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		// 회원 등급 코드 삭제
		couponDao.deleteCouponMbrGrd(po);

		// 회원 등급 코드 등록
		String[] arrMbrGrdCd = po.getArrMbrGrdCd();
		for(String mbrGrdCd : arrMbrGrdCd) {
			po.setMbrGrdCd(mbrGrdCd);
			couponDao.insertCouponMbrGrd(po);
		}

		//쿠폰 대상 삭제 및 재 생성
		couponDao.deleteCouponTarget(po);
		if(AdminConstants.CP_TG_20.equals(po.getCpTgCd())){
			if(po.getArrGoodsId() != null && po.getArrGoodsId().length > 0){
				for(String goodsId : po.getArrGoodsId()) {
					CouponTargetPO couponTargetPO = new CouponTargetPO();
					couponTargetPO.setCpNo(po.getCpNo());
					couponTargetPO.setGoodsId(goodsId);

					result = couponDao.insertCouponTarget(couponTargetPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		} else if(AdminConstants.CP_TG_30.equals(po.getCpTgCd())) {
			if(po.getArrDispClsfNo() != null && po.getArrDispClsfNo().length > 0){
				for(Long dispClsfNo : po.getArrDispClsfNo()) {
					CouponTargetPO couponTargetPO = new CouponTargetPO();
					couponTargetPO.setCpNo(po.getCpNo());
					couponTargetPO.setDispClsfNo(dispClsfNo);

					result = couponDao.insertCouponTarget(couponTargetPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}else if(AdminConstants.CP_TG_40.equals(po.getCpTgCd())) {
			if(po.getArrExhbtNo()  != null && po.getArrExhbtNo().length > 0){
				for(Long exhbtNo : po.getArrExhbtNo()) {
					CouponTargetPO couponTargetPO = new CouponTargetPO();
					couponTargetPO.setCpNo(po.getCpNo());
					couponTargetPO.setExhbtNo(exhbtNo);

					result = couponDao.insertCouponTarget(couponTargetPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}else if(AdminConstants.CP_TG_50.equals(po.getCpTgCd())) {
			if(po.getArrCompNo() != null && po.getArrCompNo().length > 0){
				for(Long compNo : po.getArrCompNo()) {
					CouponTargetPO couponTargetPO = new CouponTargetPO();
					couponTargetPO.setCpNo(po.getCpNo());
					couponTargetPO.setCompNo(compNo);

					result = couponDao.insertCouponTarget(couponTargetPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}else if(AdminConstants.CP_TG_60.equals(po.getCpTgCd())
				&& po.getArrBndNo() != null && po.getArrBndNo().length > 0) {
			for(Long bndNo : po.getArrBndNo()) {
				CouponTargetPO couponTargetPO = new CouponTargetPO();
				couponTargetPO.setCpNo(po.getCpNo());
				couponTargetPO.setBndNo(bndNo);

				result = couponDao.insertCouponTarget(couponTargetPO);

				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}

		// 쿠폰 적용 대상이 카테고리나 기획전일 때 제외 상품이 있으면 삭제 후 재 등록함.
		if (hasExcludedGoods(po)) {
			// 쿠폰 적용 제외 대상 상품 삭제
			couponDao.deleteCouponExTarget(po);

			for(String goodsId : po.getArrGoodsExId()) {
				CouponTargetPO couponTargetPO = new CouponTargetPO();
				couponTargetPO.setCpNo(po.getCpNo());
				couponTargetPO.setGoodsId(goodsId);

				result = couponDao.insertCouponExTarget(couponTargetPO);

				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}

		/*
		조건 :
		난수쿠폰, 쿠폰 발급 코드가 제한
		*/
		String cpIsuCd = po.getCpIsuCd();
		if(		StringUtil.equals(cpStatCd,CommonConstants.CP_STAT_10) &&
				StringUtil.equals(newCpPvdMthCd,CommonConstants.CP_PVD_MTH_20) && StringUtil.equals(cpIsuCd,CommonConstants.CP_ISU_20)){
			//최초 등록 시 입력한 제한 수
			Long orgCpIsuQty = Optional.ofNullable(vo.getCpIsuQty()).orElseGet(()->0L);
			//코드입력 -> 난수일 경우, 입력된 isuSrlNo 지우고 제한수만큼 새로 생성
			if(case2){
				orgCpIsuQty = 0L;
			}
			//수정 시 입력한 제한 수
			Long newCpIsuQty = Optional.ofNullable(po.getCpIsuQty()).orElseGet(()->0L);

			int compare = Long.compare(orgCpIsuQty,newCpIsuQty);

			//감소했을 때
			if(compare > 0){
				CouponIssuePO decrease = new CouponIssuePO();
				decrease.setCpNo(po.getCpNo());
				decrease.setDecreaseCnt(orgCpIsuQty-newCpIsuQty);

				couponIssueDao.deleteCouponCode(decrease);
			}
			//추가 되었을 때
			if(compare < 0){
				Long increaseCnt = newCpIsuQty - orgCpIsuQty;
				Integer limit = increaseCnt.intValue();
				for(int i=0; i<limit; i+=1){
					try {
						String uuid = UUID.randomUUID().toString().replace("-", "").substring(0, 16).toUpperCase();
						CouponIssuePO couponIssuePO = new CouponIssuePO();
						couponIssuePO.setIsuSrlNo(uuid);
						couponIssuePO.setCpNo(po.getCpNo());
						result = couponDao.insertCouponIssue(couponIssuePO);
						if(result == 0) {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
					} catch (Exception e){
						i--;
						log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					}
				}
			}
		}

	}

	@Override
	public void deleteCoupon(CouponBasePO po) {
		CouponSO so = new CouponSO();
		so.setCpNo(po.getCpNo());

		CouponBaseVO vo = getCouponBase(so);

		if(vo == null) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 쿠폰을 발급받은 회원이 있는지 확인
		int cnt = couponDao.getCouponBaseDeleteCheck(po);
		if(cnt > 0){
			throw new CustomException(ExceptionConstants.ERROR_COUPON_DELETE_CHECK);
		}
		// 쿠폰 대상 상품 삭제
		couponDao.deleteCouponTarget(po);
		// 쿠폰 발권 번호 삭제
		couponDao.deleteCouponIssue(po);
		// 쿠폰 대상 제외 상품 삭제
		couponDao.deleteCouponExTarget(po);
		// 쿠폰 매핑(사이트) 정보 삭제
		couponDao.deleteStCouponMap(po);

		int result = couponDao.deleteCouponBase(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_COUPON_DELETE);
		}

		/*FtpImgUtil ftpImgUtil = new FtpImgUtil();
		try {
			ftpImgUtil.delete(vo.getCpImgPathnm());
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}*/
		
		// 회원 등급 코드 삭제
		couponDao.deleteCouponMbrGrd(po);

	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: CouponServiceImpl.java
	 * - 작성일		: 2016. 3. 2.
	 * - 작성자		: 김재윤
	 * - 설명		: [FO]쿠폰존 - 쿠폰 리스트 ( 2021.03.04 기준 쿠폰존 페이징 X. 이후 페이징 요건 혹은 타 파트에서 페이징 필요 시, rows만 SET 하여 호출)
	 * </pre>
	 */
	@Override
	@Transactional(readOnly=true)
	public List<CouponBaseVO> listCouponZone(CouponSO so) {
		so.setCpShowYn(CommonConstants.COMM_YN_Y);		// 쿠폰존 노출 여부 Y
		so.setOutsideCpYn(CommonConstants.COMM_YN_N);	// 외부 쿠폰 아닌 것
		so.setCpStatCd(CommonConstants.CP_STAT_20);		// 진행 중인 쿠폰만 조회

		so.setMbrNo(FrontSessionUtil.getSession().getMbrNo());

		return couponDao.pageCoupon(so);
	}

	@Override
	@Transactional(readOnly=true)
	public List<CouponTargetVO> listCouponGoods(CouponSO so) {
		so.setPrmtAplGbCd(AdminConstants.PRMT_APL_GB_20);
		List<StStdInfoVO> stStdList = couponDao.listStStdInfoByCoupon(so);
		so.setStStdList(stStdList);

		return couponDao.listCouponGoods(so);
	}

	@Override
	@Transactional(readOnly=true)
	public List<CouponTargetVO> listCouponGoodsEx(CouponSO so) {
		so.setPrmtAplGbCd(AdminConstants.PRMT_APL_GB_20);
		List<StStdInfoVO> stStdList = couponDao.listStStdInfoByCoupon(so);
		so.setStStdList(stStdList);

		return couponDao.listCouponGoodsEx(so);
	}

	@Override
	@Transactional(readOnly=true)
	public List<DisplayCouponTreeVO> listCouponDisplayTree(CouponSO so) {
		return couponDao.listCouponDisplayTree(so);
	}
	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.promotion.service
	* - 파일명      : CouponServiceImpl.java
	* - 작성일      : 2017. 4. 7.
	* - 작성자      : valuefactory 권성중
	* - 설명      :홈 > 마케팅 관리 > 쿠폰 프로모션 > 쿠폰 등록
	* </pre>
	 */
	@Override
	@Transactional(readOnly=true)
	public List<DisplayCouponTreeVO> listCouponShowDispClsf(CouponSO so) {
		return couponDao.listCouponShowDispClsf(so);
	}






	/* 쿠폰 정보 조회
	 * @see biz.app.promotion.service.CouponService#getCoupon(biz.app.promotion.model.CouponSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public CouponBaseVO getCoupon(CouponSO so) {
		return couponDao.getCoupon(so);
	}

	/* 쿠폰 대상 상품 조회
	 * @see biz.app.promotion.service.CouponService#pageCouponTargetGoods(biz.app.promotion.model.CouponTargetSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<GoodsBaseVO> pageCouponTargetGoods(CouponTargetSO sto) {
		return couponDao.pageCouponTargetGoods(sto);
	}

	/* 쿠폰 대상 카테고리 조회
	 * @see biz.app.promotion.service.CouponService#pageCouponTargetCategory(biz.app.promotion.model.CouponTargetSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<DisplayCategoryVO> getCouponTargetCategory(CouponTargetSO sto) {
		return couponDao.getCouponTargetCategory(sto);
	}

	@Override
	@Transactional(readOnly=true)
	public List<MemberCouponVO> pageMemberCoupon(CouponSO so) {
		return couponDao.pageMemberCoupon(so);
	}

	@Override
	@Transactional(readOnly=true)
	public List<CouponIssueVO> pageCouponIssue(CouponSO so) {
		List<StStdInfoVO> stStdList = couponDao.listStStdInfoByCoupon(so);
		so.setStStdList(stStdList);

		return couponDao.pageCouponIssue(so);
	}

	@Override
	@Transactional(readOnly=true)
	public List<CouponIssueVO> pageDownCouponIssue(CouponSO so) {
		List<StStdInfoVO> stStdList = couponDao.listStStdInfoByCoupon(so);
		so.setStStdList(stStdList);

		return couponDao.pageDownCouponIssue(so);
	}

	@Override
	public void updateBatchCouponCpStat() {
		couponDao.updateBatchCouponCpStat();
	}

	@Override
	public String goodsDlvrcPayMth(String goodsId) {
		return couponDao.goodsDlvrcPayMth(goodsId);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.promotion.service
	* - 파일명      : CouponServiceImpl.java
	* - 작성일      : 2017. 4. 19.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 홈 > 마케팅 관리 > 쿠폰 프로모션 > 쿠폰 등록    // 쿠폰대상인 업체 인  업체 리스트
	* </pre>
	 */
	@Override
	@Transactional(readOnly=true)
	public List<CompanyBaseVO> listCouponTargetCompNo(CouponSO so) {
		return couponDao.listCouponTargetCompNo(so);
	}

	@Override
	@Transactional(readOnly=true)
	public List<BrandBaseVO> listCouponTargetBndNo(CouponSO so) {
		return couponDao.listCouponTargetBndNo(so);
	}

	@Override
	@Transactional(readOnly=true)
	public List<ExhibitionVO> listCouponTargetExhbtNo(CouponSO so) {
		return couponDao.listCouponTargetExhbtNo(so);
	}
	
	@Override
	@Transactional(readOnly=false)
	public CouponBasePO copyCoupon(CouponSO so) {
		CouponBaseVO vo = getCouponBase(so);
		
		if(vo.getVldPrdEndDtm() != null) {
			Timestamp vldPrdEndDtm = DateUtil.getTimestamp(DateUtil.getTimestampToString(vo.getVldPrdEndDtm()), "yyyyMMdd");
			vo.setVldPrdEndDtm(vldPrdEndDtm);
		}
		if(vo.getAplEndDtm() != null) {
			Timestamp aplEndDtm = DateUtil.getTimestamp(DateUtil.getTimestampToString(vo.getAplEndDtm()), "yyyyMMdd");
			vo.setAplEndDtm(aplEndDtm);
		}
		
		List<CouponTargetVO> couponTargetList = couponDao.listCouponTarget(so); 
		List<CouponTargetVO> couponExGoodsList = couponDao.listCouponExGoods(so); 
		BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );
		
		CouponBasePO po = new CouponBasePO();
		try {
			BeanUtils.copyProperties(po, vo );
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}


		Long newCpNo = bizService.getSequence(AdminConstants.SEQUENCE_COUPON_BASE_SEQ);
		po.setCpNo(newCpNo);
		po.setCpNm("[복사]".concat(vo.getCpNm()));
		po.setCpStatCd(CommonConstants.CP_STAT_10);
		int result = couponDao.insertCouponBase(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 회원 등급 코드 등록
		String[] arrMbrGrdCd = vo.getMbrGrdCd().split(",");
		for(String mbrGrdCd : arrMbrGrdCd) {
			po.setMbrGrdCd(mbrGrdCd);
			couponDao.insertCouponMbrGrd(po);
		}
		
		// 사이트와 쿠폰의 매핑정보 등록
		
		for(StStdInfoVO site : vo.getStStdList()) {
			StStdInfoPO stStdInfoPO = new StStdInfoPO();
			stStdInfoPO.setStId(site.getStId());
			stStdInfoPO.setCpNo(newCpNo);
			
			result = couponDao.insertStCouponMap(stStdInfoPO);
			if (result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
		
		//대상 리스트
		for(CouponTargetVO target : couponTargetList) {
			CouponTargetPO couponTargetPO = new CouponTargetPO();
			try {
				BeanUtils.copyProperties(couponTargetPO, target);
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
			}
			couponTargetPO.setCpNo(newCpNo);
			result = couponDao.insertCouponTarget(couponTargetPO);

			if(result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
		
		//제외상품 리스트
		for(CouponTargetVO exGoods : couponExGoodsList) {
			CouponTargetPO exGoodsPO = new CouponTargetPO();
			try {
				BeanUtils.copyProperties(exGoodsPO, exGoods);
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
			}
			exGoodsPO.setCpNo(newCpNo);
			result = couponDao.insertCouponExTarget(exGoodsPO);

			if(result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
		
		//난수 생성 쿠폰일 때, 시리얼 번호 새로 채번
		if(AdminConstants.CP_PVD_MTH_20.equals(vo.getCpPvdMthCd())) {
			if(vo.getCpIsuQty() > 0) {
				for(int i=0; i < vo.getCpIsuQty(); i++){
					try {
						String uuid = UUID.randomUUID().toString().replace("-", "").substring(0, 16).toUpperCase();
						CouponIssuePO couponIssuePO = new CouponIssuePO();
						couponIssuePO.setIsuSrlNo(uuid);
						couponIssuePO.setCpNo(newCpNo);
						result = couponDao.insertCouponIssue(couponIssuePO);
						if(result == 0) {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
					} catch (Exception e){
						i--;
						log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					}
				}
			} else {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
		
		return po;
		
	}

	@Override
	public String getCouponIsAllDownYn(CouponSO so) {
		String result = CommonConstants.COMM_YN_Y;
		so.setCpShowYn(CommonConstants.COMM_YN_Y);		// 쿠폰존 노출 여부 Y
		so.setOutsideCpYn(CommonConstants.COMM_YN_N);	// 외부 쿠폰 아닌 것
		so.setCpStatCd(CommonConstants.CP_STAT_20);		// 진행 중인 쿠폰만 조회
		so.setMbrNo(FrontSessionUtil.getSession().getMbrNo());

		//정회원,준회원 구분
		String mbrGbCd = FrontSessionUtil.getSession().getMbrGbCd();
		if(StringUtil.equals(mbrGbCd, FrontConstants.MBR_GB_CD_10)){
			so.setIsuTgCd(FrontConstants.ISU_TG_20);
		}else if(StringUtil.equals(mbrGbCd,FrontConstants.MBR_GB_CD_20)){
			so.setIsuTgCd(FrontConstants.ISU_TG_10);
		}else{
			so.setIsuTgCd(FrontConstants.ISU_TG_00);
		}
		MemberCouponVO obj = couponDao.getCouponIsDownYn(so);

		Integer cpDownCnt = obj.getCpDownCnt();
		Integer mbrCpDownCnt = obj.getMbrCpDownCnt();

		if(Integer.compare(cpDownCnt,mbrCpDownCnt) == 0 || Integer.compare(cpDownCnt,mbrCpDownCnt) < 0){
			result = CommonConstants.COMM_YN_N;
		}
		return result;
	}
}