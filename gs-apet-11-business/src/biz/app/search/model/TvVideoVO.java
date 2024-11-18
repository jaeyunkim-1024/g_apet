package biz.app.search.model;

import framework.common.util.StringUtil;
import lombok.Data;

@Data
public class TvVideoVO {
	
	/** 영상번호 */
	private String vd_id;
	
	/** 조회수 */
	private Long hits;
	
	/** 좋아요 */
	private Long like_cnt;
	
	/** 썸네일 경로 */
	private String thum_path;
	
	/** 시리즈 명 */
	private String sris_nm;
	
	/** 시즌 명 */
	private String sesn_nm;
	
	/** 제목 */
	private String ttl;
	
	/** 시리즈 ID */
	private String sris_id;
	
	/** 영상 길이 */
	private String vd_lnth;
	
	public String getTtl() {
		return (StringUtil.isBlank(ttl))?"":ttl.replaceAll("¶HS¶", "<span>").replaceAll("¶HE¶", "</span>");
	}
	
	public String getVd_lnth() {
		if(vd_lnth == null || vd_lnth.equals("0")) {
			return "00:00";
		}else {
			long vdLnth = Long.parseLong(vd_lnth);
			String min = ((vdLnth/60) < 10)? String.valueOf("0"+(vdLnth/60)) : String.valueOf(vdLnth/60);
			String sec = ((vdLnth%60) < 10)? String.valueOf("0"+(vdLnth%60)) : String.valueOf(vdLnth%60);
			return min+":"+sec;
		}
	}
}
