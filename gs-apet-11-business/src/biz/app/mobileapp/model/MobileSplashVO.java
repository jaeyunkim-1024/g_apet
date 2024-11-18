package biz.app.mobileapp.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
@Data
public class MobileSplashVO extends BaseSysVO {
	private Long	splashNo;					// 스플래시 번호
	private String	appId = "";					// 앱 ID
	private String	mobileOs = "";				// 단말 OS 정보 (A:안드로이드, I:iOS)
	private String	title = "";					// 등록명
	private	String	linkType = "";				// 링크형식 (L:Link URL, I:Image)
	private String	link = "";					// 웹페이지 또는 이미지 URL
	private Integer	status;						// 등록상태 (0:준비, 1:사용중,  2:중지, 3:삭제)
}
