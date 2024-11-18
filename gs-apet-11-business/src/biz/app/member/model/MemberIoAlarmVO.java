package biz.app.member.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberIoAlarmVO extends BaseSysVO {
	
	/** UID */
	private static final long serialVersionUID = 1L;

	/** 알림 번호 */
	private Long goodsIoAlmNo;
	/** 회원번호 */
	private Long mbrNo;
	/** 회원명 */
	private String mbrNm;
	/** 상품 아이디 */
	private String goodsId;
	/** 상품 명 */
	private String goodsNm;
	/** 묶음상품 아이디 */
	private String pakGoodsId;
	/** 알림 여부 */
	private String almYn;
	/** 알림 발송여부 */
	private String almSndDtm;
	/** 삭제여부 */
	private String delYn;
	/** 관리자 삭제여부 */
	private String sysDelYn;

//	/** 등록 회원번호 */
//	private Long sysRegrNo;
//	/** 등록일 */
//	private String sysRegDtm;
//	/** 수정 회원번호 */
//	private Long sysUpdrNo;
//	/** 수정일 */
//	private String sysUpdDtm;
	/** 삭제 회원번호 */
	private Long sysDelrNo;
	/** 삭제일 */
	private Timestamp sysDelDtm;

	/** 이력 통지 번호 */
	private int noticeSendNo;



}
