package biz.app.mobileapp.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
@Data
public class MobileSplashSO extends BaseSearchVO<MobileVersionSO> {
	private Long	splashNo;					// 스플래시 번호
	private String	mobileOs = "";				// 단말 OS 정보 (A:안드로이드, I:iOS)
	private Integer	status;						// 등록상태 (0:준비, 1:사용중,  2:중지, 3:삭제)
	
	public MobileSplashSO() {}
	public MobileSplashSO(Long splashNo) {
		this.splashNo = splashNo;
	}
}
