package biz.app.member.service;

import biz.app.member.dao.MemberAddressDao;
import biz.app.member.model.MemberAddressPO;
import biz.app.member.model.MemberAddressSO;
import biz.app.member.model.MemberAddressVO;
import biz.common.service.BizService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.service
* - 파일명		: MemberAddressServiceImpl.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 회원 주소록 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("memberAddressService")
public class MemberAddressServiceImpl implements MemberAddressService {

	@Autowired private MemberAddressDao memberAddressDao;
	
	@Autowired private BizService bizService;

	/*
	 * 회원 주소록 목록 조회
	 * @see biz.app.member.service.MemberAddressService#listMemberAddress(biz.app.member.model.MemberAddressListSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<MemberAddressVO> listMemberAddress(MemberAddressSO so) {
		
		List<MemberAddressVO> addressList = this.memberAddressDao.listMemberAddress(so);
	
		for(MemberAddressVO vo : addressList) {
			String roadDtlAddr = bizService.twoWayDecrypt(vo.getRoadDtlAddr());
			String tel = bizService.twoWayDecrypt(vo.getTel());
			String mobile = bizService.twoWayDecrypt(vo.getMobile());
			String adrsNm = bizService.twoWayDecrypt(vo.getAdrsNm());
			String prclDtlAddr = bizService.twoWayDecrypt(vo.getPrclDtlAddr());
			
			vo.setRoadDtlAddr(roadDtlAddr);
			vo.setPrclDtlAddr(prclDtlAddr);
			vo.setTel(tel);
			vo.setMobile(mobile);
			vo.setAdrsNm(adrsNm);
		}
		return addressList;
	}

	/*
	 * 회원 주소록 상세 조회
	 * @see biz.app.member.service.MemberAddressService#getMemberAddress(java.lang.Integer)
	 */
	@Override
	@Transactional(readOnly=true)
	public MemberAddressVO getMemberAddress(Long mbrDlvraNo) {
		MemberAddressSO so = new MemberAddressSO();
		so.setMbrDlvraNo(mbrDlvraNo);
		
		MemberAddressVO address = memberAddressDao.getMemberAddress(so);
		address.setAdrsNm(bizService.twoWayDecrypt(address.getAdrsNm()));
		address.setMobile(bizService.twoWayDecrypt(address.getMobile()));
		address.setRoadDtlAddr(bizService.twoWayDecrypt(address.getRoadDtlAddr()));
		address.setPrclDtlAddr(bizService.twoWayDecrypt(address.getPrclDtlAddr()));
		
		return address;
	}

	
	/*
	 * 회원 기본배송지 조회
	 * @see biz.app.member.service.MemberAddressService#getMemberAddressDefault(java.lang.Integer)
	 */
	@Override
	@Transactional(readOnly = true)
	public MemberAddressVO getMemberAddressDefault(Long mbrNo) {
		MemberAddressSO so = new MemberAddressSO();
		so.setMbrNo(mbrNo);
		so.setDftYn(CommonConstants.COMM_YN_Y);
		MemberAddressVO address = Optional.ofNullable(memberAddressDao.getMemberAddress(so)).orElseGet(()->null);
		if(address != null){
			address.setAdrsNm(bizService.twoWayDecrypt(address.getAdrsNm()));
			address.setMobile(bizService.twoWayDecrypt(address.getMobile()));
			address.setRoadDtlAddr(bizService.twoWayDecrypt(address.getRoadDtlAddr()));
			address.setPrclDtlAddr(bizService.twoWayDecrypt(address.getPrclDtlAddr()));
		}

		return address;
	}

	/*
	 * 회원 주소록 등록
	 * @see biz.app.member.service.MemberAddressService#insertMemberAddress(biz.app.member.model.MemberAddressInsertPO)
	 */
	@Override
	public int insertMemberAddress(MemberAddressPO po) {
		int result = 0;
		
		// 배송지가 5개 이상일 경우 등록 안 함
		MemberAddressSO maso = new MemberAddressSO();
		maso.setMbrNo(po.getMbrNo());
		List<MemberAddressVO> maList = memberAddressDao.listMemberAddress(maso);
		if (CollectionUtils.isNotEmpty(maList) && maList.size() > 4) {
			return result;
		}
		
		//시퀀스 생성
		Long mbrDlvraNo = this.bizService.getSequence(CommonConstants.SEQUENCE_MEMBER_ADDRESS_SEQ);
		po.setMbrDlvraNo(mbrDlvraNo);
		
		if(StringUtil.isEmpty(po.getGoodsRcvPstEtc())){
			po.setGoodsRcvPstEtc(null);
		}
		if(StringUtil.isEmpty(po.getPblGatePswd())){
			po.setPblGatePswd(null);
		}
		if(StringUtil.isEmpty(po.getDlvrDemand())){
			po.setDlvrDemand(null);
		}
		if(StringUtil.isEmpty(po.getDftYn())){
			po.setDftYn("N");
		}
		
		
		po.setAdrsNm(bizService.twoWayEncrypt(po.getAdrsNm()));
		po.setMobile(bizService.twoWayEncrypt(po.getMobile()));
		po.setRoadDtlAddr(bizService.twoWayEncrypt(po.getRoadDtlAddr()));
		
		//temp
		//po.setPrclAddr(po.getRoadAddr());
		po.setPrclDtlAddr(po.getRoadDtlAddr());
		
		result = this.memberAddressDao.insertMemberAddress(po);

		// 기본배송지 설정
		if(CommonConstants.COMM_YN_Y.equals(po.getDftYn())){
			updateMemberAddressDefault(po);
		}
		
		if(result != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		return result;
	}

	/*
	 * 회원 주소록 수정
	 * @see biz.app.member.service.MemberAddressService#updateMemberAddress(biz.app.member.model.MemberAddressUpdatePO)
	 */
	@Override
	public int updateMemberAddress(MemberAddressPO po) {
		// 기본배송지 설정
		if("Y".equals(po.getDftYn())){
			updateMemberAddressDefault(po);
		}
		if(StringUtil.isEmpty(po.getGoodsRcvPstEtc())){
			po.setGoodsRcvPstEtc(null);
		}
		if(StringUtil.isEmpty(po.getPblGatePswd())){
			po.setPblGatePswd(null);
		}
		if(StringUtil.isEmpty(po.getDlvrDemand())){
			po.setDlvrDemand(null);
		}
		
		po.setAdrsNm(bizService.twoWayEncrypt(po.getAdrsNm()));
		po.setMobile(bizService.twoWayEncrypt(po.getMobile()));
		po.setRoadDtlAddr(bizService.twoWayEncrypt(po.getRoadDtlAddr()));
		po.setPrclDtlAddr(bizService.twoWayEncrypt(po.getPrclDtlAddr()));

		int result = this.memberAddressDao.updateMemberAddress(po);
		
		if(result != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		return result;
	}

	/*
	 * 회원 주소록 기본 설정
	 * 1:정상, 0:실패
	 * @see biz.app.member.service.MemberAddressService#updateMemberAddressDefault(biz.app.member.model.MemberAddressDefaultUpdatePO)
	 */
	@Override
	public void updateMemberAddressDefault(MemberAddressPO po) {
		
		Long mbrNo = po.getMbrNo();
		Long mbrDlvraNo = po.getMbrDlvraNo();
		
		// 회원의 모든 주속 'N' 처리
		po.setMbrNo(mbrNo);
		po.setMbrDlvraNo(null);
		po.setDftYn(CommonConstants.COMM_YN_N);
		this.memberAddressDao.updateMemberAddressDefault(po);
		
		// 요청 배송지 순번을 기본으로 설정
		po.setMbrNo(null);
		po.setMbrDlvraNo(mbrDlvraNo);
		po.setDftYn(CommonConstants.COMM_YN_Y);
		
		int result = this.memberAddressDao.updateMemberAddressDefault(po);
		
		if(result != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

	}

//	/*
//	 * 회원 주소록 선택 삭제
//	 * 지정된 배송지 주소에 대해서만 삭제 처리
//	 * 삭제수, 0:실패
//	 * @see biz.app.member.service.MemberAddressService#deleteAddress(java.lang.Integer[])
//	 */
//	@Override
//	public void deleteMemberAddress(Long[] mbrDlvraNos) {
//		MemberAddressPO po = null;
//		
//		if(mbrDlvraNos != null && mbrDlvraNos.length > 0){
//			for(Long mbrDlvraNo : mbrDlvraNos){
//				po = new MemberAddressPO();
//				po.setMbrDlvraNo(mbrDlvraNo);
//				this.memberAddressDao.deleteMemberAddress(po);
//			}
//		}else{
//			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
//		}
//		
//
//	}

	/* 
	 * 회원 주소록 삭제(건별)
	 * @see biz.app.member.service.MemberAddressService#deleteAddress(java.lang.Long)
	 */
	@Override
	public int deleteMemberAddress(Long mbrDlvraNo) {
		MemberAddressPO po = new MemberAddressPO();
		po.setMbrDlvraNo(mbrDlvraNo);
		int result = this.memberAddressDao.deleteMemberAddress(po);
		
		if(result != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		return result;
	}
}