package biz.app.contents.service;

import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.appweb.service.PushService;
import biz.app.contents.dao.PetLogMgmtDao;
import biz.app.contents.model.PetLogMgmtPO;
import biz.app.contents.model.PetLogMgmtSO;
import biz.app.contents.model.PetLogMgmtVO;
import biz.app.member.model.MemberBaseVO;
import biz.app.tag.dao.TagDao;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.common.model.PushTargetPO;
import biz.common.model.SendPushPO;
import biz.common.model.SsgMessageSendPO;
import biz.common.service.BizService;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.StringUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;


/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.contents.service
 * - 파일명		: PetLogServiceImpl.java
 * - 작성자		: valueFactory
 * - 설명		: 펫로그 Service Implement
 * </pre>
 */
@Service
@Transactional
public class PetLogMgmtServiceImpl implements PetLogMgmtService {
	
	@Autowired private PetLogMgmtDao petLogMgmtDao;

	@Autowired private TagDao tagDao;

	@Autowired private Properties webConfig;
	
	@Autowired private BizService bizService;
	
	@Autowired private PushService pushService;

	/**
	 * <pre>펫로그 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so PetlogSO
	 * @return
	 */
	@Override
	@Transactional(readOnly = true)
	public List<PetLogMgmtVO> pagePetLog(PetLogMgmtSO so) {
		//펫로그 기본 BASE 리스트
		//id 암호화		
		if(StringUtil.isNotBlank(so.getRegGb())) {
			if(so.getRegGb().equals("loginId")) {
				so.setLoginId(bizService.twoWayEncrypt(so.getLoginId()));			
			}
		}
		
		List<PetLogMgmtVO> list = petLogMgmtDao.pagePetLog(so);

		//펫로그 대표 이미지 set , 관련 태그 가져오기
		for(PetLogMgmtVO vo : list){
			//BO 펫로그 관리가 아닌곳에서 호출할 경우만 실행
			if(StringUtil.isBlank(so.getPetLogMgmtCallYn()) || !"Y".equals(so.getPetLogMgmtCallYn())) {
				String thumbNail = Optional.ofNullable(vo.getVdPath()).orElseGet(
						()->Optional.ofNullable(vo.getImgPath1()).orElseGet(
								()->Optional.ofNullable(vo.getImgPath2()).orElseGet(
										()->Optional.ofNullable(vo.getImgPath3()).orElseGet(
												()->Optional.ofNullable(vo.getImgPath4()).orElseGet(
														()->Optional.ofNullable(vo.getImgPath5()).orElseGet(()->"")
												)
										)
								))
				);
				vo.setThumbNail(thumbNail);

				TagBaseSO tso = new TagBaseSO();
				tso.setPetLogNo(vo.getPetLogNo());
				vo.setTagList(Optional.ofNullable(tagDao.listTagBase(tso)).orElseGet(()->new ArrayList<TagBaseVO>()));
			}
			
			//위치 복호화
			if(StringUtil.isNotBlank(vo.getPstNm())) { 
				vo.setPstNm(bizService.twoWayDecrypt(vo.getPstNm()));
			}
					
		}
		
		//펫로그 관련
		return list;
	}
	
	@Override
	public int updatePetLogStat(List<PetLogMgmtPO> petLogPOList) {
		int updateCnt = 0;
		if(petLogPOList != null && !petLogPOList.isEmpty()) {
			for(PetLogMgmtPO po : petLogPOList) {
				int upCnt = petLogMgmtDao.updatePetLogStat(po);
				if(upCnt > 0 && AdminConstants.CONTS_STAT_20.equals(po.getContsStatCd())) {
					sendKkoMsg(po);
				}
				updateCnt += upCnt;
			}
		}

		return updateCnt;
	}
	
	@Override
	public List<PetLogMgmtVO> pagePetLogReport(PetLogMgmtSO so){
		List<PetLogMgmtVO> list = petLogMgmtDao.pagePetLogReport(so);
		for(PetLogMgmtVO vo : list) {
			if(StringUtil.isNotBlank(vo.getRptpLoginId())){
				String rptpId = bizService.twoWayDecrypt(vo.getRptpLoginId());
				rptpId = MaskingUtil.getId(rptpId);
				vo.setRptpLoginId(rptpId);
			}
		}
		return list;
	}
	
	public int sendKkoMsg(PetLogMgmtPO po) {		
		int result=0;	
		
		//회원정보 조회
		PetLogMgmtSO so = new PetLogMgmtSO();
		so.setPetLogNo(po.getPetLogNo());
		MemberBaseVO memVo = petLogMgmtDao.selectPetLogRegrInfo(so);

		if(StringUtil.isNotEmpty(memVo)) {
			if(AdminConstants.MBR_STAT_10.equals(memVo.getMbrStatCd())) {
				if(StringUtil.isNotBlank(memVo.getMobile())) {					
					String nickNm = StringUtil.isNotBlank(memVo.getNickNm())?memVo.getNickNm():"";					
					SendPushPO ppo = new SendPushPO();
					ppo.setTmplNo(92L);
					List<PushTargetPO> target = new ArrayList<PushTargetPO>();
					PushTargetPO tpo = new PushTargetPO();
					tpo.setTo(""+memVo.getMbrNo());
					Map<String, String> paramMap = new HashMap<String, String>();
					paramMap.put(CommonConstants.PUSH_TMPL_VRBL_80, nickNm);
					tpo.setParameters(paramMap);
					target.add(tpo);
					ppo.setTarget(target);
					ppo.setReservationDateTime(DateUtil.getNowDateTime());
					bizService.sendPush(ppo);
				}
			}			
		}
		
		return result;
	}

	
}