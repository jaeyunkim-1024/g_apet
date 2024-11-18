package biz.app.brand.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.brand.dao.BrandCntsDao;
import biz.app.brand.model.BrandCntsItemPO;
import biz.app.brand.model.BrandCntsItemSO;
import biz.app.brand.model.BrandCntsItemVO;
import biz.app.brand.model.BrandCntsPO;
import biz.app.brand.model.BrandCntsSO;
import biz.app.brand.model.BrandCntsVO;
import biz.common.service.BizService;
import framework.admin.constants.AdminConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.StringUtil;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.brand.service
* - 파일명		: BrandCntsServiceImpl.java
* - 작성일		: 2017. 2. 7.
* - 작성자		: hongjun
 * - 설명		: 브랜드 콘텐츠 서비스
* </pre>
*/
@Service
@Transactional
public class BrandCntsServiceImpl implements BrandCntsService {

	@Autowired
	private BrandCntsDao brandCntsDao;

	@Autowired
	private BizService bizService;

	@Override
	@Transactional(readOnly=true)
	public List<BrandCntsVO> pageBrandCnts(BrandCntsSO so) {
		return brandCntsDao.pageBrandCnts(so);
	}

	@Override
	public void insertBrandCnts(BrandCntsPO po) {
		po.setBndCntsNo(bizService.getSequence(AdminConstants.SEQUENCE_BRAND_CNTS_SEQ));
		setImgPath(po);
		
		int result = brandCntsDao.insertBrandCnts(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void updateBrandCnts(BrandCntsPO po) {
		setImgPath(po);
		
		int result = brandCntsDao.updateBrandCnts(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	private void setImgPath(BrandCntsPO po) {
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		
		// PC이미지 처리
		if(ftpImgUtil.tempFileCheck(po.getCntsImgPath())){
			String filePath = ftpImgUtil.uploadFilePath(po.getCntsImgPath(), AdminConstants.BRAND_CNTS_IMAGE_PATH + FileUtil.SEPARATOR + po.getBndCntsNo());
			ftpImgUtil.upload(po.getCntsImgPath(), filePath);
			po.setCntsImgPath(filePath);
		}

		// MOBILE이미지 처리
		if(ftpImgUtil.tempFileCheck(po.getCntsMoImgPath())){
			String filePath = ftpImgUtil.uploadFilePath(po.getCntsMoImgPath(), AdminConstants.BRAND_CNTS_IMAGE_PATH + FileUtil.SEPARATOR + po.getBndCntsNo());
			ftpImgUtil.upload(po.getCntsMoImgPath(), filePath);
			po.setCntsMoImgPath(filePath);
		}
		
		// PC이미지 처리
		if(ftpImgUtil.tempFileCheck(po.getTnImgPath())){
			String filePath = ftpImgUtil.uploadFilePath(po.getTnImgPath(), AdminConstants.BRAND_CNTS_IMAGE_PATH + FileUtil.SEPARATOR + po.getBndCntsNo());
			ftpImgUtil.upload(po.getTnImgPath(), filePath);
			po.setTnImgPath(filePath);
		}

		// MOBILE이미지 처리
		if(ftpImgUtil.tempFileCheck(po.getTnMoImgPath())){
			String filePath = ftpImgUtil.uploadFilePath(po.getTnMoImgPath(), AdminConstants.BRAND_CNTS_IMAGE_PATH + FileUtil.SEPARATOR + po.getBndCntsNo());
			ftpImgUtil.upload(po.getTnMoImgPath(), filePath);
			po.setTnMoImgPath(filePath);
		}
	}

	@Override
	public void deleteBrandCnts(BrandCntsPO po) {
		BrandCntsItemSO itemSo = new BrandCntsItemSO();
		itemSo.setBndCntsNo(po.getBndCntsNo());
		List<BrandCntsItemVO> itemVos = brandCntsDao.pageBrandCntsItem(itemSo);
		Long[] itemNos = null;

		if(itemVos != null && !itemVos.isEmpty() ) {
			itemNos = new Long[itemVos.size()];
			for (int i = 0; i < itemVos.size(); i++) {
				itemNos[i] = itemVos.get(i).getItemNo();
			}
		}
		
		if (itemNos != null) {
			deleteBrandCntsItem(itemNos);
		}
		
		// 이미지 삭제
		BrandCntsSO so = new BrandCntsSO();
		so.setBndCntsNo(po.getBndCntsNo());
		BrandCntsVO vo = brandCntsDao.pageBrandCnts(so).get(0);
		if(vo != null ) {
			if(!StringUtil.isEmpty(vo.getCntsImgPath()) ) {
				imageDelete (vo.getCntsImgPath());
			}
			if(!StringUtil.isEmpty(vo.getCntsMoImgPath()) ) {
				imageDelete (vo.getCntsMoImgPath());
			}
			if(!StringUtil.isEmpty(vo.getTnImgPath()) ) {
				imageDelete (vo.getTnImgPath());
			}
			if(!StringUtil.isEmpty(vo.getTnMoImgPath()) ) {
				imageDelete (vo.getTnMoImgPath());
			}
		}
		
		int result = brandCntsDao.deleteBrandCnts(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_COUPON_DELETE);
		}
	}

	@Override
	@Transactional(readOnly=true)
	public List<BrandCntsItemVO> pageBrandCntsItem(BrandCntsItemSO so) {
		return brandCntsDao.pageBrandCntsItem(so);
	}

	@Override
	public void brandCntsItemSave(BrandCntsItemPO po) {
		Long itemNo = null;
		if (po.getItemNo() == null) {
			itemNo = bizService.getSequence(AdminConstants.SEQUENCE_BRAND_CNTS_ITEM_SEQ);
		}		
		
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		
		// PC이미지 처리
		if(ftpImgUtil.tempFileCheck(po.getItemImgPath())){
			String filePath = ftpImgUtil.uploadFilePath(po.getItemImgPath(), AdminConstants.BRAND_CNTS_ITEM_IMAGE_PATH + FileUtil.SEPARATOR + itemNo);
			ftpImgUtil.upload(po.getItemImgPath(), filePath);
			po.setItemImgPath(filePath);
		}

		// MOBILE이미지 처리
		if(ftpImgUtil.tempFileCheck(po.getItemMoImgPath())){
			String filePath = ftpImgUtil.uploadFilePath(po.getItemMoImgPath(), AdminConstants.BRAND_CNTS_ITEM_IMAGE_PATH + FileUtil.SEPARATOR + itemNo);
			ftpImgUtil.upload(po.getItemMoImgPath(), filePath);
			po.setItemMoImgPath(filePath);
		}
		
		int result;
		if (po.getItemNo() == null) {
			po.setItemNo(itemNo);
			result = brandCntsDao.insertBrandCntsItem(po);
		} else {
			result = brandCntsDao.updateBrandCntsItem(po);
		}

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public int deleteBrandCntsItem(Long[] itemNos) {
		int rtnValue = 0;

		if(itemNos != null && itemNos.length > 0 ) {
			for(Long itemNo : itemNos ) {
				// 이미지 삭제
				BrandCntsItemSO so = new BrandCntsItemSO();
				so.setItemNo(itemNo);
				BrandCntsItemVO vo = brandCntsDao.pageBrandCntsItem(so).get(0);
				if(vo != null ) {
					if(!StringUtil.isEmpty(vo.getItemImgPath()) ) {
						imageDelete (vo.getItemImgPath());
					}
					if(!StringUtil.isEmpty(vo.getItemMoImgPath()) ) {
						imageDelete (vo.getItemMoImgPath());
					}
				}

				BrandCntsPO po = new BrandCntsPO();
				po.setItemNo(itemNo);
				brandCntsDao.deleteBrandCntsItem(po );
				rtnValue ++;
			}
		}

		return rtnValue;		
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsServiceImpl.java
	 * - 작성일		: 2017. 2. 7.
	 * - 작성자		: hongjun
	* - 설명			: 이미지 삭제
	* </pre>
	* @param imgPath
	*/
	public void imageDelete (String imgPath ) {
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		ftpImgUtil.delete(imgPath );
	}
	
	
	
	
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsService.java
	 * - 작성일		: 2017. 3. 8.
	 * - 작성자		: wyjeong
	 * - 설명		: 브랜드 미니샵 노출 top 컨텐츠 조회
	 * </pre>
	 * @param bndNo
	 */
	@Override
	public BrandCntsVO getTopBrandCnt(Long bndNo) {
		return brandCntsDao.getTopBrandCnt(bndNo);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsService.java
	 * - 작성일		: 2017. 3. 8.
	 * - 작성자		: wyjeong
	 * - 설명		: 브랜드 미니샵 노출 컨텐츠 리스트
	 * </pre>
	 * @param po
	 */
	@Override
	public List<BrandCntsVO> listBrandCnts(BrandCntsSO so) {
		return brandCntsDao.listBrandCnts(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsService.java
	 * - 작성일		: 2017. 3. 8.
	 * - 작성자		: wyjeong
	 * - 설명		: 브랜드 컨텐츠 조회
	 * </pre>
	 * @param bndCntsNo
	 */
	@Override
	public BrandCntsVO getBrandCnts(Long bndCntsNo) {
		return brandCntsDao.getBrandCnts(bndCntsNo);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsService.java
	 * - 작성일		: 2017. 3. 8.
	 * - 작성자		: wyjeong
	 * - 설명		: 브랜드 미니샵 노출 컨텐츠 아이템 리스트
	 * </pre>
	 * @param po
	 */
	@Override
	public List<BrandCntsItemVO> listBrandCntsItem(BrandCntsItemSO so) {
		return brandCntsDao.listBrandCntsItem(so);
	}
}