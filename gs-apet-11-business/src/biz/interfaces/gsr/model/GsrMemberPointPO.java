package biz.interfaces.gsr.model;

import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import lombok.Data;

@Data
public class GsrMemberPointPO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /** 포인트 */
    private String point;

    /** 주문 번호(= ORD_NO + ORD_DTL_SEQ) 단, API 호출 전 PREFIX 인 C를 제외 */
    private String rcptNo;

    /* 적립, 포인트 사용 호출 시 반환 받았던 apprDate ( yyyyMMdd ) */
    private String orgApprDate;

    /* 적립, 포인트 사용 호출 시 반환 받았던 apprNo */
    private String orgApprNo;

    /** 고객 번호*/
    private String custNo;

    /** 구매금액 합계 */
    private String saleAmt;

    /** 판매일자 */
    private String saleDate;

    /** 판매 일시 */
    private String saleEndDt;

    /** BO에서 호출 시 mbrNo 필요 -> api 호출 파라미터 생성 시 제거 대상 */
    private Long mbrNo;
    /** 포인트 사유 사용 코드*/
    private String pntRsnCd;

    /** 아래 값들은 자동으로 SET 해 줍니다. */
    /** 적립 사용 구분*/
    private String accumUseType;
    public void setAccumUseType(String accumUseType){
        this.accumUseType = accumUseType;
        this.pntType = StringUtil.equals(accumUseType, FrontConstants.GSR_POINT_ACCUM) ? FrontConstants.GSR_POINT_TYPE_ACCUM : FrontConstants.GSR_POINT_TYPE_USE ;
    }
    /** 거래 구분*/
    private String dealSp;
    /** 포인트 타입*/
    private String pntType;
    /** 카드 번호*/
    private String cardNo;
    /** 1건 거래에 N건 포인트 타입이 발생 될 때 ( default = 1)*/
    private String pntTypeCnt = "1";
    /** IP 주소*/
    private String ipAddr;

    /** 상품 후기 적립 시, 삭제제*/
   private String ordNoForCheck;
}
