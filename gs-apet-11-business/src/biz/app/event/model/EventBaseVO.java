package biz.app.event.model;

import biz.app.st.model.StStdInfoVO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper=false)
public class EventBaseVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 이벤트 번호 */
	private Long eventNo;

	/** 쿠폰 번호*/
	private Long cpNo;

	/** 쿠폰 이름*/
	private String cpNm;

	/** SEO 정보 번호*/
	private Long seoInfoNo;

	/** 제목 */
	private String ttl;

	/** 이벤트 서브명*/
	private String eventSubNm;

	/** 이벤트 유형 코드*/
	private String eventTpCd;
	private String eventTpNm;

	/** 이벤트 설명(=참고) */
	private String eventDscrt;

	/** 이벤트 혜택 */
	private String eventBnfts;

	/** 이벤트 구분 코드 */
	private String eventGbCd;
	private String eventGbNm;

	/** 이벤트 구분2 코드 */
	private String eventGb2Cd;
	private String eventGb2Nm;

	/** 이벤트 상태 코드 */
	private String eventStatCd;
	private String eventStatNm;

	/** 대표 이미지 경로 */
	private String dlgtImgPath;

	/** 내용 */
	private String content;

	/** 이벤트 시작 일시 */
	private Timestamp aplStrtDtm;
	private String aplStrtDtmStr;

	/** 이벤트 종료 일시 */
	private Timestamp aplEndDtm;
	private String aplEndDtmStr;

	/** 당첨일자 */
	private String winDt;

	/** 프로모션 매핑 적용 구분 코드 (이벤트 : 30) */
	private String prmtAplGbCd;

	/** 종료 여부 */
	private String endYn;

	/** 참여자 수*/
	private Integer entryCnt;

	/** 이벤트 결과 발표*/
	private String winRstYn;

	/** 로그인 여부*/
	private String loginRqidYn;

	/* PC 이미지 경로 */
	private String pcImgPath;

	/** MO 이미지 경로*/
	private String moImgPath;

	/** 이벤트 당첨 타이틀*/
	private String winTtl;

	/** 댓글 사용 여부 */
	private String aplyUseYn;

	/** 비공개 여부*/
	private String notOpenYn;

	/** 이벤트 종료일까지 남은일수 */
	private String leftDays;

	/** 댓글 수*/
	private Long aplyCnt;

	/** 마케팅, 카카오 채널 추가 링크 */
	private String isKaKaoChannelYn;
}