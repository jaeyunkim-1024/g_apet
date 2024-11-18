package biz.app.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.member.dao.MemberInterestGoodsDao;
import biz.app.member.model.MemberInterestGoodsPO;
import biz.app.member.model.MemberInterestGoodsSO;
import biz.app.member.model.MemberInterestGoodsVO;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.service
* - 파일명		: MemberInterestGoodsServiceImpl.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 회원 관심상품 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("memberInterestGoodsService")
public class MemberInterestGoodsServiceImpl implements MemberInterestGoodsService {

	@Autowired private MemberInterestGoodsDao memberInterestGoodsDao;

	@Override
	public int insertMemberInterestGoods(MemberInterestGoodsPO po, String search) {
		int rs =0;
		MemberInterestGoodsSO so = new MemberInterestGoodsSO();
		so.setMbrNo(po.getMbrNo());
		so.setGoodsId(po.getGoodsId());
		MemberInterestGoodsVO miGoods = this.memberInterestGoodsDao.getMemberInterestGoods(so);

		// 관심상품에 등록되지 않은 경우에만 등록
		if(miGoods == null){
			int result = this.memberInterestGoodsDao.insertMemberInterestGoods(po);

			if(result != 1){
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			rs = 1;
		}else{
			if (search == null || search.isEmpty()) {
				Long mbrNo = po.getMbrNo();
				String [] goodsIds = new String[1];
				goodsIds[0] = po.getGoodsId();
	
				this.deleteMemberInterestGoods(mbrNo, goodsIds);
				rs = 2;
			}
			//throw new CustomException(ExceptionConstants.ERROR_MEMBER_INTEREST_GOODS_DUPLICATE);
		}
		return rs;
	}


	/* 회원 관심 상품 목록
	 * @see biz.app.member.service.MemberInterestGoodsService#pageMemberInterestGoods(biz.app.member.model.MemberInterestGoodsSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<MemberInterestGoodsVO> pageMemberInterestGoods(MemberInterestGoodsSO so) {
		return this.memberInterestGoodsDao.pageMemberInterestGoods(so);
	}

	/* 회원 관심 상품 삭제
	 * @see biz.app.member.service.MemberInterestGoodsService#deleteMemberInterestGoods(java.lang.String[])
	 */
	@Override
	public void deleteMemberInterestGoods(Long mbrNo, String[] goodsIds) {
		MemberInterestGoodsPO po = new MemberInterestGoodsPO();
		int result = 0;

		if(goodsIds != null && goodsIds.length > 0){
			for(String goodsId : goodsIds){
				po.setMbrNo(mbrNo);
				po.setGoodsId(goodsId);
				result += this.memberInterestGoodsDao.deleteMemberInterestGoods(po);
			}

			if(result == 0){
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}else{
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}
	}

	/*
	 * 회원 관심 상품 삭제(Batch용)
	 * @see biz.app.member.service.MemberInterestGoodsService#deleteMemberInterestGoods(biz.app.member.model.MemberInterestGoodsPO)
	 */
	@Override
	public void deleteMemberInterestGoods(MemberInterestGoodsPO po) {
		this.memberInterestGoodsDao.deleteMemberInterestGoods(po);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestGoodsServiceImpl.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: hjko
	* - 설명		: 마이페이지 > 찜 > 상품 목록 모두출력
	* </pre>
	* @param iso
	* @return
	 */
	@Override
	public List<MemberInterestGoodsVO> listMemberInterestGoods(MemberInterestGoodsSO so){
		return this.memberInterestGoodsDao.listMemberInterestGoods(so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberInterestGoodsServiceImpl.java
	 * - 작성일		: 2017. 3. 14.
	 * - 작성자		: hjko
	 * - 설명		: 마이페이지 > 찜상품 개수
	 * </pre>
	 * @param iso
	 * @return
	 */
	@Override
	public int listMemberInterestGoodsCount(MemberInterestGoodsSO so){
		
		return this.memberInterestGoodsDao.listMemberInterestGoodsCount(so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2017. 07. 11.
	 * - 작성자		: wyjeong
	 * - 설명		: 회원 찜 상품 여부
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<MemberInterestGoodsVO> checkMemberInterestGoods(MemberInterestGoodsSO so) {
		return memberInterestGoodsDao.checkMemberInterestGoods(so);
	}

	@Override
	public MemberInterestGoodsVO getMemberInterestGoods(String goodsId) {
		MemberInterestGoodsSO so = new MemberInterestGoodsSO();
		so.setGoodsId(goodsId);
		return memberInterestGoodsDao.getMemberInterestGoods(so);
	}
}