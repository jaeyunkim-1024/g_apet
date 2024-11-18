package biz.interfaces.nicepay.enums;

import java.util.HashMap;

import org.apache.commons.lang.StringUtils;

import biz.interfaces.nicepay.constants.NicePayConstants;
import framework.common.constants.CommonConstants;
import lombok.Getter;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.nicepay.enums
 * - 파일명		: NicePayMapping.java
 * - 작성일		: 2021. 01. 13.
 * - 작성자		: JinHong
 * - 설명		: NICE PAY CODE MAPPING  
 * </pre>
 */
@Getter
@SuppressWarnings({ "unchecked", "rawtypes", "serial" })
public enum NicePayCodeMapping {
	/** 사용 구분 코드 */
	USE_GB(new HashMap() {{ 
		put(CommonConstants.USE_GB_10, NicePayConstants.RECEIPT_TYPE_1);
		put(CommonConstants.USE_GB_20, NicePayConstants.RECEIPT_TYPE_2);
	}}),
	/** 결제 수단 코드 */
	PAY_METHOD(new HashMap() {{ 
		put(CommonConstants.PAY_MEANS_10, NicePayConstants.PAY_METHOD_CARD);
		put(CommonConstants.PAY_MEANS_20, NicePayConstants.PAY_METHOD_BANK);
		put(CommonConstants.PAY_MEANS_30, NicePayConstants.PAY_METHOD_VBANK);
		put(CommonConstants.PAY_MEANS_70, NicePayConstants.PAY_METHOD_CARD);
		put(CommonConstants.PAY_MEANS_71, NicePayConstants.PAY_METHOD_CARD);
		put(CommonConstants.PAY_MEANS_72, NicePayConstants.PAY_METHOD_CARD);
	}}),
	/** 지불 수단 코드 */
	PAY_MEANS(new HashMap() {{ 
		put(CommonConstants.PAY_MEANS_10, NicePayConstants.PAY_MEANS_01);
		put(CommonConstants.PAY_MEANS_20, NicePayConstants.PAY_MEANS_02);
		put(CommonConstants.PAY_MEANS_30, NicePayConstants.PAY_MEANS_03);
		put(CommonConstants.PAY_MEANS_70, NicePayConstants.PAY_MEANS_01);
		put(CommonConstants.PAY_MEANS_71, NicePayConstants.PAY_MEANS_01);
		put(CommonConstants.PAY_MEANS_72, NicePayConstants.PAY_MEANS_01);
	}}),
	/** 은행 코드 - 과오납 변환용 */
	BANK(new HashMap() {{ 
		put(CommonConstants.BANK_04, NicePayConstants.BANK_004);
		put(CommonConstants.BANK_03, NicePayConstants.BANK_003);
		put(CommonConstants.BANK_88, NicePayConstants.BANK_088);
		put(CommonConstants.BANK_20, NicePayConstants.BANK_020);
		put(CommonConstants.BANK_81, NicePayConstants.BANK_081);
	}})
	;
	
	private HashMap<String, String> map;
	
	private NicePayCodeMapping(HashMap<String, String> map) {
		this.map = map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.nicepay.enums
	 * - 작성일		: 2021. 01. 13.
	 * - 작성자		: JinHong
	 * - 설명		: Common Code -> NicePay Code
	 * </pre>
	 * @param grpCd
	 * @param dtlCd
	 * @return
	 */
	public static String getMappingToNiceCode(String grpCd, String dtlCd) {
		return NicePayCodeMapping.valueOf(grpCd).getMap().get(dtlCd);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.nicepay.enums
	 * - 작성일		: 2021. 01. 13.
	 * - 작성자		: JinHong
	 * - 설명		: NicePay Code -> Common Code
	 * </pre>
	 * @param grpCd
	 * @param dtlCd
	 * @return
	 */
	public static String getMappingToCommonCode(String grpCd, String niceCode) {
		
		HashMap<String, String> codeMap = NicePayCodeMapping.valueOf(grpCd).getMap();
		
		for(String key : codeMap.keySet()) {
			if(codeMap.get(key).equals(niceCode)) {
				return key;
			}
		}
		
		return null;
	}
}
