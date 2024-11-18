package biz.app.contents.model;

import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class VodVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** rownum */
	private Long rowIndex;

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

	/** 시리즈 여부 */
	private String srisYn;

	/** 전시 여부 */
	private String dispYn;

	/** 썸네일 자동 여부 */
	private String thumAutoYn;

	/** 파일 번호 */
	private Long flNo;

	/** 썸네일 경로 */
	private String thumPath;

	/** 썸네일 다운로드 url */
	private String thumImgDownloadUrl;

	/** 이미지 경로 */
	private String imgPath;

	/** 큰 배너 이미지 경로 */
	private String bnrImgPathL;

	/** 작은 배너 이미지 경로 */
	private String bnrImgPathS;
	
	/** PC 배너 이미지 경로 */
	private String bnrImgPathPc;

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
	
	/** 매칭률*/
	private String rate;
	
	/** 매칭률*/
	private Integer intRate;

	/** 교육용 컨텐츠 카테고리 코드 */
	private String edcContsCtgCd;

	/** 난이도 코드 */
	private String lodCd;

	/** 준비물 코드 */
	private String prpmCd;
	
	/** 컨텐츠 상태 코드 */
	private String contsStatCd;
	
	/** 좋아요 수 */
	private Long likeCnt;
	
	/** 댓글 수 */
	private Long replyCnt;
	
	/** 공유 수 */
	private Long shareCnt;

	/** 시리즈 명 */
	private String srisNm;
	
	/** 시즌 번호 */
	private Long sesnNo;
	
	/** 시즌 명*/
	private String sesnNm;
	
	/** 시청 시간*/
	private Integer histLnth;
	
	/** 영상 시간*/
	private Integer totalLnth;
	
	/** 영상 총 시간 계산*/
	private String totLnth;
	
	/** 태그 명*/
	private String tagNm;
	
	/** 태그 번호*/
	private String tagNo;
	
	/** 펫 구분 코드 */
	private String petGbCd;
	
	private ApetAttachFileVO vodFile;
	
	private ApetAttachFileVO thumImg;
	
	private ApetAttachFileVO thumVod;
	
	private ApetAttachFileVO topDispImg;
	
	/** 교육 시청이력 */
	private Long stepProgress;
	
	/** 찜 수 */
	private Long zzimCnt;
	
	/** 새로 올라온 영상인지 확인 유무 */
	private String NewYn;
	
	/** 정렬순서 */
	private Long sortCd;
	
	/** 랜덤시리즈 리스트 */
	private List<SeriesVO> srisRandomList;
	
	/** 태그리스트 */
	private List<VodVO> tagList;
	
	/** 연관 상품 리스트 */
	private List<VodGoodsVO> goodsList;
	private int goodsCount;
	
	/** 시리즈 프로필 이미지 경로 */
	private String srisPrflImgPath;
	
	/** 회원번호 */
	private Long mbrNo;
	
	/** 찜 여부 */
	private String zzimYn;
	
	/** 좋아요 여부 */
	private String likeYn;
	
	/** 교육용 컨텐츠 카테고리_M_코드 */
	private String eudContsCtgMCd;
	
	/** 교육용 컨텐츠 카테고리_S_코드 */
	private String eudContsCtgSCd;
	
	/** 교육용 컨텐츠 카테고리_M_코드 명 */
	private String ctgMnm;
	
	/** 교육용 컨텐츠 카테고리_M_코드 약어명 */
	private String ctgShtMnm;
	
	/** 교육 영상 시청 기록 유무 판단*/
	private String schlViewYn;

	/** 이력 번호 */
	private Long histNo;
	
	/** short url */ 
	private String srtUrl;

	/** 영상 파일명 */
	private String vodNm;

	/** 영상 썸네일명*/
	private String thumNm;

	/** 영상 타입명 */
	private String tpNm;

	/** 시리즈 타입명 */
	private String srisTpNm;
	
}