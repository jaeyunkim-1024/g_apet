package biz.app.event.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EventBasePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 이벤트 번호 */
	private Long eventNo;

	/** 쿠폰 번호*/
	private Long cpNo;

	/** SEO 정보 번호*/
	private Long seoInfoNo;

	/** 제목 */
	private String ttl;

	/** 이벤트 서브 명*/
	private String eventSubNm;

	/** 이벤트 혜택*/
	private String eventBnfts;

	/** 참고 사항(=설명) */
	private String eventDscrt;

	private String eventStatCd;

	/** 이벤트 유형 코드*/
	private String eventTpCd;

	/** 이벤트 구분 코드 */
	private String eventGbCd;

	/** 이벤트 구분2 코드*/
	private String eventGb2Cd;

	/** 대표 이미지 경로 */
	private String dlgtImgPath;

	/** 대표 이미지 경로 */
	private String orgDlgtImgPath;

	/** 이벤트 적용 시작 일시*/
	private Timestamp aplStrtDtm;

	/** 이벤트 적용 종료 일시*/
	private Timestamp aplEndDtm;

	/** 당첨일자 */
	private String winDt;

	/** 댓글 사용 여부 */
	private String aplyUseYn;

	/** 내용 */
	private String content;

	/** 사이트 아이디 */
	private Long stId;

	/** 이벤트 대표이미지 삭제 여부 */
	private String dlgtImgPathDel;

	/** 응모형 이벤트 추가필드*/
	private String addFieldJsonStr;

	/** 응모형 이벤트 퀴즈*/
	private String quizJsonStr;

	/* *응모형 이벤트 수집 항목*/
	private String[] collectItemCd;

	/** 응모형 이벤트 - 팝업 상단 이미지(PC)*/
	private String pcImgPath;

	/** 응모형 이벤트 - 팝업 하단 이미지(MO)*/
	private String moImgPath;

	/*참여 시 로그인 여부*/
	private String loginRqidYn;
		
	/** 당첨자 목록 csv 파일 경로*/
	private String filePath;

	/** 당첨자 목록 csv 파일 이름*/
	private String fileNm;

	/** 비공개 여부*/
	private String notOpenYn;

	/** 이벤트 참여자 csvData 정보*/
	private List<String> csvData;
}