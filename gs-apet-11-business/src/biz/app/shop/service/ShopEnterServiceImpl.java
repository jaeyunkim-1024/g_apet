package biz.app.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.shop.dao.ShopEnterDao;
import biz.app.shop.model.ShopEnterFileSO;
import biz.app.shop.model.ShopEnterFileVO;
import biz.app.shop.model.ShopEnterPO;
import biz.app.shop.model.ShopEnterSO;
import biz.app.shop.model.ShopEnterVO;
import biz.common.model.AttachFilePO;
import biz.common.service.BizService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.FileUtil;
import framework.common.util.FtpFileUtil;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.shop.service
* - 파일명	: ShopEnterServiceImpl.java
* - 작성일	: 2016. 4. 18.
* - 작성자	: jangjy
* - 설명		: 입점문의 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("shopEnterService")
public class ShopEnterServiceImpl implements ShopEnterService {

	@Autowired private BizService bizService;
	
	@Autowired private ShopEnterDao shopEnterDao;

	/*
	 * 입점문의 등록
	 * @see biz.app.shop.service.ShopEnterService#insertShopEnter(biz.app.shop.model.ShopEnterPO)
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public void insertShopEnter(ShopEnterPO po) {
		
		String[] orgFlNms = po.getOrgFlNms();
		String[] phyPaths = po.getPhyPaths();
		Long[] flSzs = po.getFlSzs();
		AttachFilePO filePO = null;
		
		if (orgFlNms != null && orgFlNms.length > 0) {
			Long flNo = this.bizService.getSequence(CommonConstants.SEQUENCE_ATTACH_FILE_SEQ);
			po.setFlNo(flNo);	// 파일 번호
			
			for (int i = 0; i < orgFlNms.length; i++) {
				filePO = new AttachFilePO();
				
				FtpFileUtil ftpFileUtil = new FtpFileUtil();
				String filePath = ftpFileUtil.uploadFilePath(phyPaths[i], CommonConstants.CONTECT_FILE_PATH + FileUtil.SEPARATOR + po.getFlNo());
				
				filePO.setFlNo(po.getFlNo());
				filePO.setPhyPath(filePath);
				filePO.setFlSz(flSzs[i]);
				filePO.setOrgFlNm(orgFlNms[i]);
				filePO.setSysRegrNo(po.getSysRegrNo());
				
				ftpFileUtil.upload(phyPaths[i], filePath);
				
				this.bizService.insertAttachFile(filePO);
			}
		}
		
		Long seNo = this.bizService.getSequence(CommonConstants.SEQUENCE_SHOP_ENTER_SEQ);
		po.setSeNo(seNo);	// 입점 번호
		po.setSeStatCd(CommonConstants.SE_STAT_10);	// 입점 상태 : 요청
		po.setBizNo(po.getBizNo().replaceAll("-", ""));
		po.setPicMobile(po.getPicMobile().replaceAll("-", ""));
		
		int result = this.shopEnterDao.insertShopEnter(po);
		if(result != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	@Override
	public List<ShopEnterVO> pageContectList(ShopEnterSO so) {
		return shopEnterDao.pageContectList(so);
	}

	@Override
	@Transactional(readOnly=true)
	public List<ShopEnterVO> listShopEnterDetail(ShopEnterSO so){

		return shopEnterDao.listShopEnterDetail(so);
	}
	
	@Override
	public List<ShopEnterFileVO> listShopEnterFile(ShopEnterFileSO sefso){
		return shopEnterDao.listShopEnterFile(sefso);
	}
}
