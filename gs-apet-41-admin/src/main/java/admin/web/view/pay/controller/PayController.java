package admin.web.view.pay.controller;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import admin.web.config.view.View;
import biz.app.pay.model.PayBasePO;
import biz.app.pay.model.PayBaseVO;
import biz.app.pay.service.PayBaseService;
import biz.common.service.BizService;
import biz.interfaces.nicepay.model.response.data.VirtualAccountNotiVO;
import biz.interfaces.nicepay.service.NicePayNotiService;
import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명		: gs-apet-11-business
 * - 패키지명		: admin.web.view.pay.controller
 * - 파일명		: PayController.java
 * - 작성일		: 2021. 03. 15.
 * - 작성자		: sorce
 * - 설명			: NicePay Noti(통보) Controller
 * </pre>
 */
@Slf4j
@Controller
public class PayController {

	@Autowired private NicePayNotiService nicePayNotiService;  

	@Autowired private BizService bizService;
	
	@Autowired private PayBaseService payBaseService;
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: notitest
	 * - 작성일		: 2021. 03. 15.
	 * - 작성자		: sorce
	 * - 설명			: 입금완료 처리
	 * </pre>
	 * @param vo
	 * @param model
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value="/interface/completeVirtualAccount.do")
	public String completeVirtualAccount (VirtualAccountNotiVO vo, Model model) throws ParseException {
		log.debug("vo.getAmt			=="+vo.getAmt			());	
		log.debug("vo.getAuthCode		=="+vo.getAuthCode		());	
		log.debug("vo.getAuthDate		=="+vo.getAuthDate		());	
		log.debug("vo.getBuyerAuthNum	=="+vo.getBuyerAuthNum	());	
		log.debug("vo.getBuyerEmail		=="+vo.getBuyerEmail	());	
		log.debug("vo.getFnCd			=="+vo.getFnCd			());	
		log.debug("vo.getFnName			=="+vo.getFnName		());	
		log.debug("vo.getGoodsName		=="+vo.getGoodsName		());	
		log.debug("vo.getMallUserID		=="+vo.getMallUserID	());	
		log.debug("vo.getMID			=="+vo.getMID			());	
		log.debug("vo.getMOID			=="+vo.getMOID			());	
		log.debug("vo.getname			=="+vo.getName			());	
		log.debug("vo.getPayMethod		=="+vo.getPayMethod		());	
		log.debug("vo.getRcptAuthCode	=="+vo.getRcptAuthCode	());	
		log.debug("vo.getRcptTID		=="+vo.getRcptTID		());	
		log.debug("vo.getRcptType		=="+vo.getRcptType		());	
		log.debug("vo.getReceitType		=="+vo.getReceitType	());	
		log.debug("vo.getResultCode		=="+vo.getResultCode	());	
		log.debug("vo.getResultMsg		=="+vo.getResultMsg		());	
		log.debug("vo.getStateCd		=="+vo.getStateCd		());	
		log.debug("vo.getTID			=="+vo.getTID			());	
		log.debug("vo.getVbankInputName	=="+vo.getVbankInputName());	
		log.debug("vo.getVbankName		=="+vo.getVbankName		());	
		log.debug("vo.getVbankNum		=="+vo.getVbankNum		());	
		log.debug("vo.getMallReserved	=="+vo.getMallReserved	());	
		log.debug("vo.getMallReserved1	=="+vo.getMallReserved1	());	
		log.debug("vo.getMallReserved2	=="+vo.getMallReserved2	());	
		log.debug("vo.getMallReserved3	=="+vo.getMallReserved3	());	
		log.debug("vo.getMallReserved4	=="+vo.getMallReserved4	());	
		log.debug("vo.getMallReserved5	=="+vo.getMallReserved5	());	
		log.debug("vo.getMallReserved6	=="+vo.getMallReserved6	());	
		
		/**
		 * 1. 입금완료 처리
		 */
		if(StringUtils.isNotEmpty(vo.getTID())) {
			model.addAttribute("result", nicePayNotiService.completeVirtualAccount(vo));
			log.debug("result== OK");
		} else {
			model.addAttribute("result", false);
			log.debug("result== FAIL");
		}


		return "/pay/completeVirtualAccount";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 메서드명	: completeVirtualAccountNomal
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: KKB
	 * - 설명		: 입금완료 처리
	 * </pre>
	 * @param vo
	 * @param model
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value="/interface/completeVirtualAccountNomal.do")
	public String completeVirtualAccountNomal (VirtualAccountNotiVO vo, Model model) throws ParseException {
		log.debug("vo.getAmt			=="+vo.getAmt			());	
		log.debug("vo.getAuthCode		=="+vo.getAuthCode		());	
		log.debug("vo.getAuthDate		=="+vo.getAuthDate		());	
		log.debug("vo.getBuyerAuthNum	=="+vo.getBuyerAuthNum	());	
		log.debug("vo.getBuyerEmail		=="+vo.getBuyerEmail	());	
		log.debug("vo.getFnCd			=="+vo.getFnCd			());	
		log.debug("vo.getFnName			=="+vo.getFnName		());	
		log.debug("vo.getGoodsName		=="+vo.getGoodsName		());	
		log.debug("vo.getMallUserID		=="+vo.getMallUserID	());	
		log.debug("vo.getMID			=="+vo.getMID			());	
		log.debug("vo.getMOID			=="+vo.getMOID			());	
		log.debug("vo.getname			=="+vo.getName			());	
		log.debug("vo.getPayMethod		=="+vo.getPayMethod		());	
		log.debug("vo.getRcptAuthCode	=="+vo.getRcptAuthCode	());	
		log.debug("vo.getRcptTID		=="+vo.getRcptTID		());	
		log.debug("vo.getRcptType		=="+vo.getRcptType		());	
		log.debug("vo.getReceitType		=="+vo.getReceitType	());	
		log.debug("vo.getResultCode		=="+vo.getResultCode	());	
		log.debug("vo.getResultMsg		=="+vo.getResultMsg		());	
		log.debug("vo.getStateCd		=="+vo.getStateCd		());	
		log.debug("vo.getTID			=="+vo.getTID			());	
		log.debug("vo.getVbankInputName	=="+vo.getVbankInputName());	
		log.debug("vo.getVbankName		=="+vo.getVbankName		());	
		log.debug("vo.getVbankNum		=="+vo.getVbankNum		());	
		log.debug("vo.getMallReserved	=="+vo.getMallReserved	());	
		log.debug("vo.getMallReserved1	=="+vo.getMallReserved1	());	
		log.debug("vo.getMallReserved2	=="+vo.getMallReserved2	());	
		log.debug("vo.getMallReserved3	=="+vo.getMallReserved3	());	
		log.debug("vo.getMallReserved4	=="+vo.getMallReserved4	());	
		log.debug("vo.getMallReserved5	=="+vo.getMallReserved5	());	
		log.debug("vo.getMallReserved6	=="+vo.getMallReserved6	());	
		
		/**
		 * 1. 입금완료 처리
		 */
		if(StringUtils.isNotEmpty(vo.getTID())) {
			PayBasePO po = new PayBasePO();
			if (StringUtils.isNotEmpty(vo.getAuthDate())) { // 결제완료 일시
				SimpleDateFormat format = new SimpleDateFormat("yyMMddHHmmss");
				Date date = format.parse(vo.getAuthDate());
				Timestamp timestamp = new Timestamp(date.getTime());
				po.setPayCpltDtm(timestamp);
			}
			po.setPayAmt(Long.parseLong(vo.getAmt())); // 결제 금액
			po.setStrId(vo.getMID()); // 상점아이디
			po.setDealNo(vo.getTID()); // 거래번호
			po.setCfmRstCd(vo.getResultCode()); // 승인 결과 코드
			po.setCfmRstMsg(vo.getResultMsg()); // 승인 결과 메세지
			po.setDpstrNm(vo.getVbankInputName()); // 입금자명
			po.setBankCd(vo.getVbankName());	// 은행명
			po.setAcctNo(vo.getVbankNum());		// 계좌번호
			Gson gson = new Gson();
			po.setLnkRspsRst(gson.toJson(vo));
			po.setPayStatCd(CommonConstants.PAY_STAT_01);
			int result = payBaseService.insertPayBase(po);
			model.addAttribute("result", (result == 1)? true : false);
			log.debug("result== OK");
		} else {
			model.addAttribute("result", false);
			log.debug("result== FAIL");
		}
		return "/pay/completeVirtualAccount";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: test
	 * - 작성일		: 2021. 03. 18.
	 * - 작성자		: sorce
	 * - 설명			: 암호 테스트용
	 * </pre>
	 * @param vo
	 * @param model
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping(value="/interface/decryptList.do")
	public String decryptList (PayBaseVO vo, Model model) throws ParseException {

		model.addAttribute("list", nicePayNotiService.selectList(vo));

		return View.jsonView();
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: encrypt
	 * - 작성일		: 2021. 03. 21.
	 * - 작성자		: sorce
	 * - 설명			: update test
	 * </pre>
	 * @param vo
	 * @param model
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping(value="/interface/encrypt.do")
	public String encrypt (PayBaseVO vo, Model model) throws ParseException {

		vo.setLnkRspsRst("정정용");
		model.addAttribute("update", nicePayNotiService.updateCryptoTest(vo));

		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: encrypt
	 * - 작성일		: 2021. 04. 13.
	 * - 작성자		: sorce
	 * - 설명			: 
	 * </pre>
	 * @param vo
	 * @param model
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping(value="/interface/encryptForTable.do")
	public String encryptForTable (@RequestParam String tableName, @RequestParam String fieldName, Model model) throws ParseException {

		Map<String, String> map = new HashMap<String, String>();
		map.put("tableName", tableName); // table name
		map.put("fieldName", fieldName); // field name
		model.addAttribute("result", nicePayNotiService.encrypForTable(map));

		return View.jsonView();
	}
	
	@RequestMapping(value="/interface/decryptForTable.do")
	public String decryptForTable (@RequestParam String tableName, @RequestParam String fieldName, Model model) throws ParseException {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("tableName", tableName); // table name
		map.put("fieldName", fieldName); // field name
		model.addAttribute("result", nicePayNotiService.decrypForTable(map));

		return View.jsonView();
	}

	@RequestMapping(value="/interface/cryptoForTable.do")
	public String cryptoForTable (Model model) throws ParseException {

		return "/pay/cryptoForTable";
	}

}
