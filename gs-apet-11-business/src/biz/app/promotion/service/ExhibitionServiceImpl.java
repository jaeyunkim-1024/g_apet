package biz.app.promotion.service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsDispSO;
import biz.app.goods.model.GoodsDispVO;
import biz.app.goods.service.GoodsDispService;
import biz.app.promotion.dao.ExhibitionDao;
import biz.app.promotion.model.ExhibitionBasePO;
import biz.app.promotion.model.ExhibitionBaseVO;
import biz.app.promotion.model.ExhibitionMainVO;
import biz.app.promotion.model.ExhibitionSO;
import biz.app.promotion.model.ExhibitionThemeGoodsPO;
import biz.app.promotion.model.ExhibitionThemeGoodsSO;
import biz.app.promotion.model.ExhibitionThemeGoodsVO;
import biz.app.promotion.model.ExhibitionThemePO;
import biz.app.promotion.model.ExhibitionThemeSO;
import biz.app.promotion.model.ExhibitionThemeVO;
import biz.app.promotion.model.ExhibitionVO;
import biz.app.st.model.StStdInfoVO;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.StringUtil;

/**
 * 기획전 ServiceImpl
 * @author		hongjun
 * @since		2017. 5. 30.
 */
@Service
@Transactional
public class ExhibitionServiceImpl implements ExhibitionService {

	@Autowired
	private ExhibitionDao exhibitionDao;
	
	@Autowired private GoodsDispService goodsDispService;


	@Override
	@Transactional(readOnly=true)
	public List<ExhibitionMainVO> listExhibitionMainNc(ExhibitionSO so) {
		return exhibitionDao.listExhibitionMainNc(so);
	}

	@Override
	@Transactional(readOnly=true)
	public List<ExhibitionVO> pageExhibition(ExhibitionSO so) {
		return exhibitionDao.pageExhibition(so);
	}

	@Override
	@Transactional(readOnly=true)
	public ExhibitionVO getExhibitionBase(ExhibitionSO so) {
		return exhibitionDao.getExhibitionBase(so);
	}

	@Override
	@Transactional(readOnly=true)
	public List<StStdInfoVO> getExhibitionStMap(ExhibitionSO so) {
		return exhibitionDao.getExhibitionStMap(so);
	}

	@Override
	public int getExhbtThmCnt(ExhibitionSO so) {
		return exhibitionDao.getExhbtThmCnt(so);
	}

	@Override
	public void insertExhibitionBase(ExhibitionBasePO po) {
		po.setBnrImgPath(uploadImg(po.getBnrImgPath(), po.getExhbtNo().toString(), AdminConstants.EXHIBITION_IMAGE_PATH));
		po.setBnrMoImgPath(uploadImg(po.getBnrMoImgPath(), po.getExhbtNo().toString(), AdminConstants.EXHIBITION_IMAGE_PATH));
		po.setGdBnrImgPath(uploadImg(po.getGdBnrImgPath(), po.getExhbtNo().toString(), AdminConstants.EXHIBITION_IMAGE_PATH));
		po.setGdBnrMoImgPath(uploadImg(po.getGdBnrMoImgPath(), po.getExhbtNo().toString(), AdminConstants.EXHIBITION_IMAGE_PATH));

		int result = exhibitionDao.insertExhibitionBase(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		saveStExhibitionMap(po);
		
		//기획전 태그 매핑
		String[] tagNos = po.getTagNos();
		if( tagNos != null && tagNos.length > 0) {
			for(String tagNo : tagNos) {
				po.setTagNo(tagNo);
				exhibitionDao.saveExhibitionTagMap(po);
			}
		}		
	}

	@Override
	public void updateExhibitionBase(ExhibitionBasePO po) {
		po.setBnrImgPath(uploadImg(po.getBnrImgPath(), po.getExhbtNo().toString(), AdminConstants.EXHIBITION_IMAGE_PATH));
		po.setBnrMoImgPath(uploadImg(po.getBnrMoImgPath(), po.getExhbtNo().toString(), AdminConstants.EXHIBITION_IMAGE_PATH));
		po.setGdBnrImgPath(uploadImg(po.getGdBnrImgPath(), po.getExhbtNo().toString(), AdminConstants.EXHIBITION_IMAGE_PATH));
		po.setGdBnrMoImgPath(uploadImg(po.getGdBnrMoImgPath(), po.getExhbtNo().toString(), AdminConstants.EXHIBITION_IMAGE_PATH));

		int result = exhibitionDao.updateExhibitionBase(po);
		
		if (!CommonConstants.DEL_YN_Y.equals(po.getDelYn())) {
			updateExhibitionBaseStat30To10(po);
			saveStExhibitionMap(po);
			//기본정보일때만 태그 수정
			if(StringUtil.isEmpty(po.getViewType())) {
				updateExhibitionTagMap(po);
			}
		}
		
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
	}

	@Override
	public void updateExhibitionBaseStat30To10(ExhibitionBasePO po) {
		Session session = AdminSessionUtil.getSession();
		if(session !=null
				&& AdminConstants.USR_GRP_20.equals(session.getUsrGrpCd())){
			// 업체이면서 승인상태가 반려일 경우 승인상태를 대기로 변경
			exhibitionDao.updateExhibitionBaseStat30To10(po);
		}
	}

	@Override
	public int updateExhibitionStateBatch(ExhibitionBasePO po) {
		Session session = AdminSessionUtil.getSession();
		int updateCount = 0;
		if(session !=null
				&& AdminConstants.USR_GRP_10.equals(session.getUsrGrpCd())){
			// 관리자 권한일 때 일괄 상태 변경 가능함.
			updateCount = exhibitionDao.updateExhibitionStateBatch(po);
		}

		return updateCount;
	}

	private String uploadImg(String imgPath, String id, String fileImgPath) {
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		String filePath = imgPath;

		if (ftpImgUtil.tempFileCheck(imgPath) && StringUtils.isNotBlank(imgPath)) {
			filePath = ftpImgUtil.uploadFilePath(imgPath, fileImgPath + FileUtil.SEPARATOR + id);
			ftpImgUtil.upload(imgPath, filePath);
		}

		return filePath;
	}

	/**
	 * 기획전은 한개 사이트에만 등록가능하므로 사이트/기획전 매핑테이블은 참고용으로만 사용하게 되었음.
	 * @param po
	 */
	private void saveStExhibitionMap(ExhibitionBasePO po) {
		// 사이트와 기획전 매핑정보 삭제 후 재등록
		 exhibitionDao.deleteStExhibitionMap(po);

		 int result = exhibitionDao.insertStExhibitionMap(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	@Transactional(readOnly=true)
	public List<ExhibitionThemeVO> getExhibitionTheme(ExhibitionThemeSO so) {
		return exhibitionDao.getExhibitionTheme(so);
	}

	@Override
	@Transactional(readOnly=true)
	public List<ExhibitionThemeVO> pageExhibitionTheme(ExhibitionThemeSO so) {
		return exhibitionDao.pageExhibitionTheme(so);
	}

	@Override
	public void insertExhibitionTheme(ExhibitionThemePO po) {
		int result = exhibitionDao.insertExhibitionTheme(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void updateExhibitionTheme(ExhibitionThemePO po) {
		int result = exhibitionDao.updateExhibitionTheme(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	@Transactional(readOnly=true)
	public List<ExhibitionThemeGoodsVO> pageExhibitionThemeGoods(ExhibitionThemeSO so) {
		return exhibitionDao.pageExhibitionThemeGoods(so);
	}

	@Override
	public int insertUpdateExhibitionThemeGoods(ExhibitionThemeGoodsPO po) {
		int result = exhibitionDao.insertUpdateExhibitionThemeGoods(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		return result;
	}

	@Override
	public void updateExhibitionThemeGoods(ExhibitionThemeGoodsPO po) {
		int result = exhibitionDao.updateExhibitionThemeGoods(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void deleteExhibitionThemeGoods(ExhibitionThemeGoodsPO po) {
		int result = exhibitionDao.deleteExhibitionThemeGoods(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}


	@Override
	@Transactional(readOnly=true)
	public List<ExhibitionVO> selectPageExhibitionFO(ExhibitionSO so, Long StId, String deviceGb) {
		//기획전 정보 가져오는 쿼리
		List<ExhibitionVO> exhibitionList = this.pageExhibitionFO(so);
		
		//기획전 테마 리스트
		List<ExhibitionThemeVO> exhbTm = new ArrayList<>();
		ExhibitionThemeSO exhSo = new ExhibitionThemeSO();
		
			if(so.getExhbtGbCd() == "10") {
				//테마
				for(int i=0; i<exhibitionList.size(); i++) {
					exhbTm.addAll(exhibitionList.get(i).getExhibitionThemeList());
					
					for(int j=0; j<exhbTm.size(); j++) {
						exhSo.setPage(so.getPage());
						exhSo.setThmNo(exhbTm.get(j).getThmNo());
						exhSo.setExhbtNo(exhbTm.get(j).getExhbtNo());
						//상품
						List<GoodsDispVO> exhGoods = goodsDispService.getGoodsExhibited(StId, so.getMbrNo() ,exhSo.getThmNo(), exhSo.getExhbtNo(), so.getExhbtGbCd() ,deviceGb, null, so.getRows() ,CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_N);
						
						GoodsDispSO gso = new GoodsDispSO();
						gso.setThmNo(exhbTm.get(j).getThmNo());
						gso.setExhbtNo(exhbTm.get(j).getExhbtNo());
						int exbCnt = goodsDispService.selectGoodsExhibitedCount(gso);
						
						exhbTm.get(j).setExhibitionGoods(exhGoods);
						exhbTm.get(j).setEhbCnt(exbCnt);
					}
					exhibitionList.get(i).setExhibitionThemeList(exhbTm);
				}
				
			}else {
				for(int i=0; i<exhibitionList.size(); i++) {
					//테마
					exhbTm.addAll(exhibitionList.get(i).getExhibitionThemeList());
					
					for(int j=0; j<exhbTm.size(); j++) {
						exhSo.setThmNo(exhbTm.get(j).getThmNo());
						exhSo.setExhbtNo(exhbTm.get(j).getExhbtNo());
						//상품
						List<GoodsDispVO> exhGoods = goodsDispService.getGoodsExhibited(StId, so.getMbrNo() ,exhSo.getThmNo(), exhSo.getExhbtNo(), so.getExhbtGbCd() ,deviceGb, null, so.getRows(), CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_N);
						exhibitionList.get(i).setExhibitionGoods(exhGoods); 
					}
				}
			}
		
		return exhibitionList;
	}

	@Override
	public List<ExhibitionVO> listExhibitionByGoods(GoodsBaseSO so) {
		return exhibitionDao.listExhibitionByGoods(so);
	}

	@Override
	public List<ExhibitionThemeVO> listExhibitionTheme(ExhibitionSO so) {
		return exhibitionDao.listExhibitionTheme(so);
	}

	@Override
	public List<ExhibitionThemeGoodsVO> pageExhbtThemeGoodsFO(ExhibitionThemeGoodsSO so) {
		return exhibitionDao.pageExhbtThemeGoodsFO(so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : ExhibitionServiceImpl.java
	 * - 작성일        : 2021. 1. 12.
	 * - 작성자        : YKU
	 * - 설명          : 기획전 태그 저장
	 * </pre>
	 * @param po
	 */
	@Override
	public void saveExhibitionTagMap(ExhibitionBasePO po) {
		int result = exhibitionDao.saveExhibitionTagMap(po);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : ExhibitionServiceImpl.java
	 * - 작성일        : 2021. 1. 12.
	 * - 작성자        : YKU
	 * - 설명          : 기획전 태그 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	@Transactional(readOnly=true)
	public List<ExhibitionVO> listExhibitionTagMap(ExhibitionSO so) {
		return exhibitionDao.listExhibitionTagMap(so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : ExhibitionServiceImpl.java
	 * - 작성일        : 2021. 1. 12.
	 * - 작성자        : YKU
	 * - 설명          : 기획전 태그 수정
	 * </pre>
	 * @param po
	 */
	private void updateExhibitionTagMap(ExhibitionBasePO po) {
		//전체 삭제
		exhibitionDao.deleteExhibitionTagMap(po);
		
		//등록
		if(po.getTagNos() != null) {
			String[] tagNos = po.getTagNos();
			for(String tagNo : tagNos) {
				po.setTagNo(tagNo);
				exhibitionDao.saveExhibitionTagMap(po);
			}
		}
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : ExhibitionServiceImpl.java
	 * - 작성일        : 2021. 3. 10.
	 * - 작성자        : YKU
	 * - 설명          :
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<ExhibitionThemeVO> selectExhibitionTheme(ExhibitionThemeSO so) {
		return exhibitionDao.selectExhibitionTheme(so);
	}

	@Override
	public List<ExhibitionVO> pageExhibitionFO(ExhibitionSO so) {
		return exhibitionDao.pageExhibitionFO(so);
	}

	@Override
	public List<ExhibitionVO> getThemeTitle(ExhibitionSO so) {
		return exhibitionDao.getThemeTitle(so);
	}

	@Override
	public int countThemeGoods(ExhibitionThemeGoodsSO gso) {
		return exhibitionDao.countThemeGoods(gso);
	}
}