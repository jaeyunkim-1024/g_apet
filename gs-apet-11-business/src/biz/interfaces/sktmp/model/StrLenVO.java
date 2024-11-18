package biz.interfaces.sktmp.model;

import org.apache.commons.lang.StringUtils;

import lombok.Data;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model
 * - 파일명		: StrLenVO.java
 * - 작성일		: 2021. 06. 28.
 * - 작성자		: kjhvf01
 * - 설명		: 전문 데이터 String and length
 * </pre>
 */
@Data
public class StrLenVO {
	
	/** 항목 값 */
	private String value;
	
	/** 항목 당 Byte */
	private Integer len;
	
	/**
	 * String or Interger 남는 전문 처리
	 * String  -> 공백처리
	 * Integer -> 0 처리
	 * */ 
	private Type type;
	
	
	public StrLenVO(String value, Integer len) {
		this.value = value;
		this.len = len;
		this.type = Type.STRING;
	}
	
	public StrLenVO(Integer len) {
		this.len = len;
		this.type = Type.STRING;
	}
	
	public StrLenVO(Integer len, Type type) {
		this.len = len;
		this.type = type;
	}

	public enum Type {
		STRING, INTEGER;
	}
	
	public Integer getIntValue() {
		if(StringUtils.isNumeric(this.value)) {
			return Integer.parseInt(this.value);
		}else {
			return null;
		}
	}
}