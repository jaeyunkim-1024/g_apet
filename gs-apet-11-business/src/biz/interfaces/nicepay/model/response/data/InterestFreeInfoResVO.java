package biz.interfaces.nicepay.model.response.data;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import biz.interfaces.nicepay.model.response.ResponseCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class InterestFreeInfoResVO extends ResponseCommonVO{
	private static final long serialVersionUID = 1L;

	/** header */
	private Header header;
	
	/** body */
	private Body body;
	
	/**
	 * Header
	 */
	@Data
	public static class Header {
		/** 전문ID */
		private String sid;
		/** API 전송 일시 (YYYYMMDDHHMISS)*/
		private String trDtm;
		/** 구분 */
		private String gubun;
		/** 결과코드 */
		private String resCode;
		/** 결과메세지 */
		private String resMsg;
	}
	/**
	 * Body
	 */
	@Data
	public static class Body {
		/** 상점 아이디 */
		private String mid;
		/** 대상일자 (yyyymmdd) */
		private String targetDt;
		/** 데이터 Count */
		private int    dataCnt;
		/** 무이자 할부 정보 */
		private List<InterestFreeInfoItemResVO> data;
	}
	
}
