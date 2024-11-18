package front.web.view.pay.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import front.web.config.view.ViewPopup;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("pay/receipt")
public class ReceiptController {

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: ReceiptController.java
	* - 작성일		: 2017. 4. 26.
	* - 작성자		: Administrator
	* - 설명			: 카드영수증 팝업
	* </pre>
	* @param map
	* @param view
	* @param tid
	* @return
	*/
	@RequestMapping(value="popupCardReceipt")
	public String popupCardReceipt(ModelMap map, ViewBase view, @RequestParam String tid){
	
//		String receiptUrl = INIPayUtil.getCardReceiptUrl(tid);
		
		map.put("view", view);
//		map.put("receiptUrl", receiptUrl);
		
		return TilesView.popup(
				new String[] {"pay", "receipt", "popupReceipt"}
				);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: ReceiptController.java
	* - 작성일		: 2017. 4. 26.
	* - 작성자		: Administrator
	* - 설명			: 현금영수증 팝업
	* </pre>
	* @param map
	* @param view
	* @param tid
	* @return
	*/
	@RequestMapping(value="popupCashReceipt")
	public String popupCashReceipt(ModelMap map, ViewBase view, @RequestParam String tid){
	
//		String receiptUrl = INIPayUtil.getCashReceiptUrl(tid);
		
		map.put("view", view);
//		map.put("receiptUrl", receiptUrl);
		
		return TilesView.popup(
				new String[] {"pay", "receipt", "popupReceipt"}
				);
	}	
}

