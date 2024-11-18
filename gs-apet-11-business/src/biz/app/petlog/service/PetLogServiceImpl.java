package biz.app.petlog.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;
import java.util.stream.Collectors;

import biz.interfaces.gsr.dao.GsrLogDao;
import biz.interfaces.gsr.model.GsrLnkMapPO;
import org.apache.commons.codec.binary.StringUtils;
import org.apache.commons.text.StringEscapeUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.appweb.dao.PushDao;
import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.display.dao.DisplayDao;
import biz.app.display.model.DisplayBannerVO;
import biz.app.display.model.DisplayCornerItemVO;
import biz.app.display.model.DisplayCornerSO;
import biz.app.display.model.DisplayCornerTotalVO;
import biz.app.goods.model.GoodsCommentPO;
import biz.app.goods.model.GoodsCommentSO;
import biz.app.goods.service.GoodsCommentService;
import biz.app.member.dao.MemberBaseDao;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.app.order.dao.OrdSavePntDao;
import biz.app.order.dao.OrderDetailDao;
import biz.app.order.model.OrdSavePntPO;
import biz.app.order.model.OrderDetailPO;
import biz.app.pet.service.PetService;
import biz.app.petlog.dao.PetLogDao;
import biz.app.petlog.model.FollowMapPO;
import biz.app.petlog.model.FollowMapVO;
import biz.app.petlog.model.PetLogBasePO;
import biz.app.petlog.model.PetLogBaseSO;
import biz.app.petlog.model.PetLogBaseVO;
import biz.app.petlog.model.PetLogInterestPO;
import biz.app.petlog.model.PetLogListSO;
import biz.app.petlog.model.PetLogMemberSO;
import biz.app.petlog.model.PetLogMemberVO;
import biz.app.petlog.model.PetLogMentionMemberPO;
import biz.app.petlog.model.PetLogMentionMemberSO;
import biz.app.petlog.model.PetLogMentionMemberVO;
import biz.app.petlog.model.PetLogReplyPO;
import biz.app.petlog.model.PetLogReplyVO;
import biz.app.petlog.model.PetLogRptpPO;
import biz.app.petlog.model.PetLogSharePO;
import biz.app.system.model.CodeDetailVO;
import biz.app.tag.dao.TagDao;
import biz.app.tag.model.TagBasePO;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.common.model.PushTargetPO;
import biz.common.model.SendPushPO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import biz.interfaces.gsr.model.GsrLnkMapSO;
import biz.interfaces.gsr.model.GsrMemberPointPO;
import biz.interfaces.gsr.model.GsrMemberPointVO;
import biz.interfaces.gsr.service.GsrService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.enums.SearchApiSpec;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.ObjectUtil;
import framework.common.util.SearchApiUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("petLogService")
@Transactional
public class PetLogServiceImpl implements PetLogService {

	@Autowired private Properties bizConfig;
	@Autowired private Properties webConfig;
	@Autowired
	private PetLogDao petLogDao;
	@Autowired
	private TagDao tagDao;	
	@Autowired
	private DisplayDao displayDao;	
	@Autowired
	private SearchApiUtil searchApiClient;
	@Autowired	
	private BizService bizService;
	@Autowired
	private OrderDetailDao orderDetailDao;
	@Autowired
	private PetService petService;
	@Autowired
	private GsrService gsrService;
	@Autowired
	private MemberBaseDao memberBaseDao;
	@Autowired
	private PushDao pushDao;
	@Autowired
	private CacheService cacheService;
	@Autowired
	private MemberService memberService;
	@Autowired	
	private OrdSavePntDao ordSavePntDao;
	@Autowired
	private GoodsCommentService goodsCommentService;
	@Autowired
	private GsrLogDao gsrLogDao;
	
	@Override
	@Transactional(readOnly=true)
	public PetLogBaseVO getPetLogDetail(PetLogBaseSO so) {
		PetLogBaseVO vo = Optional.ofNullable(petLogDao.getPetLogDetail(so)).orElseGet(()-> new PetLogBaseVO());
		
		// 위치정보 복호화
		if( StringUtil.isNotEmpty(vo.getLogLitd()) ){	//경도
			vo.setLogLitd(bizService.twoWayDecrypt(vo.getLogLitd()));
		}
		if( StringUtil.isNotEmpty(vo.getLogLttd()) ){	//위도
			vo.setLogLttd(bizService.twoWayDecrypt(vo.getLogLttd()));
		}
		if( StringUtil.isNotEmpty(vo.getPrclAddr()) ){	//지번주소
			vo.setPrclAddr(bizService.twoWayDecrypt(vo.getPrclAddr()));
		}
		if( StringUtil.isNotEmpty(vo.getRoadAddr()) ){	//도로주소
			vo.setRoadAddr(bizService.twoWayDecrypt(vo.getRoadAddr()));
		}
		if( StringUtil.isNotEmpty(vo.getPstNm()) ){	//위치명
			vo.setPstNm(bizService.twoWayDecrypt(vo.getPstNm()));
		}
		
		return vo;
	}
	
	@Override
	@Transactional(readOnly=true)
	public List<PetLogBaseVO> pagePetLogBase (PetLogListSO so) {
		return petLogDao.pagePetLogBase(so );
	}
	
	private PetLogBasePO insertPetLogTagMap(PetLogBasePO po, String gb) {
		// 사용자가 입력한 설명에 # 로 등록된 태그에 대해서
		// 1. TAG_BASE 에 있으면, PET_LOG_TAG_MAP 에 등록
		// 2.          에 없으면, TAG_BASE 에 TAG 신조어로 등록 후, PET_LOG_TAG_MAP 에 등록
		List<String> tagNmsList = StringUtil.getTags(po.getDscrt(),"#");
		
		//펫로그 후기일 경우 #상품후기 태그가 없을경우 내용 뒤에 \n&emsp;\n#상품후기 추가
		if(StringUtil.equals(po.getPetLogChnlCd(), CommonConstants.PETLOG_CHNL_20)) {
			if(!tagNmsList.contains("상품후기")) {
				tagNmsList.add("상품후기");
			}
		}
		
		if( tagNmsList != null && tagNmsList.size() > 0) {
			//중복제거
			List<String> tagNms = tagNmsList.stream().distinct().collect(Collectors.toList());
			
			TagBaseSO tagSo = null;
			TagBaseVO tagVo = null;
			TagBasePO tagPo = null;
			// 펫로그 수정의 경우, 먼저 delete
			if( gb.equals("U") ) {
				petLogDao.deletePetLogTagMap(po );
			}
			
			for(String tagNm : tagNms) {
				//System.out.println("======================================");
				//System.out.println("tagNm:"+tagNm);
				// 20자까지만 태그로 등록 - 2021.04.20 추가.
				if( tagNm.length() > 20 ) continue;
				
				tagSo = new TagBaseSO();
				tagSo.setTagNm(tagNm);
				tagVo = tagDao.getTagInfo(tagSo);
				if( tagVo != null && tagVo.getTagNo() != null) {
					//System.out.println("tagNo:"+tagVo.getTagNo());
					// 기 등록된 tag 가 있는 경우, USE_CNT+1 로 update
					tagPo = new TagBasePO();
					tagPo.setTagNo(tagVo.getTagNo());
					tagPo.setUseCnt(1);
					tagDao.updateTagBase(tagPo);
					
					po.setTagNo(tagVo.getTagNo());					
				}else {
					tagPo = new TagBasePO();
					tagPo.setTagNm(tagNm);
					tagPo.setStatCd("U"); // 태그 신조어로 등록.
					tagPo.setSrcCd("M"); // 팻로그 등록 시 등록된 태그(수동생성)
					tagDao.insertTagBase(tagPo);
					
					po.setTagNo(tagPo.getTagNo());					
				}
				
				petLogDao.insertPetLogTagMap(po );
			}
		}
		
		return po;
	}
	
	
	@Override
	public Long insertPetLogBase(PetLogBasePO po) {
		Long petLogNo = petLogDao.getPetLogBaseSeq();
		po.setPetLogNo(petLogNo);
		
		//펫로그 후기일 경우 #상품후기 태그가 없으면 내용 뒤에 \n&emsp;\n#상품후기 추가
		if(StringUtil.equals(po.getPetLogChnlCd(), CommonConstants.PETLOG_CHNL_20)) {
			List<String> tagNmsList = StringUtil.getTags(po.getDscrt(),"#");
			if(StringUtil.isEmpty(po.getDscrt()) || !tagNmsList.contains("상품후기")) {
				po.setDscrt(po.getDscrt()+"\n&emsp;\n#상품후기");
			}
		}
		
		if(StringUtil.isNotEmpty(po.getDscrt())) {
			po = this.insertPetLogTagMap(po, "I");
		}
		
		// 펫로그 등록 
		if (po.getImgPath() != null) {
			for (int i = 0; i < po.getImgPath().length; i++) {

				String filePath = po.getImgPath()[i];
//
//				FtpImgUtil ftpImgUtil = new FtpImgUtil();
//				String filePath = ftpImgUtil.uploadFilePath(orgFileStr, CommonConstants.PET_LOG_IMAGE_PATH + FileUtil.SEPARATOR + petLogNo);
//				ftpImgUtil.upload(orgFileStr, filePath);

				switch (i+1) {
					case 1:
						po.setImgPath1(filePath);
						break;
					case 2:
						po.setImgPath2(filePath);
						break;
					case 3:
						po.setImgPath3(filePath);
						break;
					case 4:
						po.setImgPath4(filePath);
						break;
					case 5:
						po.setImgPath5(filePath);
						break;					
					default:
						break;
				}
			}
		}
		
		
		// 펫로그 기본 등록 시 암호화 필드 셋팅.
		if( StringUtil.isNotEmpty(po.getLogLitd()) ){	//경도
			po.setLogLitd(bizService.twoWayEncrypt(po.getLogLitd()));
		}
		if( StringUtil.isNotEmpty(po.getLogLttd()) ){	//위도
			po.setLogLttd(bizService.twoWayEncrypt(po.getLogLttd()));
		}
		if( StringUtil.isNotEmpty(po.getPrclAddr()) ){	//지번주소
			po.setPrclAddr(bizService.twoWayEncrypt(po.getPrclAddr()));
		}
		if( StringUtil.isNotEmpty(po.getRoadAddr()) ){	//도로주소
			po.setRoadAddr(bizService.twoWayEncrypt(po.getRoadAddr()));
		}
		if( StringUtil.isNotEmpty(po.getPstNm()) ){	//위치명
			po.setPstNm(bizService.twoWayEncrypt(po.getPstNm()));
		}
		
		if(po.getPetLogChnlCd().equals(CommonConstants.PETLOG_CHNL_20) && StringUtil.isNotEmpty(po.getGoodsEstmNo())) {
			po.setRvwYn("Y");
		}
		
		petLogDao.insertPetLogBase(po );
		//petLogNo = po.getPetLogNo();		
		
		//펫로그 채널 코드가 10이 아닌 경우, 펫로그 연관 매핑에 등록.
		if( !po.getPetLogChnlCd().equals(CommonConstants.PETLOG_CHNL_10) ) { 
			petLogDao.insertPetLogRltMap(po);
		}
		
		
		// 상품후기 펫로그 게시물의 경우 펫로그 상품후기 매핑 등록
		if( StringUtil.isNotEmpty(po.getRvwYn()) && po.getRvwYn().equals(CommonConstants.COMM_YN_Y) ) {
		//if(po.getPetLogChnlCd().equals(CommonConstants.PETLOG_CHNL_20) && StringUtil.isNotEmpty(po.getGoodsEstmNo())) {
			//po.setRvwYn("Y");
			petLogDao.insertPetLogGoodsReviewMap(po);
			
			//주문 상세 수정 - 펫로그 후기 작성 시 주문상세 후기 작성여부 수정 
			OrderDetailPO orderPO = new OrderDetailPO();
			orderPO.setGoodsEstmRegYn(CommonConstants.COMM_YN_Y);
			orderPO.setSysUpdrNo(po.getSysRegrNo());
			orderPO.setGoodsEstmNo(po.getGoodsEstmNo());

			int orderResult = orderDetailDao.updateOrderDetailPlg(orderPO);
			if(orderResult == 0){
				throw new CustomException(ExceptionConstants.ERROR_CODE_PET_LOG_INSERT_FAIL);
			}
		}
		
		return petLogNo;		
	}
	
	
	public Long updatePetLogBase(PetLogBasePO po) {
		int result = 0;
		// 단축경로/조회수 update 
		if( !StringUtil.isEmpty(po.getSrtPath()) || !StringUtil.isEmpty(po.getHits())) {
			result = petLogDao.updatePetLogSrtPathHits(po);
		}else {
			//펫로그 후기일 경우 #상품후기 태그가 없으면 내용 뒤에 \n&emsp;\n#상품후기 추가
			if(StringUtil.equals(po.getPetLogChnlCd(), CommonConstants.PETLOG_CHNL_20)) {
				List<String> tagNmsList = StringUtil.getTags(po.getDscrt(),"#");
				if(StringUtil.isEmpty(po.getDscrt()) || !tagNmsList.contains("상품후기")) {
					po.setDscrt(po.getDscrt()+"\n&emsp;\n#상품후기");
				}
			}
			
			po = this.insertPetLogTagMap(po, "U");
		
			// 펫로그 등록 
			if (po.getImgPath() != null) {
				po.setImgPath1(null);
				po.setImgPath2(null);
				po.setImgPath3(null);
				po.setImgPath4(null);
				po.setImgPath5(null);			
				
				for (int i = 0; i < po.getImgPath().length; i++) {
	
					String filePath = po.getImgPath()[i];
					//System.out.println("filePath"+(i+1)+"===>" + filePath);
					// 신규 파일만 upload --- 앱에서 등록.
					/*String orgFileStr = po.getImgPath()[i];
					if( orgFileStr.startsWith(bizConfig.getProperty("common.file.upload.base"))) {
						FtpImgUtil ftpImgUtil = new FtpImgUtil();
						filePath = ftpImgUtil.uploadFilePath(orgFileStr, CommonConstants.PET_LOG_IMAGE_PATH + FileUtil.SEPARATOR + po.getPetLogNo());
						ftpImgUtil.upload(orgFileStr, filePath);
					}*/
					
					switch (i+1) {
						case 1:
							po.setImgPath1(filePath);
							break;
						case 2:
							po.setImgPath2(filePath);
							break;
						case 3:
							po.setImgPath3(filePath);
							break;
						case 4:
							po.setImgPath4(filePath);
							break;
						case 5:
							po.setImgPath5(filePath);
							break;					
						default:
							break;
					}
	
				}
			}
			
			// 펫로그 기본 등록 시 암호화 필드 셋팅.
			if( StringUtil.isNotEmpty(po.getLogLitd()) ){	//경도
				po.setLogLitd(bizService.twoWayEncrypt(po.getLogLitd()));
			}
			if( StringUtil.isNotEmpty(po.getLogLttd()) ){	//위도
				po.setLogLttd(bizService.twoWayEncrypt(po.getLogLttd()));
			}
			if( StringUtil.isNotEmpty(po.getPrclAddr()) ){	//지번주소
				po.setPrclAddr(bizService.twoWayEncrypt(po.getPrclAddr()));
			}
			if( StringUtil.isNotEmpty(po.getRoadAddr()) ){	//도로주소
				po.setRoadAddr(bizService.twoWayEncrypt(po.getRoadAddr()));
			}
			if( StringUtil.isNotEmpty(po.getPstNm()) ){	//위치명
				po.setPstNm(bizService.twoWayEncrypt(po.getPstNm()));
			}			
			
			result = petLogDao.updatePetLogBase(po);
		}

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		return po.getPetLogNo();
	}
	
	@Override
	public void deletePetLogBase(PetLogBasePO po, String callGb) {
		int result = petLogDao.deletePetLogBase(po);		

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}else {
			// petlog 삭제 정보 등록
			result = petLogDao.insertPetLogBaseDelete(po);
			if (result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}else {
				// APETQA-6430 펫로그 중복 삭제로 인해 펫로그에서 호출할 경우만 삭제되도록 수정
				//펫로그 후기일 경우 후기도 삭제처리
				if(StringUtil.equals(callGb, "LOG")) {
					GoodsCommentSO gcSO = new GoodsCommentSO();
					gcSO.setPetLogNo(po.getPetLogNo());
					GoodsCommentPO gcPO = goodsCommentService.getCommentDeleteInfo(gcSO);
					
					if(!StringUtil.isEmpty(gcPO)) {
						gcPO.setSysRegrNo(gcPO.getEstmMbrNo());
						goodsCommentService.deleteGoodsComment(gcPO);
					}
				}
				/* 검색 엔진 API 호출 : action_log 삭제 */
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String nowTime = format.format(new Date());
				Map<String,String> requestParam = new HashMap<String,String>();
				
				requestParam.put("MBR_NO", String.valueOf(po.getMbrNo()));
				requestParam.put("SECTION", "log");
				requestParam.put("CONTENT_ID", String.valueOf(po.getPetLogNo()));
				requestParam.put("ACTION", "delete");
				requestParam.put("TIMESTAMP", nowTime);
				
				searchApiClient.getResponse(SearchApiSpec.SRCH_API_IF_ACTION, requestParam);
			}
		}
		
	}
	
	@Override
	public List<PetLogReplyVO> listPetLogReply (PetLogBaseSO so ){
		List<PetLogReplyVO> replyList = petLogDao.listPetLogReply(so );
		for(PetLogReplyVO reply : replyList) {
			List<String> nickNmList = StringUtil.getTags(reply.getAply() , "@");
			if( nickNmList != null && nickNmList.size() > 0) {
				PetLogMemberSO pso = null;
				PetLogReplyPO rppo = null; 
				for(String nickNm : nickNmList) {
					String[] mentionArr = nickNm.split("[|]");
					pso = new PetLogMemberSO();
					
					//멘션 insert시 존재하는 회원이라 mbrNo가 존재한다면 mbrNo set 아니라면 nickNm set
					if(mentionArr.length == 3) {
						pso.setMbrNo(Long.valueOf(mentionArr[1]));
					}else {
						pso.setNickNm(mentionArr[0]);
					}
					
					PetLogMemberVO mvo = Optional.ofNullable(petLogDao.getMbrBaseInfo(pso)).orElseGet(()-> new PetLogMemberVO());

					
					//멘션시에는 존재하지 않는 닉네임이였지만 이후 해당 닉네임의 회원이 존재하는 경우 업데이트
					//해당 회원이 존재하더라도 펫로그 URL이 존재하지 않는다면 UPDATE 하지 않는다.
//					if(ObjectUtil.isNotEmpty(mvo.getPetLogUrl()) && StringUtil.isNotBlank(pso.getNickNm())) {
//						rppo = new PetLogReplyPO();
//						rppo.setPetLogAplySeq(reply.getPetLogAplySeq());
//						rppo.setAply(reply.getAply() + "|" + mvo.getMbrNo() + "|" + mvo.getPetLogUrl());
//						petLogDao.updatePetLogReply(rppo);
//						reply.setAply(rppo.getAply());
//					}
					
			
					if(ObjectUtil.isNotEmpty(mvo.getMbrNo()) && mentionArr.length == 3) {
						//기존 멘션시에 펫로그URL이 없었지만 이후 펫로그URL이 생성된 회원은 업데이트 
						if(!StringUtil.isNull(mvo.getPetLogUrl()) && StringUtil.equals(mentionArr[2], "null")) {
							rppo = new PetLogReplyPO();
							rppo.setPetLogAplySeq(reply.getPetLogAplySeq());
							rppo.setAply(StringUtil.replaceAll(reply.getAply(),  "null", mvo.getPetLogUrl()));
							petLogDao.updatePetLogReply(rppo);
							
							reply.setAply(rppo.getAply());
						}
						
						//멘션된 회원의 닉네임이 변경된 경우 변경된 닉네임 SET	
						if(ObjectUtil.isNotEmpty(mvo.getMbrNo()) && !StringUtil.equals(mvo.getNickNm(), mentionArr[0])) {
							rppo = new PetLogReplyPO();
							rppo.setPetLogAplySeq(reply.getPetLogAplySeq());
							rppo.setAply(StringUtil.replaceAll(reply.getAply(),  mentionArr[0], mvo.getNickNm()));
							petLogDao.updatePetLogReply(rppo);
							
							reply.setAply(rppo.getAply());
							//닉네임 변경과 탈퇴 동시 처리 시 탈퇴 회원 처리를 위해
							nickNm = StringUtil.replaceAll(nickNm, mentionArr[0], mvo.getNickNm());
						}
					}
					//탈퇴 회원인 경우 어바웃 펫 회원으로 노출
					if(StringUtil.equals(mvo.getMbrStatCd(), CommonConstants.MBR_STAT_50)) { reply.setAply(StringUtil.replaceAll(reply.getAply(),  "@"+nickNm, "@어바웃펫 회원"));}
					//미등록 회원 , 펫로그 URL이 없는 회원일 경우 해당 닉네임 텍스트로 노출
					if(ObjectUtil.isEmpty(mvo.getMbrNo()) || StringUtil.isEmpty(mvo.getPetLogUrl())) { reply.setAply(StringUtil.replaceAll(reply.getAply(),  "@"+nickNm, "@"+mentionArr[0])); }
					
				}
			}
		}
		return replyList;
	}	

	@Override
	@Transactional(readOnly=true)
	public List<PetLogBaseVO> listPetLogLike (PetLogListSO lso ){
		int cornCnt = 6;
		if( lso.getPetLogNos() != null ) {cornCnt = 0;}
		
		List<PetLogBaseVO> petLogList =  petLogDao.listLikePetLogByDispCorn(lso );
		
		return this.getPetLogRecommendList(lso, petLogList, cornCnt);
	}	
	
	@Override
	public Long insertPetLogReply(PetLogReplyPO po) {
		Long petLogNo = po.getPetLogNo();
		
		// 사용자가 입력한 댓글에 @닉네임 에 대해서
		// PET_LOG_MENTION_MEMBER 에 등록
	
		List<String> nickNmList = StringUtil.getTags(po.getAply(),"@");
		List<String> nickNms = new ArrayList<String>();
		if( nickNmList != null && nickNmList.size() > 0) {			
			for(String nickNm : nickNmList) {
				//esacpe처리된 ' 문자가 태그 구분을 위한 #에 걸려 unescape처리 후 닉네임으로 회원 조회 시 다시 escape처리
				if(StringEscapeUtils.unescapeHtml4(nickNm).indexOf("#") > -1) {
					nickNm = StringEscapeUtils.unescapeHtml4(nickNm).substring(0, nickNm.indexOf("#"));
				}
				nickNms.add(nickNm);
			}
			nickNms = nickNms.stream().distinct().collect(Collectors.toList());
			
			PetLogMemberSO pso = null;
			for(String nickNm : nickNms) {
				//mbrNo 조회
				pso = new PetLogMemberSO();
				pso.setNickNm(nickNm);
				PetLogMemberVO mvo = petLogDao.getMbrBaseInfo(pso);	
				
				if( !StringUtil.isEmpty(mvo)) {
					String mntMbrInfo = " @"+nickNm+"|"+mvo.getMbrNo()+"|"+mvo.getPetLogUrl() + " ";
					//같은 닉네임을 두번 멘션 후 하나의 닉네임 뒤에만 내용을 붙여서 추가하더라도 replace되기에 띄어쓰기까지 replace 타겟으로 지정
					po.setAply(StringUtil.replaceAll(po.getAply(),  "@"+nickNm+" ", mntMbrInfo));
				}
			}
		}

		int result = petLogDao.insertPetLogReply(po);
		
		if(result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}else {
			MemberBaseSO mbso = new MemberBaseSO();
			mbso.setMbrNo(po.getMbrNo());
			MemberBaseVO mbvo = Optional.ofNullable(memberService.getMemberBase(mbso)).orElseGet(()->new MemberBaseVO());
			
			PetLogBaseSO plso = new PetLogBaseSO();
			plso.setPetLogNo(po.getPetLogNo());
			PetLogBaseSO gFpSo = new PetLogBaseSO();
			gFpSo.setPetLogNo(po.getPetLogNo());
			gFpSo.setMbrNo(po.getMbrNo());
			PetLogBaseSO getPetLogFlag = petLogDao.getPetLogFlag(gFpSo);			
			PetLogBaseVO petLogDetail = this.getPetLogDetail(plso);
			
			//댓글 멘션 insert
			if( nickNms != null && nickNms.size() > 0) {	
				PetLogMentionMemberPO mntMbrPo = null;
				PetLogMemberSO pso = null;
				int mntnSeq = 1;
				for(String nickNm : nickNms) {
					pso = new PetLogMemberSO();
					pso.setNickNm(nickNm);
					PetLogMemberVO mvo = petLogDao.getMbrBaseInfo(pso);	
					
					if( !StringUtil.isEmpty(mvo)) {
						mntMbrPo = new PetLogMentionMemberPO();
						mntMbrPo.setPetLogNo(petLogNo);
						mntMbrPo.setAplyNo(po.getPetLogAplySeq().intValue());
						mntMbrPo.setMetnSeq(mntnSeq);
						mntMbrPo.setMetnTgMbrNo(mvo.getMbrNo());
						mntMbrPo.setMetnMbrNo(po.getMbrNo());
						int mntnResult = petLogDao.insertPetLogReplyMention(mntMbrPo);
						
						if(mntnResult != 1) {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}else {
							mntnSeq++;
						}
					}
				}
			}
			
			if(getPetLogFlag == null) {
				PushSO pso = new PushSO();
				pso.setTmplNo(Long.valueOf(cacheService.getCodeCache(CommonConstants.TMPL_NO, CommonConstants.TMPL_PET_LOG_REPLY).getUsrDfn1Val()));
				PushVO template = Optional.ofNullable(pushDao.getNoticeTemplate(pso)).orElseGet(()->new PushVO());
				
				if (StringUtil.isNotBlank(template.getSubject()) && StringUtil.isNotBlank(template.getContents())) {
					List<PushTargetPO> ptpoList = new ArrayList<>();
					PushTargetPO ptpo = new PushTargetPO();
					
					ptpo.setTo(petLogDetail.getMbrNo().toString());
					ptpo.setImage(template.getImgPath());
					ptpo.setLandingUrl(template.getMovPath() + "&petLogNo=" + po.getPetLogNo());
					
					Map<String,String> map =new HashMap<String, String>();
					map.put("nick_nm", mbvo.getNickNm());
					ptpo.setParameters(map);
					ptpoList.add(ptpo);
					
					SendPushPO sppo = new SendPushPO();
					sppo.setTitle(template.getSubject());
					sppo.setMessageType("NOTIF");
					sppo.setType("USER");
					sppo.setTmplNo(pso.getTmplNo());
					sppo.setTarget(ptpoList);
					
//					if (StringUtil.isNotEmpty(mbvo.getDeviceTpCd())) {
//						if (mbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_10)) {
//							sppo.setDeviceType("GCM");
//						} else if (mbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_20)) {
//							sppo.setDeviceType("APNS");
//						}
//					}
					
					String noticeSendNo = bizService.sendPush(sppo);
					
					if (StringUtil.equals(noticeSendNo, null)) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
			
			// 멘션 푸쉬 start
			if( nickNmList != null && nickNmList.size() > 0) {
//				List<String> nickNms = nickNmList.stream().distinct().collect(Collectors.toList());
				PetLogMemberSO pso = null;
				for(String nickNm : nickNms) {
					//mbrNo 조회
					pso = new PetLogMemberSO();
					pso.setNickNm(nickNm);
					PetLogMemberVO mvo = petLogDao.getMbrBaseInfo(pso);	
					
					if( !StringUtil.isEmpty(mvo)) {
						MemberBaseSO mentionPushmbso = new MemberBaseSO();
						mentionPushmbso.setMbrNo(mvo.getMbrNo());
						MemberBaseVO mentionPushmbvo = Optional.ofNullable(memberService.getMemberBase(mentionPushmbso)).orElseGet(()->new MemberBaseVO());
						
						PetLogBaseSO mentionPushplso = new PetLogBaseSO();
						mentionPushplso.setPetLogNo(po.getPetLogNo());
						PetLogBaseVO mentionPushPetLogDetail = this.getPetLogDetail(mentionPushplso);
						
						if(getPetLogFlag == null) {
							PushSO mentionPushpso = new PushSO();
							mentionPushpso.setTmplNo(Long.valueOf(cacheService.getCodeCache(CommonConstants.TMPL_NO, CommonConstants.TMPL_PET_LOG_REPLY_MENTION).getUsrDfn1Val()));
							PushVO mentionPushpsoTemplate = Optional.ofNullable(pushDao.getNoticeTemplate(mentionPushpso)).orElseGet(()->new PushVO());
							
							if (StringUtil.isNotBlank(mentionPushpsoTemplate.getSubject()) && StringUtil.isNotBlank(mentionPushpsoTemplate.getContents())) {
								List<PushTargetPO> mentionPushPtpoList = new ArrayList<>();
								PushTargetPO mentionPushPtpo = new PushTargetPO();
								
								mentionPushPtpo.setTo(mvo.getMbrNo().toString());
								mentionPushPtpo.setImage(mentionPushpsoTemplate.getImgPath());
								mentionPushPtpo.setLandingUrl(mentionPushpsoTemplate.getMovPath() + "&petLogNo=" + po.getPetLogNo());
								
								Map<String,String> mentionPushMap =new HashMap<String, String>();
								mentionPushMap.put("nick_nm", mbvo.getNickNm());
								mentionPushPtpo.setParameters(mentionPushMap);
								mentionPushPtpoList.add(mentionPushPtpo);
								
								SendPushPO mentionPushSppo = new SendPushPO();
								mentionPushSppo.setTitle(mentionPushpsoTemplate.getSubject());
								mentionPushSppo.setMessageType("NOTIF");
								mentionPushSppo.setType("USER");
								mentionPushSppo.setTmplNo(mentionPushpso.getTmplNo());
								mentionPushSppo.setTarget(mentionPushPtpoList);
								
								if (StringUtil.isNotEmpty(mentionPushmbvo.getDeviceTpCd())) {
									if (mentionPushmbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_10)) {
										mentionPushSppo.setDeviceType("GCM");
									} else if (mentionPushmbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_20)) {
										mentionPushSppo.setDeviceType("APNS");
									}
								}
								
								String mentionSendNo = bizService.sendPush(mentionPushSppo);
								
								if (StringUtil.equals(mentionSendNo, null)) {
									throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
								}
							}
						}
					}
				}
			}
			// 멘션 푸쉬 end
			// 20210802 추가. 댓글 태그 등록
			insertPetLogReplyTag(po, "");
		}
		
		return petLogNo;		
	}
	
	@Override
	public Long updatePetLogReply(PetLogReplyPO po) {
		Long petLogNo = po.getPetLogNo();

		PetLogMentionMemberSO plmmSO = new PetLogMentionMemberSO();
		plmmSO.setPetLogNo(petLogNo);
		plmmSO.setAplyNo(po.getPetLogAplySeq().intValue());
		List<PetLogMentionMemberVO> mntMbrList = petLogDao.petLogReplyMentionList(plmmSO);
		petLogDao.deletePetLogReplyMention(plmmSO);

		List<String> pushNickNms = new ArrayList<>();
		List<String> nickNms = new ArrayList<String>();
		List<String> nickNmList = StringUtil.getTags(po.getAply(),"@");
		if( nickNmList != null && nickNmList.size() > 0) {
			for(String nickNm : nickNmList) {
				//esacpe처리된 ' 문자가 태그 구분을 위한 #에 걸려 unescape처리 후 닉네임으로 회원 조회 시 다시 escape처리
				if(StringEscapeUtils.unescapeHtml4(nickNm).indexOf("#") > -1) {
					nickNm = StringEscapeUtils.unescapeHtml4(nickNm).substring(0, nickNm.indexOf("#"));
				}
				nickNms.add(nickNm);
			}
			nickNms = nickNms.stream().distinct().collect(Collectors.toList());
			PetLogMemberSO pso = null;
			for(String nickNm : nickNms) {
				//mbrNo 조회
				pso = new PetLogMemberSO();
				pso.setNickNm(nickNm);
				PetLogMemberVO mvo = petLogDao.getMbrBaseInfo(pso);	
				
				if( !StringUtil.isEmpty(mvo)) {
					String mntMbrInfo = " @"+nickNm+"|"+mvo.getMbrNo()+"|"+mvo.getPetLogUrl() + " ";
					po.setAply(StringUtil.replaceAll(po.getAply(),  "@"+nickNm, mntMbrInfo));
					//System.out.println("insertPetLogReply===>"+po.getAply());
				}
			}
		}
		
		int result = petLogDao.updatePetLogReply(po);
	
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}else {
			MemberBaseSO mbso = new MemberBaseSO();
			mbso.setMbrNo(po.getMbrNo());
			MemberBaseVO mbvo = Optional.ofNullable(memberService.getMemberBase(mbso)).orElseGet(()->new MemberBaseVO());
			
			PetLogBaseSO gFpSo = new PetLogBaseSO();
			gFpSo.setPetLogNo(po.getPetLogNo());
			gFpSo.setMbrNo(po.getMbrNo());
			PetLogBaseSO getPetLogFlag = petLogDao.getPetLogFlag(gFpSo);
			
			PetLogMentionMemberPO mntMbrPo = null;
			PetLogMemberSO pmso = null;
			int mntnSeq = 1;
			for(String nickNm : nickNms) {
				//mbrNo 조회
				pmso = new PetLogMemberSO();
				pmso.setNickNm(nickNm);
				PetLogMemberVO mvo = petLogDao.getMbrBaseInfo(pmso);	
				
				//댓글 멘션 insert
				if( !StringUtil.isEmpty(mvo)) {
					mntMbrPo = new PetLogMentionMemberPO();
					mntMbrPo.setPetLogNo(petLogNo);
					mntMbrPo.setAplyNo(po.getPetLogAplySeq().intValue());
					mntMbrPo.setMetnSeq(mntnSeq);
					mntMbrPo.setMetnTgMbrNo(mvo.getMbrNo());
					mntMbrPo.setMetnMbrNo(po.getMbrNo());
					int mentionResult = petLogDao.insertPetLogReplyMention(mntMbrPo);
					if(mentionResult != 1) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}else {
						for(PetLogMentionMemberVO v : mntMbrList) {
							//업데이트 전 멘션된 회원은 push보내지 않음
							if(v.getMetnTgMbrNo() != mvo.getMbrNo()) {
								pushNickNms.add(mvo.getNickNm());
							}
						}
						mntnSeq++;
					}
				}
			}
			// 멘션 푸쉬 start
			if( pushNickNms != null && pushNickNms.size() > 0) {
				PetLogMemberSO pso = null;
				
				for(String nickNm : nickNms) {
					//mbrNo 조회
					pso = new PetLogMemberSO();
					pso.setNickNm(nickNm);
					PetLogMemberVO mvo = petLogDao.getMbrBaseInfo(pso);	
					
					if( !StringUtil.isEmpty(mvo)) {
						MemberBaseSO mentionPushmbso = new MemberBaseSO();
						mentionPushmbso.setMbrNo(mvo.getMbrNo());
						MemberBaseVO mentionPushmbvo = Optional.ofNullable(memberService.getMemberBase(mentionPushmbso)).orElseGet(()->new MemberBaseVO());
						
						PetLogBaseSO mentionPushplso = new PetLogBaseSO();
						mentionPushplso.setPetLogNo(po.getPetLogNo());
						PetLogBaseVO mentionPushPetLogDetail = this.getPetLogDetail(mentionPushplso);
						
						if(getPetLogFlag == null) {
							PushSO mentionPushpso = new PushSO();
							mentionPushpso.setTmplNo(Long.valueOf(cacheService.getCodeCache(CommonConstants.TMPL_NO, CommonConstants.TMPL_PET_LOG_REPLY_MENTION).getUsrDfn1Val()));
							PushVO mentionPushpsoTemplate = Optional.ofNullable(pushDao.getNoticeTemplate(mentionPushpso)).orElseGet(()->new PushVO());
							
							if (StringUtil.isNotBlank(mentionPushpsoTemplate.getSubject()) && StringUtil.isNotBlank(mentionPushpsoTemplate.getContents())) {
								List<PushTargetPO> mentionPushPtpoList = new ArrayList<>();
								PushTargetPO mentionPushPtpo = new PushTargetPO();
								
								mentionPushPtpo.setTo(mvo.getMbrNo().toString());
								mentionPushPtpo.setImage(mentionPushpsoTemplate.getImgPath());
								mentionPushPtpo.setLandingUrl(mentionPushpsoTemplate.getMovPath() + "&petLogNo=" + po.getPetLogNo());
								
								Map<String,String> mentionPushMap =new HashMap<String, String>();
								mentionPushMap.put("nick_nm", mbvo.getNickNm());
								mentionPushPtpo.setParameters(mentionPushMap);
								mentionPushPtpoList.add(mentionPushPtpo);
								
								SendPushPO mentionPushSppo = new SendPushPO();
								mentionPushSppo.setTitle(mentionPushpsoTemplate.getSubject());
								mentionPushSppo.setMessageType("NOTIF");
								mentionPushSppo.setType("USER");
								mentionPushSppo.setTmplNo(mentionPushpso.getTmplNo());
								mentionPushSppo.setTarget(mentionPushPtpoList);
								
								if (StringUtil.isNotEmpty(mentionPushmbvo.getDeviceTpCd())) {
									if (mentionPushmbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_10)) {
										mentionPushSppo.setDeviceType("GCM");
									} else if (mentionPushmbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_20)) {
										mentionPushSppo.setDeviceType("APNS");
									}
								}
								
								String mentionSendNo = bizService.sendPush(mentionPushSppo);
								
								if (StringUtil.equals(mentionSendNo, null)) {
									throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
								}
							}
						}
					}
				}
			}
			// 멘션 푸쉬 end
			// 20210802 추가. 댓글 태그 등록
			insertPetLogReplyTag(po, "");
		} 
		
		
		return po.getPetLogNo();
	}
	
	@Override
	public void deletePetLogReply(PetLogReplyPO po) {
		int result = petLogDao.deletePetLogReply(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}else {
			PetLogMentionMemberSO plmmSO = new PetLogMentionMemberSO();
			plmmSO.setPetLogNo(po.getPetLogNo());
			plmmSO.setAplyNo(po.getPetLogAplySeq().intValue());
			int mentionResult = petLogDao.deletePetLogReplyMention(plmmSO);
		}
	}
	
	@Override
	public Long insertPetLogRptp(PetLogRptpPO po) {
		
		int result = petLogDao.insertPetLogRptp(po);
		
		if(result > 0) {
			int updateResult;
			if(StringUtil.isNotEmpty(po.getPetLogAplySeq())) {
				PetLogReplyPO rpo = new PetLogReplyPO();
				rpo.setPetLogNo(po.getPetLogNo());
				rpo.setPetLogAplySeq(po.getPetLogAplySeq());
				rpo.setContsStatCd(CommonConstants.CONTS_STAT_30);
				rpo.setUpdateGb("REPORT");
				updateResult = petLogDao.updatePetLogReply(rpo);
			}else{
				PetLogBasePO lpo = new PetLogBasePO();
				lpo.setPetLogNo(po.getPetLogNo());
				lpo.setContsStatCd(CommonConstants.CONTS_STAT_30);
				lpo.setUpdateGb("REPORT");
				updateResult = petLogDao.updatePetLogBase(lpo);
			}
			
			// 신고 횟수가 5회 이상인 경우 비노출 후 sendPush
			if(updateResult == 1) {
				MemberBaseSO mbso = new MemberBaseSO();
				mbso.setMbrNo(po.getMbrNo());
				MemberBaseVO mbvo = Optional.ofNullable(memberService.getMemberBase(mbso)).orElseGet(()->new MemberBaseVO());
				
				PetLogBaseSO plso = new PetLogBaseSO();
				plso.setPetLogNo(po.getPetLogNo());
				PetLogBaseVO petLogDetail = this.getPetLogDetail(plso);

					String tmplCd;
					if(StringUtil.isEmpty(po.getPetLogAplySeq())) {
						tmplCd = CommonConstants.TMPL_PET_LOG_RPTP;
					}else {
						tmplCd = CommonConstants.TMPL_PET_LOG_RPLY_RPTP;
					}
				
					PushSO pso = new PushSO();	
					pso.setTmplNo(Long.valueOf(cacheService.getCodeCache(CommonConstants.TMPL_NO, tmplCd).getUsrDfn1Val()));
					PushVO template = Optional.ofNullable(pushDao.getNoticeTemplate(pso)).orElseGet(()->new PushVO());


					if (StringUtil.isNotBlank(template.getSubject()) && StringUtil.isNotBlank(template.getContents())) {
						List<PushTargetPO> ptpoList = new ArrayList<>();
						PushTargetPO ptpo = new PushTargetPO();

						ptpo.setTo(petLogDetail.getMbrNo().toString());
						ptpo.setImage(template.getImgPath());
						ptpo.setLandingUrl(template.getMovPath());

						Map<String,String> map =new HashMap<String, String>();
						map.put("nick_nm", petLogDetail.getNickNm());
						ptpo.setParameters(map);
						ptpoList.add(ptpo);

						SendPushPO sppo = new SendPushPO();
						sppo.setTitle(template.getSubject());
						sppo.setMessageType("NOTIF");
						sppo.setType("USER");
						sppo.setTmplNo(pso.getTmplNo());
						sppo.setTarget(ptpoList);

//						if (StringUtil.isNotEmpty(mbvo.getDeviceTpCd())) {
//							if (mbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_10)) {
//								sppo.setDeviceType("GCM");
//							} else if (mbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_20)) {
//								sppo.setDeviceType("APNS");
//							}
//						}

						String noticeSendNo = bizService.sendPush(sppo);

						if (StringUtil.equals(noticeSendNo, null)) {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
					}
				}
		}
		
		return po.getPetLogNo();
	}
	
	@Override
	public int insertPetLogInterest(PetLogInterestPO po) {
		
		int result = petLogDao.insertPetLogInterest(po);
		
		if(result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}else {
			if(StringUtil.equals(po.getIntsGbCd() , CommonConstants.INTR_GB_10)) {
			MemberBaseSO mbso = new MemberBaseSO();
			mbso.setMbrNo(po.getMbrNo());
			MemberBaseVO mbvo = Optional.ofNullable(memberService.getMemberBase(mbso)).orElseGet(()->new MemberBaseVO());
		
			PetLogBaseSO plso = new PetLogBaseSO();
			plso.setPetLogNo(po.getPetLogNo());
			PetLogBaseSO gFpSo = new PetLogBaseSO();
			gFpSo.setPetLogNo(po.getPetLogNo());
			gFpSo.setMbrNo(po.getMbrNo());
			PetLogBaseSO getPetLogFlag = petLogDao.getPetLogFlag(gFpSo);
			PetLogBaseVO petLogDetail = this.getPetLogDetail(plso);
			
			log.info("---------------------mbvo.mbrNo : " + mbvo.getMbrNo());
			
				if(getPetLogFlag == null) {
					PushSO pso = new PushSO();
					pso.setTmplNo(Long.valueOf(cacheService.getCodeCache(CommonConstants.TMPL_NO, CommonConstants.TMPL_PET_LOG_LIKE).getUsrDfn1Val()));
					PushVO template = Optional.ofNullable(pushDao.getNoticeTemplate(pso)).orElseGet(()->new PushVO());


					if (StringUtil.isNotBlank(template.getSubject()) && StringUtil.isNotBlank(template.getContents())) {
						List<PushTargetPO> ptpoList = new ArrayList<>();
						PushTargetPO ptpo = new PushTargetPO();

						ptpo.setTo(petLogDetail.getMbrNo().toString());
						ptpo.setImage(template.getImgPath());
						ptpo.setLandingUrl(template.getMovPath() + "&petLogNo=" + po.getPetLogNo());

						Map<String,String> map =new HashMap<String, String>();
						map.put("nick_nm", mbvo.getNickNm());
						ptpo.setParameters(map);
						ptpoList.add(ptpo);

						SendPushPO sppo = new SendPushPO();
						sppo.setTitle(template.getSubject());
						sppo.setMessageType("NOTIF");
						sppo.setType("USER");
						sppo.setTmplNo(pso.getTmplNo());
						sppo.setTarget(ptpoList);

//						if (StringUtil.isNotEmpty(mbvo.getDeviceTpCd())) {
//							if (mbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_10)) {
//								sppo.setDeviceType("GCM");
//							} else if (mbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_20)) {
//								sppo.setDeviceType("APNS");
//							}
//						}

						String noticeSendNo = bizService.sendPush(sppo);

						if (StringUtil.equals(noticeSendNo, null)) {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
					}
				}

				//펫 로그 좋아요 카운트가 펫로그 카운트 건수 넘을시 단,펫로그 게시글 등록자가 GS 포인트연동 되어있어야함 ,, 좋아요 1개에 총 5~6개 트랜잭션,,,과연 성능이,,?
				MemberBaseSO oso = new MemberBaseSO();
				oso.setMbrNo(petLogDetail.getMbrNo());
				MemberBaseVO owner = memberBaseDao.getMemberBase(oso);
				String gsptNo = Optional.ofNullable(owner.getGsptNo()).orElseGet(()->"");

				if(StringUtil.isNotEmpty(gsptNo)){
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

					//오늘이 기간에 포함되면
					if(isPeriod){
						//STEP 1 : 펫로그 카운트 수 가져오기
						PetLogInterestPO po1 = new PetLogInterestPO();
						po1.setPetLogNo(po.getPetLogNo());
						int likeCnt =  getPetLogInterestCount(po1);
						
						//보상 가져오기
						CodeDetailVO cntLimit = gsrService.getCodeDetailVO(CommonConstants.VARIABLE_CONSTANTS,CommonConstants.VARIABLE_CONSTATNS_PET_LOG_LIKE_PNT);
						if(StringUtil.equals(cntLimit.getUseYn(),CommonConstants.COMM_YN_Y)
								&& StringUtil.equals(Optional.ofNullable(cntLimit.getSysDelYn()).orElseGet(()->CommonConstants.COMM_YN_N),CommonConstants.COMM_YN_N)){
							Long petLogNo = po.getPetLogNo();
							//사용자정의 내림차순정렬 리스트(5,4,3,2,1)
							List<String> limitArr = getLikeRewardCntArr(cntLimit);

							Boolean isAccumed = false;
							int size = limitArr.size();
							//2021.07.12 기준, 3번째 혜택 부터 체크
							for(int i=0; i<size; i+=1){
								String usrDfnVal = limitArr.get(i);

								String[] limitCntArr = usrDfnVal.split(";");
								Integer rewardLikeCnt = Integer.parseInt(limitCntArr[0]);
								if(likeCnt >= rewardLikeCnt){
									GsrLnkMapSO so = new GsrLnkMapSO();
									so.setPetLogNo(petLogNo);
									Integer accumedCnt = gsrService.getRcptNoCnt(so);
									Integer n = i+1;

									//지급 조건 만족 시
									if(accumedCnt == (size - n)){
										String rewardPoint = limitCntArr[1].trim();
										GsrMemberPointPO ppo = new GsrMemberPointPO();
										ppo.setPntRsnCd(CommonConstants.PNT_RSN_REVIEW);
										ppo.setRcptNo(String.valueOf(petLogNo));
										ppo.setPoint(rewardPoint);
										ppo.setCustNo(gsptNo);
										ppo.setSaleAmt(String.valueOf(0));
										ppo.setSaleDate(DateUtil.getNowDate());
										ppo.setSaleEndDt(DateUtil.getNowDateTime().substring(11).replace(":", ""));
										GsrMemberPointVO gmpvo = gsrService.petLogPotinAccumtByCount(ppo);
										if(StringUtil.isNotEmpty(Optional.ofNullable(gmpvo.getApprNo()).orElseGet(()->""))){
											isAccumed = true;

											// GS포인트 이력 저장
											OrdSavePntPO pntPO = new OrdSavePntPO();
											pntPO.setSaveUseGbCd(CommonConstants.SAVE_USE_GB_10); // 적립
											pntPO.setDealGbCd(CommonConstants.DEAL_GB_40);		  // 좋아요
											pntPO.setMbrNo(owner.getMbrNo());
											pntPO.setGspntNo(gsptNo);
											pntPO.setPnt((StringUtil.isNotBlank(rewardPoint))?Integer.valueOf(rewardPoint):0);
											pntPO.setDealNo(gmpvo.getApprNo());
											pntPO.setDealDtm(new Timestamp(System.currentTimeMillis()));
											pntPO.setSysRegrNo(owner.getMbrNo());
											ordSavePntDao.insertGsPntHist(pntPO);
										}
									}
								}
								if(isAccumed){
									break;
								}
							}
						}
					}
				}
			}
		}
		return result;
	}

	private List<String> getLikeRewardCntArr(CodeDetailVO cntLimit){
		String[] limitArr = { cntLimit.getUsrDfn5Val(),cntLimit.getUsrDfn4Val(),cntLimit.getUsrDfn3Val(),cntLimit.getUsrDfn2Val(),cntLimit.getUsrDfn1Val() };
		return Arrays.asList(limitArr).stream().filter(v->StringUtil.isNotEmpty(v)).collect(Collectors.toList());
	}

	@Override
	public int deletePetLogInterest(PetLogInterestPO po) {
		int result = petLogDao.deletePetLogInterest(po);
		
		return result;
	}
	
	@Override
	public Long insertPetLogShare(PetLogSharePO po) {
		petLogDao.insertPetLogShare(po);
		
		return po.getPetLogNo();
	}
	
	@Override
	public PetLogMemberVO getMbrBaseInfo(PetLogMemberSO so) {
		PetLogMemberVO pvo = petLogDao.getMbrBaseInfo(so);	
		return pvo;
	}
	
	
	private List<PetLogBaseVO> getPetLogRecommendList (PetLogListSO lso, List<PetLogBaseVO> petLogList, int listCnt){
		int cornCnt = listCnt;
		boolean chkDup = false;

		if( listCnt == 0 ) return petLogList; // 다른 파트에서 호출.
		//List<PetLogBaseVO> likePetLogList = petLogDao.listLikePetLogByDispCorn(lso );

		if( petLogList.size() < cornCnt ) {					
			if( petLogList.size() > 0 ) {chkDup = true;}
			
			Map<String,String> requestParam = new HashMap<String,String>();
	        requestParam.put("INDEX","LOG");
	        requestParam.put("TARGET_INDEX","log-optimal");
	        requestParam.put("MBR_NO", String.valueOf(lso.getLoginMbrNo())); 
	        requestParam.put("FROM", String.valueOf(lso.getRecommendPage()));
	        requestParam.put("SIZE", String.valueOf(cornCnt)); 	
	        
	        try {
	        
		        String res = searchApiClient.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
		        if(res != null) {
		        	ObjectMapper objectMapper = new ObjectMapper();
		        	Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
		        	Map<String, Object> statusMap = (Map)resMap.get("STATUS");
		        	if( ((Integer)statusMap.get("CODE")).equals(200) ) {
		        		Map<String, Object> dataMap = (Map)resMap.get("DATA");
	        		
		        		if( (int)dataMap.get("TOTAL") > 0 ) {
		        			List<Map<String, Object>> items = (List)dataMap.get("ITEM");
		        			for(Map<String, Object> item : items ) {
		        				PetLogBaseVO vo;
		        				List<String> followTagNm = null ;
		        				log.info("===========================");
		        				log.info("=======================serachAPIitem : " + item);
		        				log.info("===========================");
		        				long petLogNo = Long.valueOf((Integer)item.get("PET_LOG_NO"));
		        				// 중복체크
		        				if(chkDup) {
		        					
		        					for(PetLogBaseVO pvo : petLogList ) {
		        						if( petLogNo == pvo.getPetLogNo()) {
		        							petLogNo = 0L;
		        							break;
		        						}
		        					}
		        				}		        				
		        				if( petLogNo == 0L ) continue;
		        				
		        				//System.out.println("검색-like:"+item.get("RATE"));
		        				vo = new PetLogBaseVO();
		        				vo.setPetLogNo(Long.valueOf((Integer)item.get("PET_LOG_NO")));
		        				vo.setRate((String)item.get("RATE"));
		        				vo.setMbrNo(Long.valueOf((int)item.get("MBR_NO")));
		        				vo.setNickNm((String)item.get("NICK_NM"));
		        				vo.setPrflImg((String)item.get("PRFL_IMG"));
		        				vo.setPetLogUrl((String)item.get("PET_LOG_URL")); 
		        				vo.setDscrt((String)item.get("DSCRT"));	
		        				vo.setImgPath1((String)item.get("IMG_PATH1"));
		        				vo.setVdPath((String)item.get("VD_PATH"));	
		        				vo.setSrtPath((String)item.get("SRT_PATH"));
		        				vo.setRvwYn((String)item.get("RVW_YN"));
		        				vo.setGoodsRcomYn((String)item.get("GOODS_RCOM_YN"));
		        				vo.setEncCpltYn("Y");
		        				
		        				StringBuilder imgPathAll = new StringBuilder();
		        				if( !StringUtil.isEmpty((String)item.get("IMG_PATH1")) ) {
		        					imgPathAll.append((String)item.get("IMG_PATH1"));
		        				}
		        				if( !StringUtil.isEmpty((String)item.get("IMG_PATH2")) ) {
		        					imgPathAll.append("|");
		        					imgPathAll.append((String)item.get("IMG_PATH2"));
		        				}
		        				if( !StringUtil.isEmpty((String)item.get("IMG_PATH3")) ) {
		        					imgPathAll.append("|");
		        					imgPathAll.append((String)item.get("IMG_PATH3"));
		        				}
		        				if( !StringUtil.isEmpty((String)item.get("IMG_PATH4")) ) {
		        					imgPathAll.append("|");
		        					imgPathAll.append((String)item.get("IMG_PATH4"));
		        				}
		        				if( !StringUtil.isEmpty((String)item.get("IMG_PATH5")) ) {
		        					imgPathAll.append("|");
		        					imgPathAll.append((String)item.get("IMG_PATH5"));
		        				}
		        				vo.setImgPathAll(imgPathAll.toString());
		        				
		        				// 좋아요 게시물 목록에서만 조회한다.
		        				if( lso.getListType() != null &&  lso.getListType().equals("L")) {
			        				//LIKE_CNT
			        				PetLogInterestPO ipo = new PetLogInterestPO();
			        				ipo.setIntsGbCd(CommonConstants.INTR_GB_10);
			        				ipo.setPetLogNo(vo.getPetLogNo());		        				
			        				vo.setLikeCnt(petLogDao.getPetLogInterestCount(ipo));
			        				
			        				//BOOKMARK_CNT
			        				ipo.setIntsGbCd(CommonConstants.INTR_GB_20);
			        				ipo.setPetLogNo(vo.getPetLogNo());		        				
			        				vo.setBookmarkCnt(petLogDao.getPetLogInterestCount(ipo));
			        				
			        				//REPLY_CNT
			        				PetLogReplyPO rpo = new PetLogReplyPO();
			        				rpo.setPetLogNo(vo.getPetLogNo());	
			        				vo.setReplyCnt(petLogDao.getPetLogReplyCount(rpo));
			        				
			        				// 로그인 한 경우.
			        				if( lso.getLoginMbrNo() != 0 ) {
			        					// 찜 여부
				        				ipo.setMbrNo(lso.getLoginMbrNo());	
				        				String interestYn = "N";
				        				if( petLogDao.getPetLogInterestCount(ipo) > 0 ) {interestYn = "Y";}
				        				vo.setBookmarkYn(interestYn);
				        				
				        				// 좋아요 여부
				        				ipo.setIntsGbCd(CommonConstants.INTR_GB_10);
				        				interestYn = "N";
				        				if( petLogDao.getPetLogInterestCount(ipo) > 0 ) {interestYn = "Y";}
				        				vo.setLikeYn(interestYn);			        					
			        					
				        				//게시글 신고 여부			        					
				        				PetLogRptpPO ppo = new PetLogRptpPO();
				        				ppo.setMbrNo(lso.getLoginMbrNo());
				        				ppo.setPetLogNo(vo.getPetLogNo());
				        				vo.setRptpYn(petLogDao.isPetLogReport(ppo));
				        				
				        				
				        				//내가 팔로우한 태그명
				        				//2021-06-24 인기 게시물은 비 로그인시에만 조회하므로 주석처리
//				        				PetLogBaseSO petSo = new PetLogBaseSO();
//				        				petSo.setMbrNo(lso.getLoginMbrNo());
//				        				petSo.setExcludeMbrNo(Long.valueOf((int)item.get("MBR_NO")));
//				        				petSo.setPetLogNo(Long.valueOf((Integer)item.get("PET_LOG_NO")));
//				        				followTagNm = petLogDao.getFollowTagNm(petSo) ;
//				        				if(followTagNm.size() > 0 && lso.getLoginMbrNo() != petSo.getExcludeMbrNo() ) {
//				        					vo.setPetLogFollowTagNm(followTagNm);
//			        						vo.setPetLogType("T");
//				        				}else {
//				        					vo.setPetLogType("");
//				        				}
			        				}
			        				
			        				if( !StringUtil.isEmpty(item.get("SYS_REG_DTM"))) {
			        					vo.setSysRegDtm(DateUtil.getTimestamp((String)item.get("SYS_REG_DTM"),CommonConstants.COMMON_DATE_FORMAT));
			        				}
		        				}
		        				petLogList.add(vo);
		        				// 검색을 2배수로 가져오기 때문에 
		        				if(petLogList.size() == cornCnt) break;
		        			}
		        		}
		        	}
				}
	        }catch(Exception e) {
	        	log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
	        }
		}
		
		// 게시물 리스트 일때만 적용
		if( lso.getListType() != null &&  lso.getListType().equals("L")) {
			
			
			// 위치정보 복호화
			for(PetLogBaseVO pvo : petLogList ) {
				
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
				
			}		
			
		}			
	

		
		return petLogList;
	}
	@Override
	public List<DisplayCornerTotalVO> getPetLogHomeByDispCorn(Long dispClsfNo, PetLogListSO lso){
		if (lso == null) {
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}
		
		List<DisplayCornerTotalVO> cornTotalList = new ArrayList<>();
		// 1. 전시번호에 해당하는 코너목록 가져오기
		DisplayCornerSO dso = new DisplayCornerSO();
		dso.setDispClsfNo(dispClsfNo);
		dso.setPreviewDt(lso.getPreviewDt());
		List<DisplayCornerTotalVO> cornList = displayDao.listDisplayClsfCornerDate(dso);
		// 2. 코너 타입별 코너 아이템 조회
		DisplayCornerSO so = new DisplayCornerSO();
		int cornCnt = 0;
		boolean chkDup = false;
		
//		// BO 의 미리보기 시 previewDt 가 들어옴.
//		if( StringUtil.isEmpty(lso.getPreviewDt()) ) {					
//			Timestamp previewDt = DateUtil.getTimestamp(DateUtil.getNowDate(), "yyyyMMdd") ;
//			lso.setPreviewDt(previewDt);
//		}		
		
		
		// 페이징 변경으로 페이지 조건 추가
		// 1.첫번째 페이지는 좋아할만한 펫로그만 조회
		// 2.두번째 페이지 or 페이징 시 이 친구 어때요 조회 
		// 3.세번째 페이지는 인기 # 태그만 조회
		for (DisplayCornerTotalVO corner : cornList) {
			// true 일 경우만, 중복체크한다.(어드민 등록+검색연동 시에만)
			chkDup = false;
			
			if (corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_75) 
					|| corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_20)) {		// 배너(Text Or 이미지)
				
				so.setDispClsfNo(dispClsfNo);
				so.setDispCornNo(corner.getDispCornNo());
				so.setPreviewDt(lso.getPreviewDt());
				List<DisplayBannerVO> bannerList = displayDao.pageDisplayCornerItemBnrFO(so);
				corner.setListBanner(bannerList);
			
			}
			else if (corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_100) && lso.getRecommendPage() == 1) {		// 좋아할만한 펫로그
				cornCnt = 6;
				lso.setDispClsfNo(dispClsfNo);
				lso.setDispCornNo(corner.getDispCornNo());

				//List<PetLogBaseVO> likePetLogList = this.getPetLogLikeList(lso);
				List<PetLogBaseVO> likePetLogList = petLogDao.listLikePetLogByDispCorn(lso );
				likePetLogList = this.getPetLogRecommendList(lso, likePetLogList, cornCnt);
				
				corner.setPetLogList(likePetLogList);
			}
			else if (corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_90) && (lso.getRecommendPage() != 1 && lso.getRecommendPage() != 3)) {		// 이 친구 어때요?
				lso.setDispClsfNo(dispClsfNo);
				lso.setDispCornNo(corner.getDispCornNo());
				
				List<PetLogBaseVO> recMbrPetLogList = new ArrayList<>();
				
					lso.setPage(lso.getBoRecMemberPage());
					lso.setRows(FrontConstants.PAGE_ROWS_1);
					recMbrPetLogList = petLogDao.listRecMbrPetLogByDispCorn(lso );
					if(recMbrPetLogList.size() > 0 ) {
						String excludeRecMbrNo = lso.getExcludeRecMbrNo();
						if(StringUtil.isBlank(excludeRecMbrNo)) {
							lso.setExcludeRecMbrNo(String.valueOf(recMbrPetLogList.get(0).getMbrNo()));
						}else {
							lso.setExcludeRecMbrNo(excludeRecMbrNo + "," + String.valueOf(recMbrPetLogList.get(0).getMbrNo())); 
						}
						lso.setRecYn("N");
					}
				
				cornCnt = 1;			
				if( recMbrPetLogList.size() < cornCnt ) {
					Map<String,String> requestParam = new HashMap<String,String>();
			        requestParam.put("INDEX","LOG");
			        requestParam.put("TARGET_INDEX","log-member");
			        requestParam.put("MBR_NO", String.valueOf(lso.getLoginMbrNo())); 
			        requestParam.put("FROM", String.valueOf(lso.getRecMemberPage()));
			        requestParam.put("SIZE", String.valueOf(cornCnt-recMbrPetLogList.size())); 			        
			        if(StringUtil.isNotBlank(String.valueOf(lso.getExcludeRecMbrNo()))) {
			        	requestParam.put("EXCLUDE_MBR_NO", String.valueOf(lso.getExcludeRecMbrNo())); 		
			        }
			        
			        try {			        
				        String res = searchApiClient.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
				        if(res != null) {
				        	ObjectMapper objectMapper = new ObjectMapper();
				        	Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
				        	Map<String, Object> statusMap = (Map)resMap.get("STATUS");
				        	if( ((Integer)statusMap.get("CODE")).equals(200) ) {
				        		Map<String, Object> dataMap = (Map)resMap.get("DATA");
			        		
				        		if( (int)dataMap.get("TOTAL") > 0 ) {
				        			List<Map<String, Object>> items = (List)dataMap.get("ITEM");
				        			Long recMbrNo = Long.valueOf((Integer)items.get(0).get("MBR_NO"));
				        			PetLogListSO mbrSo = new PetLogListSO();			        			
				        			mbrSo.setRecMbrNo(recMbrNo);
				        			mbrSo.setLoginMbrNo(lso.getLoginMbrNo());
				        			
				        			recMbrPetLogList = petLogDao.listRecMbrPetLogByDispCorn(mbrSo );	
				        			
				        			if( recMbrPetLogList.size() > 0) {
				        				for(PetLogBaseVO plvo : recMbrPetLogList) {
				        					plvo.setRate((String)items.get(0).get("RATE"));
				        				}
//				        				recMbrPetLogList.get(0).setRate((String)items.get(0).get("RATE"));
				        			}
				        		}
				        	}
				        	lso.setRecYn("Y");
						}
			        }catch(Exception e) {
			        	log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			        	//System.out.println("이 친구 어때요? api 오류====" + e.getMessage());
			        }
				}
				corner.setPetLogList(recMbrPetLogList);
			}
			else if(corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_80)) {		// 태그(관리자 태그/인기태그)
				List<String> tagList;
				List<PetLogBaseVO> petLogTagList = new ArrayList<PetLogBaseVO>();
				PetLogListSO tso;
				
			
				if( String.valueOf(corner.getDispCornNo()).equals(webConfig.getProperty("disp.corn.no.petlog.main.tag.poptag"))) { // 인기태그
					if(lso.getRecommendPage() == 3) {
						cornCnt = 6;	
						lso.setDispClsfNo(dispClsfNo);
						lso.setDispCornNo(corner.getDispCornNo());
						//lso.setRows(cornCnt);
						lso.setLimit(0); // 관리자 추천 tag 목록에만 limit 적용
						
						/* 기획변경으로 기존로직 제거 모든데이터 Bo우선 노출
						List<PetBaseVO> petList = new ArrayList<PetBaseVO>();
						Long mbrNo = Optional.ofNullable(lso.getLoginMbrNo()).orElseGet(()->0L);
						//System.out.println("+++++++++++++++++++++++++++");
						//System.out.println("mbrNo1==>"+mbrNo);
						if(mbrNo != 0L) {
							//System.out.println("mbrNo2==>"+mbrNo);
							PetBaseSO pbso = new PetBaseSO();
							pbso.setMbrNo(lso.getLoginMbrNo());
							petList = petService.listPetBase(pbso);
						}
						
						
						// 비회원 or 반려동물이 등록 되지 않은 회원 일 경우
						if(!StringUtil.isEmpty(petList)) {
							//tagList = petLogDao.listTagNoByDispCorn(lso);
							lso.setLimit(10); // 최대 10개
							tagList = petLogDao.listadminRecTag(lso);
						}else {
							tagList = new ArrayList<String>();
						}
						*/
						/* 모든 조건에서 BO 우선 노출 */
						lso.setLimit(10); // 최대 10개
						tagList = petLogDao.listadminRecTag(lso);
						
						// BO 에서 6개를 충당 못할경우를 대비 
						tagList = getTagNameBySearchAPI(String.valueOf(lso.getLoginMbrNo()), tagList);
						for(String tag : tagList) {
							tso = new PetLogListSO();
				        	tso.setSidx("LIKE_CNT");
				        	tso.setSord(lso.getSord());
				        	tso.setTag(tag);
				        	/* 노출여부 상관없이 BO 등록된거 무조건 
				    		tso.setContsStatCd(CommonConstants.PETLOG_DISP_GB_10); //노출.
				    		*/
				    		PetLogBaseVO plvo = petLogDao.getPopularTagNm(tso);
				    		if(plvo != null) {
				    			petLogTagList.add(plvo);
				    		}
				    		if(petLogTagList.size() == 6) {
				    			break;
				    		}
						}
						corner.setPetLogList(petLogTagList);	
					}
					}else {
						if(lso.getRecommendPage() == 1) {
						//만들기 바텀 sheet 만들기 태그
						lso.setDispClsfNo(dispClsfNo);
						lso.setDispCornNo(corner.getDispCornNo());
						lso.setLimit(10); // 최대 10개
						/* 기존 쿼리 주석처리 05-10 rshoo79
							tagList = petLogDao.listTagNoByDispCorn(lso );
						 */
						tagList = petLogDao.listadminRecTag(lso);
						corner.setTagList(tagList);
						}
					}
				}	
			
			cornTotalList.add(corner);
		}

		return cornTotalList;
	}
	
	
	@Override
	@Transactional(readOnly=true)
	public List<String> listTagNoByDispCorn (PetLogListSO so ){
		return petLogDao.listTagNoByDispCorn(so );
	}
	@Override
	@Transactional(readOnly=true)
	public String getBannerTextByDispCorn (DisplayCornerSO so ) {
		String bannerTxt = null;
		List<DisplayBannerVO> bannerList = displayDao.pageDisplayCornerItemBnrFO(so);
		if( !bannerList.isEmpty()) {
			DisplayBannerVO vo = bannerList.get(0);
			bannerTxt = vo.getBnrText();
		}
		return bannerTxt;
	}

	@Override
	@Transactional(readOnly=true)
	public List<PetLogBaseVO> listFollowPetLog (PetLogListSO so ){
		return petLogDao.listFollowPetLog(so );
	}	

	@Override
	@Deprecated
	@Transactional(readOnly=true)
	public List<PetLogBaseVO> pageFollowPetLog (PetLogListSO so ){
		int cornCnt = so.getRows();
		//boolean chkDup = false;
		List<PetLogBaseVO> list = new ArrayList<PetLogBaseVO>();
		
		//로그인 시 내가 쓴 게시물 , 팔로워 게시물 , 신규 게시물은 DB에서 조회
		/*if( so.getLoginMbrNo() != null && so.getLoginMbrNo() != 0 ) {

			list = petLogDao.pageFollowPetLog(so);			
			//내가 팔로우한 태그명
			for(PetLogBaseVO plso : list) {
				
				PetLogBaseSO petSo = new PetLogBaseSO();
				List<String> followTagNm = null;
				petSo.setMbrNo(so.getLoginMbrNo());
				petSo.setExcludeMbrNo(plso.getMbrNo());
				petSo.setPetLogNo(plso.getPetLogNo());
				followTagNm = petLogDao.getFollowTagNm(petSo) ;
				if(followTagNm.size() > 0 && plso.getMbrNo() != so.getLoginMbrNo()) {
					plso.setPetLogFollowTagNm(followTagNm);
					plso.setPetLogType("T");
				}else {
					plso.setPetLogType("");
				}
			}
		//비 로그인일 시 검색 API에서 인기 게시물 조회
		}else {
			so.setListType("L");
			this.getPetLogRecommendList(so, list, cornCnt);	
		}*/
		return list;
	}	
	
	@Override
	@Transactional(readOnly=true)
	public List<PetLogBaseVO> pageTagPetLog (PetLogListSO so) {
		return petLogDao.pageTagPetLog(so );
	}
	
	@Override
	@Transactional(readOnly=true)
	public int getPetLogInterestCount(PetLogInterestPO po) {
		return petLogDao.getPetLogInterestCount(po);
	}

	@Override
	public int insertFollowMapMember(FollowMapPO po) {
		int result = petLogDao.insertFollowMapMember(po);
		if(result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}else {
			MemberBaseSO mbso = new MemberBaseSO();
			mbso.setMbrNo(po.getMbrNo());
			MemberBaseVO mbvo = Optional.ofNullable(memberService.getMemberBase(mbso)).orElseGet(()->new MemberBaseVO());
		
			PushSO pso = new PushSO();	
			pso.setTmplNo(Long.valueOf(cacheService.getCodeCache(CommonConstants.TMPL_NO, CommonConstants.TMPL_PET_LOG_FOLLOW).getUsrDfn1Val()));
			PushVO template = Optional.ofNullable(pushDao.getNoticeTemplate(pso)).orElseGet(()->new PushVO());
			
			if (StringUtil.isNotBlank(template.getSubject()) && StringUtil.isNotBlank(template.getContents())) {
				List<PushTargetPO> ptpoList = new ArrayList<>();
				PushTargetPO ptpo = new PushTargetPO();

				ptpo.setTo(po.getMbrNoFollowed().toString());
				ptpo.setImage(template.getImgPath());
				ptpo.setLandingUrl(StringUtil.replaceAll(template.getMovPath(), CommonConstants.PUSH_TMPL_VRBL_360, mbvo.getPetLogUrl()) + "&mbrNo=" + po.getMbrNo());

				Map<String,String> map =new HashMap<String, String>();
				map.put("nick_nm", mbvo.getNickNm());
				ptpo.setParameters(map);
				ptpoList.add(ptpo);

				SendPushPO sppo = new SendPushPO();
				sppo.setTitle(template.getSubject());
				sppo.setMessageType("NOTIF");
				sppo.setType("USER");
				sppo.setTmplNo(pso.getTmplNo());
				sppo.setTarget(ptpoList);

//				if (StringUtil.isNotEmpty(mbvo.getDeviceTpCd())) {
//					if (mbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_10)) {
//						sppo.setDeviceType("GCM");
//					} else if (mbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_20)) {
//						sppo.setDeviceType("APNS");
//					}
//				}

				String noticeSendNo = bizService.sendPush(sppo);

				if (StringUtil.equals(noticeSendNo, null)) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
		
		return result;
	}
	
	@Override
	public int deleteFollowMapMember(FollowMapPO po) {
		int result = petLogDao.deleteFollowMapMember(po);
		
		return result;
	}
	
	@Override
	public int insertFollowMapTag(FollowMapPO po) {
		int result = petLogDao.insertFollowMapTag(po);
		if(result != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		return result;
	}
	
	@Override
	public int deleteFollowMapTag(FollowMapPO po) {
		int result = petLogDao.deleteFollowMapTag(po);
		if(result != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		return result;
	}
	
	@Override
	@Transactional(readOnly=true)
	public String isFollowMapMember(FollowMapPO po) {
		return petLogDao.isFollowMapMember(po);
	}
	
	@Override
	@Transactional(readOnly=true)
	public String isFollowMapTag(FollowMapPO po) {
		return petLogDao.isFollowMapTag(po);
	}	

	@Override
	@Transactional(readOnly=true)
	public List<PetLogMemberVO> listMyFollower (PetLogListSO so ){
		return petLogDao.listMyFollower(so );
	}	

	@Override
	@Transactional(readOnly=true)
	public List<FollowMapVO> listMyFollowing(PetLogListSO so ){
		return petLogDao.listMyFollowing(so );
	}
		
	@Override
	@Transactional(readOnly=true)
	public int getMyFollowerCnt(PetLogListSO po) {
		return petLogDao.getMyFollowerCnt(po);
	}	
	
	@Override
	@Transactional(readOnly=true)
	public int getMyFollowingCnt(PetLogListSO po) {
		return petLogDao.getMyFollowingCnt(po);
	}
	
	
	@Override
	public void updateMemberBase(MemberBasePO po) {
		
		// APP 이 아닌 경우 -  파일 업로드 해야함.
		if( !StringUtil.isEmpty(po.getPrflImg()) && po.getPrflImg().startsWith(bizConfig.getProperty("common.file.upload.base"))) { 
			FtpImgUtil ftpImgUtil = new FtpImgUtil();
			String filePath = ftpImgUtil.uploadFilePath(po.getPrflImg(), CommonConstants.PET_LOG_IMAGE_PATH + FileUtil.SEPARATOR + po.getMbrNo()+ FileUtil.SEPARATOR + "profile");
			ftpImgUtil.upload(po.getPrflImg(), filePath);
			po.setPrflImg(filePath);
		}
		
		if(petLogDao.updateMemberBase(po) == 0){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}	
	
//	private List<Map<String, Object>> getSearchApiResponse(Map<String,String> requestParam){
//		try{	
//			List<Map<String, Object>> items  = null;
//			
//		String res = searchApiClient.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
//        if(res != null) {
//        	ObjectMapper objectMapper = new ObjectMapper();
//        	Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
//        	Map<String, Object> statusMap = (Map)resMap.get("STATUS");
//        	if( ((Integer)statusMap.get("CODE")).equals(200) ) {
//        		Map<String, Object> dataMap = (Map)resMap.get("DATA");
//    		
//        		if( (int)dataMap.get("TOTAL") > 0 ) {
//        			items = new ArrayList<Map<String, Object>>();
//        			items = (List)dataMap.get("ITEM");
//        			return items;
//        		}
//        	}
//		}
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
//	}
	
	private List<String> getTagNameBySearchAPI(String mbrNo , List<String> tagList){
		Map<String,String> requestParam = new HashMap<String,String>();
        requestParam.put("INDEX","LOG");
        requestParam.put("TARGET_INDEX","log-tag"); // TODO : log-tag 로 변경해야함.
        requestParam.put("MBR_NO", mbrNo); 
        requestParam.put("FROM", "1"); 
        requestParam.put("SIZE", String.valueOf(50)); 			
        try {
	        String res = searchApiClient.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
	        if(res != null) {
	        	ObjectMapper objectMapper = new ObjectMapper();
	        	Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
	        	Map<String, Object> statusMap = (Map)resMap.get("STATUS");
	        	if( ((Integer)statusMap.get("CODE")).equals(200) ) {
	        		Map<String, Object> dataMap = (Map)resMap.get("DATA");
        		
	        		if( (int)dataMap.get("TOTAL") > 0 ) {
	        			List<Map<String, String>> items = (List)dataMap.get("ITEM");
	        			
	        			for( Map<String, String> item : items) {
	        				if(!tagList.contains(item.get("TAG"))) {
	        					tagList.add(item.get("TAG"));
	        				}
	        				
	        			}
	        		}
	        	}
			}					        
        }catch(Exception e) {
        	log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
        }
    	return tagList;
	}
	
	
	@Override
	public List<MemberBaseVO> getNickNameList(String nickNm) {
		return petLogDao.getNickNameList(nickNm);
	}
	
	@Override
	public List<PetLogBaseVO> pagePetLogRecommend (PetLogListSO lso){		
		Map<String,String> requestParam = new HashMap<String,String>();
        requestParam.put("INDEX","LOG");
        requestParam.put("TARGET_INDEX","log-like");
        requestParam.put("MBR_NO", String.valueOf(lso.getLoginMbrNo())); 
        requestParam.put("FROM", String.valueOf(lso.getPage()));
        requestParam.put("SIZE", String.valueOf(lso.getRows())); 			
//        requestParam.put("EXCLUDE_LOGS", lso.getExcludeLogNo()); 	
        
        List<PetLogBaseVO> petLogList = new ArrayList<PetLogBaseVO>() ;
        try {
	        
	        String res = searchApiClient.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
	        System.out.println("res=====>"+res.toString());
	        if(res != null) {
	        	ObjectMapper objectMapper = new ObjectMapper();
	        	Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
	        	Map<String, Object> statusMap = (Map)resMap.get("STATUS");
	        	if( ((Integer)statusMap.get("CODE")).equals(200) ) {
	        		Map<String, Object> dataMap = (Map)resMap.get("DATA");
        		
	        		if( (int)dataMap.get("TOTAL") > 0 ) {
	        			List<Map<String, Object>> items = (List)dataMap.get("ITEM");
	        			for(Map<String, Object> item : items ) {
	        				PetLogBaseVO vo;
	        				
	        				//System.out.println("검색-like:"+item.get("RATE"));
	        				vo = new PetLogBaseVO();
	        				vo.setPetLogNo(Long.valueOf((Integer)item.get("PET_LOG_NO")));
	        				vo.setRate((String)item.get("RATE"));
	        				vo.setMbrNo(Long.valueOf((int)item.get("MBR_NO")));
	        				vo.setNickNm((String)item.get("NICK_NM"));
	        				vo.setPrflImg((String)item.get("PRFL_IMG"));
	        				vo.setPetLogUrl((String)item.get("PET_LOG_URL")); 
	        				vo.setDscrt((String)item.get("DSCRT"));	
	        				vo.setImgPath1((String)item.get("IMG_PATH1"));
	        				vo.setVdPath((String)item.get("VD_PATH"));	
	        				vo.setSrtPath((String)item.get("SRT_PATH"));	
	        				vo.setEncCpltYn("Y");
	        				
	        				StringBuilder imgPathAll = new StringBuilder();
	        				if( !StringUtil.isEmpty((String)item.get("IMG_PATH1")) ) {
	        					imgPathAll.append((String)item.get("IMG_PATH1"));
	        				}
	        				if( !StringUtil.isEmpty((String)item.get("IMG_PATH2")) ) {
	        					imgPathAll.append("|");
	        					imgPathAll.append((String)item.get("IMG_PATH2"));
	        				}
	        				if( !StringUtil.isEmpty((String)item.get("IMG_PATH3")) ) {
	        					imgPathAll.append("|");
	        					imgPathAll.append((String)item.get("IMG_PATH3"));
	        				}
	        				if( !StringUtil.isEmpty((String)item.get("IMG_PATH4")) ) {
	        					imgPathAll.append("|");
	        					imgPathAll.append((String)item.get("IMG_PATH4"));
	        				}
	        				if( !StringUtil.isEmpty((String)item.get("IMG_PATH5")) ) {
	        					imgPathAll.append("|");
	        					imgPathAll.append((String)item.get("IMG_PATH5"));
	        				}
	        				vo.setImgPathAll(imgPathAll.toString());
	        				
	        				// 게시물 목록에서만 조회한다.
	        				if( lso.getListType() != null &&  lso.getListType().equals("L")) {
		        				//LIKE_CNT
		        				PetLogInterestPO ipo = new PetLogInterestPO();
		        				ipo.setIntsGbCd(CommonConstants.INTR_GB_10);
		        				ipo.setPetLogNo(vo.getPetLogNo());		        				
		        				vo.setLikeCnt(petLogDao.getPetLogInterestCount(ipo));
		        				
		        				//BOOKMARK_CNT
		        				ipo.setIntsGbCd(CommonConstants.INTR_GB_20);
		        				ipo.setPetLogNo(vo.getPetLogNo());		        				
		        				vo.setBookmarkCnt(petLogDao.getPetLogInterestCount(ipo));
		        				
		        				//REPLY_CNT
		        				PetLogReplyPO rpo = new PetLogReplyPO();
		        				rpo.setPetLogNo(vo.getPetLogNo());	
		        				vo.setReplyCnt(petLogDao.getPetLogReplyCount(rpo));
		        				
		        				// 로그인 한 경우.
		        				if( lso.getLoginMbrNo() != 0 ) {
		        					// 찜 여부
			        				ipo.setMbrNo(lso.getLoginMbrNo());	
			        				String interestYn = "N";
			        				if( petLogDao.getPetLogInterestCount(ipo) > 0 ) interestYn = "Y";
			        				vo.setBookmarkYn(interestYn);
			        				
			        				// 좋아요 여부
			        				ipo.setIntsGbCd(CommonConstants.INTR_GB_10);
			        				interestYn = "N";
			        				if( petLogDao.getPetLogInterestCount(ipo) > 0 ) interestYn = "Y";
			        				vo.setLikeYn(interestYn);			        					
		        					
			        				//게시글 신고 여부			        					
			        				PetLogRptpPO ppo = new PetLogRptpPO();
			        				ppo.setMbrNo(lso.getLoginMbrNo());
			        				ppo.setPetLogNo(vo.getPetLogNo());
			        				vo.setRptpYn(petLogDao.isPetLogReport(ppo));
			        				
			        				//내가 팔로우한 태그명
			        				PetLogBaseSO petSo = new PetLogBaseSO();
			        				petSo.setMbrNo(lso.getLoginMbrNo());
			        				petSo.setExcludeMbrNo(Long.valueOf((int)item.get("MBR_NO")));
			        				petSo.setPetLogNo(Long.valueOf((Integer)item.get("PET_LOG_NO")));			        				
			        				String followTagNm = petLogDao.getFollowTagNm(petSo) ;
			        				if(StringUtil.isNotBlank(followTagNm) && lso.getLoginMbrNo() != petSo.getExcludeMbrNo() ) {
			        					vo.setFollowTagNm(followTagNm);
		        						vo.setPetLogType("T");
			        				}else {
			        					vo.setPetLogType("");
			        				}
		        				}
		        				
		        				if( !StringUtil.isEmpty(item.get("SYS_REG_DTM"))) {
		        					vo.setSysRegDtm(DateUtil.getTimestamp((String)item.get("SYS_REG_DTM"),CommonConstants.COMMON_DATE_FORMAT));
		        				}
		        				
	        				}    
	        				petLogList.add(vo);
	        					
	        			}
	        		}
	        	}
			}
        }catch(Exception e) {
        	log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
        }
    
        
        return petLogList;
	}
	
	
	
	@Override
	public List<PetLogBaseVO> getListRecMbrPetLogByDispCorn(PetLogListSO lso){
		// 이 친구 어때요?
		List<PetLogBaseVO> recMbrPetLogList = new ArrayList<>();
			
		Map<String,String> requestParam = new HashMap<String,String>();
        requestParam.put("INDEX","LOG");
        requestParam.put("TARGET_INDEX","log-member");
        requestParam.put("MBR_NO", String.valueOf(lso.getLoginMbrNo())); 
        requestParam.put("FROM", String.valueOf(lso.getPage())); 
        requestParam.put("SIZE", "1"); 			        
        
        try {			        
	        String res = searchApiClient.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
	        if(res != null) {
	        	ObjectMapper objectMapper = new ObjectMapper();
	        	Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
	        	Map<String, Object> statusMap = (Map)resMap.get("STATUS");
	        	if( ((Integer)statusMap.get("CODE")).equals(200) ) {
	        		Map<String, Object> dataMap = (Map)resMap.get("DATA");
        		
	        		if( (int)dataMap.get("TOTAL") > 0 ) {
	        			List<Map<String, Object>> items = (List)dataMap.get("ITEM");
	        			Long recMbrNo = Long.valueOf((Integer)items.get(0).get("MBR_NO"));
	        			PetLogListSO mbrSo = new PetLogListSO();			        			
	        			mbrSo.setRecMbrNo(recMbrNo);
	        			mbrSo.setLoginMbrNo(lso.getLoginMbrNo());
	        			
	        			recMbrPetLogList = petLogDao.listRecMbrPetLogByDispCorn(mbrSo );	
	        			if( recMbrPetLogList.size() > 0) {
	        				recMbrPetLogList.get(0).setRate((String)items.get(0).get("RATE"));
	        			}
	        		}
	        	}
			}
        }catch(Exception e) {
        	log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
        	//System.out.println("이 친구 어때요? api 오류====" + e.getMessage());
        }	

		return recMbrPetLogList;
	}
	
	@Override
	public List<DisplayCornerTotalVO> getDisplayCornerItemTotalFO(Long dispClsfNo) {
		return petLogDao.listDisplayClsfCorner(dispClsfNo);
	}
	
	public List<DisplayCornerItemVO> listDisplayCornerPetLogMember(PetLogListSO so) {
		return petLogDao.listDisplayCornerPetLogMember(so);
	}	
	
	public List<PetLogBaseVO> listRecMbrPetLog(PetLogListSO so , boolean apiSearchYn) {
		List<PetLogBaseVO> recMbrPetLogList = null;
		if(apiSearchYn) {
			
			Map<String,String> requestParam = new HashMap<String,String>();
	        requestParam.put("INDEX","LOG");
	        requestParam.put("TARGET_INDEX","log-member");
	        requestParam.put("MBR_NO", String.valueOf(so.getLoginMbrNo())); 
	        requestParam.put("FROM", String.valueOf(so.getRecommendPage())); 
	        requestParam.put("SIZE", "1"); 			        
	        
	        try {			        
		        String res = searchApiClient.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
		        if(res != null) {
		        	ObjectMapper objectMapper = new ObjectMapper();
		        	Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
		        	Map<String, Object> statusMap = (Map)resMap.get("STATUS");
		        	if( ((Integer)statusMap.get("CODE")).equals(200) ) {
		        		Map<String, Object> dataMap = (Map)resMap.get("DATA");
	        		
		        		if( (int)dataMap.get("TOTAL") > 0 ) {
		        			List<Map<String, Object>> items = (List)dataMap.get("ITEM");
		        			Long recMbrNo = Long.valueOf((Integer)items.get(0).get("MBR_NO"));
		        			so.setRecMbrNo(recMbrNo);
		        			so.setLoginMbrNo(so.getLoginMbrNo());
		        			
		        			recMbrPetLogList = petLogDao.listRecMbrPetLog(so);	
		        			if( recMbrPetLogList.size() > 0) {
		        				recMbrPetLogList.get(0).setRate((String)items.get(0).get("RATE"));
		        			}
		        		}
		        	}
				}
	        }catch(Exception e) {
	        	log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
	        	//System.out.println("이 친구 어때요? api 오류====" + e.getMessage());
	        }
		}else {
			recMbrPetLogList = petLogDao.listRecMbrPetLog(so);
		}
		
		return  recMbrPetLogList;
	}	
	
	@Override
	public PetLogBaseVO getPetLogDeleteInfo(PetLogBasePO plgPO) {
		return petLogDao.getPetLogDeleteInfo(plgPO);
	}

	public int encCpltYnUpdate(PetLogBasePO po) {
		int result = petLogDao.encCpltYnUpdate(po);
		if(result == 0){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		return result;
	}
	
	public int checkRegPet(Long mbrNo) {
		int result = petLogDao.checkRegPet(mbrNo);
		return result;
	}
	
	
	@Override
	@Transactional(readOnly=true)
	public List<PetLogBaseVO> pagePetLogMainList(PetLogListSO so){
		int cornCnt = so.getRows();
		//boolean chkDup = false;
		List<PetLogBaseVO> list = new ArrayList<PetLogBaseVO>();
		String excludePetLogNo = null;
		int count = petLogDao.pagePetLogMainListCount(so);
		so.setNewPostCheckPage(count % cornCnt == 0 ? count / 5 : (count / 5) + 1);
		
		if(StringUtil.isNotBlank(so.getExcludeLogNo())) {
			so.setSearchExcludeLogNo(so.getExcludeLogNo().split(","));
		}
		
		//로그인 시 내가 쓴 게시물 , 팔로워 게시물 , 신규 게시물을 DB에서 조회(7일 이내 등록건)
		if( so.getLoginMbrNo() != null && so.getLoginMbrNo() != 0 ) {
			// 내가 쓴 게시물 , 팔로워 게시물 조회
			if(so.getNewPostCheckPage() >= so.getPage()) {
				list = petLogDao.pagePetLogMainList(so);
			}
			
			// 내가 쓴 게시물 , 팔로워 게시물이 부족하거나 없을 시 신규 게시물 조회
			if(list.size() < cornCnt) {
				List<PetLogBaseVO> addList = new ArrayList<PetLogBaseVO>();
				so.setPage(so.getNewPostPage());
				// 내가 쓴 게시물 , 팔로워 게시물이 존재하지만 5개가 안될 시
				if(list.size() > 0) {
					so.setRows(FrontConstants.PAGE_ROWS_5 - list.size());
					addList = petLogDao.pageNewPetLogMainList(so);
					for(PetLogBaseVO pvo : addList) {
						//페이징 시 제외할 신규 펫로그 번호
						if(StringUtil.isBlank(excludePetLogNo)) {
							excludePetLogNo = String.valueOf(pvo.getPetLogNo());
						}else {
							excludePetLogNo = excludePetLogNo + "," + String.valueOf(pvo.getPetLogNo());
						}
						so.setExcludeLogNo(excludePetLogNo);
					}
				}else {
					addList = petLogDao.pageNewPetLogMainList(so);
				}
				for(PetLogBaseVO addVo : addList) {
//					addVo.setPetLogType("check");
					addVo.setNewPostYn(CommonConstants.COMM_YN_Y);
					list.add(addVo);
				}
					int newPostCount = petLogDao.pageNewPetLogMainListCount(so);
					so.setNewPostCount(newPostCount);
			}	
			
			//내가 팔로우한 태그명
			for(PetLogBaseVO plso : list) {
				// 태그 팔로잉 게시물만 태그명 조회
				if(StringUtils.equals(plso.getPetLogType() , "CHECK" )) {
					PetLogBaseSO petSo = new PetLogBaseSO();
					petSo.setMbrNo(so.getLoginMbrNo());
					petSo.setExcludeMbrNo(plso.getMbrNo());
					petSo.setPetLogNo(plso.getPetLogNo());
					String followTagNm = petLogDao.getFollowTagNm(petSo) ;
					if(StringUtil.isNotBlank(followTagNm) && plso.getMbrNo() != so.getLoginMbrNo()) {
						plso.setFollowTagNm(followTagNm);
						plso.setPetLogType("T");
					}else {
						plso.setPetLogType("");
					}
				}
				if( StringUtil.isNotEmpty(plso.getLogLitd()) ){	//경도
					plso.setLogLitd(bizService.twoWayDecrypt(plso.getLogLitd()));
				}
				if( StringUtil.isNotEmpty(plso.getLogLttd()) ){	//위도
					plso.setLogLttd(bizService.twoWayDecrypt(plso.getLogLttd()));
				}
				if( StringUtil.isNotEmpty(plso.getPrclAddr()) ){	//지번주소
					plso.setPrclAddr(bizService.twoWayDecrypt(plso.getPrclAddr()));
				}
				if( StringUtil.isNotEmpty(plso.getRoadAddr()) ){	//도로주소
					plso.setRoadAddr(bizService.twoWayDecrypt(plso.getRoadAddr()));
				}
				if( StringUtil.isNotEmpty(plso.getPstNm()) ){	//위치명
					plso.setPstNm(bizService.twoWayDecrypt(plso.getPstNm()));
				}			
			}
			
		//비 로그인일 시 검색 API에서 인기 게시물 조회
		}else {
			so.setListType("L");
			this.getPetLogRecommendList(so, list, cornCnt);	
		}
		return list;
	}	
	
	@Override
	@Transactional(readOnly=true)
	public PetLogBaseVO getPetLogShareInfo(PetLogBaseSO so) {
		PetLogBaseVO vo = petLogDao.getPetLogDetail(so);
			
		if (vo == null) {
			MemberBaseSO mbSO = new MemberBaseSO();
			mbSO.setMbrNo(so.getMbrNo());
			MemberBaseVO mbVO = memberBaseDao.getMemberBase(mbSO);
			
			vo = new PetLogBaseVO();
			vo.setMbrNo(mbVO.getMbrNo());
			vo.setNickNm(mbVO.getNickNm());
			vo.setDscrt("");
			vo.setImgCnt(1);
			vo.setImgPath1("");
		}else {
			
			// 위치정보 복호화
			if( StringUtil.isNotEmpty(vo.getLogLitd()) ){	//경도
				vo.setLogLitd(bizService.twoWayDecrypt(vo.getLogLitd()));
			}
			if( StringUtil.isNotEmpty(vo.getLogLttd()) ){	//위도
				vo.setLogLttd(bizService.twoWayDecrypt(vo.getLogLttd()));
			}
			if( StringUtil.isNotEmpty(vo.getPrclAddr()) ){	//지번주소
				vo.setPrclAddr(bizService.twoWayDecrypt(vo.getPrclAddr()));
			}
			if( StringUtil.isNotEmpty(vo.getRoadAddr()) ){	//도로주소
				vo.setRoadAddr(bizService.twoWayDecrypt(vo.getRoadAddr()));
			}
			if( StringUtil.isNotEmpty(vo.getPstNm()) ){	//위치명
				vo.setPstNm(bizService.twoWayDecrypt(vo.getPstNm()));
			}
		}
		
		return vo;
	}
	
	public void insertPetLogReplyTag(PetLogReplyPO po, String gb) {
		
		// 사용자가 입력한 댓글에 # 로 등록된 태그에 대해서
		// 1. TAG_BASE 에 있으면, USE_CNT 1추가
		// 2.          에 없으면, TAG_BASE 에 TAG 신조어로 등록
		try {
			List<String> tagNmsList = StringUtil.getTags(po.getAply(),"#");
			if( tagNmsList != null && tagNmsList.size() > 0) {
				//중복제거
				List<String> tagNms = tagNmsList.stream().distinct().collect(Collectors.toList());
				
				TagBaseSO tagSo = null;
				TagBaseVO tagVo = null;
				TagBasePO tagPo = null;
				
				for(String tagNm : tagNms) {				
					// 20자까지만 태그로 등록 - 2021.04.20 추가.
					if( tagNm.length() > 20 ) continue;
					
					tagSo = new TagBaseSO();
					tagSo.setTagNm(tagNm);
					tagVo = tagDao.getTagInfo(tagSo);
					if( tagVo != null && tagVo.getTagNo() != null) {
						// 기 등록된 tag 가 있는 경우, USE_CNT+1 로 update
						tagPo = new TagBasePO();
						tagPo.setTagNo(tagVo.getTagNo());
						tagPo.setUseCnt(1);
						tagDao.updateTagBase(tagPo);									
					}else {
						tagPo = new TagBasePO();
						tagPo.setTagNm(tagNm);
						tagPo.setStatCd("U"); // 태그 신조어로 등록.
						tagPo.setSrcCd("M"); // 팻로그 댓글 등록 시 등록된 태그(수동생성)
						tagDao.insertTagBase(tagPo);										
					}				
				}
			}
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e.getClass());
		}		
	}
	
}


