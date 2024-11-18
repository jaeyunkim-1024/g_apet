package biz.app.goods.service;

import biz.app.goods.dao.GoodsCommentDao;
import biz.app.goods.model.*;
import biz.app.member.dao.MemberSavedMoneyDao;
import biz.app.member.model.MemberSavedMoneyPO;
import biz.app.member.service.MemberSavedMoneyService;
import biz.app.order.dao.OrderDao;
import biz.app.order.dao.OrderDetailDao;
import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderSO;
import biz.app.pet.model.PetBaseSO;
import biz.app.pet.model.PetBaseVO;
import biz.app.pet.service.PetService;
import biz.app.petlog.model.PetLogBasePO;
import biz.app.petlog.model.PetLogBaseVO;
import biz.app.petlog.model.PetLogGoodsSO;
import biz.app.petlog.model.PetLogGoodsVO;
import biz.app.petlog.service.PetLogService;
import biz.common.service.BizService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.LogUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.StringUtil;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Properties;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.service
* - 파일명		: GoodsCommentServiceImpl.java
* - 작성일		: 2016. 3. 7.
* - 작성자		: snw
* - 설명		: 상품 평가 서비스
* </pre>
*/
@Transactional
@Service("goodsCommentService")
public class GoodsCommentServiceImpl implements GoodsCommentService {

	@Autowired private GoodsCommentDao goodsCommentDao;

	@Autowired private OrderDao orderDao;

	@Autowired private OrderDetailDao orderDetailDao;

	@Autowired private MemberSavedMoneyDao memberSavedMoneyDao;

	@Autowired private PetService petService;
	
	@Autowired private BizService bizService;
	
	@Autowired private MemberSavedMoneyService memberSavedMoneyService;

	@Autowired private Properties bizConfig;
	
	@Autowired private PetLogService petLogService;
	
	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	/*
	 * 상품평가 페이징 조회
	 * @see biz.app.goods.service.GoodsCommentService#pageGoodsComment(biz.app.goods.model.GoodsCommentSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<GoodsCommentVO> pageGoodsComment(GoodsCommentSO so) {
		List<GoodsCommentVO> goodsCommentList = this.goodsCommentDao.pageGoodsComment(so);
		
		if (CollectionUtils.isNotEmpty(goodsCommentList)) {
			for(int i=0; i<goodsCommentList.size(); i++) {
				// 로그인 아이디 복호화/마스킹
				String loginId = bizService.twoWayDecrypt(goodsCommentList.get(i).getLoginId());
				if (StringUtil.isNotEmpty(loginId)) {
					goodsCommentList.get(i).setLoginId(MaskingUtil.getId(loginId));
				}
			}
		}
		return goodsCommentList;
	}
	
	/*
	 * 상품평가 페이징 조회
	 * @see biz.app.goods.service.GoodsCommentService#pageGoodsComment(biz.app.goods.model.GoodsCommentSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<GoodsCommentVO> pageGoodsCommentAddBest(GoodsCommentSO so) {
		return this.goodsCommentDao.pageGoodsCommentAddBest(so);
	}

	/*
	 * Front 마이페이지 - 작성가능한 상품평 리스트 페이징 조회
	 * @see biz.app.goods.service.GoodsCommentService#pageBeforeGoodsCommentList(biz.app.order.model.OrderSO)
	 */
	@Override
	public List<OrderDetailVO> pageBeforeGoodsCommentList(OrderSO so) {
		return this.orderDao.pageBeforeGoodsCommentList(so);
	}

	/*
	 * Front 마이페이지 - 상품평가 데이터 조회
	 * @see biz.app.goods.service.GoodsCommentService#getGoodsCommentBase(Integer)
	 */
	@Override
	public GoodsCommentVO getGoodsCommentBase(Long goodsEstmNo) {
		GoodsCommentSO so = new GoodsCommentSO();
		so.setGoodsEstmNo(goodsEstmNo);
		return this.goodsCommentDao.getGoodsCommentBase(so);
	}

	/*
	 * Front[상품상세-상품평가] 상품평가 전체 데이터 수 조회
	 * @see biz.app.goods.service.GoodsCommentService#getGoodsCommentCount(java.lang.String)
	 */
	@Override
	public GoodsCommentCountVO getGoodsCommentCount(String goodsId) {
		GoodsCommentSO so = new GoodsCommentSO();
		so.setGoodsId(goodsId);
		return this.goodsCommentDao.getGoodsCommentCount(so);
	}
	@Override
	public GoodsCommentCountVO getGoodsCommentCount(GoodsCommentSO so) {
		return this.goodsCommentDao.getGoodsCommentCount(so);
	}

	/*
	 * 상품평 등록
	 * @see biz.app.goods.service.GoodsCommentService#insertGoodsComment(biz.app.goods.model.GoodsCommentPO, biz.app.order.model.OrderDetailPO)
	 */
	@Override
	public void insertGoodsComment(GoodsCommentPO gPo, OrderDetailPO oPo) {

		Long goodsEstmNo = this.bizService.getSequence(CommonConstants.SEQUENCE_GOODS_COMMENT_SEQ);
		gPo.setGoodsEstmNo(goodsEstmNo);
		oPo.setGoodsEstmNo(goodsEstmNo);
		gPo.setImgRegYn(gPo.getImgPath() != null ? CommonConstants.COMM_YN_Y : CommonConstants.COMM_YN_N);// 이미지 등록 여부

		// 상품평 등록
		int rstGoodsComment = this.goodsCommentDao.insertGoodsComment(gPo);
		if(rstGoodsComment != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		// 상품평 이미지 등록
		if (gPo.getImgPath() != null) {
			
			Long imgSeq = this.goodsCommentDao.getMaxImageSequence(gPo.getGoodsEstmNo());
			
			for (int i = 0; i < gPo.getImgPath().length; i++) {

				String orgFileStr = gPo.getImgPath()[i];

				FtpImgUtil ftpImgUtil = new FtpImgUtil();
				String filePath = ftpImgUtil.uploadFilePath(orgFileStr, CommonConstants.GOODS_COMMENT_IMAGE_PATH + FileUtil.SEPARATOR + goodsEstmNo);
				ftpImgUtil.upload(orgFileStr, filePath);

				GoodsCommentImagePO iPo = new GoodsCommentImagePO();
				iPo.setGoodsEstmNo(goodsEstmNo);
				iPo.setImgPath(filePath);
				iPo.setImgSeq(imgSeq);
				iPo.setSysRegrNo(gPo.getSysRegrNo());

				int rstGoodsCommentImg = this.goodsCommentDao.insertGoodsCommentImage(iPo);
				if(rstGoodsCommentImg != 1){
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
				imgSeq++;
			}
		}

		// 주문상세 상품평가 등록여부 업데이트
		int rstOrderDetail = this.orderDetailDao.updateOrderDetailComment(oPo);
		if(rstOrderDetail != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		/******************************************
		 * 상품평작성 적립금 지급
		 * - 제공여부가 'Y'인 경우에만 지급
		 ******************************************/
		if(CommonConstants.COMM_YN_Y.equals(this.bizConfig.getProperty("member.savedMoney.estm.yn"))){
			// 적립금 등록 PO
			MemberSavedMoneyPO mPo = new MemberSavedMoneyPO(); 
			mPo.setMbrNo(gPo.getSysRegrNo());	
			mPo.setSysRegrNo(gPo.getSysRegrNo());
			
			// 주문한 상품의 최초 리뷰일 경우
			if(this.goodsCommentDao.getGoodsCommentCountByOrd(oPo) == 1){
				mPo.setSvmnRsnCd(CommonConstants.SVMN_RSN_900);
				mPo.setEtcRsn("첫 상품평");
				mPo.setSaveAmt(Long.valueOf(this.bizConfig.getProperty("member.savedMoney.first.amt")));
				this.memberSavedMoneyService.insertMemberSavedMoney(mPo);
			}
			
			// 리뷰(일반/포토) 타입에 따른 지급
			mPo.setEtcRsn("");
			mPo.setSvmnRsnCd(CommonConstants.SVMN_RSN_220);
			mPo.setSaveAmt(Long.valueOf(this.bizConfig.getProperty("member.savedMoney."+(gPo.getImgRegYn().equals(CommonConstants.COMM_YN_Y)?"photo":"text")+".amt")));
			mPo.setOrdNo(oPo.getOrdNo());
			mPo.setOrdDtlSeq(oPo.getOrdDtlSeq());
			mPo.setGoodsEstmNo(goodsEstmNo);
			this.memberSavedMoneyService.insertMemberSavedMoney(mPo);
		}
		
	}

	/*
	 * Front 마이페이지 - 작성한 상품평 리스트 페이징 조회
	 * @see biz.app.goods.service.GoodsCommentService#pageAfterGoodsCommentList(biz.app.goods.model.GoodsCommentSO)
	 */
	@Override
	public List<GoodsCommentVO> pageAfterGoodsCommentList(GoodsCommentSO so) {
		return this.goodsCommentDao.pageAfterGoodsCommentList(so);
	}

	/*
	 * 상품평 수정
	 * @see biz.app.goods.service.GoodsCommentService#updateGoodsComment(biz.app.goods.model.GoodsCommentPO)
	 */
	@Override
	public void updateGoodsComment(GoodsCommentPO po, String deviceGb) {
		if(po.getPetNo() != null && po.getPetNo() != 0) {
			PetBaseSO petSO = new PetBaseSO();
			petSO.setPetNo(po.getPetNo());
			PetBaseVO petVO = petService.getPetInfo(petSO);

			po.setPetNo(petVO.getPetNo());
			po.setAge(petVO.getAge());
			po.setPetKindNm(petVO.getPetKindNm());
			po.setPetNm(petVO.getPetNm());
			po.setMonth(petVO.getMonth());
			po.setBirth(petVO.getBirth());
			po.setWeight(petVO.getWeight());
			po.setPetGdGbCd(petVO.getPetGdGbCd());
			po.setFixingYn(petVO.getFixingYn());
			po.setAllergyYn(petVO.getAllergyYn());
			po.setWryDaYn(petVO.getWryDaYn());
			po.setPetImgPath(petVO.getImgPath());
		}

		int result = goodsCommentDao.updateGoodsComment(po);
		if(result == 0){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}else {
			//NULL 체크 수정 - 2021.05.13 - 김재윤
			if(Optional.ofNullable(po.getEstmQstNos()).orElseGet(()->new Long[]{}).length != 0
					&& Optional.ofNullable(po.getEstmRplNos()).orElseGet(()->new Long[]{}).length != 0) {
				//상품 평가 답변 수정
				GoodsEstmRplPO estmRplPO = new GoodsEstmRplPO();
				estmRplPO.setGoodsEstmNo(po.getGoodsEstmNo());
				for(int i = 0; i < po.getEstmRplNos().length; i++) {
					estmRplPO.setEstmRplNo(po.getEstmRplNos()[i]);
					estmRplPO.setEstmQstNo(po.getEstmQstNos()[i]);
					estmRplPO.setEstmItemNo(po.getEstmItemNos()[i]);
					
					int estmRplResult = goodsCommentDao.updateGoodsEstmRpl(estmRplPO);
					if(estmRplResult == 0){
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
					
				}
			}
			
			//상품 이미지 업로드
			if(!deviceGb.equals(CommonConstants.DEVICE_GB_30) && po.getImgPath() != null && po.getImgPath().length != 0) {
				GoodsCommentImagePO imgPO = new GoodsCommentImagePO();
				imgPO.setGoodsEstmNo(po.getGoodsEstmNo());
				imgPO.setVdYn(CommonConstants.COMM_YN_N);
				for(int i = 0; i < po.getImgPath().length; i++) {
					imgPO.setImgPath(po.getImgPath()[i]);
					
					if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
					FtpImgUtil ftpImgUtil = new FtpImgUtil();
					String filePath = ftpImgUtil.uploadFilePath(imgPO.getImgPath(), AdminConstants.GOODS_COMMENT_IMG_PATH + FileUtil.SEPARATOR + po.getGoodsEstmNo());
					ftpImgUtil.upload(imgPO.getImgPath(), filePath);
					if(StringUtil.isNotEmpty(filePath)){
						imgPO.setImgPath(filePath);
					}
					
					int imgResult = goodsCommentDao.insertGoodsCommentImage(imgPO);
					if(imgResult == 0){
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
			
			if(po.getDelImgSeq() != null && po.getDelImgSeq().length != 0) {
				GoodsCommentImagePO imgPO = new GoodsCommentImagePO();
				imgPO.setGoodsEstmNo(po.getGoodsEstmNo());
				for(int i = 0; i < po.getDelImgSeq().length; i++) {
					imgPO.setImgSeq(po.getDelImgSeq()[i]);
					
					int imgResult = goodsCommentDao.deleteGoodsCommentImage(imgPO);
					if(imgResult == 0){
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
			
		}

	}

	/*
	 * 상품평 삭제
	 * @see biz.app.goods.service.GoodsCommentService#deleteGoodsComment(biz.app.goods.model.GoodsCommentPO)
	 */
	@Override
	public void deleteGoodsComment(GoodsCommentPO po) {
		// 상품평 삭제
		int rstGoodsComment = this.goodsCommentDao.deleteGoodsComment(po);
		if(rstGoodsComment != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		OrderDetailPO orderPO = new OrderDetailPO();
		orderPO.setGoodsEstmRegYn(CommonConstants.COMM_YN_N);
		orderPO.setSysUpdrNo(po.getSysRegrNo());
		orderPO.setOrdNo(po.getOrdNo());
		orderPO.setOrdDtlSeq(po.getOrdDtlSeq());
		int orderResult = orderDetailDao.updateOrderDetailComment(orderPO);
		if(orderResult == 0){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		// APETQA-6430 펫로그 중복 삭제 로직으로 주석 처리
		//펫로그 후기일 경우 펫로그도 삭제
//		PetLogBasePO plgPO = new PetLogBasePO();
//		plgPO.setGoodsEstmNo(po.getGoodsEstmNo());
//		PetLogBaseVO plgVO = petLogService.getPetLogDeleteInfo(plgPO);
//		
//		if(!StringUtil.isEmpty(plgVO)) {
//			plgPO.setPetLogNo(plgVO.getPetLogNo());
//			plgPO.setMbrNo(plgVO.getMbrNo());
//			petLogService.deletePetLogBase(plgPO, "GoodsComment");
//		}
		
		// 상품평 이미지 삭제
		/*int rstGoodsCommentImage = this.goodsCommentDao.deleteGoodsCommentImage(po);
		if(rstGoodsCommentImage < 0){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}*/
	}

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//


	@Override
	public List<GoodsCommentVO> pageGoodsCommentGrid (GoodsCommentSO so ) {
		
		if(StringUtil.isNotBlank(so.getLoginId())) {
			so.setLoginId(bizService.twoWayEncrypt(so.getLoginId()));
		}
		
		List<GoodsCommentVO> list = goodsCommentDao.pageGoodsCommentGrid(so );
		if (CollectionUtils.isNotEmpty(list)) {
			list.stream().forEach(v->{
				String replaceEstmId = bizService.twoWayDecrypt(v.getEstmId());
				if (StringUtil.isNotEmpty(replaceEstmId)) {
					v.setEstmId(replaceEstmId);
				}
			});
		}
		return list;
	}


	@Override
	public GoodsCommentVO getGoodsComment (GoodsCommentDetailPO po ) {
		return goodsCommentDao.getGoodsComment(po );
	}


	@Override
	public List<GoodsCommentImageVO> listGoodsCommentImage (Long goodsEstmNo ) {
		return goodsCommentDao.listGoodsCommentImage(goodsEstmNo );
	}


	@Override
	public int updateGoodsCommentBo (GoodsCommentPO po ) {
		return goodsCommentDao.updateGoodsCommentBo(po );
	}

	@Override
	public int updateGoodsCommentBatch (List<GoodsCommentPO> goodsCommentPOList ) {
		int updateCnt = 0;

		if(goodsCommentPOList != null && !goodsCommentPOList.isEmpty()) {
			for(GoodsCommentPO po : goodsCommentPOList ) {
				LogUtil.log(po );

				goodsCommentDao.updateGoodsCommentBo(po );
				updateCnt ++;
			}
		}

		return updateCnt;
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public GoodsCommentVO getGoodsCommentScore(GoodsCommentSO so) {
		GoodsCommentVO vo = new GoodsCommentVO();
		
		//상품평 점수 목록
		List<GoodsCommentScoreVO> scoreList = goodsCommentDao.getGoodsCommentScore(so);
		if(scoreList != null && scoreList.size() != 0) {
			vo.setEstmAvg(scoreList.get(0).getEstmAvg() != null ? scoreList.get(0).getEstmAvg() : 0);
			vo.setEstmAvgStar(scoreList.get(0).getEstmAvg() != null ? Math.floor(scoreList.get(0).getEstmAvg() ) / 2: 0);
			vo.setScoreTotal(scoreList.get(0).getScoreTotal());
			List<GoodsCommentScoreVO> list = new ArrayList<>();

			/*int totalCnt = 0;*/
			int maxScore = 0;
			int maxCnt = 0;
			for(int i = 5; i >0; i--) {
				GoodsCommentScoreVO resultVO = new GoodsCommentScoreVO();
				int nowScore = i*2;
				int odd = 0; //홀
				int even = 0;//짝
				for(GoodsCommentScoreVO svo : scoreList) {
					if(svo.getEstmScore() == nowScore - 1 ) {
						odd = svo.getScoreTotal();
					}
					if(svo.getEstmScore() == nowScore) {
						even = svo.getScoreTotal();
					}
					if(maxCnt < odd + even) {
						maxScore = i;
						maxCnt = odd + even;
					}
				}
				resultVO.setEstmScore(i);
				resultVO.setScoreTotal(odd + even);
				list.add(resultVO);
			}
			if(maxScore != 0) {
				for(int i = 0; i < list.size(); i++) {
					if(list.get(i).getEstmScore().equals(maxScore)) {
						list.get(i).setMaxYn("Y");
					}else {
						list.get(i).setMaxYn("N");
					}
				}
			}
			
			vo.setGoodsCommentScoreVOList(list);
			/*vo.setScoreTotal(totalCnt);*/
		}
		
		//묶음상품, 옵션 묶음상품일 경우 대표상품 기준으로 평가 노출(기획서에 관련 내용 없음-임시)
		if(StringUtil.isNotEmpty(so.getDlgtGoodsId())) {
			so.setGoodsId(so.getDlgtGoodsId());
		}
		
		//상품평 평가 목록
		List<GoodsEstmQstVO> estmList = goodsCommentDao.getGoodsEstm(so);
		if(estmList != null && estmList.size() != 0) {
			for(int i = 0; i < estmList.size(); i++) {
				int total = 0;
				int maxCnt = 0;
				Long maxQstItem = 0L;
				for (GoodsEstmQstVO data : estmList.get(i).getEstmQstVOList()) {
					if( StringUtil.isEmpty(estmList.get(i).getEstmCnt()) ||
						(StringUtil.isNotEmpty(estmList.get(i).getEstmCnt()) && StringUtil.isNotEmpty(data.getEstmCnt()))
						&& estmList.get(i).getEstmCnt() <= data.getEstmCnt() ) {
						estmList.get(i).setQstClsf(data.getQstClsf());
						estmList.get(i).setQstContent(data.getQstContent());
						estmList.get(i).setEstmItemNo(data.getEstmItemNo());
						estmList.get(i).setItemContent(data.getItemContent());
						estmList.get(i).setEstmCnt(data.getEstmCnt());
					}
					total += (data.getEstmCnt()!=null?data.getEstmCnt():0);
					if(data.getEstmCnt()!=null&&maxCnt<=data.getEstmCnt()) {
						maxCnt = data.getEstmCnt();
						maxQstItem = data.getEstmItemNo();
					}
				}
				
				if(maxCnt != 0 && total != 0 ) {
					int avg = Math.round(100*maxCnt/total);
					estmList.get(i).setEstmAvg(avg);
				}else {
					estmList.get(i).setEstmAvg(0);
				}
				estmList.get(i).setEstmTotal(total);
				estmList.get(i).setMaxQst(maxQstItem);
			}
		}
		
		vo.setGoodsEstmQstVOList(estmList);
		
		return vo;
	}

	@Override
	@Transactional(readOnly=true)
	public List<GoodsCommentImageVO> getGoodsPhotoComment(GoodsCommentSO so) {
		List<GoodsCommentImageVO> imgList = goodsCommentDao.getGoodsPhotoComment(so);
		//TODO 이미지 경로 처리 필요 예상
		
		/*imgList.stream().forEach(v->{
			if(v.getImgPath() != null && v.getImgPath().startsWith("http")) {
				v.getImgPath();
			} else {
				v.setImgPath(bizConfig.getProperty("naver.cloud.cdn.domain.folder")+v.getImgPath());
			}
		});*/
		
		return imgList;
	}

	@Override
	@Transactional(readOnly=true)
	public GoodsBaseVO commentWriteInfo(GoodsCommentSO so) {
		GoodsBaseVO vo = goodsCommentDao.commentWriteInfo(so);
		vo.setGoodsEstmQstVOList(goodsCommentDao.goodsEstmQstList(so));
		vo.setPetBaseVOList(goodsCommentDao.petBaseList(so));
		return vo;
	}

	@Override
	public void insertGoodsComment(GoodsCommentPO po, String deviceGb) {
		if(StringUtil.isNotEmpty(po.getPetNo())) {
			PetBaseSO petSO = new PetBaseSO();
			petSO.setPetNo(po.getPetNo());
			PetBaseVO petVO = petService.getPetInfo(petSO);
			
			po.setPetNo(petVO.getPetNo());
			po.setAge(petVO.getAge());
			po.setPetKindNm(petVO.getPetKindNm());
			po.setPetNm(petVO.getPetNm());
			po.setMonth(petVO.getMonth());
			po.setBirth(petVO.getBirth());
			po.setWeight(petVO.getWeight());
			po.setPetGdGbCd(petVO.getPetGdGbCd());
			po.setFixingYn(petVO.getFixingYn());
			po.setAllergyYn(petVO.getAllergyYn());
			po.setWryDaYn(petVO.getWryDaYn());
			po.setPetImgPath(petVO.getImgPath());
		}
		
		//
		int result = goodsCommentDao.insertGoodsComment(po);
		if(result == 0){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}else {
			//주문 상세 수정
			OrderDetailPO orderPO = new OrderDetailPO();
			if(po.getGoodsEstmTp().equals(CommonConstants.GOODS_ESTM_TP_NOR)) {
				orderPO.setGoodsEstmRegYn(CommonConstants.COMM_YN_Y);
			}else {
				orderPO.setGoodsEstmRegYn(CommonConstants.COMM_YN_N);
			}
			
			orderPO.setSysUpdrNo(po.getSysRegrNo());
			orderPO.setGoodsEstmNo(po.getGoodsEstmNo());
			orderPO.setOrdNo(po.getOrdNo());
			orderPO.setOrdDtlSeq(po.getOrdDtlSeq());
			int orderResult = orderDetailDao.updateOrderDetailComment(orderPO);
			if(orderResult == 0){
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			
			//상품평 상품 링크 테이블 등록
			int linkResult = goodsCommentDao.insertGoodsCommentLink(po);
			if(linkResult == 0){
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			
			
			if(po.getEstmQstNos() != null && po.getEstmQstNos().length != 0) {
				//상품 평가 답변 등록
				GoodsEstmRplPO estmRplPO = new GoodsEstmRplPO();
				estmRplPO.setGoodsEstmNo(po.getGoodsEstmNo());
				for(int i = 0; i < po.getEstmQstNos().length; i++) {
					estmRplPO.setEstmQstNo(po.getEstmQstNos()[i]);
					estmRplPO.setEstmItemNo(po.getEstmItemNos()[i]);
					
					int estmRplResult = goodsCommentDao.insertGoodsEstmRpl(estmRplPO);
					if(estmRplResult == 0){
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
					
				}
			}
			
			//상품 이미지 업로드
			if(!deviceGb.equals(CommonConstants.DEVICE_GB_30) && po.getImgPath() != null && po.getImgPath().length != 0) {
				GoodsCommentImagePO imgPO = new GoodsCommentImagePO();
				imgPO.setGoodsEstmNo(po.getGoodsEstmNo());
				imgPO.setVdYn(CommonConstants.COMM_YN_N);
				for(int i = 0; i < po.getImgPath().length; i++) {
					imgPO.setImgPath(po.getImgPath()[i]);
					//제거. CSR-1185. 2021-06-01
//					if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
//					}
					FtpImgUtil ftpImgUtil = new FtpImgUtil();
					String filePath = ftpImgUtil.uploadFilePath(imgPO.getImgPath(), AdminConstants.GOODS_COMMENT_IMG_PATH + FileUtil.SEPARATOR + po.getGoodsEstmNo());
					ftpImgUtil.upload(imgPO.getImgPath(), filePath);
					if(StringUtil.isNotEmpty(filePath)){
						imgPO.setImgPath(filePath);
					}
					
					int imgResult = goodsCommentDao.insertGoodsCommentImage(imgPO);
					if(imgResult == 0){
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
					
				}
			}
			
		}
		
	}
	
	/*상품평 좋아요 체크*/
	@Override
	public int likeComment(GoodsCommentPO po) {
		int check = goodsCommentDao.commentLikeCheck(po);
		if(check != 0) {
			int result = goodsCommentDao.delCommentLike(po);
			if(result < 0){
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			check--;
		}else {
			int result = goodsCommentDao.addCommentLike(po);
			if(result < 0){
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			check++;
		}
		
		return check;
	}

	@Override
	public void reportGoodsComment(GoodsCommentPO po) {
		GoodsCommentSO so = new GoodsCommentSO();
		so.setGoodsEstmNo(po.getGoodsEstmNo());
		so.setSysRegrNo(po.getSysRegrNo());
		
		int check = goodsCommentDao.searchReportGoodsComment(so);
		
		if(check != 0) {
			throw new CustomException(ExceptionConstants.ERROR_GOODS_COMMENT_REPORT);
		}else {
			int result = goodsCommentDao.reportGoodsComment(po);
			if(result == 0){
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
	}
	
	
	@Override
	@Transactional(readOnly=true)
	public GoodsCommentVO getGoodsComment(GoodsCommentSO so) {
		return goodsCommentDao.getGoodsComment(so);
	}

	@Override
	public List<GoodsEstmQstVO> getPageGoodsCommentEstmList(GoodsCommentSO so) {
		return goodsCommentDao.getPageGoodsCommentEstmList(so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayServiceImpl.java
	 * - 작성일        : 2021. 3. 2.
	 * - 작성자        : YKU
	 * - 설명          : 펫로그 후기
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<PetLogGoodsVO> petLogReview(PetLogGoodsSO so) {
		return goodsCommentDao.petLogReview(so);
	}

	/* (non-Javadoc)
	 * @see biz.app.goods.service.GoodsCommentService#getMyGoodsComment(biz.app.order.model.OrderDetailSO)
	 * 나의 상품평 조회
	 */
	@Override
	@Transactional(readOnly=true)
	public List<GoodsCommentVO> getMyGoodsComment(OrderDetailSO so) {
		List<GoodsCommentVO> list = goodsCommentDao.getMyGoodsComment(so);
		
		return list;
	}

	/* (non-Javadoc)
	 * @see biz.app.goods.service.GoodsCommentService#pageGoodsCommentCount(biz.app.goods.model.GoodsCommentSO)
	 */
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public int pageGoodsCommentCount(GoodsCommentSO commentSO) {
		return goodsCommentDao.pageGoodsCommentCount(commentSO);
	}

	@Override
	public void appCommentImageUpdate(GoodsCommentPO po, String deviceGb) {
		//상품 이미지 업로드
		if(deviceGb.equals(CommonConstants.DEVICE_GB_30) && po.getImgPath() != null && po.getImgPath().length != 0) {
			GoodsCommentImagePO imgPO = new GoodsCommentImagePO();
			imgPO.setGoodsEstmNo(po.getGoodsEstmNo());
			imgPO.setSysRegrNo(po.getSysRegrNo());
			imgPO.setVdYn(CommonConstants.COMM_YN_N);
			for(int i = 0; i < po.getImgPath().length; i++) {
				imgPO.setImgPath(po.getImgPath()[i]);
				
				int imgResult = goodsCommentDao.insertGoodsCommentImage(imgPO);
				if(imgResult == 0){
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
		
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentServiceImpl.java
	* - 작성일		: 2021. 3. 25.
	* - 작성자		: pcm
	* - 설명		: 펫로그 후기 이어쓰기 여부 체크
	* </pre>
	* @param so
	* @return
	*/
	@Override
	public int inheritCheck(GoodsCommentSO so) {
		return goodsCommentDao.inheritCheck(so);
	}

	@Override
	public List<GoodsCommentImageVO> getGoodsPhotoCommentAll(GoodsCommentSO so) {
		return goodsCommentDao.getGoodsPhotoCommentAll(so);
	}

	@Override
	public int getDuplicateCommentCount(GoodsBaseSO so) {
		return goodsCommentDao.getDuplicateCommentCount(so);
	}

	@Override
	public GoodsCommentPO getCommentDeleteInfo(GoodsCommentSO so) {
		return goodsCommentDao.getCommentDeleteInfo(so);
	}

	@Override
	public GoodsCommentVO getPetLogGoodsComment(GoodsCommentSO so) {
		return goodsCommentDao.getPetLogGoodsComment(so);
	}


}