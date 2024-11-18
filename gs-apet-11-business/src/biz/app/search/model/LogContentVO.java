package biz.app.search.model;

import lombok.Data;

@Data
public class LogContentVO {
	
	/** 영상경로 */
	private String vd_path;
	
	/** 태그 */
	private String tag_nm[];
	
	/** 이미지 경로 */
	private String img_path1;
	
	private String img_path2;
	
	private String img_path3;
	
	private String img_path4;
	
	private String img_path5;
	
	/** 펫로그 번호 */
	private Long pet_log_no;
	
	/** 영상 썸네일 경로 */
	private String vd_thum_path;
}
