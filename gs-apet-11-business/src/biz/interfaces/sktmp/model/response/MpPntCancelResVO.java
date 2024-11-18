package biz.interfaces.sktmp.model.response;

import java.io.Serializable;

import biz.interfaces.sktmp.constants.SktmpConstants;
import biz.interfaces.sktmp.model.StrLenVO;
import lombok.Data;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model.response
 * - 파일명		: MpPntCancelResVO.java
 * - 작성일		: 2021. 06. 30.
 * - 작성자		: JinHong
 * - 설명		:  MP 포인트 취소 응답 전문
 * </pre>
 */
@Data
public class MpPntCancelResVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	/** 전문 유형 */
	private StrLenVO msgType = new StrLenVO(4);
	
	/** 거래 금액 : Right Justify(할인전금액 입력) */
	private StrLenVO dealAmt = new StrLenVO(12, StrLenVO.Type.INTEGER);
	
	/** MP포인트 사용 금액 : Right Justify(할인전금액 입력) 
	 * 1.포인트 사용 없으면 0처리
	 * 2.MAX 처리시 거래금액과 동일하게 처리
	 * -요청 MP포인트와 다를 수 있음 (예 : 고객 MAX 사용 요청시 or 부스트 이벤트 등)
	 * */
	private StrLenVO useMpPnt = new StrLenVO(12, StrLenVO.Type.INTEGER);
	
	/** 전문 전송 일시 : YYYYMMDDhhmmss */
	private StrLenVO msgSndDtm = new StrLenVO(14);
	
	/** 카드 번호 : SK-T 멤버십 번호 */
	private StrLenVO cardNum = new StrLenVO(16);
	
	/** 거래 고유 번호 : ‘67’ + 고유번호(10자리) */
	private StrLenVO dealNum = new StrLenVO(12);
	
	/** 단말# : FIX - 1000000000*/
	private StrLenVO device = new StrLenVO(10);
	
	/** 가맹점# : 제휴사코드 4자리 +  점포코드 4자리 + SPACE  2자리 */
	private StrLenVO storeNum = new StrLenVO(10);
	
	/** 상품 유형 : 4자리 상품코드(default:’    ’)  */
	private StrLenVO goodsType = new StrLenVO(4);
	
	/** 취소 구분 코드 : 91:단말기취소  */
	private StrLenVO cancelGbCd = new StrLenVO(SktmpConstants.CANCEL_GB_NORMAL, 2);
	
	/** 응답 코드 : 승인:00, 거절:define要  */
	private StrLenVO resCd = new StrLenVO(2);
	
	/** 승인 번호 : 취소 승인 번호  */
	private StrLenVO apprNum = new StrLenVO(8);
	
	/** 잔여 MP 포인트 */
	private StrLenVO rmnMpPnt = new StrLenVO(10, StrLenVO.Type.INTEGER);
	
	/** 적립 MP 포인트 */
	private StrLenVO accumMpPnt = new StrLenVO(10, StrLenVO.Type.INTEGER);
	
	/** dummy*/
	private StrLenVO dummy = new StrLenVO(26);
	
	public void setMsgType(String msgType) {
		this.msgType.setValue(msgType);
	}

	public void setDealAmt(String dealAmt) {
		this.dealAmt.setValue(dealAmt);
	}

	public void setUseMpPnt(String useMpPnt) {
		this.useMpPnt.setValue(useMpPnt);
	}

	public void setMsgSndDtm(String msgSndDtm) {
		this.msgSndDtm.setValue(msgSndDtm);
	}

	public void setCardNum(String cardNum) {
		this.cardNum.setValue(cardNum);
	}

	public void setDealNum(String dealNum) {
		this.dealNum.setValue(dealNum);
	}

	public void setDevice(String device) {
		this.device.setValue(device);
	}

	public void setStoreNum(String storeNum) {
		this.storeNum.setValue(storeNum);
	}

	public void setGoodsType(String goodsType) {
		this.goodsType.setValue(goodsType);
	}

	public void setResCd(String resCd) {
		this.resCd.setValue(resCd);
	}

	public void setApprNum(String apprNum) {
		this.apprNum.setValue(apprNum);
	}

	public void setRmnMpPnt(String rmnMpPnt) {
		this.rmnMpPnt.setValue(rmnMpPnt);
	}

	public void setAccumMpPnt(String accumMpPnt) {
		this.accumMpPnt.setValue(accumMpPnt);
	}

	public void setCancelGbCd(String cancelGbCd) {
		this.cancelGbCd.setValue(cancelGbCd);
	}

	public void setDummy(String dummy) {
		this.dummy.setValue(dummy);
	}
}
