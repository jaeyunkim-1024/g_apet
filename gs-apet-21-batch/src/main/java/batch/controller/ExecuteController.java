package batch.controller;

import java.lang.reflect.Method;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import biz.app.system.dao.CodeDao;
import biz.app.system.model.CodeDetailSO;
import biz.app.system.model.CodeDetailVO;
import framework.common.constants.CommonConstants;

/**
* 사용법
* - 공통 코드 등록 
*  ㄱ. 그룹코드 : BATCH
*  ㄴ. 사용자 정의1 값 : 배치명 입력
*  ㄷ. 사용자 정의2 값 : 패키지 경로 입력
*  ㄹ. 사용자 정의3 값 : 클래스명 입력
*  ㅁ. 사용자 정의4 값 : 매서드 명 입력
* - 사용여부로 배치 실행 가능 여부 결정
* - 실행 화면 URL : /executeView
*/

@Controller
@RequestMapping("/")
@Slf4j
public class ExecuteController {

	@Autowired
	private CodeDao codeDao;
	
	/**
	* <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: NoticeExecute.java
	* - 작성일		: 2021. 03. 08.
	* - 작성자		: KKB
	* - 설명		: 배치 실행 화면
	* </pre>
	*/
	@RequestMapping("executeView")
	public String executeView(ModelMap map) {
		CodeDetailSO cdso = new CodeDetailSO();
		cdso.setGrpCd("BATCH");
		List<CodeDetailVO> batchCodeList = codeDao.pageCodeDetail(cdso);
		ObjectMapper mapper = new ObjectMapper();
		String jsonText ="";
		try {
			jsonText = mapper.writeValueAsString( batchCodeList );
		} catch (JsonProcessingException e) {
			//보안성 진단. 오류메시지를 통한 정보노출
			//e.printStackTrace();
			log.error("##### JsonProcessingException When executeView", e.getClass());
		}
		map.put("codeList", batchCodeList);
		map.put("jsonText", jsonText);
		return "executeView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: NoticeExecute.java
	* - 작성일		: 2021. 03. 08.
	* - 작성자		: KKB
	* - 설명		: 배치 실행
	* </pre>
	*/
	@ResponseBody
	@RequestMapping(value = "/executeBatch", method = RequestMethod.POST )
	public ModelMap executeMethod(String dtlCd) {
		ModelMap map = new ModelMap();
		try {
			CodeDetailSO cdso = new CodeDetailSO();
			cdso.setGrpCd("BATCH");
			cdso.setDtlCd(dtlCd);
			CodeDetailVO batchCode = codeDao.getCodeDetail(cdso);
			log.info("############# BATCH 아이디 : {}" , batchCode.getUsrDfn1Val());
			log.info("############# BATCH 상세명 : {}" , batchCode.getDtlNm());
			log.info("############# BATCH 패키지 : {}" , batchCode.getUsrDfn2Val());
			log.info("############# BATCH 클래스 : {}" , batchCode.getUsrDfn3Val());
			log.info("############# BATCH 실행 메소드 : {}" , batchCode.getUsrDfn4Val());
			log.info("############# BATCH 사용 여부 : {}" , batchCode.getUseYn());

			if(CommonConstants.COMM_YN_Y.equals(batchCode.getUseYn())) {
				Class<?> cls = Class.forName(batchCode.getUsrDfn2Val()+"."+batchCode.getUsrDfn3Val()); // 클래스 로딩
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
				ServletContext context = request.getSession().getServletContext();
				ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(context);
				Object obj = cls.newInstance(); // 해당 클래스 인스턴스 생성
				ac.getAutowireCapableBeanFactory().autowireBean(obj);
				Method thisMethod = cls.getMethod(batchCode.getUsrDfn4Val()); // 메소드 로딩		
				thisMethod.invoke(obj); // 실행
				map.put("result", "DONE");
			}
		} catch (Exception e) {
			map.put("result", "FAIL");
		}
		return map;
	}
}
