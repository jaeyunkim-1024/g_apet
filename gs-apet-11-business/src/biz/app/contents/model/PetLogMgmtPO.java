package biz.app.contents.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetLogMgmtPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 펫로그 번호 */
	private Long petLogNo;
	
	/** 펫로그 설명 */
	private String dscrt;
	
	/** 펫로그 회원번호 */
	private Long mbrNo;
	
	/** 펫로그 이미지경로1 */
	private String imgPath1;
	
	/** 펫로그 이미지경로2 */
	private String imgPath2;
	
	/** 펫로그 이미지경로3 */
	private String imgPath3;
	
	/** 펫로그 이미지경로4 */
	private String imgPath4;
	
	/** 펫로그 이미지경로5 */
	private String imgPath5;
	
	/** 펫로그 동영상경로 */
	private String vdPath;
	
	/** 펫로그 조회수 */
	private Long hits;
	
	/** 펫로그 상품추천여부 */
	private String goodsMapYn;
	
	/** 펫로그 신고수 */
	private Long claimCnt;
	
	/** 펫로그 전시구분 */
	private String dispGb;
	
	/** 펫로그 제재여부 */
	private String restrictYn;
	
	/** 펫로그 태그 */
	private String tag;
	
	/** 펫로그 전시구분 */
	private String contsStatCd;
	
	/** 펫로그 제재여부 */
	private String snctYn;

}