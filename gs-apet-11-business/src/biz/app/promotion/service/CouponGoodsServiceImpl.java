package biz.app.promotion.service;

import biz.app.member.dao.MemberCouponDao;
import biz.app.member.model.MemberCouponPO;
import biz.app.promotion.dao.CouponGoodsDao;
import biz.app.promotion.model.CouponTargetGoodsVO;
import biz.app.promotion.model.CouponTargetSO;
import biz.common.service.BizService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;

@Slf4j
@Service("couponGoodsServiceImpl")
public class CouponGoodsServiceImpl implements CouponGoodsService {

	@Autowired
	private CouponGoodsDao couponGoodsDao;

	@Autowired private MemberCouponDao memberCouponDao;

	@Autowired
	private BizService bizService;

	@Override
	public List<CouponTargetGoodsVO> listCouponTargetGoodsDetail(CouponTargetSO so) {
		return couponGoodsDao.listCouponTargetGoodsDetail(so);
	}

	@Override
	public List<CouponTargetGoodsVO> pageCouponTargetGoodsDetail(CouponTargetSO so) {
		return couponGoodsDao.pageCouponTargetGoodsDetail(so);
	}

	@Override
	public int pageCouponTargetGoodsDetailCount(CouponTargetSO so) {
		return couponGoodsDao.pageCouponTargetGoodsDetailCount(so);
	}

	@Override
	public synchronized int insertCouponGoodsMember(CouponTargetGoodsVO couponVo, MemberCouponPO po) {

		int insertCnt = 0;
		if ("N".equals(couponVo.getCpDwYn()) || ("Y".equals(couponVo.getDupleUseYn()) && "Y".equals(couponVo.getCpUseYn()))) {
			try {
				Long mbrCpNo = this.bizService.getSequence(CommonConstants.SEQUENCE_MEMBER_COUPON_SEQ);
				po.setCpNo(couponVo.getCpNo());
				po.setMbrCpNo(mbrCpNo);
				po.setUseYn(CommonConstants.COMM_YN_N);
				insertCnt = this.memberCouponDao.insertMemberCoupon(po);
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}
		}
		return insertCnt;
	}

	@Override
	public MemberCouponPO couponGoodsMemberValidation(CouponTargetGoodsVO coupon) throws CustomException {
		MemberCouponPO po = new MemberCouponPO();
		long today = System.currentTimeMillis();
		long aplStrtDtm = coupon.getAplStrtDtm().getTime();
		long aplEndDtm = coupon.getAplEndDtm().getTime();

		Integer mbrCpCnt = 0;

		if(CommonConstants.CP_STAT_20.equals(coupon.getCpStatCd())){
			if(aplStrtDtm<=today && today<=aplEndDtm){ // 적용시작일시

				// 유효기간코드 10: 발급일, 20: 일자지정  hjko 추가
				if(CommonConstants.VLD_PRD_10.equals(coupon.getVldPrdCd())){

					// 사용시작일시와 사용종료일시 세팅
					String ss = DateUtil.getNowDate()+" 00:00:00";
					Timestamp strtd = DateUtil.getTimestamp(ss, "yyyyMMdd 00:00:00") ;
					po.setUseStrtDtm(strtd);

					String e = DateUtil.addDays(DateUtil.getNowDate(), coupon.getVldPrdDay().intValue())+" 23:59:59" ;
					Timestamp endd = DateUtil.getTimestamp(e, "yyyyMMdd HH:mm:ss");

					po.setUseEndDtm(endd);

				}else{
					po.setUseStrtDtm(coupon.getVldPrdStrtDtm());
					po.setUseEndDtm(coupon.getVldPrdEndDtm());
				}

				// 중복 사용 체크 : 사용이 가능한 경우 등록 아닌 경우 예외처리
				if(CommonConstants.COMM_YN_N.equals(coupon.getDupleUseYn())){
					//현재 회원쿠폰테이블에 중복 쿠폰 존재하는지 체크

					mbrCpCnt = this.memberCouponDao.getMemberCouponCnt(po);

					if(mbrCpCnt.intValue() > 0){
						// 해당 쿠폰은 중복 사용할 수 없습니다.
						throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_DUPLICATION);
					}
				}else{
					po.setUseYn(CommonConstants.USE_YN_N);
					mbrCpCnt = this.memberCouponDao.getMemberCouponCnt(po);

					if(mbrCpCnt.intValue() > 0){
						// 이미 다운로드 받은 쿠폰입니다.
						throw new CustomException(ExceptionConstants.ERROR_COUPON_ALREADY_DOWNLOAD);
					}
				}

				if(CommonConstants.CP_ISU_20.equals(coupon.getCpIsuCd())){ // 쿠폰 발급 수량이 제한일 경우
					//해당 쿠폰발급 수량 count
					Integer cpIsuQty = this.memberCouponDao.getCouponBaseIsuQty(po);
					if(cpIsuQty >= coupon.getCpIsuQty()) {
						//발급 가능한 수량이 없습니다
						throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_AVAILABLE_QTY);
					}
				}

			}else{ //사용종료된 쿠폰입니다
				throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_PERIOD);
			}
		}else{
			// 정상 쿠폰이 아닙니다.
			throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_NORMAL);
		}

		return po;
	}
}
