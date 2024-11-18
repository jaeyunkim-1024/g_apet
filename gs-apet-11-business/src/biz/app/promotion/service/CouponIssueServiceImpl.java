package biz.app.promotion.service;

import java.util.ArrayList;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.member.dao.MemberCouponDao;
import biz.app.member.model.MemberCouponPO;
import biz.app.member.service.MemberCouponService;
import biz.app.promotion.dao.CouponIssueDao;
import biz.app.promotion.model.CouponBaseVO;
import biz.app.promotion.model.CouponIssuePO;
import biz.app.promotion.model.CouponIssueSO;
import biz.app.promotion.model.CouponIssueVO;
import biz.app.promotion.model.CouponSO;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

@Transactional
@Service("couponIssueService")
public class CouponIssueServiceImpl implements CouponIssueService {

	@Autowired private CouponIssueDao couponIssueDao;
	@Autowired private MemberCouponService memberCouponService;
	@Autowired private MemberCouponDao memberCouponDao;
	@Autowired private CouponService couponService;

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CouponIssueServiceImpl.java
	* - 작성일		: 2016. 5. 10.
	* - 작성자		: kyh
	* - 설명		: 쿠폰 등록
	* @see biz.app.member.service.MemberService#checkCoupon(java.lang.Integer, java.lang.String)
	* </pre>
	* @param session
	* @param pswd
	* @param type
	* @return
	* @throws Exception
	*/

	@Override
	public void couponApply(CouponIssuePO po) {

		CouponIssueSO so = new CouponIssueSO();
		MemberCouponPO po1 = new MemberCouponPO();
		so.setMbrNo(po.getMbrNo());
		so.setIsuSrlNo(po.getIsuSrlNo());

		CouponIssueVO checkCoupon = couponIssueDao.getCouponIssue(so);

		if(checkCoupon != null){   // 등록된 쿠폰인 경우
			if(checkCoupon.getMbrCpNo() == null){  // 사용하지 않은 쿠폰인지 체크
				po.setCpNo(checkCoupon.getCpNo());

				po1.setCpNo(checkCoupon.getCpNo());
				po1.setMbrNo(po.getMbrNo());
				po1.setUseYn(CommonConstants.COMM_YN_N);
				po1.setSysRegrNo(po.getMbrNo());

				Long mbrCpNo = memberCouponService.insertMemberCoupon(po1);  // 사용자 쿠폰 등록
				po.setMbrCpNo(mbrCpNo);
				int ciResult = this.couponIssueDao.updateCouponIssue(po);
				if(ciResult != 1){ //오류가 발생하였습니다. 관리자에게 문의하시기 바랍니다.
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}

			} else {  // 이미 등록된 쿠폰입니다.
				throw new CustomException(ExceptionConstants.ERROR_COUPON_ALREADY_USED);
			}
		} else {  //쿠폰번호가 유효하지 않습니다. 다시 입력하여 주세요.
			throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_DATA);
		}
	}
	
	@Override
	public int deleteCouponIssueStb(ArrayList<CouponIssueVO> so) {
		int rtnValue = 0;
		if(so != null && so.size() > 0 ) {
			for(CouponIssueVO issueInfo : so ) {
				//쿠폰 발급 대상 삭제
				couponIssueDao.deleteCouponIssueStb(issueInfo);
				rtnValue ++;
			}
		}
		return rtnValue;
	}
	
	@Override
	public int insertMemberCouponList(Long cpNo, Long[] mbrNos) {
		
		Long usrNo = AdminSessionUtil.getSession().getUsrNo();
		int resCnt = 0;

		//쿠폰 유효기간 체크 후 대기, 즉시발급 여부 세팅
		CouponSO cso = new CouponSO();
		cso.setCpNo(cpNo);
		CouponBaseVO coupon = Optional.ofNullable(couponService.getCoupon(cso)).orElseThrow(()->new CustomException(ExceptionConstants.ERROR_COUPON_NO_DATA)); // 쿠폰번호를 다시 확인해주세요.
		long today = System.currentTimeMillis();
		long aplStrtDtm = coupon.getAplStrtDtm().getTime();
		boolean isIssueCoupon = (aplStrtDtm <= today); // 대기, 즉시 발급 여부
		
		for(Long mbrNo : mbrNos) {
			MemberCouponPO po = new MemberCouponPO();
			po.setCpNo(cpNo);
			po.setMbrNo(mbrNo);
			po.setSysRegrNo(usrNo);
			po.setIsuTpCd(CommonConstants.ISU_TP_30);		// 발급유형  ISU_TP_30 : CS
			
			// 유효한 쿠폰이 있거나 발급대기 중 회원은 제외
			po.setUseYn("N");
			if(Integer.compare(memberCouponDao.getMemberCouponCnt(po) ,0) == 0
				&& Integer.compare(couponIssueDao.getMemberCouponStbCnt(po) ,0) == 0
					){
				
				if(isIssueCoupon){
					// 쿠폰 발급 - 즉시
					memberCouponService.insertMemberCoupon(po, true);
				}else {
					// 쿠폰 발급 - 대기
					couponIssueDao.insertMemberCouponIssueStb(po);
				}
				resCnt++;
				
			}
		}
		
		return resCnt;
		
	}

	@Override
	public boolean selectCouponIssueStbYn(Long cpNo, Long mbrNo) {

		MemberCouponPO po = new MemberCouponPO();
		po.setCpNo(cpNo);
		po.setMbrNo(mbrNo);
		
		// 유효한 쿠폰이 있거나 발급대기 중 회원은 제외
		po.setUseYn("N");
				
		return (Integer.compare(memberCouponDao.getMemberCouponCnt(po) ,0) == 0 
				&& Integer.compare(couponIssueDao.getMemberCouponStbCnt(po) ,0) == 0);
	}
	
	/* 쿠폰발급 정보 조회
	 * @see biz.app.promotion.service.CouponIssueService#getCouponIssue(biz.app.promotion.model.CouponIssueSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public CouponIssueVO getCouponIssue(CouponIssueSO so) {
		return couponIssueDao.getCouponIssue(so);
	}

}
