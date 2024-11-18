package batch.excute.goods;

import java.io.File;
import java.util.List;
import java.util.Properties;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.goods.model.GoodsImgChgHistPO;
import biz.app.goods.model.GoodsImgPO;
import biz.app.goods.model.GoodsImgPrcsListPO;
import biz.app.goods.model.GoodsImgPrcsListVO;
import biz.app.goods.service.GoodsBulkUploadService;
import biz.app.goods.service.GoodsService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.ImageDownUtil;
import framework.common.util.ImagePathUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 21.batch
* - 패키지명		: batch.excute.goods
* - 파일명		: GoodsImgPrcsListExecute.java
* - 작성일		: 2017. 5. 23.
* - 작성자		: hongjun
* - 설명			: 상품일괄 이미지 업로드 관련 Excute
* </pre>
*/
@Slf4j
@Component
public class GoodsImgPrcsListExecute {

	@Autowired
	private GoodsBulkUploadService goodsBulkUploadService;

	@Autowired
	private Properties bizConfig;

	@Autowired
	private BatchService batchService;

	@Autowired
	private GoodsService goodsService;

	@Autowired
	private MessageSourceAccessor message;

	/**
	 * <pre>
	 * - 프로젝트명	: 21.batch
	 * - 파일명		: GoodsImgPrcsListExecute.java
	 * - 작성일		: 2017. 5. 23.
	 * - 작성자		: hongjun
	 * - 설명		: 이미지를 URL 에서 다운로드 후 상품의 이미지로 Update
	 * </pre>
	 */
//	@Scheduled(cron = "0 0 * * * *")
	public void cronGoodsImgPrcsList() {

		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_GOODS_IMG_PRCS_LIST);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);

		ImageDownUtil imageDownUtil = new ImageDownUtil(bizConfig);
		FtpImgUtil ftpImgUtil = new FtpImgUtil(bizConfig);

		try {
			List<GoodsImgPrcsListVO> listGoodsImgPrcsListVO = goodsBulkUploadService.getGoodsImgPrcsList();

			log.info("Goods Img Prcs List Target Count :: " + listGoodsImgPrcsListVO.size());

			for (GoodsImgPrcsListVO vo : listGoodsImgPrcsListVO) {
				GoodsImgPrcsListPO goodsImgPrcsListPO = new GoodsImgPrcsListPO();
				goodsImgPrcsListPO.setGoodsId(vo.getGoodsId());
				goodsImgPrcsListPO.setPrcsSeq(vo.getPrcsSeq());
				goodsImgPrcsListPO.setImgPrcsYn(CommonConstants.COMM_YN_Y);
				goodsImgPrcsListPO.setSysUpdrNo(CommonConstants.COMMON_BATCH_USR_NO);

				String[] urlArray = vo.getUrlArray().split(":IMG_URL:");

				try {
					int imgSeq = 1;
					for (int i = 0 ; i < urlArray.length; i++) {
						GoodsImgPO po = new GoodsImgPO();
						po.setGoodsId(vo.getGoodsId() );
						po.setDlgtYn(CommonConstants.COMM_YN_N);
						po.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
						po.setSysUpdrNo(CommonConstants.COMMON_BATCH_USR_NO);

						if (i == 0) {
							po.setDlgtYn(CommonConstants.COMM_YN_Y);
						}

						String[] imgUrl = urlArray[i].split(":SPLIT:");
						if (StringUtils.startsWithIgnoreCase(imgUrl[0], "http")) {
							po.setImgPath(imageDownUtil.fetchFile(imgUrl[0]));
							if (StringUtils.startsWithIgnoreCase(imgUrl[1], "http")) {
								po.setRvsImgPath(imageDownUtil.fetchFile(imgUrl[1]));
							}
							po.setImgSeq(imgSeq++);
						} else {
							continue;
						}

						/*
						if (imgUrl.length > 0) {
							if (!"NULL".equals(imgUrl[0]) && StringUtil.isNotBlank(imgUrl[0])) {
								po.setImgPath(imageDownUtil.fetchFile(imgUrl[0]));
							}
						}
						if (imgUrl.length > 1) {
							if (!"NULL".equals(imgUrl[1]) && StringUtil.isNotBlank(imgUrl[1])) {
								po.setRvsImgPath(imageDownUtil.fetchFile(imgUrl[1]));
							}
						}
						*/

//						if (StringUtil.isEmpty(po.getImgPath()) && StringUtil.isEmpty(po.getRvsImgPath()) ) {
//							continue;
//						}

						String realImgPath = null;
						String realRvsImgPath = null;
						String realPath = null;

						// 정 이미지
						if(!StringUtil.isEmpty(po.getImgPath()) ) {
							realImgPath = ImagePathUtil.makeGoodsImagePath (po.getImgPath(), po.getGoodsId(), po.getImgSeq(), false );
							FileUtil.fileCopy(po.getImgPath(), realImgPath );	// temp 디렉토리에서 상품 이미지 포멧에 맞추어 복사.
							FileUtil.delete(po.getImgPath()); // temp 이미지 삭제
							realPath = ftpImgUtil.goodsImgUpload(realImgPath );	// 원본 이미지 FTP 복사
							goodsService.goodsImgResize(realImgPath);	// 이미지 리사이징.
							po.setImgPath(realPath);
							FileUtil.delete(realImgPath);	// 복사된 이미지 삭제.. [temp]
						}

						// 역 이미지
						if(!StringUtil.isEmpty(po.getRvsImgPath()) ) {
							realRvsImgPath = ImagePathUtil.makeGoodsImagePath (po.getRvsImgPath(), po.getGoodsId(), po.getImgSeq(), true );
							FileUtil.fileCopy(po.getRvsImgPath(), realRvsImgPath );	// temp 디렉토리에서 상품 이미지 포멧에 맞추어 복사.
							FileUtil.delete(po.getRvsImgPath()); // temp 이미지 삭제
							realPath = ftpImgUtil.goodsImgUpload(realRvsImgPath );	// 원본 이미지 FTP 복사
							goodsService.goodsImgResize(realRvsImgPath);	// 이미지 리사이징.
							po.setRvsImgPath(realPath);
							FileUtil.delete(realRvsImgPath );	// 복사된 이미지 삭제.. [temp]
						}

						try {

							if (!StringUtil.isEmpty(po.getImgPath()) || !StringUtil.isEmpty(po.getRvsImgPath())) {
								FileUtil.delete(new File(StringUtils.isEmpty(realImgPath) ? realRvsImgPath : realImgPath).getParent());
							}

						} catch (Exception e) {
							log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
						}

						// 이미지 수정
						int result = goodsService.updateGoodsImg(po );

						if ( result != 1 ) {
							// 이미지 등록
							result = goodsService.insertGoodsImg(po );

							if ( result != 1 ) {
								throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
							}
						}

						// 이력 등록
						GoodsImgChgHistPO goodsImgChgHistPO = new GoodsImgChgHistPO ();
						goodsImgChgHistPO.setGoodsId(po.getGoodsId() );
						goodsImgChgHistPO.setImgSeq(po.getImgSeq());
						goodsImgChgHistPO.setImgPath(po.getImgPath());
						goodsImgChgHistPO.setRvsImgPath(po.getRvsImgPath());
						goodsImgChgHistPO.setDlgtYn(po.getDlgtYn());
						goodsImgChgHistPO.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
						goodsImgChgHistPO.setSysUpdrNo(CommonConstants.COMMON_BATCH_USR_NO);

						goodsService.insertGoodsImgChgHist(goodsImgChgHistPO );
//						apprCnt++;
					}

					goodsBulkUploadService.updateGoodsImgPrcsList(goodsImgPrcsListPO);
				} catch (Exception e) {
//					cnclCnt++;
					goodsImgPrcsListPO.setImgPrcsYn(CommonConstants.COMM_YN_N);
					goodsImgPrcsListPO.setMemo(e.toString() + ": " + e.getMessage());
					goodsBulkUploadService.updateGoodsImgPrcsList(goodsImgPrcsListPO);
				}
			}

			blpo.setBatchEndDtm(DateUtil.getTimestamp());
			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
			blpo.setBatchRstMsg(this.message.getMessage("batch.log.result.msg.goods.image.resize", new Object[] { listGoodsImgPrcsListVO.size() }));

			batchService.insertBatchLog(blpo);

			log.debug(String.valueOf(blpo.getResult()));

		} catch (Exception e) {
			blpo.setBatchEndDtm(DateUtil.getTimestamp());
			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_FAIL);
			blpo.setBatchRstMsg(e.getMessage());

			batchService.insertBatchLog(blpo);

			log.debug(String.valueOf(blpo.getResult()));
		}
	}
}
