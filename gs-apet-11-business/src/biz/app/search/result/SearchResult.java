package biz.app.search.result;

public class SearchResult {
	
//	//인기검색어 결과리스트
//	public List<SearchResultVo> getHotResult(Result result){
//		ArrayList<SearchResultVo> list = new ArrayList<>();
//		for(int i = 0; i < result.getRealSize(); i++){
//
//			 SearchResultVo resultVo = new SearchResultVo();
//			 resultVo.setKeyword(new String(result.getResult(i, 0)));		 
//			 resultVo.setHotRanking(new String(result.getResult(i, 1)));	 
//			 resultVo.setHotDate(new String(result.getResult(i, 2)));
//	 
//			 list.add(resultVo);
//		}
//		
//		return list;
//	}
//
//	//자동완성 결과리스트
//	public List<SearchResultVo> getAutoResult(Result result){
//		ArrayList<SearchResultVo> list = new ArrayList<>();
//		for(int i = 0; i < result.getRealSize(); i++){
//			SearchResultVo resultVo = new SearchResultVo();
//			resultVo.setKeyword(new String(result.getResult(i,0)));
//			resultVo.setAutoCount(new String(result.getResult(i, 1)));
//				 
//			list.add(resultVo);
//		}
//		
//		return list;
//	}
//	
//	//상품 결과리스트
//	public List<SearchResultVo> getResult(Result result, SearchDqVo searchVo){
//		ArrayList<SearchResultVo> list = new ArrayList<>();
//		for(int i = 0; i < result.getRealSize(); i++){
//
//			SearchResultVo resultVo = new SearchResultVo();	
//			resultVo.setGoodsid(new String(result.getResult(i, 0)));
//			resultVo.setGoodsnm(new String(result.getResult(i, 1)));
//			resultVo.setBndnmko(new String(result.getResult(i, 2)));
//			resultVo.setImgseq(new String(result.getResult(i, 3)));
//			resultVo.setImgpath(new String(result.getResult(i, 4)));
//			resultVo.setPrwdsshowyn(new String(result.getResult(i, 5)));
//			resultVo.setPrwds(new String(result.getResult(i, 6)));
//			resultVo.setFreedlvryn(new String(result.getResult(i, 7)));
//			resultVo.setCouponyn(new String(result.getResult(i, 8)));
//			resultVo.setNewyn(new String(result.getResult(i,9)));
//			resultVo.setBestyn(new String(result.getResult(i, 10)));
//			resultVo.setSoldoutyn(new String(result.getResult(i, 11)));
//			resultVo.setHotdeal(new String(result.getResult(i, 12)));
//
//			if(searchVo.getDevicesType().equals("mobile")){
//				resultVo.setSaleamt(new String(result.getResult(i, 15)));
//				resultVo.setPrmtdcamt(new String(result.getResult(i, 16)));
//				resultVo.setSalepct(new String(result.getResult(i, 18)));
//        	}else{
//        		resultVo.setSaleamt(new String(result.getResult(i, 13)));
//    			resultVo.setPrmtdcamt(new String(result.getResult(i, 14)));
//    			resultVo.setSalepct(new String(result.getResult(i, 17)));
//        	}
//			resultVo.setGonggu(new String(result.getResult(i, 19)));
//			resultVo.setBulkordendyn(new String(result.getResult(i, 20)));
//			
//
//			list.add(resultVo);
//		}
//		
//		return list;
//	}	

}
