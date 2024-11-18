package biz.app.system.model;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DeliverDateSetSO extends BaseSearchVO<DeliverDateSetSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 직배송아이디 */
	private Integer dsId;

	/** 직배지역코드 */
	private Integer areaId;

	/** 구분(1:기간,2:이후) */
	private String deliverGubunCd;

	/** 배송일자 */
	private String deliverDate;

	/** 배송일자 */
	private String strtDate;

	private String endDate;

	/** 지역코드 */
	private String areaCd;
	
	/** 배송년,월 */
	private String deliveryYear;
	private String deliveryMonth;
	
	/** 우편번호 */
	private String postNoOld;
	private String postNoNew;
	
	/* 총부피 */
	private Integer vlmTotal;

	/* 총수량 */
	private Integer qtyTotal;
	
	/* 가중치 적용될 부피 합계 */
	private Integer vlmAddTotal;
	
	/* 가중치 적용될 수량 합계 */
	private Integer qtyAddTotal;
	
	/** 수량 */
	private Integer qty;
	
	/** 단품번호 */
	private String itemNos;
	
	/** 단품수량 */
	private String qtys;
	
	/* 조립서비스 유무 */
	private String asbSvcs;
	
	/* 달력 유형 */
	private String calendarType;
	
	/* 달력 검색 시작 기준일 */
	private Integer startPeriod;

	/* 달력 검색 종료 기준일 */
	private Integer endPeriod;
	
	/** bom 코드 */
	private List<String> bomNos;

}