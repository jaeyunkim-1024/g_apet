package framework.front.tags;



/**
 * 상품 이미지 경로 생성 
 * 
 * @author valueFactory
 * @since 2016. 03. 02.
 */
public class GoodsImageTag extends GoodsImageSupport {

	private static final long serialVersionUID = -6809925482855163073L;

	public void setImgPath(String imgPath){
		this.imgPath = imgPath;
	}
	
	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}

	public void setSeq(Integer seq){
		this.seq = seq;
	}

	public void setGb(String gb){
		this.gb = gb;
	}

	public void setSize(String[] size) {
		this.size = size;
	}
	
	public void setCls(String cls){
		this.cls = cls;
	}
	
	public void setAlt(String alt){
		this.alt = alt;
	}
	
	public void setNoImg(String noImg){
		this.noImg = noImg;
	}

}