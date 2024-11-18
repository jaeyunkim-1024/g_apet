package biz.app.order.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BatchOrderVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 결제 번호 */
	private Integer payNo;

	/** 원 결제 번호 */
	private Long orgPayNo;

	/** 주문 클레임 구분 코드 */
	private String ordClmGbCd;

	/** 주문 번호 */
	private String ordNo;

	/** 회원 번호 */
	private Integer mbrNo;

	/** 회원 명 */
	private String mbrNm;

	/** 로그인 아이디 */
	private String loginId;

	/** 전화 */
	private String tel;

	/** 휴대폰 */
	private String mobile;

	/** 이메일 */
	private String email;

	/** 이메일 수신 여부 */
	private String emailRcvYn;

	/** SMS 수신 여부 */
	private String smsRcvYn;

	/** 적립금 잔여 금액 */
	private Long svmnRmnAmt;

	/** 예치금 잔여 금액 */
	private Long blcRmnAmt;

	/** 회원 등급 코드 */
	private String mbrGrdCd;

	/** 회원 등급 명 */
	private String mbrGrdNm;
}