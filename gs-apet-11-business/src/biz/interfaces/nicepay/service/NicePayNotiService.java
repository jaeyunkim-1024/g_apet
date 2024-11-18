package biz.interfaces.nicepay.service;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import biz.app.pay.model.PayBaseVO;
import biz.interfaces.nicepay.model.request.data.CancelProcessReqVO;
import biz.interfaces.nicepay.model.request.data.CashReceiptReqVO;
import biz.interfaces.nicepay.model.response.data.CancelProcessResVO;
import biz.interfaces.nicepay.model.response.data.CashReceiptResVO;
import biz.interfaces.nicepay.model.response.data.VirtualAccountNotiVO;


/**
 * <pre>
 * - 프로젝트명		: gs-apet-11-business
 * - 패키지명		: biz.interfaces.nicepay.service
 * - 파일명		: NicePayNotiService.java
 * - 작성일		: 2021. 03. 15.
 * - 작성자		: sorce
 * - 설명			: 나이스페이 입금통보 서비스
 * </pre>
 */
public interface NicePayNotiService {
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: completeVirtualAccount
	 * - 작성일		: 2021. 03. 15.
	 * - 작성자		: sorce
	 * - 설명			: 무통장입름완료 -> 결제완료 처리
	 * </pre>
	 * @param vo
	 */
	public Boolean completeVirtualAccount(VirtualAccountNotiVO vo) throws ParseException;
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: selectList
	 * - 작성일		: 2021. 03. 18.
	 * - 작성자		: sorce
	 * - 설명			: 테스트용
	 * </pre>
	 * @param vo
	 * @return
	 */
	public List<PayBaseVO> selectList(PayBaseVO vo);
	

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: updateCryptoTest
	 * - 작성일		: 2021. 03. 21.
	 * - 작성자		: sorce
	 * - 설명			: 암호화 테스트
	 * </pre>
	 * @param vo
	 * @return
	 */
	public int updateCryptoTest(PayBaseVO vo);
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: encrypForTable
	 * - 작성일		: 2021. 04. 13.
	 * - 작성자		: sorce
	 * - 설명			: encrypt
	 * </pre>
	 * @param map
	 * @return
	 */
	public int encrypForTable(Map<String, String> map);
	
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: decrypForTable
	 * - 작성일		: 2021. 04. 13.
	 * - 작성자		: sorce
	 * - 설명			: decrypt
	 * </pre>
	 * @param map
	 * @return
	 */
	public int decrypForTable(Map<String, String> map);
}