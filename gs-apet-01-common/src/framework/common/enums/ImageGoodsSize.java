package framework.common.enums;

import framework.common.constants.CommonConstants;

public enum ImageGoodsSize {

	// naming rule 정의
	SIZE_10(new String[] { "600", "600" }), 
	SIZE_20(new String[] { "440", "440" }),
	SIZE_30(new String[] { "374", "374" }), 
	SIZE_40(new String[] { "315", "315" }),
	SIZE_50(new String[] { "280", "280" }), 
	SIZE_60(new String[] { "224", "224" }),
	SIZE_70(new String[] { "167", "167" }),
	
	OPT_SIZE_210(new String[] { CommonConstants.IMG_OPT_QRY_210 , "500", "500" }),
	OPT_SIZE_70(new String[] { CommonConstants.IMG_OPT_QRY_70 , "490", "279" }),
	OPT_SIZE_170(new String[] { CommonConstants.IMG_OPT_QRY_170 , "375", "375" }),
	OPT_SIZE_240(new String[] { CommonConstants.IMG_OPT_QRY_240 , "375", "214" }),
	OPT_SIZE_160(new String[] { CommonConstants.IMG_OPT_QRY_160 , "317", "317" }),
	OPT_SIZE_100(new String[] { CommonConstants.IMG_OPT_QRY_110 , "280", "280" }),
	OPT_SIZE_340(new String[] { CommonConstants.IMG_OPT_QRY_340 , "230", "230" }),
	OPT_SIZE_30(new String[] { CommonConstants.IMG_OPT_QRY_30 , "178", "178" }),
	OPT_SIZE_270(new String[] { CommonConstants.IMG_OPT_QRY_270 , "160", "160" }),
	OPT_SIZE_250(new String[] { CommonConstants.IMG_OPT_QRY_250 , "120", "120" }),
	OPT_SIZE_220(new String[] { CommonConstants.IMG_OPT_QRY_220 , "90", "90" }),
	OPT_SIZE_60(new String[] { CommonConstants.IMG_OPT_QRY_60 , "70", "70" });

	private String[] size;

	private ImageGoodsSize(String[] size) {
		this.size = size;
	}

	public String[] getSize() {
		//return size;
		
		String[] copySize = null;
		if(this.size != null) {
			copySize = new String[this.size.length];
			for(int i=0; i<this.size.length; i++) {
				copySize[i] = this.size[i];
			}
		}
		
		return copySize;
	}
}
