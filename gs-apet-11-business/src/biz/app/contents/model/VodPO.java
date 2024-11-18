package biz.app.contents.model;

import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class VodPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 영상 ID */
	private String vdId;
	
	/** SGR 영상 ID */
	private String outsideVdId;

	/** 영상 구분 코드 */
	private String vdGbCd;

	/** 타입 코드 */
	private String tpCd;

	/** 시리즈 번호 */
	private Long srisNo;

	/** 시즌 번호 */
	private Long sesnNo;

	/** 전시 여부 */
	private String dispYn;

	/** 썸네일 자동 여부 */
	private String thumAutoYn;

	/** 파일 번호 */
	private Long flNo;

	/** 영상 경로 */
	private String vodPath;

	/** 영상 명 */
	private String vodNm;

	/** 영상 파일 사이즈 */
	private Long vodFlSz;
	
	/** 썸네일 경로 */
	private String thumImgPath;

	/** 썸네일 다운로드 url */
	private String thumImgDownloadUrl;

	/** 썸네일 변경 다운로드 url */
	private String thumImgChgDownloadUrl;

	/** 썸네일 명 */
	private String thumImgNm;

	/** 썸네일 파일 사이즈 */
	private Long thumImgFlSz;

	/** 상단 노출 경로 */
	private String topImgPath;

	/** 상단 노출 이미지 명 */
	private String topImgNm;

	/** 상단 노출 이미지 파일 사이즈 */
	private Long topImgFlSz;

	/** 큰 배너 이미지 경로 */
	private String bnrImgPathL;

	/** 작은 배너 이미지 경로 */
	private String bnrImgPathS;

	/** 제목 */
	private String ttl;

	/** 내용 */
	private String content;

	/** 음악 저작권 */
	private String crit;

	/** 영상 타입 코드 */
	private String vdTpCd;

	/** 조회수 */
	private Long hits;

	/** 교육용 컨텐츠 카테고리 코드 */
	private String edcContsCtgCd;

	/** 난이도 코드 */
	private String lodCd;

	/** 준비물 코드 */
	private String prpmCd;
	
	/** 컨텐츠 상태 코드 */
	private String contsStatCd;
	
	/** 펫 구분 코드 */
	private String petGbCd;

	/** tags */
	private String[] tags;
	
	/** paths */
	private String[] paths;
	
	/** names */
	private String[] names;
	
	/** flSzs */
	private Long[] flSzs;
	
	/** vdLnthArr */
	private Long[] vdLnthArr;
	
	/** vdLnth */
	private Long vdLnth;

	/** 연동 상품 리스트 */
	private List<VodGoodsPO> vodGoodsPoList;
	
	/** short url */ 
	private String srtUrl;

}