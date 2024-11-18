package biz.interfaces.cis.model.request.goods;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import biz.app.brand.model.BrandCisVO;
import lombok.Data;
import lombok.EqualsAndHashCode;



/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.interfaces.cis.model.request.goods
* - 파일명 	: CisBrandPO.java
* - 작성일	: 2021. 4. 7.
* - 작성자	: valfac
* - 설명 		: cis 브랜드 po
* </pre>
*/
@Data
@JsonIgnoreProperties(value = { "cisDtm", "cisMinute"})
@EqualsAndHashCode(callSuper=true)
public class CisBrandPO extends BrandCisVO {
	
}
