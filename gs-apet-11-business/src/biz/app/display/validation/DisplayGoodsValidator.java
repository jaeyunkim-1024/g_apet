package biz.app.display.validation;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import biz.app.display.dao.DisplayDao;
import biz.app.display.model.DisplayGoodsPO;
import framework.admin.constants.AdminConstants;
import framework.admin.util.LogUtil;
import framework.common.util.StringUtil;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.validation
* - 파일명		: GoodsValidation.java
* - 작성일		: 2016. 5. 20.
* - 작성자		: valueFactory
* - 설명		: 상품 일괄 업로드 검증
* </pre>
*/
public class DisplayGoodsValidator {

	private MessageSourceAccessor message;
	private DisplayDao displayDao;

	public DisplayGoodsValidator () {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		ServletContext context = request.getSession().getServletContext();
		ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(context);

		message = ac.getBean(MessageSourceAccessor.class );
		displayDao = ac.getBean(DisplayDao.class );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayGoodsValidator.java
	 * - 작성일		: 2016. 6. 30.
	 * - 작성자		: valueFactory
	 * - 설명		: 검증
	 * </pre>
	 * @param po
	 * @return
	 */
	public boolean validateDisplayGoods(DisplayGoodsPO po) {
		boolean rtnVal = true;

		// 넘어온 데이터가 없으면
		if(po == null ) {
			return false;
		}

		// 성공으로 하고.. 아래 검사시 오류건에 대해서 처리
		po.setSuccessYn(AdminConstants.COMM_YN_Y );

		// 상품ID
		if(!validateGoodsId(po)) {
			rtnVal = false;
		}

		LogUtil.log(po);

		return rtnVal;
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsValidatior.java
	* - 작성일		: 2016. 5. 20.
	* - 작성자		: valueFactory
	* - 설명		: 상품아이디 검사
	* </pre>
	* @param po
	* @return
	*/
	public boolean validateGoodsId(DisplayGoodsPO po) {
		boolean rtnVal = true;
		String goodsId = null;
		String msg = "";
		String key = message.getMessage("column.goods_id" );

		goodsId = po.getGoodsId();

		// NotNull
		msg = ValidationUtil.notNull(goodsId, key);
		if(StringUtil.isNotEmpty(msg)) {
			setFailMsg(po, msg);
			rtnVal = false;
		}

		// 중복된 상품번호 검사
		if(displayDao.checkGoodsId(po) > 0) {
			msg = String.format("이미 등록된 [%s]", key);
			setFailMsg (po, msg);
			rtnVal = false;
		}

		return rtnVal;
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsValidator.java
	* - 작성일		: 2016. 5. 23.
	* - 작성자		: valueFactory
	* - 설명		: 실패 메시지
	* </pre>
	* @param po
	* @param failMsg
	*/
	public void setFailMsg(DisplayGoodsPO po, String failMsg) {
		// 실패
		po.setSuccessYn(AdminConstants.COMM_YN_N );

		if(StringUtil.isEmpty(po.getResultMessage())) {
			po.setResultMessage(failMsg);
		} else {
			String orgMsg = po.getResultMessage();
			po.setResultMessage(orgMsg + "\n" + failMsg);
		}
	}
}