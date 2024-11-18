package biz.app.search.model;

import framework.common.util.StringUtil;
import lombok.Data;

@Data
public class LogMemberVO {
	
	/** 닉네임 */
	private String nick_nm;
	
	/** 펫로그 url */
	private String pet_log_url;
	
	/** 팔로워 수 */
	private Long follow_cnt;
	
	/** 로그 수 */
	private Long log_cnt;
	
	
	private String prfl_img;
	
	/** 회원번호 */
	private Long mbr_no;
	
	public String getNick_nm() {
		return (StringUtil.isBlank(nick_nm))?"":nick_nm.replaceAll("¶HS¶", "<span>").replaceAll("¶HE¶", "</span>");
	}
}
