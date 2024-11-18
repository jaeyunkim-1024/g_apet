package biz.app.search.model;

import framework.common.util.StringUtil;
import lombok.Data;

@Data
public class ShopBrandVO {
	
	/** 브랜드 번호 */
	private Long bnd_no;
	
	/** 브랜드 명 */
	private String bnd_nm_ko;	
	
	public String getBnd_nm_ko() {
		return (StringUtil.isBlank(bnd_nm_ko))?"":bnd_nm_ko.replaceAll("¶HS¶", "<span>").replaceAll("¶HE¶", "</span>");
	}
}
