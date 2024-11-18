package biz.app.settlement.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SettlementSO extends BaseSearchVO<SettlementSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 정산 번호 */
	private Long stlNo;

	/** 정산 월 */
	private String stlMonth;
	
	/** 정산 차수 */
	private Integer stlOrder;
	
	/** 업체 번호 */
	private Integer compNo;

	/** 업체 번호 */
	private Integer orgCompNo;

	/** 업체 구분 코드 */
	private String compGbCd;
	
	/** 사이트 id */
	private Integer stId;

	/** 사용자 번호 */
	private Long mdUsrNo;	
	
	/** 집계 일자 */
	private String totalDt;
	
	/** 상세 순번 */
	private Integer dtlSeq;	
	
	/** 페이지 구분 코드 */
	private String pageGbCd;

	/** 시스템 등록 일시 : Start */
	private Timestamp sysRegDtmStart;
	
	/** 시스템 등록 일시 : End */
	private Timestamp sysRegDtmEnd;
	
	/** 전체 하위업체 표시 플래그 */
	private String showAllLowCompany;
	
	/** 하위 업체 번호 */
	private Long lowCompNo;	

	/** 정산 YEAR */
	private String selYear;
	
	/** 정산 MONTH */
	private String selMon;
	
	/** 지급 상태 코드 */
	private String pvdStatCd;
	
	/** 업체 번호 */
	private String selectCompNo;
	
	/** 하위 업체 번호 */
	private String showAllLowComp;
	
	/** MD명 */
	private String mdUsrNm;
	
	/** 업체 정산 번호 */
	private Long[] arrStlNo;
	
	/** 업체 정산 번호 */
	private Long[] stlNos;
	
	/** 정산 차수 */
	private Long[] stlOrders;
	
	/** 업체 번호 */
	private Long[] compNos;

	/** 사이트 id */
	private Long[] stIds;	

}
