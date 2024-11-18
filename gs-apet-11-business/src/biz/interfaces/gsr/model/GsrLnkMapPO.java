package biz.interfaces.gsr.model;

import lombok.Data;

import java.io.Serializable;

@Data
public class GsrLnkMapPO implements Serializable {
    /** 고객 번호 */
    private String gsptNo;

    /** 고유 랜덤 번호 */
    private String rcptNo;
        
    /** 주문 번호 */
    private String ordNo;
    
    /** 펫 로그 번호 */
    private Long petLogNo;
    
    /** 펫 로그 후기 번호 */
    private Long goodsEstmNo;
    
    /** 거래 번호 -> 포인트 사용, 포인트 적립 시에는 API 반환 값*/
    private String apprNo;
    
    /** 거래 일시 -> 포인트 사용, 포인트 적립 시에는 API 반환 값 */
    private String apprDate;
    
    /** 취소 거래 번호  -> 포인트 사용 취소, 포인트 적립 취소시에는 호출 할 때 SET 해줘야하는 값 */
    private String orgApprNo;

    /** 취소 거래 일시 -> 포인트 사용 취소, 포인트 적립 취소시에는 호출 할 때 SET 해줘야하는 값 */
    private String orgApprDate;

    /** 시스템 등록자 */
    private Long sysRegrNo;
}
