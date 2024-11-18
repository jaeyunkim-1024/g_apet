package biz.app.goods.service;

import java.util.*;

import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.model.MemberIoAlarmVO;
import biz.app.member.service.MemberService;
import biz.common.model.PushTargetPO;
import biz.common.model.SendPushPO;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.appweb.service.PushService;
import biz.app.goods.dao.GoodsInquiryDao;
import biz.app.goods.model.GoodsInquiryPO;
import biz.app.goods.model.GoodsInquirySO;
import biz.app.goods.model.GoodsInquiryVO;
import biz.app.goods.model.GoodsIqrImgPO;
import biz.app.goods.model.GoodsPO;
import biz.common.service.BizService;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;



/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.service
* - 파일명		: GoodsInquiryServiceImpl.java
* - 작성일		: 2016. 3. 7.
* - 작성자		: snw
* - 설명		: 상품 문의 서비스
* </pre>
*/
@Transactional
@Service("goodsInquiryService")
public class GoodsInquiryServiceImpl implements GoodsInquiryService {

	@Autowired private GoodsInquiryDao goodsInquiryDao;
	@Autowired private BizService bizService;
	@Autowired private Properties bizConfig;
	@Autowired private MemberService memberService;
	@Autowired private PushService pushService;

	/*
	 * 상품문의 페이징 조회
	 * @see biz.app.goods.service.GoodsInquiryService#pageGoodsInquiry(biz.app.goods.model.GoodsInquirySO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<GoodsInquiryVO> pageGoodsInquiry(GoodsInquirySO so) {
		return this.goodsInquiryDao.pageGoodsInquiry(so);
	}

	/*
	 * 상품문의 상세 조회
	 * @see biz.app.goods.service.GoodsInquiryService#getGoodsInquiry(java.lang.Integer)
	 */
	@Override
	public GoodsInquiryVO getGoodsInquiry(GoodsInquirySO so) {
		return this.goodsInquiryDao.getGoodsInquiry(so);
	}

	/*
	 * 상품문의 삭제
	 * @see biz.app.goods.service.GoodsInquiryService#deleteGoodsInquiry(java.lang.Integer)
	 */
	@Override
	public void deleteGoodsInquiry(GoodsInquiryPO po) {
		GoodsInquirySO so = new GoodsInquirySO();
		so.setGoodsIqrNo(po.getGoodsIqrNo());
		GoodsInquiryVO goodsInquiry = this.goodsInquiryDao.getGoodsInquiry(so);

		if(goodsInquiry.getEqrrMbrNo().equals(po.getEqrrMbrNo())){
			int result = this.goodsInquiryDao.deleteGoodsInquiry(po);
			if(result == 0){
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			
			//이미지 삭제
			if(goodsInquiry.getGoodsIqrImgList() != null && goodsInquiry.getGoodsIqrImgList().size() > 0) {
				int delresult = goodsInquiryDao.deleteGoodsQnaImg(po);
				if(delresult == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}else{
			throw new CustomException(ExceptionConstants.ERROR_GOODS_INQUIRY_NO_EQUAL_MBR);
		}

	}

	/*
	 * 마이페이지 - 상품문의 페이징 조회
	 * @see biz.app.goods.service.GoodsInquiryService#pageMyGoodsInquiry(biz.app.goods.model.GoodsInquirySO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<GoodsInquiryVO> pageMyGoodsInquiry(GoodsInquirySO so) {
		return this.goodsInquiryDao.pageMyGoodsInquiry(so);
	}

	/* 상품Q&A 리스트 [BO]
	 * @see biz.app.goods.service.GoodsInquiryService#listGoodsInquiryGrid(biz.app.goods.model.GoodsInquirySO)
	 */
	@Override
	public List<GoodsInquiryVO> listGoodsInquiryGrid(GoodsInquirySO so) {
		if(StringUtil.isNotBlank(so.getLoginId())) {
			so.setLoginId(bizService.twoWayEncrypt(so.getLoginId()));
		}
		
		List<GoodsInquiryVO> inquiryList = goodsInquiryDao.listGoodsInquiryGrid(so);
		
		if (CollectionUtils.isNotEmpty(inquiryList)) {
			inquiryList.stream().forEach(v->{
				String replaceEqrrId = bizService.twoWayDecrypt(v.getEqrrId());
				if (StringUtil.isNotEmpty(replaceEqrrId)) {
					v.setEqrrId(replaceEqrrId);
				}
			});
		}
		
		return inquiryList;
	}

	/* 상품Q&A 리스트 전시상태 수정 [BO]
	 * @see biz.app.goods.service.GoodsInquiryService#updateGoodsInquiryDisp(biz.app.goods.model.GoodsInquiryPO)
	 */
	@Override
	public void updateGoodsInquiryDisp(GoodsPO po) {
		int result = 0;
		List<GoodsInquiryPO> goodsInquiryPOList = po.getGoodsInquiryPOList();

		if(goodsInquiryPOList != null && !goodsInquiryPOList.isEmpty()) {
			for(GoodsInquiryPO item : goodsInquiryPOList) {
				result = goodsInquiryDao.updateGoodsInquiryDisp(item);
			}
		}

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	/* 상품Q&A 상세 조회 [BO]
	 * @see biz.app.goods.service.GoodsInquiryService#getGoodsInquiryDetail(java.lang.Long)
	 */
	@Override
	public GoodsInquiryVO getGoodsInquiryDetail(Long goodsIqrNo) {
		GoodsInquiryVO vo = goodsInquiryDao.getGoodsInquiryDetail(goodsIqrNo);
			//문의 작성자 ID, 이름 복호화
			String replaceEqrrId = bizService.twoWayDecrypt(vo.getEqrrId());
			if (StringUtil.isNotEmpty(replaceEqrrId)) {
				vo.setEqrrId(replaceEqrrId);
			}
			String replaceEqrrNm = bizService.twoWayDecrypt(vo.getEqrrNm());
			if (StringUtil.isNotEmpty(replaceEqrrNm)) {
				vo.setEqrrNm(replaceEqrrNm);
			}
		return vo;
	}

	/* 상품Q&A 저장 [BO]
	 * @see biz.app.goods.service.GoodsInquiryService#updateGoodsInquiry(biz.app.goods.model.GoodsInquiryPO)
	 */
	@Override
	public void updateGoodsInquiry(GoodsInquiryPO po) {
		int result = goodsInquiryDao.updateGoodsInquiry(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	/* 상품Q&A 답변 리스트 [BO]
	 * @see biz.app.goods.service.GoodsInquiryService#listGoodsReplyGrid(biz.app.goods.model.GoodsInquirySO)
	 */
	@Override
	public List<GoodsInquiryVO> listGoodsReplyGrid(GoodsInquirySO so) {
		return goodsInquiryDao.listGoodsReplyGrid(so);
	}

	/* 상품Q&A 답변 수정 [BO]
	 * @see biz.app.goods.service.GoodsInquiryService#insertGoodsReply(biz.app.goods.model.GoodsInquiryPO)
	 */
	@Override
	public int updateGoodsReply(GoodsInquiryPO po) {
		// 상품 문의 상태 코드(20 : 답변완료)
		po.setGoodsIqrStatCd(CommonConstants.GOODS_IQR_STAT_20);

		GoodsInquirySO so = new GoodsInquirySO();
		so.setGoodsIqrNo(po.getGoodsIqrNo());
		GoodsInquiryVO goodsInquiryVO = getGoodsInquiry(so);



		int result = goodsInquiryDao.updateGoodsReply(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}else{
			if( goodsInquiryVO.getRplAlmRcvYn() != null && CommonConstants.COMM_YN_Y.contentEquals(goodsInquiryVO.getRplAlmRcvYn()) ) {
				MemberBaseSO mbso = new MemberBaseSO();
				mbso.setMbrNo(goodsInquiryVO.getEqrrMbrNo());
				MemberBaseVO memberBaseVO = memberService.getMemberBase(mbso);
				
				PushSO pso = new PushSO();
				pso.setTmplNo(125L);
				PushVO pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회 
//				String movPath = StringUtil.replaceAll(pvo.getMovPath(), CommonConstants.PUSH_TMPL_VRBL_320 , goodsInquiryVO.getGoodsId());
				String movPath = StringUtil.replaceAll(pvo.getMovPath(), CommonConstants.PUSH_TMPL_VRBL_370 , String.valueOf(po.getGoodsIqrNo()));
				
				SendPushPO ppo = new SendPushPO();
				ppo.setTmplNo(125L);//상품 문의 답변 알림 템플릿
				List<PushTargetPO> target = new ArrayList<PushTargetPO>();

				PushTargetPO tpo = new PushTargetPO();
				tpo.setTo(""+goodsInquiryVO.getEqrrMbrNo());
				Map<String, String> paramMap = new HashMap<String, String>();
				//tpo.setLandingUrl("/goods/indexGoodsDetail?goodsId="+ goodsInquiryVO.getGoodsId()  + "&home=shop");
				tpo.setLandingUrl(movPath);
				paramMap.put(CommonConstants.PUSH_TMPL_VRBL_80, memberBaseVO.getNickNm());//템플릿에서 회원 닉네임 치환
				tpo.setParameters(paramMap);
				target.add(tpo);

				ppo.setTarget(target);

				bizService.sendPush(ppo);
			}
		}
		return result;
	}

	/* 상품 qna 리스트 조회 [FO]
	 * @see biz.app.goods.service.GoodsInquiryService#getGoodsInquiryList(biz.app.goods.model.GoodsInquiryPO)
	*/
	@Override
	public List<GoodsInquiryVO> getGoodsInquiryList(GoodsInquirySO so) {
		List<GoodsInquiryVO> goodsInquiryList = goodsInquiryDao.getGoodsInquiryList(so);
		
		if (CollectionUtils.isNotEmpty(goodsInquiryList)) {
			for(int i=0; i<goodsInquiryList.size(); i++) {
				// 로그인 아이디 복호화/마스킹
				String replaceEqrrId = bizService.twoWayDecrypt(goodsInquiryList.get(i).getEqrrId());
				if (StringUtil.isNotEmpty(replaceEqrrId)) {
					goodsInquiryList.get(i).setEqrrId(MaskingUtil.getId(replaceEqrrId));
				}
			}
		}
		return goodsInquiryList;
	}

	/*
	 * 상품문의 등록
	 * @see biz.app.goods.service.GoodsInquiryService#insertGoodsInquiry(biz.app.goods.model.GoodsInquiryPO)
	 */
	@Override
	public void insertGoodsInquiry(GoodsInquiryPO po, String deviceGb) {
		po.setGoodsIqrStatCd(FrontConstants.GOODS_IQR_STAT_10);
		po.setDispYn(FrontConstants.COMM_YN_Y);
		int result = this.goodsInquiryDao.insertGoodsInquiry(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}else {
			//qna 이미지 등록
			if(!deviceGb.equals(CommonConstants.DEVICE_GB_30) && po.getImgPaths() != null && po.getImgPaths().size() != 0) {
				for(String imgPath : po.getImgPaths()) {
					/**
					 * 이미지 경로 처리 필요
					 * */
					GoodsIqrImgPO imgPO = new GoodsIqrImgPO();
					imgPO.setGoodsIqrNo(po.getGoodsIqrNo());
					imgPO.setImgPath(imgPath);
					imgPO.setVdYn(CommonConstants.COMM_YN_N);
					imgPO.setSysRegrNo(po.getSysRegrNo());
					
//					if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
//					}
					FtpImgUtil ftpImgUtil = new FtpImgUtil();
					String filePath = ftpImgUtil.uploadFilePath(imgPO.getImgPath(), AdminConstants.GOODS_INQUIRY_IMG_PATH + FileUtil.SEPARATOR + po.getGoodsIqrNo());
					ftpImgUtil.upload(imgPO.getImgPath(), filePath);
					if(StringUtil.isNotEmpty(filePath)){
						imgPO.setImgPath(filePath);
					}
					
					int imgResult = goodsInquiryDao.insertGoodsQnaImage(imgPO);
					if(imgResult == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}
	}

	@Override
	public void updateGoodsQna(GoodsInquiryPO po, String deviceGb) {
		int result = goodsInquiryDao.updateGoodsQna(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}else {			
			//qna 이미지 등록
			if(!deviceGb.equals(CommonConstants.DEVICE_GB_30)) {
				if(po.getImgPaths() != null && po.getImgPaths().size() != 0) {
					for(String imgPath : po.getImgPaths()) {
						/**
						 * 이미지 경로 처리 필요
						 * */
						GoodsIqrImgPO imgPO = new GoodsIqrImgPO();
						imgPO.setGoodsIqrNo(po.getGoodsIqrNo());
						imgPO.setImgPath(imgPath);
						imgPO.setVdYn(CommonConstants.COMM_YN_N);
						imgPO.setSysRegrNo(po.getSysRegrNo());
						
//						if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
//						}
						FtpImgUtil ftpImgUtil = new FtpImgUtil();
						String filePath = ftpImgUtil.uploadFilePath(imgPO.getImgPath(), AdminConstants.GOODS_INQUIRY_IMG_PATH + FileUtil.SEPARATOR + po.getGoodsIqrNo());
						ftpImgUtil.upload(imgPO.getImgPath(), filePath);
						if(StringUtil.isNotEmpty(filePath)){
							imgPO.setImgPath(filePath);
						}
						
						int imgResult = goodsInquiryDao.insertGoodsQnaImage(imgPO);
						if(imgResult == 0) {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
					}
				}
			}

			//삭제 된 사진
			if(po.getDelImgSeqs() != null && po.getDelImgSeqs().length != 0) {
				for(int i = 0; i < po.getDelImgSeqs().length; i++) {
					po.setImgSeq(po.getDelImgSeqs()[i]);
					int delresult = goodsInquiryDao.deleteGoodsQnaImg(po);

					if(delresult == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}
	}

	@Override
	public GoodsInquiryVO getGoodsQna(GoodsInquirySO so) {
		GoodsInquiryVO vo = this.goodsInquiryDao.getGoodsInquiry(so);
		if(StringUtil.isEmpty(vo.getGoodsIqrNo())) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		if(!vo.getEqrrMbrNo().equals(so.getEqrrMbrNo())){
			throw new CustomException(ExceptionConstants.ERROR_GOODS_COMMENT_NO_EQUAL_MBR);
		}
		return vo;
	}

	@Override
	public void appInquiryImageUpdate(GoodsInquiryPO po, String deviceGb) {
		if(deviceGb.equals(CommonConstants.DEVICE_GB_30) && po.getImgPaths() != null && po.getImgPaths().size() != 0) {
			GoodsIqrImgPO imgPO = new GoodsIqrImgPO();
			imgPO.setGoodsIqrNo(po.getGoodsIqrNo());
			imgPO.setVdYn(CommonConstants.COMM_YN_N);
			imgPO.setSysRegrNo(po.getSysRegrNo());
			
			for(String imgPath : po.getImgPaths()) {
				/**
				 * 이미지 경로 처리 필요
				 * */
				imgPO.setImgPath(imgPath);
				
				int imgResult = goodsInquiryDao.insertGoodsQnaImage(imgPO);
				if(imgResult == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
	}
}