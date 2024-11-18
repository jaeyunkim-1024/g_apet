package biz.app.search.model;

import framework.common.util.StringUtil;
import lombok.Data;

@Data
public class TvSeriesVO {
	
	/** 시리즈 번호 */
	private Long sris_no;
	
	/** 시즌 번호 */
	private Long sesn_no;
	
	/** 시리즈 명 */
	private String sris_nm;
	
	/** 시즌 명 */
	private String sesn_nm;
	
	/** 시리즈 이미지 */
	private String sris_img;
	
	public String getSris_nm() {
		return (StringUtil.isBlank(sris_nm))?"":sris_nm.replaceAll("¶HS¶", "<span>").replaceAll("¶HE¶", "</span>");
	}
	
	public String getSesn_nm() {
		return (StringUtil.isBlank(sesn_nm))?"":sesn_nm.replaceAll("¶HS¶", "<span>").replaceAll("¶HE¶", "</span>");
	}
}
