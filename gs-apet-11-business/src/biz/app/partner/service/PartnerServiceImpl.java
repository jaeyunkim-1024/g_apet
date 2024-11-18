package biz.app.partner.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBizInfoPO;
import biz.app.member.service.MemberService;
import biz.app.partner.dao.PartnerDao;
import biz.app.partner.model.PartnerInfoPO;
import biz.app.partner.model.PartnerInfoSO;
import biz.app.partner.model.PartnerInfoVO;
import biz.app.system.service.UserServiceImpl;
import biz.common.service.BizService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.NhnObjectStorageUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.partner.service
 * - 파일명		: PartnerServiceImpl.java
 * - 작성자		: valueFactory
 * - 설명		: 파트너 Service Implement
 * </pre>
 */
@Slf4j
@Service
@Transactional
public class PartnerServiceImpl implements PartnerService {

	@Autowired private PartnerDao partnerDao;

	@Autowired private BizService bizService;
	
	@Autowired private MemberService memberService;
	
	@Autowired private NhnObjectStorageUtil nhnObjectStorageUtil;
	
	
	private PartnerInfoPO encrypt(PartnerInfoPO po) {
		// MEMBER_BASE 암호화
		if(po.getLoginId() != null && !po.getLoginId().equals("")) 	{po.setLoginId(bizService.twoWayEncrypt(po.getLoginId()));}
		if(po.getMbrNm() != null && !po.getMbrNm().equals("")) 		{po.setMbrNm(bizService.twoWayEncrypt(po.getMbrNm()));}
		if(po.getEmail() != null && !po.getEmail().equals("")) 		{po.setEmail(bizService.twoWayEncrypt(po.getEmail()));}
		if(po.getUpdrIp() != null && !po.getUpdrIp().equals("")) 	{po.setUpdrIp(bizService.twoWayEncrypt(po.getUpdrIp()));}
		
		// MEMBER_BIZ_INFO 암호화
		if(po.getBizNm() != null && !po.getBizNm().equals("")) 				{po.setBizNm(bizService.twoWayEncrypt(po.getBizNm()));}
		if(po.getRoadDtlAddr() != null && !po.getRoadDtlAddr().equals("")) 	{po.setRoadDtlAddr(bizService.twoWayEncrypt(po.getRoadDtlAddr()));}
		if(po.getPrclDtlAddr() != null && !po.getPrclDtlAddr().equals("")) 	{po.setPrclDtlAddr(bizService.twoWayEncrypt(po.getPrclDtlAddr()));}
		
		return po;
	}
	
	
	private PartnerInfoVO decrypt(PartnerInfoVO vo) {
		// MEMBER_BASE 복호화
		if(vo.getLoginId() != null && !vo.getLoginId().equals("")) 	{vo.setLoginId(bizService.twoWayDecrypt(vo.getLoginId()));}
		if(vo.getMbrNm() != null && !vo.getMbrNm().equals("")) 		{vo.setMbrNm(bizService.twoWayDecrypt(vo.getMbrNm()));}
		if(vo.getEmail() != null && !vo.getEmail().equals("")) 		{vo.setEmail(bizService.twoWayDecrypt(vo.getEmail()));}
		if(vo.getUpdrIp() != null && !vo.getUpdrIp().equals("")) 	{vo.setUpdrIp(bizService.twoWayDecrypt(vo.getUpdrIp()));}
		
		// MEMBER_BIZ_INFO 복호화
		if(vo.getBizNm() != null && !vo.getBizNm().equals("")) 				{vo.setBizNm(bizService.twoWayDecrypt(vo.getBizNm()));}
		if(vo.getRoadDtlAddr() != null && !vo.getRoadDtlAddr().equals("")) 	{vo.setRoadDtlAddr(bizService.twoWayDecrypt(vo.getRoadDtlAddr()));}
		if(vo.getPrclDtlAddr() != null && !vo.getPrclDtlAddr().equals("")) 	{vo.setPrclDtlAddr(bizService.twoWayDecrypt(vo.getPrclDtlAddr()));}
		
		return vo;
	}
	
	@Override
	public int getPartnerIdCheck(PartnerInfoSO so) {
		PartnerInfoPO partnerPO = new PartnerInfoPO();
		partnerPO.setLoginId(so.getLoginId());
		so.setLoginId(encrypt(partnerPO).getLoginId());
		
		return partnerDao.getPartnerIdCheck(so);
	}
	
	@Override
	public void insertPartner(PartnerInfoPO po) {
		// 회원 번호 get
		Long mbrNo = this.bizService.getSequence(CommonConstants.SEQUENCE_MEMBER_BASE_SEQ);
		po.setMbrNo(mbrNo);

		// 프로필 이미지 등록
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		String filePath = ftpImgUtil.uploadFilePath(po.getPrflImg(), CommonConstants.PET_LOG_PARTNER_IMG_PATH + FileUtil.SEPARATOR + po.getMbrNo());
		ftpImgUtil.upload(po.getPrflImg(), filePath);
		po.setPrflImg(filePath);
		
		// 회사명 = 회원명
		po.setMbrNm(po.getBizNm());
		po.setUpdrIp(RequestUtil.getClientIp());
		// 도로명 상세주소 = 지번 상세주소
		po.setPrclDtlAddr(po.getRoadDtlAddr());
		
		po.setMbrGrdCd(CommonConstants.MBR_GRD_40);
		
		// 암호화
		po = encrypt(po);
		
		// 파트너 insert
		int result = partnerDao.insertPartner(po);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		// 파트너 회사정보 insert
		result = partnerDao.insertPartnerBizInfo(po);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		// MEMBER_BASE_HIST insert
		memberService.insertMemberBaseHistory(mbrNo);
	}
	
	@Override
	public List<PartnerInfoVO> pagePartnerList(PartnerInfoSO so) {
		PartnerInfoPO po = new PartnerInfoPO();
		po.setLoginId(so.getLoginId());
		po.setBizNm(so.getBizNm());
		po.setEmail(so.getEmail());
		po = encrypt(po);
		
		so.setLoginId(po.getLoginId());
		so.setBizNm(po.getBizNm());
		so.setEmail(po.getEmail());
		
		List<PartnerInfoVO> listVO = partnerDao.pagePartnerList(so);
		List<PartnerInfoVO> returnListVO = new ArrayList<PartnerInfoVO>();
		
		for(PartnerInfoVO vo : listVO) {
			decrypt(vo);
			// 마스킹
			vo.setLoginId(MaskingUtil.getId(vo.getLoginId()));
			vo.setBizNm(MaskingUtil.getName(vo.getBizNm()));
			vo.setEmail(MaskingUtil.getEmail(vo.getEmail()));
			
			returnListVO.add(vo);
		}
			
		return returnListVO;
	}
	
	@Override
	public PartnerInfoVO getPartner(PartnerInfoSO so) {
		PartnerInfoVO vo = decrypt(partnerDao.getPartner(so));

		if(StringUtil.equals(so.getMaskingYn(), CommonConstants.COMM_YN_Y)) {
			vo.setLoginId(MaskingUtil.getId(vo.getLoginId()));
			vo.setBizNm(MaskingUtil.getName(vo.getBizNm()));
			vo.setEmail(MaskingUtil.getEmail(vo.getEmail()));
			vo.setRoadAddrFull(MaskingUtil.getAddress(vo.getRoadAddr(), vo.getRoadDtlAddr()));
		}
		
		return vo; 
	}
	
	@Override	
	public void updatePartner(PartnerInfoPO po) {
		// 프로필 이미지 등록
		if(po.getImgPathTemp() != null && po.getImgPathTemp() != "") {
			if(po.getPrflImg() != null && po.getPrflImg() != "") {
				nhnObjectStorageUtil.delete(po.getPrflImg());
			}
			po.setPrflImg(po.getImgPathTemp());
			
			FtpImgUtil ftpImgUtil = new FtpImgUtil();
			String filePath = ftpImgUtil.uploadFilePath(po.getPrflImg(), CommonConstants.PET_LOG_PARTNER_IMG_PATH + FileUtil.SEPARATOR + po.getMbrNo());
			ftpImgUtil.upload(po.getPrflImg(), filePath);
			po.setPrflImg(filePath);
		}
		
		// 회사명 = 회원명
		po.setMbrNm(po.getBizNm());
		po.setUpdrIp(RequestUtil.getClientIp());
		// 도로명 상세주소 = 지번 상세주소
		po.setPrclDtlAddr(po.getRoadDtlAddr());
		
		// 암호화
		po = encrypt(po);
		
		int result = partnerDao.updatePartner(po);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		result = partnerDao.updatePartnerBizInfo(po);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	@Override
	public int deleteImage(PartnerInfoPO po) {
		po.setSysUpdrNo(AdminSessionUtil.getSession().getUsrNo());
		po.setUpdrIp(RequestUtil.getClientIp());
		po = encrypt(po);
		
		// TODO 조은지 : 서버 사진 삭제
		int result = partnerDao.deleteImage(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		return result;
	}
	
	@Override
	public int getPartnerEmailCheck(PartnerInfoSO so) {
		PartnerInfoPO partnerPO = new PartnerInfoPO();
		partnerPO.setEmail(so.getEmail());
		so.setEmail(encrypt(partnerPO).getEmail());
		
		return partnerDao.getPartnerEmailCheck(so);		
	}
	
	@Override
	public int getPartnerNickNmCheck(PartnerInfoSO so) {
		return partnerDao.getPartnerNickNmCheck(so);		
	}
	
}
