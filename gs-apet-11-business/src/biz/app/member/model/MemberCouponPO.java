package biz.app.member.model;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.member.model
* - 파일명		: MemberCouponPO.java
* - 작성일		: 2017. 2. 21.
* - 작성자		: snw
* - 설명			: 회원 쿠폰 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class MemberCouponPO extends BaseSysVO{

	private static final long serialVersionUID = 1L;

	/** 회원 쿠폰 번호 */
	private Long		mbrCpNo;

	/** 주문 번호 */
	private String		ordNo;

	/** 사용시작일시 */
	private Timestamp useStrtDtm;

	/** 사용종료일시 */
	private Timestamp useEndDtm;

	/** 발급 유형 코드 */
	private String isuTpCd;


	//======================================

	/** 쿠폰 번호 */
	private Long		cpNo;

	/** 회원 번호 */
	private Long		mbrNo;

	/** 쿠폰 발급 수량 */
	private Long		cpIsuQty;

	/** 사용 여부 */
	private String		useYn;

	/** 사용 일시 */
	private Timestamp	useDtm;

	/** 발급일련번호 */
	private String 		isuSrlNo;


	/** 웹모바일구분코드 */
	private List<String> webMobileGbCds;

	/** 발급 받는 회원의 상태 */
	private String mbrStatCd;

	/** 회원 정회원,준회원 체크 */
	private String mbrGbCd;

	/** 회원 등급 쿠폰 - 자동지급 상세 코드 */
	private List<String> dtlCds;

	/** 회원 등급 코드 */
	private String mbrGrdCd;

	private String mbrNos;
}