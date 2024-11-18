package framework.common.util.image;

import java.util.ArrayList;
import java.util.List;

import framework.common.enums.ImageGoodsSize;

public enum ImageType {

	// Goods_image
	GOODS_IMAGE {
		@Override
		public List<String[]> imageSizeList() {

			List<String[]> imageSizeList = new ArrayList<>();

			imageSizeList.add(ImageGoodsSize.SIZE_10.getSize());
			imageSizeList.add(ImageGoodsSize.SIZE_20.getSize());
			imageSizeList.add(ImageGoodsSize.SIZE_30.getSize());
			imageSizeList.add(ImageGoodsSize.SIZE_40.getSize());
			imageSizeList.add(ImageGoodsSize.SIZE_50.getSize());
			imageSizeList.add(ImageGoodsSize.SIZE_60.getSize());
			imageSizeList.add(ImageGoodsSize.SIZE_70.getSize());
			
			return imageSizeList;
		}

		@Override
		public int validWidthSize() {
			return 600;
		}

		@Override
		public int validHeightSize() {
			return 600;
		}

		@Override
		public String imgFormat() {
			return "jpg";
		}
	},
	
	GOODS_OPT_IMAGE {
		@Override
		public List<String[]> imageSizeList() {

			List<String[]> imageSizeList = new ArrayList<>();
			imageSizeList.add(ImageGoodsSize.OPT_SIZE_210.getSize());
			imageSizeList.add(ImageGoodsSize.OPT_SIZE_70.getSize());
			imageSizeList.add(ImageGoodsSize.OPT_SIZE_170.getSize());
			imageSizeList.add(ImageGoodsSize.OPT_SIZE_240.getSize());
			imageSizeList.add(ImageGoodsSize.OPT_SIZE_160.getSize());
			imageSizeList.add(ImageGoodsSize.OPT_SIZE_100.getSize());
			imageSizeList.add(ImageGoodsSize.OPT_SIZE_340.getSize());
			imageSizeList.add(ImageGoodsSize.OPT_SIZE_30.getSize());
			imageSizeList.add(ImageGoodsSize.OPT_SIZE_270.getSize());
			imageSizeList.add(ImageGoodsSize.OPT_SIZE_250.getSize());
			imageSizeList.add(ImageGoodsSize.OPT_SIZE_220.getSize());
			imageSizeList.add(ImageGoodsSize.OPT_SIZE_60.getSize());
		
			return imageSizeList;
		}
		
		@Override
		public int validWidthSize() {
			return 600;
		}

		@Override
		public int validHeightSize() {
			return 600;
		}

		@Override
		public String imgFormat() {
			return "jpg";
		}

	},

	// GOODS_SLIDE_IMAGE
	GOODS_SLIDE_IMAGE {
			@Override
			public List<String[]> imageSizeList() {

				List<String[]> imageSizeList = new ArrayList<>();
				imageSizeList.add(ImageGoodsSize.SIZE_10.getSize());
				return imageSizeList;
			}

			@Override
			public int validWidthSize() {
				return 480;
			}

			@Override
			public int validHeightSize() {
				return 480;
			}

			@Override
			public String imgFormat() {
				return "jpg";
		}
	};
		
	/**
	 * <pre>imageSizeList 사이즈 리스트</pre>
	 * 
	 * @return
	 */
	public abstract List<String[]> imageSizeList();

	/**
	 * <pre>validWidthSize 유효성 검사 가로 사이즈</pre>
	 * 
	 * @return
	 */
	public abstract int validWidthSize();

	/**
	 * <pre>validHeightSize 유효성 검사 세로 사이즈</pre>
	 * 
	 * @return
	 */
	public abstract int validHeightSize();

	/**
	 * <pre>imgFormat 이미지 format (JPG, PNG 등)</pre>
	 * 
	 * @return
	 */
	public abstract String imgFormat();

}
