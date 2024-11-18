package biz.app.event.service;

import biz.app.display.model.DisplayCategorySO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.event.dao.EventDao;
import biz.app.event.model.*;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.member.model.MemberBaseVO;
import biz.app.st.model.StStdInfoPO;
import biz.common.service.BizService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.JsonUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.event.service
* - 파일명		: EventServiceImpl.java
* - 작성일		: 2016. 4. 14.
* - 작성자		: phy
* - 설명		:
* </pre>
*/
@Slf4j
@Transactional
@Service("EventService")
public class EventServiceImpl implements EventService {

	@Autowired private EventDao eventDao;

	@Autowired private BizService bizService;

	private final String LOCAL_FILE_ROOT_PATH = "/temp/";

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	/* 이벤트 목록 조회
	 * @see biz.app.event.service.EventService#pageEvent(biz.app.event.model.EventBaseSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<EventBaseVO> pageEvent(EventBaseSO so) {
		return this.eventDao.pageEvent(so);
	}

	/* 기획전 목록 조회
	 * @see biz.app.event.service.EventService#pageExhibition(biz.app.display.model.DisplayCategorySO)
	 */
	@Override
	public List<DisplayCategoryVO> pageExhibition(DisplayCategorySO so) {
		return eventDao.pageExhibition(so);
	}

	/* 기획전 상품 조회
	 * @see biz.app.event.service.EventService#getExhibitionGoods(java.util.List)
	 */
	@Override
	public List<GoodsBaseVO> getExhibitionGoods(GoodsBaseSO gso) {
		return eventDao.getExhibitionGoods(gso);
	}
	
	/* 기획전 상품 조회
	 * @see biz.app.event.service.EventService#getExhibitionGoods(java.util.List)
	 */
	@Override
	public List<GoodsBaseVO> getExhibitionDealGoods(GoodsBaseSO gso) {
		return eventDao.getExhibitionDealGoods(gso);
	}
	
	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//

	@Override
	public EventBaseVO getEventBase (Long eventNo ) {
		return eventDao.getEventBase(eventNo);
	}

	@Override
	public Long saveEvent(EventBasePO po) {
		//EVENT_BASE 등록
		Long eventNo = Optional.ofNullable(po.getEventNo()).orElseGet(()->0L);
		String winDt = po.getWinDt().replaceAll("-","");
		po.setWinDt(winDt);
		//Boolean isInsert = Long.compare(eventNo,0L) == 0;
		Boolean isInsert = po.getEventNo() == null;

		//마케팅 일 시, 댓글 여부 무조건 N
		if(po.getContent().indexOf("/_images/common/event_img.jpg")>-1 ){
			po.setAplyUseYn(AdminConstants.COMM_YN_N);
		}

		if(isInsert){
			if(eventDao.insertEventBase(po) == 0){
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			eventNo = po.getEventNo();
			log.info("############# INSERT EVENT {}",eventNo);
			//사이트와 이벤트 매핑 등록
			Long stId = Optional.ofNullable(po.getStId()).orElseGet(()->AdminConstants.DEFAULT_ST_ID);
			if (Long.compare(stId,0L) != 0) {
				StStdInfoPO stStdInfoPO = new StStdInfoPO();
				stStdInfoPO.setStId(stId);
				stStdInfoPO.setEventNo(eventNo);
				if (eventDao.insertStEventMap(stStdInfoPO) == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}else{
			eventDao.updateEventBase(po);
			log.info("############# UPDATE EVENT {}",eventNo);
		}

		//이벤트 대표 이미지
		po.setDlgtImgPath(updateImgPath(eventNo,po.getDlgtImgPath(),Optional.ofNullable(po.getOrgDlgtImgPath()).orElseGet(()->"")));
		eventDao.updateEventDlgtImgPath(po);

		//응모형 일 때
		if(StringUtil.equals(po.getEventTpCd(),AdminConstants.EVENT_TP_20)){
			String pcImgPath = Optional.ofNullable(po.getPcImgPath()).orElseGet(()->"");
			String moImgPath = Optional.ofNullable(po.getMoImgPath()).orElseGet(()->"");

			if(StringUtil.isNotEmpty(pcImgPath) && StringUtil.isNotEmpty(moImgPath)){
				po.setPcImgPath(updateImgPath(eventNo,pcImgPath,""));
				po.setMoImgPath(updateImgPath(eventNo,moImgPath,""));

				if(isInsert && eventDao.insertEventEntry(po) == 0){
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				if(!isInsert && eventDao.updateEventEntry(po) == 0){
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}

			JsonUtil jsonUtil = new JsonUtil();
			EventCollectItemPO clctdel = new EventCollectItemPO();
			clctdel.setEventNo(eventNo);
			eventDao.deleteEventCollectItem(clctdel);

			// 이벤트 수집 항목 등록
			for (String collectItemCd : po.getCollectItemCd()) {
				EventCollectItemPO cpo = new EventCollectItemPO();
				cpo.setEventNo(eventNo);
				cpo.setCollectItemCd(collectItemCd);
				cpo.setSysRegrNo(po.getSysRegrNo());
				cpo.setSysUpdrNo(po.getSysUpdrNo());

				if (eventDao.insertEventCollectItem(cpo) == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
			
			//추가 필드
			String addFieldJsonStr = Optional.ofNullable(po.getAddFieldJsonStr()).orElseGet(()->"");
			if(StringUtil.isNotEmpty(addFieldJsonStr)){
				EventAddFieldPO del = new EventAddFieldPO();
				del.setEventNo(eventNo);
				eventDao.deleteEventAddField(del);

				List<EventAddFieldPO> addFields = jsonUtil.toArray(EventAddFieldPO.class, addFieldJsonStr);
				for (EventAddFieldPO efpo : addFields) {
					if (StringUtil.equals(efpo.getFldTpCd(), AdminConstants.FLD_TP_CD_70)) {
						String originalPath = Optional.ofNullable(efpo.getOriginalPath()).orElseGet(() -> "");
						String ftpImgPath = updateImgPath(eventNo, efpo.getFldVals(), originalPath);
						efpo.setFldVals(ftpImgPath);
					}
					efpo.setEventNo(eventNo);
					efpo.setSysRegrNo(po.getSysRegrNo());
					efpo.setSysUpdrNo(po.getSysUpdrNo());
					List<String> fldVals = Arrays.asList(Optional.ofNullable(efpo.getFldVals()).orElseGet(() -> "").split(";"));
					for(String fldVal : fldVals){
						efpo.setFldVal(fldVal);
						if (eventDao.insertEventAddField(efpo) == 0) {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
					}
				}
			}

			//퀴즈
			String quizJsonStr = Optional.ofNullable(po.getQuizJsonStr()).orElseGet(()->"");
			if(StringUtil.isNotEmpty(quizJsonStr) && StringUtil.equals(po.getEventGbCd(),AdminConstants.EVENT_GB_30)){
				EventQuestionPO qDel = new EventQuestionPO();
				EventAnswerPO aDel = new EventAnswerPO();
				qDel.setEventNo(eventNo);
				aDel.setEventNo(eventNo);
				eventDao.deleteEventQuestion(qDel);
				eventDao.deleteEventAnswer(aDel);

				List<EventQuestionPO> quizs = jsonUtil.toArray(EventQuestionPO.class, quizJsonStr);
				for(EventQuestionPO p : quizs){
					p.setEventNo(po.getEventNo());
					p.setSysRegrNo(po.getSysRegrNo());
					p.setSysUpdrNo(po.getSysUpdrNo());
					insertEventQuestionAndAnswer(p);
				}
			}
		}

		return eventNo;
	}

	@Override
	@Transactional(readOnly = false)
	public void insertEventQuestionAndAnswer(EventQuestionPO po) {
		// 질문 정보 등록
		int result = eventDao.insertEventQuestion(po);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 답변 정보 등록
		EventAnswerPO ap = new EventAnswerPO();
		ap.setQstNo(po.getQstNo());
		ap.setEventNo(po.getEventNo());
		ap.setSysRegrNo(po.getSysRegrNo());
		ap.setSysUpdrNo(po.getSysUpdrNo());

		Integer cnt = po.getRplCnt();
		String[] rplContents = po.getRplContents().split(";");
		String[] rghtansYns = po.getRghtansYns().split(";");
		for (int i = 0; i < cnt; i += 1) {
			ap.setRplContent(rplContents[i]);
			ap.setRghtansYn(rghtansYns[i]);
			result = eventDao.insertEventAnswer(ap);
			if (result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
	}
	
	//FTP 이미지 업로드
	private String updateImgPath(Long eventNo,String imgPath,String originalPath){
		String ftpUploadPath = "";
		// 이벤트 대표 이미지 처리
		String realImgPath = AdminConstants.EVENT_IMAGE_PATH + FileUtil.SEPARATOR + String.valueOf(eventNo);
		if(!StringUtil.isEmpty(imgPath) && !StringUtil.equals(imgPath,originalPath)) {
			FtpImgUtil ftpImgUtil =  new FtpImgUtil();
			
			//파일 삭제
			try{
				ftpImgUtil.delete(originalPath);
			}catch(Exception e){
				log.error("#### Error When ftp delete");
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}
			
			//파일 업로드
			try {
				realImgPath = StringUtils.replace(realImgPath, "..", StringUtils.EMPTY);
				String fileName = FilenameUtils.getName(imgPath);
				ftpUploadPath = realImgPath + FileUtil.SEPARATOR + fileName;
				ftpImgUtil.upload(imgPath, ftpUploadPath );	// 원본 이미지 FTP 복사
			} catch (Exception e) {
				log.error("#### Error When ftp upload");
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}
		}else{
			ftpUploadPath = imgPath;
		}
		return ftpUploadPath;
	}

	/* 이벤트 목록 조회
	 * @see biz.app.event.service.EventService#pageEventBase(biz.app.event.model.EventBaseSO)
	 */
	@Override
	public List<EventBaseVO> pageEventBase(EventBaseSO so) {
		List<EventBaseVO> list = Optional.ofNullable(eventDao.pageEventBase(so)).orElseGet(()->new ArrayList<EventBaseVO>());
		list.stream().forEach(v->{
			v.setAplStrtDtmStr(DateUtil.timeStamp2Str(v.getAplStrtDtm(),"yyyy.MM.dd"));
			v.setAplEndDtmStr(DateUtil.timeStamp2Str(v.getAplEndDtm(),"yyyy.MM.dd"));
		});
		return list;
	}

	@Override
	public EventBaseVO getEventPayment(){ return eventDao.getEventPayment(); }

	@Override
	public List listEventAddField(Long eventNo) {
		List<EventAddFieldVO> list = Optional.ofNullable(eventDao.listEventAddField(eventNo)).orElseGet(()->new ArrayList<EventAddFieldVO>());
		return list;
	}

	@Override
	public List listQuestionAndAnswerInfo(Long eventNo) {
		List<EventQuestionVO> list = Optional.ofNullable(eventDao.listQuestionAndAnswerInfo(eventNo)).orElseGet(()->new ArrayList<EventQuestionVO>());
		return list;
	}

	@Override
	public List<EventEntryWinInfoVO> pageEventJoinMember(EventEntryWinInfoSO so) {
		String searchCtt = so.getCtt();
		String searchPatirNm = so.getPatirNm().replaceAll("-","");
		searchCtt = bizService.twoWayEncrypt(searchCtt);
		searchPatirNm = bizService.twoWayEncrypt(searchPatirNm);
		so.setCtt(searchCtt);
		so.setPatirNm(searchPatirNm);

		List<EventEntryWinInfoVO> list = Optional.ofNullable(eventDao.pageEventJoinMember(so)).orElseGet(()->new ArrayList<EventEntryWinInfoVO>());
		Integer rowNum = so.getTotalCount() - (((int)so.getPage()-1)*so.getRows());
		for(EventEntryWinInfoVO v : list){
			String ctt = v.getCtt();
			String partirNm = v.getPatirNm();
			String email = v.getEmail();
			String loginId = v.getLoginId();

			v.setCtt(MaskingUtil.getTelNo(bizService.twoWayDecrypt(ctt)));
			v.setPatirNm(MaskingUtil.getName(bizService.twoWayDecrypt(partirNm)));
			v.setEmail(MaskingUtil.getEmail(bizService.twoWayDecrypt(email)));
			v.setLoginId(MaskingUtil.getId(bizService.twoWayDecrypt(loginId)));

			String t = Optional.ofNullable(v.getAddr()).orElseGet(()->"");
			if(StringUtil.isNotEmpty(t)){
				String[] addr = v.getAddr().split(";");
				if(addr.length > 1){
					String dtlAddr = addr[1];
					dtlAddr = bizService.twoWayDecrypt(addr[1]);
					v.setAddr(MaskingUtil.getAddress(addr[0],dtlAddr));
				}
			}

			v.setRowNum(rowNum);
			rowNum -=1;


		}
		return list;
	}

	@Override
	public List pageEventWinnerMember(EventEntryWinInfoSO so) {
		return Optional.ofNullable(eventDao.pageEventWinnerMember(so)).orElseGet(()->new ArrayList<MemberBaseVO>());
	}

	@Override
	public EventBaseVO getEventWinInfo(EventBaseSO so) {
		return Optional.ofNullable(eventDao.getEventWinInfo(so)).orElseGet(()->new EventBaseVO());
	}

	@Override
	public void insertEventWinList(EventBasePO po) {
		//TO-DO
	}
}
