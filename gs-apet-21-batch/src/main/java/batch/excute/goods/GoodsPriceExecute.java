package batch.excute.goods;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.stream.Collectors;

import batch.config.util.BatchLogUtil;
import biz.app.goods.service.GoodsPriceService;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;

import biz.app.batch.model.BatchLogPO;
import biz.app.goods.model.SkuInfoSO;
import biz.app.goods.model.SkuInfoVO;
import biz.interfaces.cis.model.request.goods.SkuInfoUpdatePO;
import biz.interfaces.cis.model.response.goods.SkuInfoUpdateVO;
import biz.interfaces.cis.service.CisGoodsService;
import biz.interfaces.cis.service.CisIfLogService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명 : workspace
 * - 패키지명   : batch.excute.goods
 * - 파일명     : GoodsPriceExecute.java
 * - 작성일     : 2021. 01. 28.
 * - 작성자     : valfac
 * - 설명       : 상품 가격 변동 CIS 전송
 * </pre>
 */

@Slf4j
@Component
public class GoodsPriceExecute {

	@Autowired
	private Properties bizConfig;

	@Autowired
	private CisGoodsService cisGoodsService;

	@Autowired
	private CisIfLogService cisIfLogService;

	@Autowired
	private GoodsPriceService goodsPriceService;

	@Autowired
	private MessageSourceAccessor message;

	/**
	 * 대상 목록 CIS 전송
	 * 1분
	 */
	public void cronSkuInfoUpdate() {

		BatchLogPO blpo = BatchLogUtil.initBatchLogStrtDtm(CommonConstants.BATCH_GOODS_STK_INFO_SEND);

		try {

			ObjectMapper objectMapper = new ObjectMapper();

			//현재 시간
			String now = DateUtil.getTimestampToString(DateUtil.getTimestamp(), "yyyyMMddHHmm");

			SkuInfoSO skuInfoSO = new SkuInfoSO();
			skuInfoSO.setGoodsCstrtTpCd(CommonConstants.GOODS_CSTRT_TP_ITEM);
			skuInfoSO.setBatchYn(CommonConstants.COMM_YN_Y);
			skuInfoSO.setSendDtm(DateUtil.getTimestamp(now + "00", "yyyyMMddHHmmss"));

			List<SkuInfoVO> list = cisGoodsService.getStuInfoListForSend(skuInfoSO);

			int total= list.size();
			int success = 0;
			int fail = 0;

			if(total > 0) {
				// CIS 로그 일괄 등록 여부
				String batchYn = CommonConstants.COMM_YN_N;
				// CIS 로그 기록용
				List<SkuInfoUpdatePO> cisLogList = new ArrayList<>();

				Long logNo = null;
				if(CommonConstants.COMM_YN_Y.equals(batchYn)) {
					// API call log insert
					logNo = insertCisIfLog(CommonConstants.CIS_API_ID_IF_R_UPDATE_SKU_INFO, objectMapper.writeValueAsString(list));
				}
				// 주석
				String dtmStr = DateUtil.getTimestampToString(DateUtil.getTimestamp(), "yyyy-MM-dd HH:mm");
				String listStr = list.stream().map(SkuInfoVO::getCisMinute).distinct().collect(Collectors.joining(",")).toString();
				log.debug("대상 리스트 - {}분 {}개", listStr, total);

				// Bean 복사를 위한 처리
				BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );

				for(SkuInfoVO vo : list) {
					try {

						SkuInfoUpdatePO po = new SkuInfoUpdatePO();
						BeanUtils.copyProperties(po, vo);
						/** 화주 코드  개발 : PB, 운영 : AP */
						po.setOwnrCd(bizConfig.getProperty("cis.api.goods.ownrCd"));
						/** 물류센터 코드 개발 : WH01, 운영 : AW01 */
						po.setWareCd(bizConfig.getProperty("cis.api.goods.wareCd"));
						/** 이미지 경로 */
						if(StringUtils.isNotEmpty(vo.getImgSrc())) {
							po.setImgSrc(bizConfig.getProperty("naver.cloud.cdn.domain.folder") + vo.getImgSrc());
						}
						SkuInfoUpdateVO res = cisGoodsService.updateSkuInfo(po, batchYn);

						/**
						 * 성공
						 */
						if(res.getResCd().equalsIgnoreCase(CommonConstants.CIS_API_SUCCESS_CD)) {

							goodsPriceService.editGoodsPriceCisYn(vo.getGoodsPrcNo(), CommonConstants.COMM_YN_Y);
							// CIS 로그 쌓기
							if(CommonConstants.COMM_YN_Y.equals(batchYn)) {
								cisLogList.add(po);
							}
							// 성공 카운트
							success++;
						} else {
							/**
							 * 실패
							 * 로그도 쌓지 않는다
							 */
							// 실패 카운트
							fail++;
							log.debug("가격 배치 실패 {} : {} ", po.getSkuCd(), po.toString());
						}

					} catch (Exception e) {
						e.printStackTrace();
						fail++;
					}
				}

				// CIS 로그 일괄 등록 Y일 경우
				if(CommonConstants.COMM_YN_Y.equals(batchYn)) {
					String httpStatusCd = CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD;
					String resCd = CommonConstants.CIS_API_SUCCESS_CD;
					String resMsg = "";
					updateCisIfLog(CommonConstants.CIS_API_ID_IF_R_UPDATE_SKU_INFO, objectMapper.writeValueAsString(list), resCd, resMsg, httpStatusCd, logNo);
				}
			}

			String batchRstCd= CommonConstants.BATCH_RST_CD_SUCCESS;
			String batchRstMsg= this.message.getMessage("batch.log.result.msg.goods.skuinfo.update.success", new Object[] { list.size(), success, fail});

			BatchLogUtil.addBatchLog(blpo, batchRstCd, batchRstMsg);

		} catch (Exception e) {
			String batchRstCd= CommonConstants.BATCH_RST_CD_FAIL;
			String batchRstMsg= this.message.getMessage("batch.log.result.msg.goods.skuinfo.update.fail", e.getMessage());

			BatchLogUtil.addBatchLog(blpo, batchRstCd, batchRstMsg);
		}
	}

	/**
	 * CIS 로그 저장
	 * @param cisApiId
	 * @param reqString
	 * @return
	 */
	public Long insertCisIfLog(String cisApiId, String reqString) {
		return cisIfLogService.insertCisIfLog(cisApiId, reqString, "전송");
	}

	/**
	 * CIS 로그 수정
	 * @param cisApiId
	 * @param resString
	 * @param resCd
	 * @param resMsg
	 * @param httpStatusCd
	 * @param logNo
	 * @return
	 * @throws Exception
	 */
	public Long updateCisIfLog(String cisApiId, String resString, String resCd, String resMsg, String httpStatusCd, Long logNo) throws Exception{
		return cisIfLogService.updateCisIfLog(cisApiId, resString, "응답완료", resCd, resMsg, httpStatusCd, logNo);
	}
}
