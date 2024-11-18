package front.web.view.petlog.controller;

import biz.app.display.model.*;
import biz.app.display.service.SeoService;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsRelatedSO;
import biz.app.goods.service.GoodsService;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.app.petlog.model.*;
import biz.app.petlog.service.PetLogService;
import biz.app.system.model.CodeDetailVO;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.app.tag.service.TagService;
import biz.common.service.BizService;
import biz.interfaces.gsr.model.GsrLnkMapSO;
import biz.interfaces.gsr.model.GsrMemberPointPO;
import biz.interfaces.gsr.model.GsrMemberPointVO;
import biz.interfaces.gsr.service.GsrService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.enums.SearchApiSpec;
import framework.common.exception.CustomException;
import framework.common.util.*;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.util.ImagePathUtil;
import front.web.config.view.ViewBase;
import front.web.view.common.controller.ExceptionController;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.logging.log4j.core.config.plugins.validation.constraints.Required;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.security.PrivateKey;
import java.util.*;


/**
 * @author kms
 *
 */
/**
 * @author kms
 *
 */
@Slf4j
@Controller
@RequestMapping("log")
public class PetLogController {

	@Autowired
	private PetLogService petLogService;
	@Autowired
	private GoodsService goodsService;
	@Autowired	
	private BizService bizService;
	@Autowired
	private GsrService gsrService;
	@Autowired
	private SearchApiUtil searchApiClient;
	
	@Autowired private MemberService memberService;
	
	@Autowired
	private SeoService seoService;
	
	@Autowired private Properties webConfig;
	
	@Autowired private NhnShortUrlUtil NhnShortUrlUtil;
	@Autowired private TagService tagService;
	
	@RequestMapping(value = "indexPetLogInsertView")
	public String indexPetLogInsertView(ModelMap map, ViewBase view, Session session,  PetLogBaseSO so
									, @RequestParam(value="rtnUrl", required=false) String rtnUrl , @RequestParam(value="goMain", required=false) String goMain) {	
		
		map.put("petLogBase", so);
		map.put("session", session);
		map.put("view", view);
		map.put("rtnUrl", rtnUrl);
		map.put("goMain", goMain);

		//펫로그 상품 후기 작성 시 포인트 지급 여부 확인
		CodeDetailVO period = gsrService.getCodeDetailVO(FrontConstants.GS_PNT_PERIOD,FrontConstants.GS_PNT_PERIOD_REVIEW);
		//기간 체크
		Boolean isPeriod = false;
		String strtDtm = Optional.ofNullable(period.getUsrDfn1Val()).orElseGet(()->"");
		String endDtm = Optional.ofNullable(period.getUsrDfn2Val()).orElseGet(()->"");
		Long today = System.currentTimeMillis();

		if(StringUtil.isNotEmpty(strtDtm) && StringUtil.isNotEmpty(endDtm)){
			Long strt = DateUtil.getTimestamp(strtDtm,"yyyyMMdd").getTime();
			Long end = DateUtil.getTimestamp(endDtm,"yyyyMMdd").getTime();
			isPeriod = strt <= today && today <= end;
		}else if(StringUtil.isNotEmpty(strtDtm)){
			Long strt = DateUtil.getTimestamp(strtDtm,"yyyyMMdd").getTime();
			isPeriod = strt <= today ;
		}else if(StringUtil.isNotEmpty(endDtm)){
			Long end = DateUtil.getTimestamp(endDtm,"yyyyMMdd").getTime();
			isPeriod = today <= end;
		}else{
			isPeriod = false;
		}

		String useYn = CommonConstants.COMM_YN_N;

		if(isPeriod){
			CodeDetailVO reward = gsrService.getCodeDetailVO(FrontConstants.VARIABLE_CONSTANTS,FrontConstants.VARIABLE_CONSTATNS_PET_LOG_REVIEW_PNT);
			useYn = reward.getUseYn();
		}
		map.put("gsReViewUseYn",useYn);
		
		return TilesView.none(new String[]{"petlog", "indexPetLogInsertView"});
	}
	

	@RequestMapping(value = "petLogBaseInsert")
	@ResponseBody
	public ModelMap petLogBaseInsert(Session session,  PetLogBasePO po) {
		
		if( po.getPetLogChnlCd().isEmpty() ) {po.setPetLogChnlCd(CommonConstants.PETLOG_CHNL_10);}
		po.setMbrNo(session.getMbrNo());
		// Pet Log 등록
		Long petLogNo = petLogService.insertPetLogBase(po);

		ModelMap map = new ModelMap();
		map.put("petLogNo", petLogNo);

		String useYn = CommonConstants.COMM_YN_N;
		if(StringUtil.equals(po.getRvwYn(),FrontConstants.COMM_YN_Y)){
			//펫로그 상품 후기 작성 시 포인트 지급 여부 확인
			CodeDetailVO period = gsrService.getCodeDetailVO(FrontConstants.GS_PNT_PERIOD,FrontConstants.GS_PNT_PERIOD_REVIEW);
			//기간 체크
			Boolean isPeriod = false;
			String strtDtm = Optional.ofNullable(period.getUsrDfn1Val()).orElseGet(()->"");
			String endDtm = Optional.ofNullable(period.getUsrDfn2Val()).orElseGet(()->"");
			Long today = System.currentTimeMillis();

			if(StringUtil.isNotEmpty(strtDtm) && StringUtil.isNotEmpty(endDtm)){
				Long strt = DateUtil.getTimestamp(strtDtm,"yyyyMMdd").getTime();
				Long end = DateUtil.getTimestamp(endDtm,"yyyyMMdd").getTime();
				isPeriod = strt <= today && today <= end;
			}else if(StringUtil.isNotEmpty(strtDtm)){
				Long strt = DateUtil.getTimestamp(strtDtm,"yyyyMMdd").getTime();
				isPeriod = strt <= today ;
			}else if(StringUtil.isNotEmpty(endDtm)){
				Long end = DateUtil.getTimestamp(endDtm,"yyyyMMdd").getTime();
				isPeriod = today <= end;
			}else{
				isPeriod = false;
			}

			if(isPeriod){
				CodeDetailVO reward = gsrService.getCodeDetailVO(FrontConstants.VARIABLE_CONSTANTS,FrontConstants.VARIABLE_CONSTATNS_PET_LOG_REVIEW_PNT);
				useYn = reward.getUseYn();
				if(StringUtil.equals(reward.getUseYn(),FrontConstants.COMM_YN_Y)){
						GsrLnkMapSO so = new GsrLnkMapSO();
						so.setOrdNo(po.getOrdNo());
						so.setGoodsEstmNo(po.getGoodsEstmNo());
						Integer cnt = gsrService.getRcptNoCnt(so);
						
						//지급된적 없을 때
						if(Integer.compare(cnt,0) == 0){
							map.put("ordNo",po.getOrdNo());
							map.put("goodsEstmNo",po.getGoodsEstmNo());
						}
				}
			}
		}
		map.put("gsReViewUseYn",useYn);

		return map;
	}	

	@RequestMapping(value = "indexPetLogDetailView")
	public String indexPetLogDetailView(ModelMap map, PetLogBaseSO so, Session session, ViewBase view) {
		so.setLoginMbrNo(session.getMbrNo());	
		
		//System.out.println( "DeviceGb1====>"+ view.getDeviceGb());	   
		String adminYn =  so.getAdminYn();
		if( !StringUtil.isEmpty(adminYn) && adminYn.equals("Y")) { // BO 에서 요청
			view.setDeviceGb(CommonConstants.DEVICE_GB_20);
		}else {
			// FO 에서는 '노출' 만.
			so.setContsStatCd(CommonConstants.PETLOG_DISP_GB_10);
		}
		
		// 공유하기 등의 링크를 통해 진입한경우
		if(StringUtil.isNotBlank(so.getShareAcc()) && "Y".equals(so.getShareAcc())) {
			view.setShareAcc("Y");
		}
		//System.out.println( "DeviceGb2====>"+ view.getDeviceGb());
	   
		// 펫로그 정보 조회
		PetLogBaseVO petLogBaseVO = petLogService.getPetLogDetail(so);
		
		//해당 펫로그 번호의 게시물이 삭제 되었을 시 404 페이지로 포워딩
		if(ObjectUtil.isEmpty(petLogBaseVO.getPetLogNo())) {
			return FrontConstants.NOT_FOUND_FORWARD;
		}
		
		// 연관상품 셋팅.
		if(StringUtil.equals(CommonConstants.COMM_YN_Y, petLogBaseVO.getRvwYn())
				|| StringUtil.equals(CommonConstants.COMM_YN_Y, petLogBaseVO.getGoodsRcomYn())) {
			String petNos = session.getPetNos();
			Long petNo = 0L;
			if(!StringUtil.isEmpty(petNos)) {
				String[] petNosList = StringUtil.split(petNos,",");
				if(petNosList.length > 0) {						
					petNo =  Long.parseLong(petNosList[0]);
				}
			}
			GoodsRelatedSO gso = null;
			setRelatedGoodsInfo(session, view, petLogBaseVO, gso, petNo);
		}
		
		// 조회 수+1 처리
		PetLogBasePO po = new PetLogBasePO();
		po.setPetLogNo(petLogBaseVO.getPetLogNo());	
		po.setHits(1);
		petLogService.updatePetLogBase(po);
		
		//ModelMap map = new ModelMap();
		map.put("petLogBase", petLogBaseVO);
		map.put("session", session);
		map.put("view", view);
		map.put("adminYn", adminYn);		
		
		// 로그인 사용자 정보
		PetLogListSO lso = new PetLogListSO();
		map = getLoginUserInfo(map, view, session, lso, "N");
		
		return TilesView.none(new String[] {"petlog", "indexPetLogDetailView"});
	}
	
	
	@RequestMapping(value = "includePetLogDetail")
	public String indexPetLogDetailAdminView(ModelMap map, PetLogBaseSO so, Session session, ViewBase view) {
		so.setLoginMbrNo(session.getMbrNo());	
		
		//System.out.println( "DeviceGb1====>"+ view.getDeviceGb());	   
		String adminYn =  so.getAdminYn();
		if( !StringUtil.isEmpty(adminYn) && adminYn.equals("Y")) {
			view.setDeviceGb(CommonConstants.DEVICE_GB_20);
		}   
		//System.out.println( "DeviceGb2====>"+ view.getDeviceGb());
	   
		// 펫로그 정보 조회
		PetLogBaseVO petLogBaseVO = petLogService.getPetLogDetail(so);

		//ModelMap map = new ModelMap();
		map.put("petLogBase", petLogBaseVO);
		map.put("session", session);
		map.put("view", view);
		map.put("adminYn", adminYn);
		
		return TilesView.none(new String[] {"petlog", "include", "includePetLogDetail"});
	}
	
	
	@RequestMapping(value = "indexPetLogUpdateView")
	public String indexPetLogUpdateView(ModelMap map, ViewBase view, Session session,  PetLogBaseSO so ,String commentYn, String goodsYn) {
		// 펫로그 정보 조회
		PetLogBaseVO vo = petLogService.getPetLogDetail(so);
		
		if(!StringUtil.isEmpty(vo.getDscrt()) && vo.getDscrt().indexOf("\n&emsp;\n#상품후기") != -1) {
			vo.setDscrt(vo.getDscrt().substring(0, vo.getDscrt().indexOf("\n&emsp;\n#상품후기")));
		}

		map.put("goodsYn", goodsYn);
		map.put("commentYn", commentYn);
		map.put("petLogBase", vo);
		map.put("session", session);
		map.put("view", view);

		//펫로그 상품 후기 작성 시 포인트 지급 여부 확인
		CodeDetailVO period = gsrService.getCodeDetailVO(FrontConstants.GS_PNT_PERIOD,FrontConstants.GS_PNT_PERIOD_REVIEW);
		//기간 체크
		Boolean isPeriod = false;
		String strtDtm = Optional.ofNullable(period.getUsrDfn1Val()).orElseGet(()->"");
		String endDtm = Optional.ofNullable(period.getUsrDfn2Val()).orElseGet(()->"");
		Long today = System.currentTimeMillis();

		if(StringUtil.isNotEmpty(strtDtm) && StringUtil.isNotEmpty(endDtm)){
			Long strt = DateUtil.getTimestamp(strtDtm,"yyyyMMdd").getTime();
			Long end = DateUtil.getTimestamp(endDtm,"yyyyMMdd").getTime();
			isPeriod = strt <= today && today <= end;
		}else if(StringUtil.isNotEmpty(strtDtm)){
			Long strt = DateUtil.getTimestamp(strtDtm,"yyyyMMdd").getTime();
			isPeriod = strt <= today ;
		}else if(StringUtil.isNotEmpty(endDtm)){
			Long end = DateUtil.getTimestamp(endDtm,"yyyyMMdd").getTime();
			isPeriod = today <= end;
		}else{
			isPeriod = false;
		}

		String useYn = CommonConstants.COMM_YN_N;
		if(isPeriod){
			CodeDetailVO reward = gsrService.getCodeDetailVO(FrontConstants.VARIABLE_CONSTANTS,FrontConstants.VARIABLE_CONSTATNS_PET_LOG_REVIEW_PNT);
			useYn = reward.getUseYn();
		}
		map.put("gsReViewUseYn",useYn);
		
		return TilesView.none(new String[]{"petlog", "indexPetLogUpdateView"});
	}
	
	
	@RequestMapping(value = "petLogBaseUpdate")
	@ResponseBody
	public ModelMap petLogBaseUpdate(Session session,  PetLogBasePO po) {
		// Pet Log 등록
		Long petLogNo = petLogService.updatePetLogBase(po);

		ModelMap map = new ModelMap();
		map.put("petLogNo", petLogNo);
		map.put("gsReViewUseYn",FrontConstants.COMM_YN_N);

		return map;
	}
	
	
	@RequestMapping(value = "petLogBaseDelete")
	@ResponseBody
	public ModelMap petLogBaseDelete(Session session,  PetLogBasePO po) {
		// Pet Log 삭제
		petLogService.deletePetLogBase(po, "LOG");

		ModelMap map = new ModelMap();
		map.put("petLogNo", po.getPetLogNo());
		return map;
	}
	
	@RequestMapping(value = "home")
	public String indexPetLogMain(ModelMap map, Session session, ViewBase view, PetLogListSO so){
		// 노출 게시물 정의													 
		// -로그인 시 (DB 조회 , 등록일 기준으로 정렬)								
		// 내가 쓴 게시물 , 팔로워가 쓴 게시물 후 노출(7일 이내 등록건)
		// 내가 쓴 게시물 , 팔로워가 쓴 게시물 전부 노출 후 신규 게시물 노출(7일 이내 등록건)
		// -비 로그인 시 
		// 누적된 전체 게시물을 검색 API에서 조회 , 좋아요 기준으로 정렬
		
		// 추천 게시물 정의 (노출 게시물 하단에 노출)
		// 첫번째 페이지 : 좋아할만한 펫로그 + 배너 (BO에서 등록한 6개노출, 없거나 갯수 미달 시 검색 api(log-optimal)호출)
		// 두번째 페이지 : 이 친구 어때요? + 배너 (BO에서 등록한 게시물 최대 6개 노출 , 없을 시 검색 api(log-member)호출)
		// 세번째 페이지 : 인기 태그 추천 + 배너 (BO에서 등록한 6개노출, 없거나 갯수 미달 시 검색 api(log-tag)호출)
		// 이후 페이징 시 : 이친구 어때요? (검색 api(log-member)호출 , 없을 시 미 노출)
		// 배너 : 이미지 배너만 등록이 가능하며 BO에서 등록한 배너 조회 , 없을 시 미 노출
		
		// 로그인 사용자의 mbrNo 셋팅(검색 추천에 사용)
		so.setLoginMbrNo(session.getMbrNo());
		// BO 의 미리보기 시 previewDt 가 들어옴.
		if( StringUtil.isEmpty(so.getPreviewDt()) ) {					
			so.setPreviewDt(DateUtil.getNowDate());			
			// FO 에서는 '노출' 만.
			so.setContsStatCd(CommonConstants.PETLOG_DISP_GB_10);
		}

		so.setRows(FrontWebConstants.PAGE_ROWS_5);	
		so.setSidx("SYS_REG_DTM");
		so.setSord(FrontWebConstants.SORD_DESC);
		if(StringUtil.isEmpty(so.getRecommendPage())) {
			so.setRecommendPage(1);
		}
		
		String prflImg = null;
		List<PetLogBaseVO> pagePetLogMainList = petLogService.pagePetLogMainList(so);
		for(PetLogBaseVO plvo: pagePetLogMainList) {
			if(session.getMbrNo() == plvo.getMbrNo()) {
				prflImg = plvo.getPrflImg();
			}
		}
		
		
		
		try {
			GoodsRelatedSO gso = null;
			String petNos = session.getPetNos();
			Long petNo = 0L;
			if(!StringUtil.isEmpty(petNos)) {
				String[] petNosList = StringUtil.split(petNos,",");
				if(petNosList.length > 0) {						
					petNo =  Long.parseLong(petNosList[0]);
				}
			}
			
			// 연관상품 갯수 조회
			for(PetLogBaseVO pvo : pagePetLogMainList ) {
				if( (!StringUtil.isEmpty(pvo.getRvwYn()) && CommonConstants.COMM_YN_Y.contentEquals(pvo.getRvwYn())) ||
						(!StringUtil.isEmpty(pvo.getGoodsRcomYn()) && CommonConstants.COMM_YN_Y.contentEquals(pvo.getGoodsRcomYn()))
				) {
					setRelatedGoodsInfo(session, view, pvo, gso, petNo);

				}
			}
			//log.info("================================================");
		}catch(Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}
//		List<PetLogBaseVO> followPetLogListTemp = new ArrayList<PetLogBaseVO>();
//		for(int i=0; i<followPetLogList.size() ; i++) {			
//			followPetLogListTemp.add(followPetLogList.get(i));
//		}
		map.put("pagePetLogMainList", pagePetLogMainList);
		
		// 인기 태그 : 인기순 
		so.setRows(FrontWebConstants.PAGE_ROWS_6);
		so.setSidx("LIKE_CNT");
		so.setSord(FrontWebConstants.SORD_DESC);
		Long dispClsfNo = Long.valueOf(webConfig.getProperty("disp.clsf.no.petlog"));
		List<DisplayCornerTotalVO> displaycornerList = petLogService.getPetLogHomeByDispCorn(dispClsfNo, so);
		
		for (DisplayCornerTotalVO corner : displaycornerList) {		
			if (corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_20)) {				// 배너 Text(만들기 bottom sheet 관리자 지정 메세지)	
				if( !corner.getListBanner().isEmpty()) {
				DisplayBannerVO vo = corner.getListBanner().get(0);
				map.put("bannerText", vo.getBnrText());
				}
			}			
			else if (corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_75)) {		// 배너 이미지			
			
				if( String.valueOf(corner.getDispCornNo()).equals(webConfig.getProperty("disp.corn.no.petlog.main.banner.likepetlog"))) { 		// 배너:좋아할만한 펫로그
					map.put("likePetLogBannerList", corner.getListBanner());	
				}else if( String.valueOf(corner.getDispCornNo()).equals(webConfig.getProperty("disp.corn.no.petlog.main.banner.recmember"))) { 	// 배너:이친구 어때요
					map.put("recMemberBannerList", corner.getListBanner());
				}else {																															// 배너:인기태그
					map.put("popTagBannerList", corner.getListBanner());
				}				
			}			
			else if (corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_100)) {		// 좋아할만한 펫로그				
				map.put("likePetLogList", corner.getPetLogList());	
			}
			else if (corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_90)) {		// 이 친구 어때요?				
				map.put("recMbrPetLogList", corner.getPetLogList());
			}
			else if(corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_80)) {			// 태그
				if( String.valueOf(corner.getDispCornNo()).equals(webConfig.getProperty("disp.corn.no.petlog.main.tag.poptag"))) { // 인기태그 
					map.put("petLogTagList", corner.getPetLogList());
				}else {																												// 관리자 추천 (만들기 bottom sheet)
					map.put("adminRecTagList", corner.getTagList());
				}
			}			
		}
		
		// 로그인 사용자 정보
		map = getLoginUserInfo(map, view, session, so, "N" );
	
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_30);
		map.put("view", view);
		map.put("so", so);
		map.put("session", session);
		map.put("prflImg", prflImg);
		
		if(so.getRecommendPage() == 1 && StringUtil.isBlank(so.getUpper())) {
			return TilesView.none(new String[] { "petlog", "indexPetLogMain" });
		}else {
			return TilesView.none(new String[] { "petlog", "indexPetLogListPaging" });
		}
	}
	
	
	private ModelMap getLoginUserInfo(ModelMap map, ViewBase view, Session session, PetLogListSO lso, String memberInfoYn){
		String petRegYn = "N";
		String prflImg = "";	
		PetLogMemberVO mvo = new PetLogMemberVO();
		
		if (session.getMbrNo() != 0) {
			String petNos = session.getPetNos();		
			if(petLogService.checkRegPet(session.getMbrNo()) > 0) petRegYn = "Y";		
			if(!StringUtil.isEmpty(session.getPrflImg())) prflImg = session.getPrflImg();		
		
			if( memberInfoYn.equals("Y") ) {
				PetLogMemberSO pso = new PetLogMemberSO();
				pso.setMbrNo(session.getMbrNo());
				pso.setSearchType("include");
				mvo = petLogService.getMbrBaseInfo(pso);
			}else {
				mvo.setPetLogUrl(session.getPetLogUrl());
				mvo.setMbrNo(session.getMbrNo());
			}
		}
		mvo.setPetRegYn(petRegYn);
		mvo.setPrflImg(prflImg);
		
		// 로그인 사용자 정보
		map.put("loginUserInfo", mvo);

		return map;
	}
	
	
	private void setRelatedGoodsInfo(Session session, ViewBase view, PetLogBaseVO vo, GoodsRelatedSO gso, Long petNo) {
			
		try {
			gso = new GoodsRelatedSO();
			try {
				BeanUtils.copyProperties(gso, vo );
				gso.setPetNo(petNo);
				
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);

				gso.setPetNo(petNo);
				gso.setPetLogNo(vo.getPetLogNo());
				gso.setRvwYn(vo.getRvwYn());
				gso.setGoodsRcomYn(vo.getGoodsRcomYn());
				vo.setGoodsRltCnt(0);
			}

			gso.setMbrNo(session.getMbrNo());
			gso.setStId(view.getStId());
			gso.setWebMobileGbCd(view.getDeviceGb());
			//APETQA-3390 10개
			gso.setLimit(10);

			List<GoodsBaseVO> GoodsBaseVOs = goodsService.getGoodsRelatedWithPetLog(gso);
			Integer goodsCnt = GoodsBaseVOs.size();
			vo.setGoodsRltCnt(goodsCnt);

			// 연관상품 썸네일 이미지 셋팅.
			if(goodsCnt!= null && goodsCnt > 0) {
				GoodsBaseVO goodsBaseVO = GoodsBaseVOs.get(0);
				vo.setGoodsThumbImgPath(goodsBaseVO.getImgPath());
			}

		}catch(Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}
	}
	
	
	private ModelMap getPetLogRegistAreaInfo(String homeYn, ModelMap map, ViewBase view, Session session, PetLogListSO lso){
		
		// TODO - DEVICE_GB_30 일 때만 조회. -- pc 일 때도 펫등록 여부 필요함.
		//if( view.getDeviceGb().equals(FrontConstants.DEVICE_GB_10)) return map;
		
		String petRegYn = "N";
		// 사용자의 프로필 이미지
		if (session.getMbrNo() != 0) {
			PetLogMemberSO pso = new PetLogMemberSO();
			pso.setMbrNo(session.getMbrNo());
			pso.setSearchType("include");
			PetLogMemberVO mvo = petLogService.getMbrBaseInfo(pso);
			petRegYn = mvo.getPetRegYn();
			map.put("memberBase", mvo);
		}			
		// 펫등록 여부
		map.put("petRegYn", petRegYn);
		
		// 펫로그 홈의 경우는 별도로 처리함.
		if( homeYn.equals("N") ) {
			DisplayCornerSO dso = new DisplayCornerSO();
			dso.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petlog")));
			dso.setDispCornNo(Long.valueOf(webConfig.getProperty("disp.corn.no.petlog.main.banner.text")));
			
			lso.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petlog")));
			lso.setDispCornNo(Long.valueOf(webConfig.getProperty("disp.corn.no.petlog.main.tag.admninrec")));
			lso.setRows(10); // 최대 10개
			
			// BO 의 미리보기 시 previewDt 가 들어옴.
			if( StringUtil.isEmpty(lso.getPreviewDt()) ) {					
				lso.setPreviewDt(DateUtil.getNowDate());
			}else {
				dso.setPreviewDt(lso.getPreviewDt());
			}
			
			//서비스 지정메세지
			String bannerText = petLogService.getBannerTextByDispCorn(dso);
			// 관리자 추천 tag
			List<String> tagList = petLogService.listTagNoByDispCorn(lso );
	
			
			map.put("bannerText", bannerText);
			map.put("adminRecTagList", tagList);
		}
		
		return map;
	}
	
	
//	@RequestMapping(value="indexIncludeRegist")
//	public String indexIncludeRegist(ModelMap map, ViewBase view, Session session, PetLogListSO lso){
//		String petRegYn = "N";
//		// 사용자의 프로필 이미지
//		if (session.getMbrNo() != 0) {
//			PetLogMemberSO pso = new PetLogMemberSO();
//			pso.setMbrNo(session.getMbrNo());
//			pso.setSearchType("include");
//			PetLogMemberVO mvo = petLogService.getMbrBaseInfo(pso);
//			petRegYn = mvo.getPetRegYn();
//			map.put("memberBase", mvo);
//		}			
//		// 펫등록 여부
//		map.put("petRegYn", petRegYn);
//		
//		DisplayCornerSO dso = new DisplayCornerSO();
//		dso.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petlog")));
//		dso.setDispCornNo(Long.valueOf(webConfig.getProperty("disp.corn.no.petlog.main.banner.text")));
//		
//		lso.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petlog")));
//		lso.setDispCornNo(Long.valueOf(webConfig.getProperty("disp.corn.no.petlog.main.tag.admninrec")));
//		//lso.setRows(corner.getShowCnt().intValue());
//		
//		// BO 의 미리보기 시 previewDt 가 들어옴.
//		if( StringUtil.isEmpty(lso.getPreviewDt()) ) {					
//			lso.setPreviewDt(DateUtil.getNowDate());
//		}else {
//			dso.setPreviewDt(lso.getPreviewDt());
//		}
//		
//		//서비스 지정메세지
//		String bannerText = petLogService.getBannerTextByDispCorn(dso);
//		// 관리자 추천 tag
//		List<String> tagList = petLogService.listTagNoByDispCorn(lso );
//
//		
//		map.put("bannerText", bannerText);
//		map.put("adminRecTagList", tagList);
//		map.put("view", view);
//		map.put("session", session);
//		
//		return  TilesView.none( new String[]{"petlog", "include", "indexIncludeRegist"});
//	}	
	
	
	
	@RequestMapping(value = "popupPetLogReplyList")
	public String popupPetLogReplyList(ModelMap map, ViewBase view, Session session,  ReplyParam param
										,@RequestParam(value="selIdx",required=false) String selIdx) {
		
		// 펫로그 정보 조회
		PetLogBaseSO so = new PetLogBaseSO();
		so.setPetLogNo(param.getPetLogNo());
		PetLogBaseVO petLogBaseVO = petLogService.getPetLogDetail(so);
		
		
		so.setMbrNo(session.getMbrNo());
		List<PetLogReplyVO> petLogReplyList = petLogService.listPetLogReply(so);
		
		map.put("petLogBase", petLogBaseVO);
		map.put("petLogReplyList", petLogReplyList);
		map.put("view", view);
		map.put("session", session);
		map.put("selIdx", selIdx);
		
		// pet 등록 여부 조회를 위해(댓글 등록 시 체크함)
		PetLogListSO lso = new PetLogListSO();
		map = getLoginUserInfo(map, view, session, lso, "N");
		
		return TilesView.none(new String[]{"petlog", "popupPetLogReplyList"});
	}
	
	@RequestMapping(value = "popupPetLogInsertLoc")
	public String popupPetLogInsertLoc(ModelMap map, ViewBase view, Session session
									,@RequestParam(value="gb",required=false)String gb) {
		

		//map.put("petLogBase", so);
		map.put("session", session);
		map.put("view", view);
		map.put("gb", gb);
		
		// pet등록 여부, 위치정보 약관 동의 확인 필
		PetLogListSO lso = new PetLogListSO();
		map = getLoginUserInfo(map, view, session, lso,"Y");
		
		return TilesView.none(new String[]{"petlog", "popupPetLogInsertLoc"});
	}

	@RequestMapping(value = "indexMyPetLog/{petLogUrl}")
	public String indexMyPetLog(ModelMap map, Session session, ViewBase view, PetLogListSO so, @PathVariable("petLogUrl") String petLogUrl , String insertYn) {
		
		// 사용자의 프로필 이미지
		PetLogMemberSO pso = new PetLogMemberSO();
		pso.setMbrNo(so.getMbrNo());
		pso.setSearchType("myPetLog");
		if( session.getMbrNo() != 0 ) {
			pso.setLoginMbrNo(session.getMbrNo());
			//pso.setMbrNo(session.getMbrNo());
		}
		
		PetLogMemberVO pvo = petLogService.getMbrBaseInfo(pso);
		
		// 팔로워/팔로잉 수 조회
		pvo.setFollowerCnt(petLogService.getMyFollowerCnt(so));
		pvo.setFollowingCnt(petLogService.getMyFollowingCnt(so));
		if( !StringUtil.isEmpty(so.getRate()) ) {pvo.setRate(so.getRate());}
		map.put("petLogUser", pvo);			
				
		
		List<PetLogBaseVO> petLogBaseList = new ArrayList<>();
		
		// 첫페이지는 24개 노출 
		so.setContsStatCd(CommonConstants.CONTS_STAT_10);
		// 최신순
		so.setSidx("SYS_REG_DTM");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setPageType("M");
		if(so.getPage() <= 1 && StringUtil.isEmpty(so.getUpper())) {
			so.setRows(FrontWebConstants.PAGE_ROWS_24);
			petLogBaseList = petLogService.pagePetLogBase(so);
		}else {
			so.setRows(FrontWebConstants.PAGE_ROWS_12);
			petLogBaseList = petLogService.pagePetLogBase(so);
		}
		

		map.put("myPetLogList", petLogBaseList);
		map.put("myPetLogTotalCount", so.getTotalCount());		
		map.put("petLogUrl", petLogUrl);
		map.put("so", so);
		map.put("view", view);
		map.put("session", session);		
		map.put("insertYn", insertYn);
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_30);
		// 로그인 사용자 정보.
		PetLogListSO lso = new PetLogListSO();
		map = getLoginUserInfo(map, view, session, lso, "N");
	
		if(so.getPage() == 1 && StringUtil.isBlank(so.getUpper()) || StringUtil.isNotBlank(so.getBackYn())) {
			return TilesView.none(new String[] { "petlog", "indexMyPetLog" });
		}else{
			return TilesView.none(new String[] { "petlog", "indexMyPetLogPaging" });
		}
	
	}
	
	// 태그 모아보기
	@RequestMapping(value = "indexPetLogTagList")
	public String indexPetLogTagList(ModelMap map, Session session, ViewBase view, PetLogListSO so) {
		
		so.setLoginMbrNo(session.getMbrNo());
		
		// 디폴트 - 최신순 
		if( StringUtil.isEmpty(so.getSidx())) {so.setSidx("SYS_REG_DTM");}
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setContsStatCd(CommonConstants.PETLOG_DISP_GB_10); //노출.
		//첫 노출 시 24개 노출 , 페이징 시 12개씩 노출
		if(so.getPage() <= 1) {
			so.setRows(FrontConstants.PAGE_ROWS_24);
		}else {
			so.setRows(FrontConstants.PAGE_ROWS_12);
			so.setPage(so.getPage()+1);
		}
		
		List<PetLogBaseVO> tagPetLogList = petLogService.pageTagPetLog(so);
		
		if( !tagPetLogList.isEmpty() ) {
			//FollowMapPO po = new FollowMapPO();
			String tagNo = tagPetLogList.get(0).getTagNo();
			//po.setTagNoFollowed(tagNo);
			so.setTagNo(tagNo);
			
			if( session.getMbrNo() != 0 ) {
				FollowMapPO po = new FollowMapPO();
				po.setTagNoFollowed(tagNo);
				po.setMbrNo(session.getMbrNo());
				String tagFollowYn = petLogService.isFollowMapTag(po);
				map.put("tagFollowYn", tagFollowYn);
			}			
		}else {//게시글의 태그가 아닌 댓글의 태그를 클릭 시. 20210802 추가
			//tag base에 태그 존재 여부 확인
			TagBaseSO tagSo = new TagBaseSO();
			tagSo.setTagNm(so.getTag());
			TagBaseVO tagVo = tagService.getTagInfo(tagSo);
			if(StringUtil.isNotEmpty(tagVo)) {
				so.setTagNo(tagVo.getTagNo());
				if( session.getMbrNo() != 0 ) {
					FollowMapPO po = new FollowMapPO();
					po.setTagNoFollowed(tagVo.getTagNo());
					po.setMbrNo(session.getMbrNo());
					String tagFollowYn = petLogService.isFollowMapTag(po);
					map.put("tagFollowYn", tagFollowYn);
				}
			}
			
		}
		
		// 모바일의 경우, 하단 만들기 영역 조회
		map = getLoginUserInfo(map, view, session, so,"N");
		
		map.put("tagPetLogList", tagPetLogList);
		map.put("view", view);
		map.put("session", session);
		map.put("so", so);
		
		
		if(so.getPage() > 1) {
			return TilesView.none(new String[] { "petlog", "indexPetLogTagListPaging" });
		}else{
			return TilesView.none(new String[] { "petlog", "indexPetLogTagList" });
		}
	}
	
	@RequestMapping(value = "indexPetLogList")
	public String indexPetLogList(ModelMap map, Session session, ViewBase view, PetLogListSO so
								,@RequestParam(value="selIdx",required=false)String selIdx
								,@RequestParam(value="pageType",required=false)String pageType
								,@RequestParam(value="petLogList",required=false)String petLogs
								,@RequestParam(value="sort",required=false)String sort
								,@RequestParam(value="goodsVal",required=false)String goodsVal
								,@RequestParam(value="tiles",required=false)String tiles) {

		List<PetLogBaseVO> petLogList = new ArrayList<PetLogBaseVO>();
		so.setLoginMbrNo(session.getMbrNo());
		if( StringUtil.isEmpty(pageType)) {  // 기본 펫로그 게시물 - 등록 후.
			so.setRows(FrontWebConstants.PAGE_ROWS_30);
			so.setSidx("SYS_REG_DTM");
			so.setSord(FrontWebConstants.SORD_DESC);
			so.setPage(1);
			so.setContsStatCd(CommonConstants.PETLOG_DISP_GB_10);
			petLogList = petLogService.pagePetLogBase(so);	
			map.put("title", "로그");
		}
		else if( pageType.equals("L")) {  //좋아할만한 펫로그 게시물 목록
			if( petLogs != null ) {
				String[] petLogNoList = StringUtil.split(petLogs,",");
		        List<Long> list = new ArrayList<Long>();
				for(String petLogNo : petLogNoList) {
					list.add(Long.valueOf(petLogNo));
				}				
				so.setPetLogNos(list.toArray(new Long[list.size()]));
			}else {			
				so.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petlog")));
				so.setDispCornNo(Long.valueOf(webConfig.getProperty("disp.corn.no.petlog.main.likepetlog")));
			}
			so.setLoginMbrNo(session.getMbrNo());
			so.setListType("L"); // 게시물 목록 일 때만 좋아요수/댓글수 조회 한다.
			petLogList = petLogService.listPetLogLike(so);	
			map.put("title", "좋아할만한 로그");
		}
		else if( pageType.equals("M")) { // 마이펫로그 게시물 목록
			so.setRows(FrontWebConstants.PAGE_ROWS_12);
			so.setSidx("SYS_REG_DTM");
			so.setSord(FrontWebConstants.SORD_DESC);
			so.setContsStatCd(CommonConstants.PETLOG_DISP_GB_10);
			petLogList = petLogService.pagePetLogBase(so);	
			if( !petLogList.isEmpty() ) {
				map.put("title", petLogList.get(0).getNickNm());
				
				so.setPetLogUrl(petLogList.get(0).getPetLogUrl());
				so.setPetLogSrtUrl(petLogList.get(0).getPetLogSrtUrl());
				so.setPrflImg(petLogList.get(0).getPrflImg());
				
				if( session.getMbrNo() != 0 ) {
					FollowMapPO po = new FollowMapPO();
					po.setMbrNoFollowed(so.getMbrNo());
					po.setMbrNo(session.getMbrNo());
					String followYn = petLogService.isFollowMapMember(po);
					map.put("followYn", followYn);
				}
			}
		}
		else if( pageType.equals("T")) { // 태그 게시물 목록
			if( StringUtil.isEmpty(so.getSidx())) {so.setSidx("SYS_REG_DTM");}
			so.setSord(FrontWebConstants.SORD_DESC);
			so.setRows(FrontWebConstants.PAGE_ROWS_12);
			so.setContsStatCd(CommonConstants.PETLOG_DISP_GB_10);
			petLogList = petLogService.pageTagPetLog(so);	
			
			
			if( !petLogList.isEmpty() ) { 
				map.put("title", petLogList.get(0).getTagNm());
				so.setTagNo(petLogList.get(0).getTagNo());
				
				if( session.getMbrNo() != 0 ) {
					FollowMapPO po = new FollowMapPO();
					po.setTagNoFollowed(petLogList.get(0).getTagNo());
					po.setMbrNo(session.getMbrNo());
					String tagFollowYn = petLogService.isFollowMapTag(po);
					map.put("tagFollowYn", tagFollowYn);
				}
			}
		}
		
		try {
			GoodsRelatedSO gso = null;
			String petNos = session.getPetNos();
			Long petNo = 0L;
			if(!StringUtil.isEmpty(petNos)) {
				String[] petNosList = StringUtil.split(petNos,",");
				if(petNosList.length > 0) {						
					petNo =  Long.parseLong(petNosList[0]);
				}
			}			
			
			for(PetLogBaseVO pvo : petLogList ) {
				// 위치정보 복호화
				if( StringUtil.isNotEmpty(pvo.getLogLitd()) ){	//경도
					pvo.setLogLitd(bizService.twoWayDecrypt(pvo.getLogLitd()));
				}
				if( StringUtil.isNotEmpty(pvo.getLogLttd()) ){	//위도
					pvo.setLogLttd(bizService.twoWayDecrypt(pvo.getLogLttd()));
				}
				if( StringUtil.isNotEmpty(pvo.getPrclAddr()) ){	//지번주소
					pvo.setPrclAddr(bizService.twoWayDecrypt(pvo.getPrclAddr()));
				}
				if( StringUtil.isNotEmpty(pvo.getRoadAddr()) ){	//도로주소
					pvo.setRoadAddr(bizService.twoWayDecrypt(pvo.getRoadAddr()));
				}
				if( StringUtil.isNotEmpty(pvo.getPstNm()) ){	//위치명
					pvo.setPstNm(bizService.twoWayDecrypt(pvo.getPstNm()));
				}
				
				if( (!StringUtil.isEmpty(pvo.getRvwYn()) && CommonConstants.COMM_YN_Y.contentEquals(pvo.getRvwYn()))
						  || (!StringUtil.isEmpty(pvo.getGoodsRcomYn()) && CommonConstants.COMM_YN_Y.contentEquals(pvo.getGoodsRcomYn()))) {
				//if(CommonConstants.COMM_YN_Y.contentEquals(pvo.getRvwYn()) || CommonConstants.COMM_YN_Y.contentEquals(pvo.getGoodsRcomYn())) {
					// 연관상품 갯수 조회 
					setRelatedGoodsInfo(session, view, pvo, gso, petNo);
				}
			}
		
		}catch(Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}
		so.setSidx(sort);
		
		// 로그인 사용자 정보
		map = getLoginUserInfo(map, view, session, so, "N");
		
		map.put("petLogList", petLogList);
		map.put("view", view);
		map.put("so", so);
		map.put("session", session);
		map.put("selIdx", selIdx);
		map.put("pageType", pageType);
		map.put("goodsVal", goodsVal);
		map.put("tiles", tiles);
		
		//2021-09-09 수정 kms
		//다른 페이지에 걸쳐있는 부분 수정 최소화 하기 위해 페이징 시에 넘어오는 파라미터로 체크
		if(StringUtil.equals(tiles, CommonConstants.COMM_YN_N)) {
			return TilesView.none(new String[] { "petlog", "indexInnerPetLogListPaging" });
		}else {
			return TilesView.none(new String[] { "petlog", "indexPetLogList" });
		}
			
	}
	@RequestMapping(value = "indexInnerPetLogListPaging")
	public String indexInnerPetLogListPaging(ModelMap map, Session session, ViewBase view, PetLogListSO so
			,@RequestParam(value="selIdx",required=false)String selIdx
			,@RequestParam(value="pageType",required=false)String pageType
			,@RequestParam(value="petLogList",required=false)String petLogs) {
		
		List<PetLogBaseVO> petLogList = new ArrayList<PetLogBaseVO>();
		so.setLoginMbrNo(session.getMbrNo());
		if( StringUtil.isEmpty(pageType)) {  // 기본 펫로그 게시물 - 등록 후.
			so.setRows(FrontWebConstants.PAGE_ROWS_30);
			so.setSidx("SYS_REG_DTM");
			so.setSord(FrontWebConstants.SORD_DESC);
			so.setPage(1);
			so.setContsStatCd(CommonConstants.PETLOG_DISP_GB_10);
			petLogList = petLogService.pagePetLogBase(so);	
			map.put("title", "로그");
		}
		else if( pageType.equals("L")) {  //좋아할만한 펫로그 게시물 목록
			if( petLogs != null ) {
				String[] petLogNoList = StringUtil.split(petLogs,",");
				List<Long> list = new ArrayList<Long>();
				for(String petLogNo : petLogNoList) {
					list.add(Long.valueOf(petLogNo));
				}				
				so.setPetLogNos(list.toArray(new Long[list.size()]));
			}else {			
				so.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petlog")));
				so.setDispCornNo(Long.valueOf(webConfig.getProperty("disp.corn.no.petlog.main.likepetlog")));
			}
			so.setLoginMbrNo(session.getMbrNo());
			so.setListType("L"); // 게시물 목록 일 때만 좋아요수/댓글수 조회 한다.
			petLogList = petLogService.listPetLogLike(so);	
			map.put("title", "좋아할만한 로그");
		}
		else if( pageType.equals("M")) { // 마이펫로그 게시물 목록
			so.setRows(FrontWebConstants.PAGE_ROWS_12);
			so.setSidx("SYS_REG_DTM");
			so.setSord(FrontWebConstants.SORD_DESC);
			so.setContsStatCd(CommonConstants.PETLOG_DISP_GB_10);
			petLogList = petLogService.pagePetLogBase(so);	
			if( !petLogList.isEmpty() ) {
				map.put("title", petLogList.get(0).getNickNm());
				
				so.setPetLogUrl(petLogList.get(0).getPetLogUrl());
				so.setPetLogSrtUrl(petLogList.get(0).getPetLogSrtUrl());
				so.setPrflImg(petLogList.get(0).getPrflImg());
				
				if( session.getMbrNo() != 0 ) {
					FollowMapPO po = new FollowMapPO();
					po.setMbrNoFollowed(so.getMbrNo());
					po.setMbrNo(session.getMbrNo());
					String followYn = petLogService.isFollowMapMember(po);
					map.put("followYn", followYn);
				}
			}
		}
		else if( pageType.equals("T")) { // 태그 게시물 목록
			if( StringUtil.isEmpty(so.getSidx())) {so.setSidx("SYS_REG_DTM");}
			so.setSord(FrontWebConstants.SORD_DESC);
			so.setRows(FrontWebConstants.PAGE_ROWS_12);
			so.setContsStatCd(CommonConstants.PETLOG_DISP_GB_10);
			petLogList = petLogService.pageTagPetLog(so);	
			
			
			if( !petLogList.isEmpty() ) { 
				map.put("title", petLogList.get(0).getTagNm());
				so.setTagNo(petLogList.get(0).getTagNo());
				
				if( session.getMbrNo() != 0 ) {
					FollowMapPO po = new FollowMapPO();
					po.setTagNoFollowed(petLogList.get(0).getTagNo());
					po.setMbrNo(session.getMbrNo());
					String tagFollowYn = petLogService.isFollowMapTag(po);
					map.put("tagFollowYn", tagFollowYn);
				}
			}
		}
		
		try {
			GoodsRelatedSO gso = null;
			String petNos = session.getPetNos();
			Long petNo = 0L;
			if(!StringUtil.isEmpty(petNos)) {
				String[] petNosList = StringUtil.split(petNos,",");
				if(petNosList.length > 0) {						
					petNo =  Long.parseLong(petNosList[0]);
				}
			}			
			
			for(PetLogBaseVO pvo : petLogList ) {
				// 위치정보 복호화
				if( StringUtil.isNotEmpty(pvo.getLogLitd()) ){	//경도
					pvo.setLogLitd(bizService.twoWayDecrypt(pvo.getLogLitd()));
				}
				if( StringUtil.isNotEmpty(pvo.getLogLttd()) ){	//위도
					pvo.setLogLttd(bizService.twoWayDecrypt(pvo.getLogLttd()));
				}
				if( StringUtil.isNotEmpty(pvo.getPrclAddr()) ){	//지번주소
					pvo.setPrclAddr(bizService.twoWayDecrypt(pvo.getPrclAddr()));
				}
				if( StringUtil.isNotEmpty(pvo.getRoadAddr()) ){	//도로주소
					pvo.setRoadAddr(bizService.twoWayDecrypt(pvo.getRoadAddr()));
				}
				if( StringUtil.isNotEmpty(pvo.getPstNm()) ){	//위치명
					pvo.setPstNm(bizService.twoWayDecrypt(pvo.getPstNm()));
				}
				
				if( (!StringUtil.isEmpty(pvo.getRvwYn()) && CommonConstants.COMM_YN_Y.contentEquals(pvo.getRvwYn()))
						|| (!StringUtil.isEmpty(pvo.getGoodsRcomYn()) && CommonConstants.COMM_YN_Y.contentEquals(pvo.getGoodsRcomYn()))) {
					//if(CommonConstants.COMM_YN_Y.contentEquals(pvo.getRvwYn()) || CommonConstants.COMM_YN_Y.contentEquals(pvo.getGoodsRcomYn())) {
					// 연관상품 갯수 조회 
					setRelatedGoodsInfo(session, view, pvo, gso, petNo);
				}
			}
			
		}catch(Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}
		
		
		// 로그인 사용자 정보
		map = getLoginUserInfo(map, view, session, so, "N");
		
		map.put("petLogListPaging", petLogList);
		map.put("view", view);
		map.put("so", so);
		map.put("session", session);
		map.put("pageType", pageType);
		map.put("selIdx", selIdx);
		
		return "/petlog/indexInnerPetLogListPaging";	
		
	}
	

	
	
/*    @ResponseBody
    @RequestMapping(value="getAutocomplete")
    public String getAutocomplete(
            @RequestParam(value="searchText",required=true)String searchText){

        String result =  searchApiUtil.autocomplete(searchText, "pet_log_autocomplete");
         return result;
    }*/
	
    @ResponseBody
    @RequestMapping(value="getAutocomplete")
    public String getAutocomplete(
              @RequestParam(value="searchText")String searchText
            , @RequestParam(value="label",required=false)String label 
            , @RequestParam(value="size",required=false)String size
            , @RequestParam(value="petLogYn",required=false)String petLogYn ){
    	
    	Map<String,String> requestParam = new HashMap<String,String>();
    	requestParam.put("MIDDLE","true");
        requestParam.put("KEYWORD",searchText);
        requestParam.put("LABEL",label);
        //멘션 회원 검색 시 petLogUrl이 있는 회원만 검색
        if(StringUtil.equals(petLogYn , "Y")) {
        	requestParam.put("PET_LOG_YN", "Y");
        }
        if( !StringUtil.isEmpty(size) ) {
        	requestParam.put("SIZE", size);
        }
         
        return searchApiClient.getResponse(SearchApiSpec.SRCH_API_IF_AUTOCOMPLETE, requestParam);
    }
    
    
	@RequestMapping(value = "listPetLogReply")
	@ResponseBody
	public ModelMap listPetLogReply(Session session,  PetLogBaseSO so) {
		if (session.getMbrNo() != 0) {
			so.setMbrNo(session.getMbrNo());
		}		
		List<PetLogReplyVO> petLogReplyList = petLogService.listPetLogReply(so);
	
		PetLogBaseVO vo = new PetLogBaseVO();
		vo.setReplyCnt(petLogReplyList.size());
		vo.setPetLogNo(so.getPetLogNo());
		
		ModelMap map = new ModelMap();
		map.put("petLogReplyList", petLogReplyList);
		map.put("petLogBase", vo);
//		map.put("view", view);
		map.put("session", session);

		return map;
	}
	
    
	@RequestMapping(value = "petLogReplySave")
	@ResponseBody
	public ModelMap petLogReplySave(Session session,  PetLogReplyPO po) {
		
		//po.setMbrNo(2L);
		Long petLogNo;
		
		if( po.getPetLogAplySeq() != null ) {
			petLogNo = petLogService.updatePetLogReply(po);
		}else {
			// Pet Log 댓글 등록
			petLogNo = petLogService.insertPetLogReply(po);
		}

		ModelMap map = new ModelMap();
		map.put("petLogNo", petLogNo);
		return map;
	}
    
	
	@RequestMapping(value = "petLogReplyDelete")
	@ResponseBody
	public ModelMap petLogReplyDelete(Session session,  PetLogReplyPO po) {
		
		//po.setMbrNo(2L);
		petLogService.deletePetLogReply(po);

		return new ModelMap();
	}
	
	@RequestMapping(value = "petLogRptpInsert")
	@ResponseBody
	public ModelMap petLogRptpInsert(Session session,  PetLogRptpPO po) {
		
		//po.setMbrNo(2L);
		// Pet Log 신고하기 등록
		Long petLogNo = petLogService.insertPetLogRptp(po);

		ModelMap map = new ModelMap();
		map.put("petLogNo", petLogNo);
		return map;
	}
	
	@RequestMapping(value = "petLogInterestSave")
	@ResponseBody
	public ModelMap petLogInterestSave(Session session,  PetLogInterestPO po) {
		ModelMap map = new ModelMap();
		map.put("petLogNo", po.getPetLogNo());
		int result = 0;
		String existCheck = "N";
		//po.setMbrNo(2L);
		po.setSysRegrNo(po.getMbrNo());
		// Pet Log 관심(좋아요/찜) 등록
		if( po.getSaveGb().equals("I")) {
			// 좋아요 , 찜 등록 시 이미 존재하는지 체크 후 insert
			result = petLogService.getPetLogInterestCount(po);
			if(result > 0) {
				existCheck = "Y";
				result = petLogService.deletePetLogInterest(po);
			}else {
				result = petLogService.insertPetLogInterest(po);
			}
		}else {
			result = petLogService.deletePetLogInterest(po);
		}
		
		//System.out.println("petLogInterestSave11:"+po.getIntsGbCd()+":"+result);
		//if( result > 0 ) {
			
			if( po.getIntsGbCd().equals(CommonConstants.INTR_GB_10) ) {
				// 조회 시에는 mbrNo 리셋.
				po.setMbrNo(0L); 
				result = petLogService.getPetLogInterestCount(po);
				//System.out.println("petLogInterestSave22:"+po.getIntsGbCd()+":"+result);
				map.put("likeCnt", result);
			}
			map.put("existCheck", existCheck);
		return map;
	}

	
	@RequestMapping(value = "followMapMemberSave")
	@ResponseBody
	public ModelMap followMapMemberSave(Session session,  FollowMapPO po) {
		ModelMap map = new ModelMap();

		int result = 0;
		//po.setMbrNo(2L);
		// follow 등록
		if( po.getSaveGb().equals("I")) {
			result = petLogService.insertFollowMapMember(po);
		}else {
			result = petLogService.deleteFollowMapMember(po);
		}
		
		return map;
	}
	
	
	@RequestMapping(value = "followMapTagSave")
	@ResponseBody
	public ModelMap followMapTagSave(Session session,  FollowMapPO po) {
		ModelMap map = new ModelMap();

		int result = 0;
		//po.setMbrNo(2L);
		// follow 등록
		if( po.getSaveGb().equals("I")) {
			result = petLogService.insertFollowMapTag(po);
		}else {
			result = petLogService.deleteFollowMapTag(po);
		}
		
		return map;
	}
	
	
	@RequestMapping(value = "petLogShareInsert")
	@ResponseBody
	public ModelMap petLogShareInsert(Session session,  PetLogSharePO po) {

		// Pet Log 공유 등록
		po.setMbrNo(session.getMbrNo());
		Long petLogNo = petLogService.insertPetLogShare(po);

		ModelMap map = new ModelMap();
		map.put("petLogNo", petLogNo);
		return map;
	}	
	
	
	@RequestMapping(value = "indexMyFollowList")
	public String indexMyFollowList(ModelMap map, Session session, ViewBase view, PetLogListSO so
			,@RequestParam(value="tabGb",required=false)String tabGb) {
		if (session.getMbrNo() != 0) {
			so.setLoginMbrNo(session.getMbrNo());
		}
		
		// 사용자의 프로필 이미지
		PetLogMemberSO pso = new PetLogMemberSO();
		pso.setMbrNo(so.getMbrNo());
		PetLogMemberVO pvo = petLogService.getMbrBaseInfo(pso);
		
		List<PetLogMemberVO> followerList = petLogService.listMyFollower(so);	
		List<FollowMapVO> followingList = petLogService.listMyFollowing(so);	
		
		map.put("followerList", followerList);
		map.put("followerCnt", followerList.size());
		map.put("followingList", followingList);
		map.put("followingCnt", followingList.size());	
		map.put("view", view);
		map.put("petLogUser", pvo);	
		map.put("session", session);
		map.put("tabGb", tabGb);
		
		// 로그인 사용자 정보
		PetLogListSO lso = new PetLogListSO();
		map = getLoginUserInfo(map, view, session, lso,"N");
		
		return TilesView.none(new String[] { "petlog", "indexMyFollowList" });
	}
	
	@RequestMapping(value = "petLogShare")
	public String petLogShare(ModelMap map, Session session, ViewBase view, 
			@RequestParam(value="shareGb",required=false)String shareGb
			, @RequestParam(value="shareNo",required=false)String shareNo) {
		String title = "";
		String imgPath = "";
		String desc = "";
		
		PetLogBaseSO so = new PetLogBaseSO();
		
		if(StringUtil.equals(shareGb, "P")) {
			so.setPetLogNo(Long.parseLong(shareNo));
		}else if(StringUtil.equals(shareGb, "M")){
			so.setMbrNo(Long.parseLong(shareNo.split("_")[1]));
		}
		
		PetLogBaseVO vo = petLogService.getPetLogShareInfo(so);
		
		if(!StringUtil.isEmpty(vo)) {
			title = vo.getNickNm();
			desc = vo.getDscrt();
			String orgPath = "";
			
			if(vo.getImgCnt() > 0) {
				orgPath = vo.getImgPath1();
			}else{
				orgPath = vo.getVdThumPath();
			}
			
			if(orgPath.lastIndexOf("cdn.ntruss.com") != -1) {
				imgPath = orgPath;
			}else {
				imgPath = ImagePathUtil.imagePath(orgPath, FrontConstants.IMG_OPT_QRY_560);
			}
		}
		
		map.put("img", imgPath);
		map.put("desc", desc);
		map.put("title", title);

		map.put("pageGb", "petLog");
		map.put("shareGb", shareGb);
		map.put("shareNo", shareNo);
		
		SeoInfoSO seoSo = new SeoInfoSO();
		seoSo.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_20);	// SEO 서비스 구분 코드
		seoSo.setSeoTpCd(FrontWebConstants.SEO_TP_10);				// SEO 유형 코드
		SeoInfoVO seoInfo = seoService.getSeoInfoFO(seoSo, false);
		if(seoInfo != null) {
			map.put("site_name", seoInfo.getPageTtl());
		}else {
			map.put("site_name", "");
		}
		
		return TilesView.none(new String[]{"common", "common", "indexShareView"});
	}
	
	@ResponseBody
	@RequestMapping(value = "getShortUrl")
	public String getShortUrl(@RequestParam(value = "originUrl") String originUrl
							, @RequestParam(value = "shareGb") String shareGb
							, @RequestParam(value = "shareNo") String shareNo) {
		if(StringUtil.isNotBlank(originUrl)) {
			originUrl = originUrl.replace("&amp;", "&");			
		}
		String shortUrl = NhnShortUrlUtil.getUrl(originUrl);
		if( !StringUtil.isEmpty(shortUrl) ) {
			
			if( shareGb.equals("M") ) {
				MemberBasePO po = new MemberBasePO();
				po.setPetLogSrtUrl(shortUrl);
				po.setMbrNo(Long.valueOf(shareNo));
				petLogService.updateMemberBase(po);
			}else {
				PetLogBasePO po = new PetLogBasePO();
				po.setPetLogNo(Long.valueOf(shareNo));
				po.setSrtPath(shortUrl);
				petLogService.updatePetLogBase(po);
			}
		}
		
		return shortUrl;
	}
	
	
	
	@RequestMapping(value = "getReviewGoodsInfo", method = RequestMethod.POST)
	public Boolean getReviewGoodsInfo(PetLogBaseSO so) {
//		if( petLogService.getReviewGoodsInfo(bnrId) > 0) {
//			return true;	
//		} else {
//			return false; 
//		}
		return false;
	}
	

	@RequestMapping(value = "memberInfoSave")
	@ResponseBody
	public ModelMap memberInfoSave(Session session, MemberBasePO po) {
		
		po.setMbrNo(session.getMbrNo());
		petLogService.updateMemberBase(po);

		PetLogMemberSO so = new PetLogMemberSO();
		so.setMbrNo(session.getMbrNo());
		PetLogMemberVO mvo = petLogService.getMbrBaseInfo(so);
		ModelMap map = new ModelMap();
		map.put("pstInfoAgrYn", mvo.getPstInfoAgrYn());
		
		return map;
	}

	
	@RequestMapping(value = "indexMyProfileView")
	public String indexMyProfileView(ModelMap map, ViewBase view, Session session,  PetLogMemberSO so) {
		if( session.getMbrNo() != 0 ) {
			so.setMbrNo(session.getMbrNo());
			PetLogMemberVO mvo = petLogService.getMbrBaseInfo(so);
			
			map.put("memberBase", mvo);
			map.put("session", session);
			map.put("view", view);
		}
		return TilesView.none(new String[]{"petlog", "indexMyProfileView"});
	}
	

	@RequestMapping(value = "myProfileSave")
	@ResponseBody
	public ModelMap myProfileSave(Session session, MemberBasePO po) {
		
		po.setMbrNo(session.getMbrNo());
		petLogService.updateMemberBase(po);

		PetLogMemberSO so = new PetLogMemberSO();
		so.setMbrNo(session.getMbrNo());
		PetLogMemberVO mvo = petLogService.getMbrBaseInfo(so);
		
		ModelMap map = new ModelMap();
		map.put("memberBase", mvo);
	
		return map;
	}	
	
	
	@ResponseBody
	@RequestMapping(value = "getNickNameList")
	public ModelMap getNickNameList(@RequestParam("nickNm") String nickNm) {
		
		ModelMap model = new ModelMap();
		List<MemberBaseVO> nickNameList = petLogService.getNickNameList(nickNm);
		model.addAttribute("list", nickNameList);
		return model;
	}

	
	@RequestMapping("layerPetlogReviewPop")
	public String layerPetlogReviewPop(ModelMap model , Session session
				, @RequestParam(value="ordNo",required = false)String ordNo
				, @RequestParam(value="goodsEstmNo",required = false)Long goodsEstmNo
			) {

			CodeDetailVO period = gsrService.getCodeDetailVO(CommonConstants.GS_PNT_PERIOD,CommonConstants.GS_PNT_PERIOD_LIKE);
			//기간 체크
			Boolean isPeriod = false;
			String strtDtm = Optional.ofNullable(period.getUsrDfn1Val()).orElseGet(()->"");
			String endDtm = Optional.ofNullable(period.getUsrDfn2Val()).orElseGet(()->"");
			Long today = System.currentTimeMillis();

			if(StringUtil.isNotEmpty(strtDtm) && StringUtil.isNotEmpty(endDtm)){
				Long strt = DateUtil.getTimestamp(strtDtm,"yyyyMMdd").getTime();
				Long end = DateUtil.getTimestamp(endDtm,"yyyyMMdd").getTime();
				isPeriod = strt <= today && today <= end;
				log.info("########################## \nstrtDtm : {} , today : {} , endDtm : {} , isPeriod : {}",strt,today,end,isPeriod);
			}else if(StringUtil.isNotEmpty(strtDtm)){
				Long strt = DateUtil.getTimestamp(strtDtm,"yyyyMMdd").getTime();
				isPeriod = strt <= today ;
			}else if(StringUtil.isNotEmpty(endDtm)){
				Long end = DateUtil.getTimestamp(endDtm,"yyyyMMdd").getTime();
				isPeriod = today <= end;
			}else{
				isPeriod = false;
			}

			if(isPeriod){
				CodeDetailVO code = gsrService.getCodeDetailVO(CommonConstants.VARIABLE_CONSTANTS,CommonConstants.VARIABLE_CONSTATNS_PET_LOG_REVIEW_PNT);
				if(StringUtil.equals(code.getUseYn(),CommonConstants.COMM_YN_Y)){
					//지급 된적 있는지 확인
					GsrLnkMapSO mso = new GsrLnkMapSO();
					mso.setGoodsEstmNo(goodsEstmNo);
					mso.setOrdNo(ordNo);
					Integer count = gsrService.getRcptNoCnt(mso);

					//최초 지급
					if(Integer.compare(count,0) == 0){
						String rewardPoint = code.getUsrDfn1Val();
						GsrMemberPointPO gsrpo = new GsrMemberPointPO();
						gsrpo.setPntRsnCd(CommonConstants.PNT_RSN_REVIEW);
						gsrpo.setRcptNo(String.valueOf(goodsEstmNo));
						gsrpo.setOrdNoForCheck(ordNo);
						gsrpo.setPoint(rewardPoint);
						gsrpo.setMbrNo(session.getMbrNo());
						gsrpo.setSaleAmt(String.valueOf(0));
						gsrpo.setSaleDate(DateUtil.getNowDate());
						gsrpo.setSaleEndDt(DateUtil.getNowDateTime().substring(11).replace(":", ""));
						GsrMemberPointVO gmpvo = gsrService.petLogReviewAccumPoint(gsrpo);
					}
				}
			}

		return "/petlog/layerPetlogReviewPop";
	}
	
	
	@ResponseBody
	@RequestMapping(value="encCpltYnUpdate")
	public int encCpltYnUpdate(ModelMap model , PetLogBasePO po) {
		int result = petLogService.encCpltYnUpdate(po);
		return result;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2021. 03. 15.
	 * - 작성자		: 이지희
	 * - 설명		: 마이페이지 > 비밀번호 변경 화면 GET
	 * </pre>
	 * @param session
	 * @param Model
	 * @param view
	 * @return
	 * @throws Exception
	 */
	@LoginCheck
	@RequestMapping(value="partnerPswdUpdate" , method=RequestMethod.GET)
	public String indexPswdUpdate(Model model,Session session,ViewBase view, String returnUrl){
		return partnerManageCheck(model,session,view,returnUrl,"/log/home");
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2021. 02. 16.
	 * - 작성자		: 김재윤
	 * - 설명		: 내 정보 관리 - 비밀번호 확인
	 * </pre>
	 * @param model
	 * @param session
	 * @param view
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value="partnerManageCheck" , method={RequestMethod.GET , RequestMethod.POST})
	public String partnerManageCheck(Model model, Session session, ViewBase view,String returnUrl,String redirectUrl) {
		// 비밀번호 여부 확인 후, 없으면 비밀번호 설정 페이지로 . 있으면 비밀번호 확인 페이지로
		String pswdCheck = memberService.isPswdForUpdate(session.getMbrNo());
		if(pswdCheck == null || pswdCheck.equals("")) {
			
			return TilesView.redirect(new String[]{"log","partnerPswdSet?returnUrl="+redirectUrl});
		}else {		
	
			model.addAttribute("session", session);
			model.addAttribute("view", view);
			model.addAttribute(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_INFO_MANAGE);
			model.addAttribute("returnUrl",returnUrl);
			model.addAttribute("redirectUrl",redirectUrl);
			
			Map<String,String> publKeyMap = RSAUtil.createPublicKey();
			model.addAttribute("RSAModulus", publKeyMap.get("RSAModulus"));
			model.addAttribute("RSAExponent", publKeyMap.get("RSAExponent"));
			
			return TilesView.none(new String[] { "petlog", "partnerManageCheck" });
		}
	}	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2021. 02. 16.
	 * - 작성자		: 김재윤
	 * - 설명		: 내 정보 관리 - 비밀번호 확인
	 * </pre>
	* @param session
	* @param pswd
	* @param type
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@ResponseBody
	@RequestMapping(value="checkPartnerPassword", method=RequestMethod.POST)
	public ModelMap checkPartnerPassword(Session session, String pswd) {
		String resultCode = null;
		String type = FrontWebConstants.PSWD_CHECK_TYPE_INFO;
		ModelMap map = new ModelMap();
		
		PrivateKey privateKey = (PrivateKey)SessionUtil.getAttribute("_RSA_WEB_KEY_");
		if(privateKey == null) {
			map.addAttribute(FrontConstants.CONTROLLER_RESULT_CODE, "keyError");
			return map;
		}
		
		pswd = RSAUtil.decryptRas(privateKey, pswd);
		
		resultCode = memberService.checkMemberPassword(session.getMbrNo(), pswd) ? FrontWebConstants.CONTROLLER_RESULT_CODE_SUCCESS : FrontWebConstants.CONTROLLER_RESULT_CODE_FAIL;
		// 성공시 세션에 비밀번호 체크 시각 설정
		if(FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS.equals(resultCode)) {
			SessionUtil.setSessionAttribute(FrontWebConstants.PSWD_CHECK_TYPE_INFO, System.currentTimeMillis());
		}
		String checkCode = makeMyInfoCode(session, type);
		map.put("type",type);
		map.put("checkCode", checkCode);
		map.put(FrontWebConstants.CONTROLLER_RESULT_CODE, resultCode);
		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2016. 3. 2.
	 * - 작성자		: snw
	 * - 설명		: 비밀번호를 거쳐서 들어가는 루트에 대한 체크 코드 생성
	 * </pre>
	 * @param session
	 * @param type
	 * @return
	 * @throws Exception
	 */
	private String makeMyInfoCode(Session session, String type){
		try {
			return CryptoUtil.encryptMD5(session.getSessionId() + String.valueOf(session.getMbrNo().intValue()) + type);
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: MyInfoController.java
	 * - 작성일		: 2021. 3. 10.
	 * - 작성자		: 이지희
	 * - 설명		: 마이페이지 > 비밀번호 설정 화면
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param checkCode
	 * @param type
	 * @return
	 * @throws Exception
	 */
	@LoginCheck
	@RequestMapping(value="partnerPswdSet" , method=RequestMethod.POST)
	public String partnerPswdSet(Model model, Session session, ViewBase view, String returnUrl ) {

		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(session.getMbrNo());
		MemberBaseVO vo = memberService.getMemberBase(so);
		vo.setMobile(bizService.twoWayDecrypt(vo.getMobile()));
		vo.setLoginId(bizService.twoWayDecrypt(vo.getLoginId()));
		vo.setBirth(bizService.twoWayDecrypt(vo.getBirth()));

		String type = FrontWebConstants.PSWD_CHECK_TYPE_INFO;
		String checkCode = makeMyInfoCode(session, type);
		model.addAttribute("type",type);
		model.addAttribute("checkCode", checkCode);

		model.addAttribute("memberId", vo.getLoginId());
		model.addAttribute("session",session);
		model.addAttribute("returnUrl", returnUrl);
		SessionUtil.setAttribute("setPswdMbrNo", vo.getMbrNo()); 
		
		Map<String,String> publKeyMap = RSAUtil.createPublicKey();
		model.addAttribute("RSAModulus", publKeyMap.get("RSAModulus"));
		model.addAttribute("RSAExponent", publKeyMap.get("RSAExponent"));

		return TilesView.none(new String[]{"petlog", "partnerPswdUpdate"} );
	}
	
	@ResponseBody
	@RequestMapping(value = "checkRegPet")
	public int checkRegPet(Model model , Session session , Long mbrNo) {
		int result = petLogService.checkRegPet(mbrNo);
		return result;
	}
	
}