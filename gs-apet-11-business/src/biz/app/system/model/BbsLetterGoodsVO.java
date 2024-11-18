package biz.app.system.model;

import java.sql.Timestamp;

import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsCstrtInfoVO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
//public class BbsLetterGoodsVO extends GoodsBaseVO {
public class BbsLetterGoodsVO extends BaseSysVO {
	
	/** UID */
	private static final long serialVersionUID = 1L;

	/** 글 번호 */
	private Long lettNo;

	/** 상품아이디 */
	private String goodsId;
	
	
	
	 
	private String goodsNm;			 
	private String goodsStatCd;		 
	private String mdlNm;			 
	private String compNo;			 
	private String mmft;			 
	private String saleStrtDtm;		 
	private String saleEndDtm;		 
	private String showYn;			 
	private String goodsTpCd;		 
	private String bigo;			 
	private String bndNo;			 
	private String compNm;			 
	private String bndNmKo;			 
	private String saleAmt;			 
	private String dispPriorRank;	 
	
	
}
