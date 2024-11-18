package biz.interfaces.nicepay.dao;

import biz.app.pay.model.PayBaseVO;
import biz.interfaces.naver.model.NaverEpVO;
import biz.interfaces.nicepay.model.response.data.VirtualAccountOrderVO;
import framework.common.dao.MainAbstractDao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Properties;

/**
 * <pre>
 * - 프로젝트명		: gs-apet-11-business
 * - 패키지명		: biz.interfaces.nicepay.dao
 * - 파일명		: NicePayNotiDao.java
 * - 작성일		: 2021. 03. 15.
 * - 작성자		: sorce
 * - 설명			: 결제완료 처리
 * </pre>
 */
@Repository
public class NicePayNotiDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "nicePayNoti.";

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: updateOrderInfoVirtualAccount
	 * - 작성일		: 2021. 03. 15.
	 * - 작성자		: sorce
	 * - 설명			: 가상계좌 입금 완료 시 주문 상태값 수정
	 * </pre>
	 * @param vo
	 * @return
	 */
	public int updateOrderInfoVirtualAccount(VirtualAccountOrderVO vo) {
		return update(BASE_DAO_PACKAGE + "updateOrderInfoVirtualAccount", vo);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: updatePayInfoVirtualAccount
	 * - 작성일		: 2021. 03. 15.
	 * - 작성자		: sorce
	 * - 설명			: 가상계좌 입금 완료 시 결제 정보 업데이트
	 * </pre>
	 * @param vo
	 * @return
	 */
	public int updatePayInfoVirtualAccount(PayBaseVO vo) {
		return update(BASE_DAO_PACKAGE + "updatePayInfoVirtualAccount", vo);
	}
	
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
	public List<PayBaseVO> selectList(PayBaseVO vo) {
		return selectList(BASE_DAO_PACKAGE + "selectList", vo);
	}

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
	public int updateCryptoTest(PayBaseVO vo) {
		return update(BASE_DAO_PACKAGE + "updateCryptoTest", vo);
	}

	public List<Map<String, Object>> selectTargetList(Map<?, ?> map) {
		return selectList(BASE_DAO_PACKAGE + "selectTargetList", map);
	}
	
	public Integer updateTargetField(Map<?, ?> map) {
		return update(BASE_DAO_PACKAGE + "updateTargetField", map);
	}

}
