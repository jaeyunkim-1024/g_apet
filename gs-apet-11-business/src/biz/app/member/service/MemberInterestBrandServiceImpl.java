package biz.app.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.member.dao.MemberInterestBrandDao;
import biz.app.member.model.MemberInterestBrandPO;
import biz.app.member.model.MemberInterestBrandSO;
import biz.app.member.model.MemberInterestBrandVO;
import biz.app.member.model.MemberInterestGoodsSO;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.service
* - 파일명		: MemberInterestBrandService.java
* - 작성일		: 2017. 02. 08.
* - 작성자		: wyjeong
* - 설명		: 회원 관심 브랜드 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("memberInterestBrandService")
public class MemberInterestBrandServiceImpl implements MemberInterestBrandService {

	@Autowired private MemberInterestBrandDao memberInterestBrandDao;

	/**
	 * 회원 관심 브랜드 등록
	 */
	@Override
	public int insertMemberInterestBrand(MemberInterestBrandPO po) {
		int rs = 0;
		MemberInterestBrandSO so = new MemberInterestBrandSO();
		so.setMbrNo(po.getMbrNo());
		so.setBndNo(po.getBndNo());
		MemberInterestBrandVO miBrand = this.memberInterestBrandDao.getMemberInterestBrand(so);

		// 관심 브랜드에 등록되지 않은 경우에만 등록
		if (miBrand == null) {
			int result = this.memberInterestBrandDao.insertMemberInterestBrand(po);

			if (result != 1) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			rs = 1;
		}
		else {
			Long mbrNo = po.getMbrNo();
			Long[] bndNos = new Long[1];
			bndNos[0] = po.getBndNo();

			this.deleteMemberInterestBrand(mbrNo, bndNos);
			rs = 2;
		}
		return rs;
	}


	/**
	 * 회원 관심 브랜드 목록
	 */
	@Override
	@Transactional(readOnly = true)
	public List<MemberInterestBrandVO> pageMemberInterestBrand(MemberInterestBrandSO so) {
		return this.memberInterestBrandDao.pageMemberInterestBrand(so);
	}

	/**
	 * 회원 관심 브랜드 삭제
	 */
	@Override
	public void deleteMemberInterestBrand(Long mbrNo, Long[] bndNos) {
		MemberInterestBrandPO po = new MemberInterestBrandPO();
		int result = 0;

		if (bndNos != null && bndNos.length > 0) {
			StringBuilder bndNoParam = new StringBuilder();

			for (int i=0; i<bndNos.length; i++) {
				bndNoParam.append(bndNos[i]);
				if (i < bndNos.length-1) {bndNoParam.append(",");}
				//po.setMbrNo(mbrNo);
				//po.setBndNo(bndNo);
				//result += this.memberInterestBrandDao.deleteMemberInterestBrand(po);
			}

			po.setMbrNo(mbrNo);
			po.setBndNos(bndNoParam.toString());
			result =this.memberInterestBrandDao.deleteMemberInterestBrands(po);

			if (result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}
	}

	/**
	 * 회원 관심 상품 삭제(Batch용)
	 */
	@Override
	public void deleteMemberInterestBrand(MemberInterestBrandPO po) {
		this.memberInterestBrandDao.deleteMemberInterestBrand(po);
	}

	/**
	 *  마이페이지 > 찜 > 찜한 브랜드 목록
	 */
	@Override
	public List<MemberInterestBrandVO> listMemberInterestBrands(MemberInterestGoodsSO so){
		return this.memberInterestBrandDao.listMemberInterestBrands(so);
	}

	/**
	 *  마이페이지 > 위시리스트 > 위시리스트 브랜드 목록
	 */
	@Override
	public List<MemberInterestBrandVO> pageMemberInterestBrands(MemberInterestBrandSO so){
		return this.memberInterestBrandDao.pageMemberInterestBrands(so);
	}
}