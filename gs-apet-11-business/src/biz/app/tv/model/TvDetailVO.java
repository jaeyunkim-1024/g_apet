package biz.app.tv.model;

import biz.app.goods.model.GoodsImgVO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.model
 * - 파일명		: TvDetailVO.java
 * - 작성일		: 2021. 01. 19. 
 * - 작성자		: LDS
 * - 설 명		: 펫TV 상세 Value Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class TvDetailVO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 영상ID */
	private String vdId;
	
	/** 영상구분코드 */
	private String vdGbCd;
	
	/** 타입코드 */
	private String tpCd;
	
	/** 시리즈번호 */
	private Long srisNo;
	
	/** 시즌번호 */
	private Long sesnNo;
	
	/** 영상파일번호 */
	private Long flNo;
	
	/** 전시여부 */
	private String dispYn;
	
	/** 영상제목 */
	private String ttl; 
	
	/** 영상내용 */
	private String content;
	
	/** 영상음원저작권 */
	private String crit;
	
	/** 영상타입코드 */
	private String vdTpCd;
	
	/** 조회수 */
	private Long hits;
	
	/** 펫구분코드 */
	private String petGbCd;
	
	/** 펫구분코드명 */
	private String petGbNm;
	
	/** 교육용컨텐츠카테고리_L_코드 */
	private String ctgLcd;
	
	/** 교육용컨텐츠카테고리_L_코드명 */
	private String ctgLnm;
	
	/** 교육용컨텐츠카테고리_M_코드 */
	private String ctgMcd;
	
	/** 교육용컨텐츠카테고리_M_코드명 */
	private String ctgMnm;
	
	/** 교육용컨텐츠카테고리_S_코드 */
	private String ctgScd;
	
	/** 교육용컨텐츠카테고리_S_코드명 */
	private String ctgSnm;
	
	/** 난이도코드 */
	private String lodCd;
	
	/** 준비물코드 */
	private String prpmCd;
	
	/** 시스템 등록자번호 */
	//private Long sysRegrNo;
	
	/** 시스템 등록 일시 */
	//private Timestamp sysRegDtm;
	
	/** 시스템 등록일 */
	private String sysRegDt;
	
	/** 시스템 수정자번호 */
	//private Long sysUpdrNo;
	
	/** 시스템 수정 일시 */
	//private Timestamp sysUpdDtm;
	
	/** 시스템 수정일 */
	private String sysUpdDt;
	
	/** 영상썸네일경로 */
	private String acPrflImgPath;
	
	/** 외부영상ID */
	private String acOutsideVdId;
	
	/** 시리즈ID */
	private String srisId;
	
	/** 시리즈명 */
	private String srisNm;
	
	/** 시리즈파일번호 */
	private Long srisFlNo;
	
	/** 시리즈프로필경로 */
	private String srisPrflImgPath;
	
	/** 시리즈 광고여부 */
	private String srisAdYn;
	
	/** 시즌명 */
	private String sesnNm;
	
	/** 영상 태그 */
	private String acTagNo;
	
	/** 영상 태그명 */
	private String acTagNm;
	
	/** 영상 좋아요여부 */
	private String likeYn;
	
	/** 영상 찜여부 */
	private String dibsYn;
	
	/** 댓글수 */
	private int replyCnt;
	
	/** 전체시리즈(시즌) 목록의 영상길이 */
	private int acTotTime;
	
	/** 전체시리즈(시즌) 목록의 시청길이 */
	private int acPlayTime;
	
	/** 전체시리즈(시즌) 목록의 NEW여부 */
	private String newYn;
	
	/** 전체시리즈(시즌) 목록의 좋아요수 */
	private Long likeCnt;
	
	/** 전체시리즈(시즌) 목록의 현 시청여부 */
	private String nowPlayYn;
	
	/** 전체시리즈(시즌) 목록의 영상길이 텍스트 */
	private String acTotTimeStr;
	
	/** 전체시리즈(시즌) 목록의 시청길이 프로그레스바 */
	private int progressBar;
	
	/** 전체시리즈(시즌) 목록의 영상수 */
	private int vdCnt;
	
	/** 추천TV 목록의 일치율 & 상세의 일치율 */
	private String rate;
	
	/** 교육완료영상파일번호 */
	private Long cmplFlNo;
	
	/** 교육외부영상ID */
	private String acdOutsideVdId;
	
	/** 연관상품 갯수 */
	private int goodsCount;
	
	/** 연관상품 썸네일 정보 */
	private GoodsImgVO goodsImgVO;
	
	/** 단축URL */
	private String srtUrl;
	
	/** 시리즈 반복여부(임시컬럼 추후 삭제) */
	private String repeatYn;
	
	/** 시리즈 정렬순서 */
	private Long srisSeq; 
}
