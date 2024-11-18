package biz.app.contents.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EduContsPO extends ApetContentsPO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 썸네일 물리 경로 */
	private String thumbImgPath;

	/** 썸네일 원 파일 명 */
	private String thumbImgOrgFlNm;

	/** 썸네일 크기 */
	private Long thumbImgSize;
	
	/** 썸네일 다운로드 URL */
	private String thumbDownloadUrl;

	/** PC배너 물리 경로 */
	private String bnrPcPath;

	/** PC배너 원 파일 명 */
	private String bnrPcOrgFlNm;

	/** PC배너 크기 */
	private Long bnrPcSize;
	
	/** 큰배너 물리 경로 */
	private String bnrLPath;

	/** 큰배너 원 파일 명 */
	private String bnrLOrgFlNm;

	/** 큰배너 크기 */
	private Long bnrLSize;
	
	/** 작은배너 물리 경로 */
	private String bnrSPath;

	/** 작은배너 원 파일 명 */
	private String bnrSOrgFlNm;

	/** 작은배너 크기 */
	private Long bnrSSize;
	
	/** 영상 물리 경로 */
	private String vodPath;

	/** 영상 원 파일 명 */
	private String vodOrgFlNm;

	/** 영상 크기 */
	private Long vodSize;
	
	/** 영상 외부 ID */
	private String vodOutsideVdId;

	/** 영상 길이 */
	private Long vodVdLnth;
	
	/** 웹툰 물리 경로 */
	private String webToonPath;

	/** 웹툰 원 파일 명 */
	private String webToonOrgFlNm;

	/** 웹툰 크기 */
	private Long webToonSize;	
	
	/** 태그 */
	private String tagNo[];
	
	/** 상품 */
	private String goodsId[];
	
	/** 단계 번호 */
	private Long stepNo[];
	
	/** 단계 물리 경로 */
	private String stepPath[];

	/** 단계 원 파일 명 */
	private String stepOrgFlNm[];

	/** 단계 크기 */
	private Long stepSize[];
	
	/** 단계 외부 ID */
	private String stepOutsideVdId[];

	/** 단계 길이 */
	private Long stepVdLnth[];
	
	/** 단계 타이틀 */
	private String stepTtl[];

	/** 단계 설명 */
	private String stepDscrt[];
	
	/** Tip 설명 */
	private String tipContent;
	
	/** QnA 타이틀 */
	private String qnaTtl[];

	/** QnA 설명 */
	private String qnaContent[];
	
	/** update 여부 APET_CONTENTS */
	private boolean chkChgContents;
	
	/** update 여부 APET_ATTACH_FILE */
	private boolean chkChgFile;
	
	/** update 여부 APET_CONTENTS_TAG_MAP */
	private boolean chkChgTag;
	
	/** update 여부 APET_CONTENTS_GOODS_MAP */
	private boolean chkChgGoods;
	
	/** update 여부 APET_CONTENTS_DETAIL */
	private boolean chkChgDetail;
	
	/** update 여부 APET_CONTENTS_CONSTRUCT */
	private boolean chkChgConstruct;
	
	/** 단축URL */
	private String srtUrl;
}