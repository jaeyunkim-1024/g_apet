package biz.app.pet.service;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.appweb.dao.PushDao;
import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.member.dao.MemberBaseDao;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.app.pet.dao.PetDao;
import biz.app.pet.model.PetBasePO;
import biz.app.pet.model.PetBaseSO;
import biz.app.pet.model.PetBaseVO;
import biz.app.pet.model.PetDaPO;
import biz.app.pet.model.PetDaVO;
import biz.app.pet.model.PetInclRecodePO;
import biz.app.pet.model.PetInclRecodeSO;
import biz.app.pet.model.PetInclRecodeVO;
import biz.common.model.PushTargetPO;
import biz.common.model.SendPushPO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.NhnObjectStorageUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class PetServiceImpl implements PetService {

	@Autowired private Properties bizConfig;

	@Autowired private PetDao petDao;

	@Autowired private CacheService codeCacheService;

	@Autowired private NhnObjectStorageUtil nhnObjectStorageUtil;
	
	@Autowired private BizService bizService;
	
	@Autowired private MemberService memberService;
	
	@Autowired private PushDao pushDao;
	
	@Autowired private MemberBaseDao memberBaseDao;
	

	
	@Override
	public List<PetBaseVO> listPetBase(PetBaseSO so) {
		
		List<PetBaseVO> voList = petDao.listPetBase(so);
		/*for(int i = 0; i < voList.size(); i++) {
			String filePath = bizConfig.getProperty("common.nas.base") + FileUtil.SEPARATOR + bizConfig.getProperty("common.nas.base.image");
			String imgPath = voList.get(i).getImgPath();
			
			if(StringUtil.isNotEmpty(imgPath)) {
				filePath = filePath + imgPath;
				voList.get(i).setImgPath(filePath);	
			}
		}*/
		
		return voList;
	}
	
	@Override
	public List<PetInclRecodeVO> pagePetInclRecode(PetBaseSO so) {
		
		List<PetInclRecodeVO> voList = petDao.pagePetInclRecode(so);
		/*for(int i = 0; i < voList.size(); i++) {
			String filePath = bizConfig.getProperty("common.nas.base") + FileUtil.SEPARATOR + bizConfig.getProperty("common.nas.base.image");
			String imgPath = voList.get(i).getImgPath();
			
			if(StringUtil.isNotEmpty(imgPath)) {
				filePath = filePath + imgPath;
				voList.get(i).setImgPath(filePath);	
			}
		}*/
		
		return voList;
	}
	
	@Override
	public PetBaseVO getPetInfo(PetBaseSO so) {
		return petDao.getPetInfo(so);
	}
	
	@Override
	public Long insertPet(PetBasePO po, PetDaPO daPo, String deviceGb) {
		int result = 0;
		
		PetBaseSO so = new PetBaseSO();
		so.setMbrNo(po.getMbrNo());
		
		int petCnt = petDao.selectPetCnt(so);
		if(petCnt >= 5) {
			throw new CustomException(ExceptionConstants.ERROR_PET_CNT);
		}
		
		Long petNo = this.bizService.getSequence(CommonConstants.SEQUENCE_PET_BASE_SEQ);
//		Long petNo = petDao.selectMaxPetNo();
		
		po.setPetNo(petNo);
		po.setSysRegrNo(po.getMbrNo());
		po.setSysUpdrNo(po.getMbrNo());
		
		if(daPo.getWryDaCds() != null) {
			po.setWryDaYn(CommonConstants.USE_YN_Y);
		} else {
			po.setWryDaYn(CommonConstants.USE_YN_N);
		}
		
		if(po.getMonth() == null || po.getMonth() == "") {
			po.setMonth("0");
		}
		
		// 생년월일로 입력한경우 현재날짜와 비교해서 년/개월 역산
		if(po.getBirth() != null && po.getBirth() != "") {
			String birth = po.getBirth();
			
			LocalDate today = LocalDate.now();
			LocalDate birthDay = LocalDate.of(Integer.parseInt(birth.substring(0, 4)), Integer.parseInt(birth.substring(4, 6)), Integer.parseInt(birth.substring(6)));
			
			Period period = birthDay.until(today);

			// 생일 지났으면 +1
			// 생일 안지났으면 만나이로 계산되기때문에 +2
			/*if(birthDay.getMonthValue() < today.getMonthValue()) {
				po.setAge(Integer.toString(period.getYears() + 1));	
			} else if(birthDay.getMonthValue() == today.getMonthValue()) {
				if(birthDay.getDayOfMonth() < today.getDayOfMonth()) {
					po.setAge(Integer.toString(period.getYears() + 1));
				}
			} else {
				po.setAge(Integer.toString(period.getYears() + 2));
			}*/
			po.setAge(Integer.toString(period.getYears()));	
			po.setMonth(Integer.toString(period.getMonths()));
			po.setBirthBatch(po.getBirth());
		} else {
			int age = po.getAge().isEmpty() ? 0 : Integer.parseInt(po.getAge());
			int month = Integer.parseInt(po.getMonth());
			int monthAll = (age * 12) + month;
			
			po.setBirthBatch(LocalDate.now().minusMonths(monthAll).format(DateTimeFormatter.ofPattern("yyyyMMdd")));
		}
		
		if(!deviceGb.equals(CommonConstants.DEVICE_GB_30)) {
			FtpImgUtil ftpImgUtil = new FtpImgUtil();
			String filePath = ftpImgUtil.uploadFilePath(po.getImgPath(), CommonConstants.PET_IMG_PATH + FileUtil.SEPARATOR + po.getPetNo());
			ftpImgUtil.upload(po.getImgPath(), filePath);
			po.setImgPath(filePath);	
		} else {
			po.setImgPath("");
		}
		
		String petLogUrl = petDao.selectMemberPetLogUrl(so);
		
		// 반려동물 최초 등록시 펫로그 URL 업데이트		
		if(petCnt == 0 && (petLogUrl == null || petLogUrl == "")) {
			MemberBasePO memberPO = new MemberBasePO();
			memberPO.setMbrNo(po.getMbrNo());
			memberPO.setPetLogUrlDeleteYn(CommonConstants.COMM_YN_N);
			memberPO.setSysUpdrNo(po.getMbrNo());
			memberPO.setUpdrIp(bizService.twoWayEncrypt(RequestUtil.getClientIp()));
			
			result = petDao.updateMemberPetLogUrl(memberPO);
			
			if(result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			
			petLogUrl = petDao.selectMemberPetLogUrl(so);
		}
		// 펫 기본 정보 등록
		result = petDao.insertPetBase(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		List<PetDaPO> daPoList = new ArrayList<PetDaPO>();
		
		
		// 펫 질환 등록
		if(daPo.getWryDaCds() != null) {
			for(int intIndex = 0; intIndex < daPo.getWryDaCds().length; intIndex++) {
				String wryDaCd = daPo.getWryDaCds()[intIndex];
				PetDaPO petDaPO = new PetDaPO();
				
				petDaPO.setPetNo(po.getPetNo());
				petDaPO.setSysRegrNo(po.getMbrNo());
				petDaPO.setSysUpdrNo(po.getMbrNo());
				petDaPO.setDaGbCd(CommonConstants.DA_GB_10);
				petDaPO.setDaCd(wryDaCd);
				
				daPoList.add(petDaPO);
			}
		}
		
		// 펫 알러지 등록
		if(daPo.getAllergyCds() != null) {
			for(int intIndex = 0; intIndex < daPo.getAllergyCds().length; intIndex++) {
				String allergyCd = daPo.getAllergyCds()[intIndex];
				PetDaPO petDaPO = new PetDaPO();
				
				petDaPO.setPetNo(po.getPetNo());
				petDaPO.setSysRegrNo(po.getMbrNo());
				petDaPO.setSysUpdrNo(po.getMbrNo());
				petDaPO.setDaGbCd(CommonConstants.DA_GB_20);
				petDaPO.setDaCd(allergyCd);
				
				daPoList.add(petDaPO);
			}
		}		

		if(daPoList.size() > 0) {
			result = petDao.insertPetDa(daPoList);
			if(result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}	
		}
		
		String petGbCd = dlgtPetCal(po);
		
		MemberBasePO memberPo = new MemberBasePO();
		memberPo.setMbrNo(po.getMbrNo());
		memberPo.setDlgtPetGbCd(petGbCd);
		memberPo.setSysUpdrNo(po.getMbrNo());
		memberPo.setUpdrIp(bizService.twoWayEncrypt(RequestUtil.getClientIp()));
		
		updateMemberDlgtPetGbCd(memberPo);
		
		// petLogUrl, petGbCd, petNos(콤마구분)
		// session에 저장
		Session session = FrontSessionUtil.getSession();
		session.setPetLogUrl(petLogUrl);
		session.setPetGbCd(petGbCd);
		
		String petNos = petDao.selectPetNosForSession(so);
		session.setPetNos(petNos);
		
		FrontSessionUtil.setSession(session);
		
		return po.getPetNo();
	}
	
	@Override
	public int updatePet(PetBasePO po, PetDaPO daPo, String deviceGb) {
		int result = 0;

		po.setSysUpdrNo(po.getMbrNo());
		
		if(daPo.getWryDaCds() != null) {
			po.setWryDaYn(CommonConstants.USE_YN_Y);
		} else {
			po.setWryDaYn(CommonConstants.USE_YN_N);
		}
		
		if(po.getMonth() == null || po.getMonth() == "") {
			po.setMonth("0");
		}
		
		// 생년월일로 입력한경우 현재날짜와 비교해서 년/개월 역산
		if(po.getBirth() != null && po.getBirth() != "") {
			String birth = po.getBirth();
			
			LocalDate today = LocalDate.now();
			LocalDate birthDay = LocalDate.of(Integer.parseInt(birth.substring(0, 4)), Integer.parseInt(birth.substring(4, 6)), Integer.parseInt(birth.substring(6)));
			
			Period period = birthDay.until(today);

			// 생일 지났으면 +1
			// 생일 안지났으면 만나이로 계산되기때문에 +2
			/*if(birthDay.getMonthValue() < today.getMonthValue()) {
				po.setAge(Integer.toString(period.getYears() + 1));	
			} else if(birthDay.getMonthValue() == today.getMonthValue()) {
				if(birthDay.getDayOfMonth() < today.getDayOfMonth()) {
					po.setAge(Integer.toString(period.getYears() + 1));
				}
			} else {
				po.setAge(Integer.toString(period.getYears() + 2));
			}*/
			po.setAge(Integer.toString(period.getYears()));	
			po.setMonth(Integer.toString(period.getMonths()));
			po.setBirthBatch(po.getBirth());
		} else {
			int age = po.getAge().isEmpty() ? 0 : Integer.parseInt(po.getAge());
			int month = Integer.parseInt(po.getMonth());
			int monthAll = (age * 12) + month;
			
			po.setBirthBatch(LocalDate.now().minusMonths(monthAll).format(DateTimeFormatter.ofPattern("yyyyMMdd")));
		}
		
		
		if(po.getImgPathTemp() != null && po.getImgPathTemp() != "") {
			// 원본 삭제
			// TODO 조은지 : 스토리지 삭제 오류로 임시 주석
			//nhnObjectStorageUtil.delete(po.getImgPath());
			po.setImgPath(po.getImgPathTemp());
			if(!deviceGb.equals(CommonConstants.DEVICE_GB_30)) {		
				FtpImgUtil ftpImgUtil = new FtpImgUtil();
				String filePath = ftpImgUtil.uploadFilePath(po.getImgPath(), CommonConstants.PET_IMG_PATH + FileUtil.SEPARATOR + po.getPetNo());
				ftpImgUtil.upload(po.getImgPath(), filePath);
				po.setImgPath(filePath);
			}
		}

		// 펫 기본 정보 수정
		result = petDao.updatePetBase(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}		
		
		// 반려동물 질환/알러지 정보 삭제 후 재등록
		petDao.deletePetDa(daPo);
		
		List<PetDaPO> daPoList = new ArrayList<PetDaPO>();
		
		// 펫 질환 등록
		if(daPo.getWryDaCds() != null) {
			for(int intIndex = 0; intIndex < daPo.getWryDaCds().length; intIndex++) {
				String wryDaCd = daPo.getWryDaCds()[intIndex];
				PetDaPO petDaPO = new PetDaPO();
				
				petDaPO.setPetNo(po.getPetNo());
				petDaPO.setSysRegrNo(po.getMbrNo());
				petDaPO.setSysUpdrNo(po.getMbrNo());
				petDaPO.setDaGbCd(CommonConstants.DA_GB_10);
				petDaPO.setDaCd(wryDaCd);
				
				daPoList.add(petDaPO);
			}
		}
		
		// 펫 알러지 등록
		if(daPo.getAllergyCds() != null) {
			for(int intIndex = 0; intIndex < daPo.getAllergyCds().length; intIndex++) {
				String allergyCd = daPo.getAllergyCds()[intIndex];
				PetDaPO petDaPO = new PetDaPO();
				
				petDaPO.setPetNo(po.getPetNo());
				petDaPO.setSysRegrNo(po.getMbrNo());
				petDaPO.setSysUpdrNo(po.getMbrNo());
				petDaPO.setDaGbCd(CommonConstants.DA_GB_20);
				petDaPO.setDaCd(allergyCd);
				
				daPoList.add(petDaPO);
			}
		}		
		
		if(daPoList.size() > 0) {
			result = petDao.insertPetDa(daPoList);
			if(result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
		
		return result;
	}
	
	@Override
	public int deletePet(PetBasePO po, PetDaPO daPo) {
		int result = 0;
		
		PetInclRecodePO inclPo = new PetInclRecodePO();
		inclPo.setPetNo(po.getPetNo());
		
		// 건강수첩 삭제
		result = petDao.deletePetInclRecode(inclPo);
				
		// 질환/알러지정보 삭제
		result = petDao.deletePetDa(daPo);
		
		// 이미지 삭제
		// TODO 조은지 : 임시주석
		//nhnObjectStorageUtil.delete(po.getImgPath());
		
		// 반려동물 삭제
		result = petDao.deletePetBase(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}	
		
		String petGbCd = dlgtPetCal(po);
		
		MemberBasePO memberPo = new MemberBasePO();
		memberPo.setMbrNo(po.getMbrNo());
		memberPo.setDlgtPetGbCd(petGbCd);
		memberPo.setSysUpdrNo(po.getMbrNo());
		memberPo.setUpdrIp(bizService.twoWayEncrypt(RequestUtil.getClientIp()));
		
		updateMemberDlgtPetGbCd(memberPo);
		
		Session session = FrontSessionUtil.getSession();
		session.setPetGbCd(petGbCd);

		PetBaseSO so = new PetBaseSO();
		so.setMbrNo(po.getMbrNo());
		
		String petNos = petDao.selectPetNosForSession(so);
		session.setPetNos(petNos);
		
		// 반려동물이 없을경우 petlogurl 삭제
		/*PetBaseSO so = new PetBaseSO();
		so.setMbrNo(po.getMbrNo());
		
		int petCnt = petDao.selectPetCnt(so);
		if(petCnt == 0) {
			MemberBasePO memberPO = new MemberBasePO();
			memberPO.setMbrNo(po.getMbrNo());
			memberPo.setSysUpdrNo(po.getMbrNo());
			memberPO.setPetLogUrlDeleteYn(CommonConstants.COMM_YN_Y);
			memberPo.setUpdrIp(bizService.twoWayEncrypt(RequestUtil.getClientIp()));
			
			result = petDao.updateMemberPetLogUrl(memberPO);
			
			if(result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}	
			
			session.setPetLogUrl(null);
		}*/

		FrontSessionUtil.setSession(session);
		
		return result;
	}
	
	private String dlgtPetCal(PetBasePO po) {
		/**
		 * 기존 PET_BASE에서 관리하던 대표반려동물여부가 사라짐에 따라
		 * MEMBER_BASE의 DLGT_PET_GB_CD로 기본반려동물을 관리함
		 * 
		 * 강아지 등록 => 강아지 홈
		 * 고양이 등록 => 고양이 홈  	
		 * 강아지, 고양이 등록 => 강아지 홈
		 * 고양이. 강이지 등록 => 강아지 홈
		 * 고양이, 고양이 등록 => 고양이 홈
		 * 강아지, 강아지 등록 => 강아지 홈	
		 */
		PetBaseSO so = new PetBaseSO();
		so.setMbrNo(po.getMbrNo());
		
		String petGbCd = null;
		int dogCnt = 0;
		int catCnt = 0;
		
		List<String> voList = petDao.listPetGb(so);
		for(String petGb : voList) {
			petGbCd = petGb;
			
			if(StringUtil.equals(petGbCd, CommonConstants.PET_GB_10)) {
				dogCnt++;
			} else if(StringUtil.equals(petGbCd, CommonConstants.PET_GB_20)) {
				catCnt++;
			}
		}
		
		if(dogCnt > 0 && catCnt == 0)		{petGbCd = CommonConstants.PET_GB_10;}
		else if(catCnt > 0 && dogCnt == 0) 	{petGbCd = CommonConstants.PET_GB_20;}
		else if(dogCnt > 0 && catCnt > 0)	{petGbCd = CommonConstants.PET_GB_10;}
		else if(dogCnt == 0 && catCnt == 0)	{petGbCd = CommonConstants.PET_GB_10;}
		
		return petGbCd;
	}
	
	@Override
	public List<PetDaVO> selectPetDa(PetBaseSO so) {
		return petDao.selectPetDa(so);
	}
	
	@Override
	public String updateMemberDlgtPetGbCd(MemberBasePO po) {
		int result = 0;
		
		result = petDao.updateMemberDlgtPetGbCd(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		memberService.insertMemberBaseHistory(po.getMbrNo());
		
		return po.getDlgtPetGbCd();
	}
	
	@Override
	public List<PetInclRecodeVO> petInclRecodeList(PetInclRecodeSO so){
		List<PetInclRecodeVO> list = petDao.petInclRecodeList(so);
		String today = DateUtil.getNowDate();
		
		for(PetInclRecodeVO vo : list) {
			if(StringUtil.isNotEmpty(vo.getAddInclDt())) {
				String removeAddInclDt = DateUtil.removeFormat(vo.getAddInclDt());
				int addYear = Integer.valueOf(removeAddInclDt.substring(0,4));
				int todayYear = Integer.valueOf(today.substring(0,4));
				int intervalDay = DateUtil.intervalDay(today, removeAddInclDt) + ((addYear - todayYear) * 365);
				vo.setIntervalDay(intervalDay);
				vo.setAddInclDt(removeAddInclDt);
			}
			
			if(StringUtil.isNotEmpty(vo.getInclDt())) {
				vo.setInclDt(DateUtil.removeFormat(vo.getInclDt()));
			}
		}
		return list;
	}
	
	@Override
	public Long insertMyPetInclRecode(PetInclRecodePO po , String deviceGb) {
		String frontInclNm = "";
		int result;
		
		// 기초 접종 중 종합백신일 경우 기초 접두사 추가
		if(StringUtil.equals(po.getInclKindCd(), CommonConstants.INCL_KIND_1001)
			|| StringUtil.equals(po.getInclKindCd(), CommonConstants.INCL_KIND_1002)
			|| StringUtil.equals(po.getInclKindCd(), CommonConstants.INCL_KIND_1003)
			|| StringUtil.equals(po.getInclKindCd(), CommonConstants.INCL_KIND_1004)
			|| StringUtil.equals(po.getInclKindCd(), CommonConstants.INCL_KIND_1005)) {
			frontInclNm = CommonConstants.INCL_BASIC;
		}
				
		// 정기 접종중 종합백신일 경우 정기 접두사 추가
		if(StringUtil.equals(po.getInclKindCd(), CommonConstants.INCL_KIND_1010)) {
			frontInclNm = CommonConstants.INCL_REGULAR;
		}
				
		// 접종구분이 기초 접종 , 정기 접종일 경우
		if(StringUtil.equals(po.getInclGbCd(), CommonConstants.INCL_GB_10) || StringUtil.equals(po.getInclGbCd(), CommonConstants.INCL_GB_20)) {
			po.setInclNm(frontInclNm + codeCacheService.getCodeName(CommonConstants.INCL_KIND, po.getInclKindCd()));
			po.setItemNm(codeCacheService.getCodeName(CommonConstants.INCL_ADD, po.getAddInclCd()));
			
			if(StringUtil.isEmpty(po.getAlmSetYn())) {
				po.setAlmSetYn("N");
			}else {
				po.setAlmSetYn("Y");
			}
		}
				
		// 접종구분이 항체가검사일 경우 접종명(항체가검사) , 추가 접종명(기존 접종명) 셋팅
		if(StringUtil.equals(po.getInclGbCd(), CommonConstants.INCL_GB_30)) {
			po.setInclNm(codeCacheService.getCodeName(CommonConstants.INCL_GB, po.getInclGbCd()));
			po.setItemNm(codeCacheService.getCodeName(CommonConstants.INCL_KIND, po.getInclKindCd()).replaceAll(" ", ""));
			
			if(StringUtil.isEmpty(po.getAlmSetYn())) {
				po.setAlmSetYn("N");
			}else {
				po.setAlmSetYn("Y");
			}
		}
				
		// 접종 구분이 투약일 경우 접종명 (투약) , 추가 접종명(기존 접종명) 셋팅
		if(StringUtil.equals(po.getInclGbCd(), CommonConstants.INCL_GB_40)){
			po.setInclNm(codeCacheService.getCodeName(CommonConstants.INCL_GB, po.getInclGbCd()));
			po.setItemNm(po.getItemNm().replaceAll(" ", ""));
		}

		//input blank null처리
		if(StringUtil.isEmpty(po.getTrmtHsptNm())) {
			po.setTrmtHsptNm(null);
		}
		if(StringUtil.isEmpty(po.getImgPath())) {
			po.setImgPath(null);
		}
		if(StringUtil.isEmpty(po.getMemo())) {
			po.setMemo(null);
		}
		if(StringUtil.isEmpty(po.getAddInclDt())) {
			po.setAddInclDt(null);
		}
		
		//이미지 업로드
		if(StringUtil.isNotEmpty(po.getImgPath()) && !StringUtil.equals(CommonConstants.DEVICE_GB_30, deviceGb)) {
			FtpImgUtil ftpImgUtil = new FtpImgUtil();
			
			// 업데이트 시 새로운 이미지 
			//보안 진단. 불필요한 코드 (비어있는 IF문)
			/*if(!StringUtil.equals(po.getOrgImgPath(), po.getImgPath())){
				
			}*/
			
			String filePath = ftpImgUtil.uploadFilePath(po.getImgPath(), AdminConstants.PET_INCL_IMG_PATH + FileUtil.SEPARATOR + po.getPetNo());
			ftpImgUtil.upload(po.getImgPath(), filePath);
			
			if(StringUtil.isNotEmpty(filePath)){
				po.setImgPath(filePath);
			}
		}
		//INSERT시 InclNo 채번
		if(StringUtil.isNotEmpty(po.getInclNo())){
			result = petDao.updateMyPetInclRecode(po);
		}else {
			po.setInclNo(bizService.getSequence(CommonConstants.SEQUENCE_PET_INCL_RECODE_SEQ));
			result = petDao.insertMyPetInclRecode(po);
		}
		
		if(result != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}else {
			//접종 구분이 기초 접종이거나 정기접종 , 알림 수신 여부 Y , 접종 예정일이 오늘보다 나중일 경우 sendPush 예약 
			String today = DateUtil.getNowDate();
			String removeAddInclDt = Optional.ofNullable(DateUtil.removeFormat(po.getAddInclDt())).orElseGet(()-> today);
			
			int addYear = Integer.valueOf(removeAddInclDt.substring(0,4));
			int todayYear = Integer.valueOf(today.substring(0,4));
			int intervalDay = DateUtil.intervalDay(today, removeAddInclDt) + ((addYear - todayYear) * 365);
			
			MemberBaseSO mbso = new MemberBaseSO();
			mbso.setMbrNo(po.getMbrNo());
			MemberBaseVO mbvo = Optional.ofNullable(memberBaseDao.getMemberBase(mbso)).orElseGet(()->new MemberBaseVO());
			
			if((StringUtil.equals(po.getInclGbCd(), CommonConstants.INCL_GB_10) 
					|| StringUtil.equals(po.getInclGbCd(), CommonConstants.INCL_GB_20) || StringUtil.equals(po.getInclGbCd(), CommonConstants.INCL_GB_30)) 
					&& StringUtil.equals(po.getAlmSetYn(), "Y")
					&& intervalDay > 0){
				
				PushSO pso = new PushSO();
				pso.setTmplNo(Long.valueOf(codeCacheService.getCodeCache(CommonConstants.TMPL_NO, CommonConstants.TMPL_ADD_INCL_DT).getUsrDfn1Val()));
				PushVO template = Optional.ofNullable(pushDao.getNoticeTemplate(pso)).orElseGet(()->new PushVO());
				
				if (StringUtil.isNotBlank(template.getSubject()) && StringUtil.isNotBlank(template.getContents())) {
					List<PushTargetPO> ptpoList = new ArrayList<>();
					PushTargetPO ptpo = new PushTargetPO();
					
					ptpo.setTo(po.getMbrNo().toString());
					ptpo.setImage(template.getImgPath());
					ptpo.setLandingUrl(template.getMovPath() + "&petNo=" + po.getPetNo());
					
					Map<String,String> map =new HashMap<String, String>();
					map.put("pet_nm", po.getPetNm());
					ptpo.setParameters(map);
					ptpoList.add(ptpo);
					
					SendPushPO sppo = new SendPushPO();
					sppo.setTitle(template.getSubject());
					sppo.setMessageType("NOTIF");
					sppo.setType("USER");
					sppo.setTmplNo(pso.getTmplNo());
					sppo.setTarget(ptpoList);
					sppo.setReservationDateTime(po.getAddInclDt());
					sppo.setSendReqDtm(Timestamp.valueOf(po.getAddInclDt()));
					
					if (StringUtil.isNotEmpty(mbvo.getDeviceTpCd())) {
						if (mbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_10)) {
							sppo.setDeviceType("GCM");
						} else if (mbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_20)) {
							sppo.setDeviceType("APNS");
						}
					}
					
					String noticeSendNo = bizService.sendPush(sppo);
					
					if (StringUtil.equals(noticeSendNo, null)) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}
		
		Long petInclNo = po.getInclNo();
		return petInclNo;	
	}
	
	@Override
	public PetInclRecodeVO getMyPetInclRecode(PetInclRecodeSO so) { 
		PetInclRecodeVO vo = petDao.getMyPetInclRecode(so);
		if(StringUtil.isEmpty(vo)) {
			throw new CustomException(ExceptionConstants.ERROR_NO_PATH);
		}
		vo.setInclDt(DateUtil.removeFormat(vo.getInclDt()));
		vo.setAddInclDt(DateUtil.removeFormat(vo.getAddInclDt()));
		return vo;
	}
	
	@Override
	public int deleteMyPetInclRecode(PetInclRecodePO po) {
		int result = petDao.deleteMyPetInclRecode(po);
		if(result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		return result;
	}
	
	@Override
	public int appPetImageUpdate(PetBasePO po) {
		int result = petDao.appPetImageUpdate(po);
		return result;
	}
	
	@Override
	public int appInclPetImageUpdate(PetInclRecodePO po) {
		return petDao.appInclPetImageUpdate(po);
	}

	@Override
	public String getPetNos(PetBaseSO so) {	
		return petDao.selectPetNosForSession(so);
	}
}
