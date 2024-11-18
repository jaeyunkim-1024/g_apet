package biz.app.search.util;

import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class SearchUtil {
	
//	private SearchResult sr = new SearchResult();
//	private int returnCode = 0;
//	private int returnCode2 = 0;
//
//	private char[] startTag = "".toCharArray();
//	private char[] endTag = "".toCharArray();
//
////	private QuerySet querySet;
//	
//	
//	//통합검색
//	public Result[] getSearch(SearchDqVo searchVo) throws IRException{
//		//QueryParser parser = new QueryParser();
//		
//		Query group_m3Query = null; //쿼리를 담는 부분
//		Query price_m3Query = null; //쿼리를 담는 부분
//		Query tab_m3Query = null; //쿼리를 담는 부분
//		Query shop_m3Query = null; //쿼리를 담는 부분
//		Query md_m3Query = null; //쿼리를 담는 부분
//		
//		Result [] resultlist = null;
//		
//		ArrayList<WhereSet> whereList_shop = new ArrayList<>();
//		ArrayList<WhereSet> whereList_md = new ArrayList<>();
//		List<WhereSet> whereList_common = new ArrayList<>();
//		ArrayList<FilterSet> filterList_shop = new ArrayList<>();
//		ArrayList<GroupBySet> groupList_shop = new ArrayList<>();
//		
//		
//		SelectSet[] shop_selectSet = null;
//		WhereSet[] shop_whereSet = null; //검색에서 검색을 할 필드를 설정하는데 필요한 변수
//		WhereSet[] md_whereSet = null; //MD상품
//		OrderBySet[] orderbys_shop = null;
//		OrderBySet[] orderbys_md = null;	//MD정렬
//		FilterSet[] filterSet_shop = null;
//		GroupBySet[] groupSet_shop =  null;
//		
//		String selectNm = "";
//		String sortNm = "";
//		String filterNm = "";
//    	if(searchVo.getDevicesType().equals("mobile")){
//    		selectNm = "WEB_MOBILE_GB_MO_PRC";
//    		sortNm = "SORT_WEB_MOBILE_GB_MO_PRC";
//    		filterNm = "FILTER_WEB_MOBILE_GB_MO_PRC";
//    	}else{
//    		selectNm = "WEB_MOBILE_GB_PC_PRC";
//    		sortNm = "SORT_WEB_MOBILE_GB_PC_PRC";
//    		filterNm = "FILTER_WEB_MOBILE_GB_PC_PRC";
//    	}
//    	
//    	
//		//상품 그룹 SelectSet 지정=====================================================================================================
//		shop_selectSet = new SelectSet[]{
//			new SelectSet(selectNm, Protocol.SelectSet.NONE)
//		};
//		//상품 그룹 SelectSet 지정=====================================================================================================
//    	
//		//상품 그룹 WhereSet 지정=====================================================================================================
//		String[] allsearchArr = searchVo.getAllsearchQuery().split("\\$\\|");
//		if(!searchVo.getAllsearchQuery().equals("")){
//			whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//
//			for(int i= 0; i < allsearchArr.length; i++){
//				if(i != 0){
//					whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//				}
//				String searchQuery = allsearchArr[i].trim();
//
//				whereList_common = setShopWhereSet(searchQuery);
//				for (int c = 0; c < whereList_common.size(); c++) {
//					whereList_shop.add(whereList_common.get(c));
//				}
//			}
//			whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//		}
//		
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//		if(searchVo.getDevicesType().equals("mobile")){
//			whereList_shop.add(new WhereSet ("WEB_MOBILE_GB_CD", Protocol.WhereSet.OP_HASANY, "00 20"));	//전체, 모바일
//		}else{
//			whereList_shop.add(new WhereSet ("WEB_MOBILE_GB_CD", Protocol.WhereSet.OP_HASANY, "00 10"));	//전체, PC
//		}
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//		
//		shop_whereSet = new WhereSet[whereList_shop.size()];
//		for (int i = 0; i < whereList_shop.size(); i++) {
//			shop_whereSet[i] = whereList_shop.get(i);
//		}
//		//상품 그룹 WhereSet 지정=====================================================================================================
//		
//		
//		//상품 그룹 OrderBySet 지정=====================================================================================================
//		orderbys_shop = new OrderBySet[1];
//		orderbys_shop[0] = new OrderBySet(false, sortNm, Protocol.OrderBySet.OP_NONE);
//		//상품 그룹 OrderBySet 지정=====================================================================================================
//		    
//		//상품 그룹 GroupBySet 지정=====================================================================================================
//		groupList_shop.add(new GroupBySet("GROUP_CTG_NM_L", (byte)(Protocol.GroupBySet.OP_COUNT | Protocol.GroupBySet.ORDER_COUNT), "DESC", ""));
//		groupList_shop.add(new GroupBySet("GROUP_CTG_NM_LM", (byte)(Protocol.GroupBySet.OP_COUNT | Protocol.GroupBySet.ORDER_COUNT), "DESC", ""));
//		groupList_shop.add(new GroupBySet("GROUP_CTG_NM_LMS", (byte)(Protocol.GroupBySet.OP_COUNT | Protocol.GroupBySet.ORDER_COUNT), "DESC", ""));
//		groupList_shop.add(new GroupBySet("GROUP_BND_NM", (byte)(Protocol.GroupBySet.OP_COUNT | Protocol.GroupBySet.ORDER_COUNT), "DESC", ""));
//		groupList_shop.add(new GroupBySet("GROUP_PRMT_BND_NM", (byte)(Protocol.GroupBySet.OP_COUNT |Protocol.GroupBySet.ORDER_COUNT), "DESC", ""));
//		groupList_shop.add(new GroupBySet("GROUP_STR_NM", (byte)(Protocol.GroupBySet.OP_COUNT |Protocol.GroupBySet.ORDER_COUNT), "DESC", ""));
//		groupList_shop.add(new GroupBySet("GROUP_DSGNR_NM", (byte)(Protocol.GroupBySet.OP_COUNT |Protocol.GroupBySet.ORDER_COUNT), "DESC", ""));
//			
//		groupList_shop.add(new GroupBySet("GROUP_BND_NM_CHO", (byte)(Protocol.GroupBySet.OP_COUNT | Protocol.GroupBySet.ORDER_NAME), "ASC", ""));
//		groupList_shop.add(new GroupBySet("GROUP_PRMT_BND_NM_CHO", (byte)(Protocol.GroupBySet.OP_COUNT |Protocol.GroupBySet.ORDER_NAME), "ASC", ""));
//		groupList_shop.add(new GroupBySet("GROUP_DSGNR_NM_CHO", (byte)(Protocol.GroupBySet.OP_COUNT |Protocol.GroupBySet.ORDER_NAME), "ASC", ""));
//		groupList_shop.add(new GroupBySet("GROUP_STR_NM_CHO", (byte)(Protocol.GroupBySet.OP_COUNT |Protocol.GroupBySet.ORDER_NAME), "ASC", ""));
//		
//		
//		groupSet_shop = new GroupBySet[groupList_shop.size()];
//		for(int i = 0; i < groupList_shop.size(); i++){
//			groupSet_shop[i] = groupList_shop.get(i);
//		}
//        //상품 카테고리 그룹 카테고리 GroupBySet 지정=====================================================================================================
//
//		//상품 카테고리 그룹, 최대값 쿼리=====================================================================================================
//		group_m3Query = new Query("","");
//		group_m3Query.setSelect(shop_selectSet);
//		group_m3Query.setWhere(shop_whereSet);
//		group_m3Query.setOrderby(orderbys_shop);
//		if(!groupList_shop.isEmpty()) group_m3Query.setGroupBy(groupSet_shop);
//		group_m3Query.setFrom("DCG"); // 사용할 콜렉션에 요청한다.
//		group_m3Query.setResult(0, 0); //페이지 결
//		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
//		group_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD));
//		//유의어 /동의어 확장 사용
//		group_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM));
//		group_m3Query.setPrintQuery(false);
//		//group_m3Query.setLoggable(true);
//		group_m3Query.setDebug(true);
//		group_m3Query.setQueryModifier("diver");
//		
//		
//		//상품 최소값 OrderBySet 지정=====================================================================================================
//		orderbys_shop = new OrderBySet[1];
//		orderbys_shop[0] = new OrderBySet(true, sortNm, Protocol.OrderBySet.OP_NONE);
//		//상품 최소값 OrderBySet 지정=====================================================================================================
//		
//		//상품 최소값 쿼리=====================================================================================================
//		price_m3Query = new Query("","");
//		price_m3Query.setSelect(shop_selectSet);
//		price_m3Query.setWhere(shop_whereSet);
//		price_m3Query.setOrderby(orderbys_shop);
//		price_m3Query.setFrom("DCG"); // 사용할 콜렉션에 요청한다.
//		price_m3Query.setResult(0, 0); //페이지 결과
//		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
//		price_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD));
//		//유의어 /동의어 확장 사용
//		price_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM));
//		price_m3Query.setPrintQuery(false);
//		//price_m3Query.setLoggable(true);
//		price_m3Query.setDebug(true);
//		price_m3Query.setQueryModifier("diver");
//
//	
//		//상품 SelectSet 지정=====================================================================================================
//		shop_selectSet = new SelectSet[]{
//			new SelectSet("GOODS_ID", Protocol.SelectSet.NONE),	 
//			new SelectSet("GOODS_NM", Protocol.SelectSet.NONE),	
//			new SelectSet("BND_NM_KO", Protocol.SelectSet.NONE), 
//			new SelectSet("IMG_SEQ", Protocol.SelectSet.NONE), 
//			new SelectSet("IMG_PATH", Protocol.SelectSet.NONE), 
//			new SelectSet("PR_WDS_SHOW_YN", Protocol.SelectSet.NONE), 
//			new SelectSet("PR_WDS", Protocol.SelectSet.NONE),        
//			new SelectSet("FREE_DLVR_YN", Protocol.SelectSet.NONE), 
//			new SelectSet("COUPON_YN", Protocol.SelectSet.NONE), 
//			new SelectSet("IS_NEW", Protocol.SelectSet.NONE),    
//			new SelectSet("IS_BEST", Protocol.SelectSet.NONE),    
//			new SelectSet("SOLD_OUT_YN", Protocol.SelectSet.NONE), 
//			new SelectSet("IS_HOT_DEAL", Protocol.SelectSet.NONE), 
//			new SelectSet("WEB_MOBILE_GB_PC_PRC", Protocol.SelectSet.NONE),   
//			new SelectSet("WEB_MOBILE_GB_PC_PRMT_PRC", Protocol.SelectSet.NONE),   
//			new SelectSet("WEB_MOBILE_GB_MO_PRC", Protocol.SelectSet.NONE),   
//			new SelectSet("WEB_MOBILE_GB_MO_PRMT_PRC", Protocol.SelectSet.NONE),
//			new SelectSet("PC_SALE_PCT", Protocol.SelectSet.NONE),
//			new SelectSet("MO_SALE_PCT", Protocol.SelectSet.NONE),
//			new SelectSet("IS_GONG_GU", Protocol.SelectSet.NONE),
//			new SelectSet("BULK_ORD_END_YN", Protocol.SelectSet.NONE)
//			
//		};
//		//상품 SelectSet 지정=====================================================================================================
//		
//		
//		//상품 WhereSet 지정=====================================================================================================
//		//혜택
//		if(searchVo.getDevicesType().equals("mobile")){
//			if(!searchVo.getSearchBenefit().equals("")){
//				String indexNm ="";
//				if(searchVo.getSearchBenefit().equals("coupon")){ //쿠폰
//					indexNm = "IDX_COUPON_YN";
//				}else if(searchVo.getSearchBenefit().equals("gonggu")){ //공동구매
//					indexNm = "IDX_IS_GONG_GU";
//				}else if(searchVo.getSearchBenefit().equals("free")){ //무료배송
//					indexNm = "IDX_FREE_DLVR_YN";
//				}
//				if(!indexNm.equals("")){
//					whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//					whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//					whereList_shop.add(new WhereSet (indexNm , Protocol.WhereSet.OP_HASALL, "Y" ,1));
//					whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//				}	
//			}
//		}else{
//			if(searchVo.getSearchBenefitPC() != null){
//				String[] searchArea = searchVo.getSearchBenefitPC();
//				int whereCont = 0;
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//				for(int a = 0; a < searchArea.length; a++){
//					if(searchArea[a].equals("coupon")){
//						if(whereCont > 0){
//							whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//						}
//						whereList_shop.add(new WhereSet ("IDX_COUPON_YN" , Protocol.WhereSet.OP_HASALL, "Y" ,1)); 
//						whereCont ++;
//					}
//					if(searchArea[a].equals("gonggu")){
//						if(whereCont > 0){
//							whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//						}
//						whereList_shop.add(new WhereSet ("IDX_IS_GONG_GU" , Protocol.WhereSet.OP_HASALL, "Y" ,1)); 
//						whereCont ++;
//					}
//					if(searchArea[a].equals("free")){
//						if(whereCont > 0){
//							whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//						}
//						whereList_shop.add(new WhereSet ("IDX_FREE_DLVR_YN" , Protocol.WhereSet.OP_HASALL, "Y" ,1)); 
//						whereCont ++;
//					}
//				}
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//	    	}
//			
//		}
//		
//		int whereSetChk = 0;
//		if(searchVo.getSearchLcate() != null || searchVo.getSearchMcate() != null || searchVo.getSearchScate() != null ||
//				searchVo.getSearchBrand() != null || searchVo.getSearchPremium() != null ||
//						searchVo.getSearchStore() != null || searchVo.getSearchDesigner() != null){
//			
//			whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//			whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//			
//			//대 카테고리
//			if(searchVo.getSearchLcate() != null){
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//				for(int d=0; d < searchVo.getSearchLcate().length; d++){
//					
//					whereList_shop.add(new WhereSet ("IDX_CTG_NM_L" , Protocol.WhereSet.OP_HASALL, searchVo.getSearchLcate()[d] ,1));
//					if(d < searchVo.getSearchLcate().length-1){
//						whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//					}
//				}
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//				whereSetChk++;
//			}
//			//중 카테고리
//			if(searchVo.getSearchMcate() != null){
//				if(whereSetChk > 0)  whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//				for(int d=0; d < searchVo.getSearchMcate().length; d++){
//					
//					whereList_shop.add(new WhereSet ("IDX_CTG_NM_LM" , Protocol.WhereSet.OP_HASALL, searchVo.getSearchMcate()[d] ,1));
//					if(d < searchVo.getSearchMcate().length-1){
//						whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//					}
//				}
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//				whereSetChk++;
//			}
//			//소 카테고리
//			if(searchVo.getSearchScate() != null){
//				if(whereSetChk > 0)  whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//				for(int d=0; d < searchVo.getSearchScate().length; d++){
//					
//					whereList_shop.add(new WhereSet ("IDX_CTG_NM_LMS" , Protocol.WhereSet.OP_HASALL, searchVo.getSearchScate()[d] ,1));
//					if(d < searchVo.getSearchScate().length-1){
//						whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//					}
//				}
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//				whereSetChk++;
//			}
//			//브랜드
//			if(searchVo.getSearchBrand() != null){
//				if(whereSetChk > 0)  whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//				for(int d=0; d < searchVo.getSearchBrand().length; d++){
//					
//					whereList_shop.add(new WhereSet ("IDX_BND_NM" , Protocol.WhereSet.OP_HASALL, searchVo.getSearchBrand()[d] ,1));
//					if(d < searchVo.getSearchBrand().length-1){
//						whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//					}
//				}
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//				whereSetChk++;
//			}
//			//프리미엄
//			if(searchVo.getSearchPremium() != null){
//				if(whereSetChk > 0)  whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//				for(int d=0; d < searchVo.getSearchPremium().length; d++){
//					
//					whereList_shop.add(new WhereSet ("IDX_PRMT_BND_NM" , Protocol.WhereSet.OP_HASALL, searchVo.getSearchPremium()[d] ,1));
//					if(d < searchVo.getSearchPremium().length-1){
//						whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//					}
//				}
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//				whereSetChk++;
//			}
//			//스토어
//			if(searchVo.getSearchStore() != null){
//				if(whereSetChk > 0)  whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//				for(int d=0; d < searchVo.getSearchStore().length; d++){
//					
//					whereList_shop.add(new WhereSet ("IDX_STR_NM_FD" , Protocol.WhereSet.OP_HASALL, searchVo.getSearchStore()[d] ,1));
//					if(d < searchVo.getSearchStore().length-1){
//						whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//					}
//				}
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//				whereSetChk++;
//			}
//			//디자이너
//			if(searchVo.getSearchDesigner() != null){
//				if(whereSetChk > 0)  whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//				for(int d=0; d < searchVo.getSearchDesigner().length; d++){
//					
//					whereList_shop.add(new WhereSet ("IDX_DSGNR_NM_FD" , Protocol.WhereSet.OP_HASALL, searchVo.getSearchDesigner()[d] ,1));
//					if(d < searchVo.getSearchDesigner().length-1){
//						whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//					}
//				}
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//			}
//			whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//		}
//
//		shop_whereSet = new WhereSet[whereList_shop.size()];
//		for (int i = 0; i < whereList_shop.size(); i++) {
//			shop_whereSet[i] = whereList_shop.get(i);
//		}
//		//상품 WhereSet 지정=====================================================================================================
//
//		//상품 FilterSet 지정=====================================================================================================
//		//가격
//		
//		if(searchVo.getButtonPrice() != null && searchVo.getSearchStartPrice().equals("") && searchVo.getSearchEndPrice().equals("")){
//			String[] btn_prc_Array = searchVo.getButtonPrice();
//			String[] btn_prc_Array2;
//			StringBuilder btn_prc_name = new StringBuilder();
//			for(int i=0;i<btn_prc_Array.length;i++){ // ~5만원,  5~10만원, 9만원~
//				btn_prc_Array2 =  btn_prc_Array[i].split("~"); // [0]="",[1]5만원 // [0]=5,[1]만원 //[0]=9만원,[1]="" 
//				String start = "";
//				String end = "";
//				if(!btn_prc_Array2[0].equals("")){
//					if(btn_prc_Array2[0].indexOf("만원") <0){
//						start = btn_prc_Array2[0] + "만원";
//					}else{
//						start = btn_prc_Array2[0];
//					}
//				}else{
//					start = "0";
//				}
//				if(btn_prc_Array2.length ==1){
//					if(!btn_prc_Array2[0].equals("")){
//						end = "999999999";
//					}
//				}else{
//					end = btn_prc_Array2[1];
//				}
//				
//				btn_prc_name.append(start.replaceAll("만원", "0000")).append("/").append(end.replaceAll("만원", "0000")).append("/");
//    		}
//			
//			String[] arrayPrice = btn_prc_name.toString().split("/");
//			
//			filterList_shop.add(new FilterSet(Protocol.FilterSet.OP_RANGE, filterNm,  arrayPrice)); 
//		}else if(searchVo.getButtonPrice() == null && (!searchVo.getSearchStartPrice().equals("") || !searchVo.getSearchEndPrice().equals(""))){
//			String start = searchVo.getSearchStartPrice().replaceAll(",", "");
//			String end = searchVo.getSearchEndPrice().replaceAll(",", "");
//        	String[] price = {start, end};
//        	
//			filterList_shop.add(new FilterSet(Protocol.FilterSet.OP_RANGE, filterNm,  price)); 
//		}
//		
//		filterSet_shop = new FilterSet[filterList_shop.size()];
//		for(int i = 0; i < filterList_shop.size(); i++){
//			filterSet_shop[i] = filterList_shop.get(i);
//		}
//        //상품 FilterSet 지정=====================================================================================================
//		
//		
//	
//		
//		//상품 탭 카테고리 쿼리=====================================================================================================
//		groupList_shop.clear();
//		groupList_shop.add(new GroupBySet("GROUP_IS_STORE", (byte)(Protocol.GroupBySet.OP_COUNT |Protocol.GroupBySet.ORDER_COUNT), "DESC", ""));
//		groupList_shop.add(new GroupBySet("GROUP_IS_DESIGNER", (byte)(Protocol.GroupBySet.OP_COUNT |Protocol.GroupBySet.ORDER_COUNT), "DESC", ""));
//		groupList_shop.add(new GroupBySet("GROUP_IS_PRMT", (byte)(Protocol.GroupBySet.OP_COUNT |Protocol.GroupBySet.ORDER_COUNT), "DESC", ""));
//		
//		groupSet_shop = new GroupBySet[groupList_shop.size()];
//		for(int i = 0; i < groupList_shop.size(); i++){
//			groupSet_shop[i] = groupList_shop.get(i);
//		}
//        //상품 GroupBySet 지정=====================================================================================================
//		
//		tab_m3Query = new Query("","");
//		tab_m3Query.setSelect(shop_selectSet);
//		tab_m3Query.setWhere(shop_whereSet);
//		//tab_m3Query.setOrderby(orderbys_shop);
//		tab_m3Query.setFrom("DCG"); // 사용할 콜렉션에 요청한다.
//		tab_m3Query.setResult(0, 0); //페이지 결과
//		if(!filterList_shop.isEmpty()) tab_m3Query.setFilter(filterSet_shop);
//		if(!groupList_shop.isEmpty()) tab_m3Query.setGroupBy(groupSet_shop);
//		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
//		tab_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD));
//		//유의어 /동의어 확장 사용
//		tab_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM));
//		tab_m3Query.setPrintQuery(false);
//		//tab_m3Query.setLoggable(true);
//		tab_m3Query.setDebug(true);
//		tab_m3Query.setQueryModifier("diver");
//				
//		//상품 WhereSet 지정=====================================================================================================
//		//카테고리
//		if(!searchVo.getSearchCategory().equals("")){
//			String indexNm ="";
//			if(searchVo.getSearchCategory().equals("store")){ //스토어
//				indexNm = "IDX_IS_STORE";
//			}else if(searchVo.getSearchCategory().equals("designer")){ //디자이너
//				indexNm = "IDX_IS_DESIGNER";
//			}else if(searchVo.getSearchCategory().equals("prmt")){ //프리미엄
//				indexNm = "IDX_IS_PRMT";
//			}
//			if(!indexNm.equals("")){
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//				whereList_shop.add(new WhereSet (indexNm , Protocol.WhereSet.OP_HASALL, "Y" ,1));
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//			}
//		}
//		shop_whereSet = new WhereSet[whereList_shop.size()];
//		for (int i = 0; i < whereList_shop.size(); i++) {
//			shop_whereSet[i] = whereList_shop.get(i);
//		}
//		//상품 WhereSet 지정=====================================================================================================
//		
//		//상품 OrderBySet 지정=====================================================================================================
//		orderbys_shop = new OrderBySet[1];
//		if(searchVo.getSearchSort().equals("best")){  //인기순
//            orderbys_shop[0] = new OrderBySet(true, "SORT_BEST_RANK", Protocol.OrderBySet.OP_POSTWEIGHT);
//        }else if(searchVo.getSearchSort().equals("date")){  //신상품순
//            orderbys_shop[0] = new OrderBySet(true, "SORT_SYS_REG_DTM", Protocol.OrderBySet.OP_POSTWEIGHT);
//        }else if(searchVo.getSearchSort().equals("lowprice")){  //낮은 가격순
//        	orderbys_shop[0] = new OrderBySet(false, sortNm, Protocol.OrderBySet.OP_POSTWEIGHT);
//        }else if(searchVo.getSearchSort().equals("highprice")){  //높은 가격순
//        	orderbys_shop[0] = new OrderBySet(true, sortNm, Protocol.OrderBySet.OP_POSTWEIGHT);
//        }else if(searchVo.getSearchSort().equals("comment")){   //상품리뷰
//            orderbys_shop[0] = new OrderBySet(true, "SORT_GOODS_COMMENT_CNT", Protocol.OrderBySet.OP_POSTWEIGHT);
//        }else{   //가중치순+인기순
//            orderbys_shop[0] = new OrderBySet(true, "SORT_BEST_RANK", Protocol.OrderBySet.OP_PREWEIGHT);
//        }
//		//상품 OrderBySet 지정=====================================================================================================
//
//		
//		//상품 쿼리=====================================================================================================
//		shop_m3Query = new Query("","");
//		shop_m3Query.setSelect(shop_selectSet);
//		shop_m3Query.setWhere(shop_whereSet);
//		shop_m3Query.setOrderby(orderbys_shop);
//		if(!filterList_shop.isEmpty()) shop_m3Query.setFilter(filterSet_shop);
//		shop_m3Query.setFrom("DCG"); // 사용할 콜렉션에 요청한다.
//		shop_m3Query.setResult(searchVo.getSearchDisplay() *(searchVo.getPageNumber()-1), (searchVo.getSearchDisplay() *searchVo.getPageNumber())-1);//페이지 결과
//		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
//		shop_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD));
//		//유의어 /동의어 확장 사용
//		shop_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM));
//		//문서랭킹/카테로리 랭킹 사용
//		shop_m3Query.setRankingOption((byte)(Protocol.RankingOption.DOCUMENT_RANKING | Protocol.RankingOption.CATEGORY_RANKING ));
//		shop_m3Query.setCategoryRankingOption((byte)(Protocol.CategoryRankingOption.QUASI_SYNONYM| Protocol.CategoryRankingOption.EQUIV_SYNONYM |Protocol.CategoryRankingOption.MULTI_TERM_WHITESPACE ));
//		shop_m3Query.setPrintQuery(false);
//		shop_m3Query.setDebug(true);
//		shop_m3Query.setLoggable(true);
//		shop_m3Query.setLogKeyword(searchVo.getSearchQuery().toCharArray());
//		shop_m3Query.setQueryModifier("diver");
//		shop_m3Query.setRecommend(searchVo.getSearchQuery().toCharArray());
//		//String queryStr = parser.queryToString( shop_m3Query );
//	    //System.out.println("queryStr = " + queryStr);
//		
//		
//		//MD WhereSet 지정=====================================================================================================
//		whereList_md.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//		for(int i= 0; i < allsearchArr.length; i++){
//			if(i != 0){
//				whereList_md.add(new WhereSet(Protocol.WhereSet.OP_AND));
//			}
//			String searchQuery = allsearchArr[i].trim();
//
//			whereList_common = setShopWhereSet(searchQuery);
//			for (int c = 0; c < whereList_common.size(); c++) {
//				whereList_md.add(whereList_common.get(c));
//			}
//		}
//		whereList_md.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//		md_whereSet = new WhereSet[whereList_md.size()];
//		
//		for (int i = 0; i < whereList_md.size(); i++) {
//			md_whereSet[i] = whereList_md.get(i);
//		}
//		
//		//MD OrderBySet 지정=====================================================================================================
//		orderbys_md = new OrderBySet[1];
//		orderbys_md[0] = new OrderBySet(true, "SORT_HITS", Protocol.OrderBySet.OP_PREWEIGHT);
//		
//		//MD 쿼리=====================================================================================================
//		md_m3Query = new Query("","");
//		md_m3Query.setSelect(shop_selectSet);
//		md_m3Query.setWhere(md_whereSet);
//		md_m3Query.setOrderby(orderbys_md);
//		//if(filterList_shop.size() > 0) shop_m3Query.setFilter(filterSet_shop);
//		md_m3Query.setFrom("DCG"); // 사용할 콜렉션에 요청한다.
//		md_m3Query.setResult(0,3);//페이지 결과
//		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
//		md_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD));
//		//유의어 /동의어 확장 사용
//		shop_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM));
//		//문서랭킹/카테로리 랭킹 사용
//		//shop_m3Query.setRankingOption((byte)(Protocol.RankingOption.DOCUMENT_RANKING | Protocol.RankingOption.CATEGORY_RANKING ));
//		//shop_m3Query.setCategoryRankingOption((byte)(Protocol.CategoryRankingOption.QUASI_SYNONYM| Protocol.CategoryRankingOption.EQUIV_SYNONYM |Protocol.CategoryRankingOption.MULTI_TERM_WHITESPACE ));
//		md_m3Query.setPrintQuery(false);
//		md_m3Query.setDebug(true);
//		//shop_m3Query.setLoggable(true);
//		//shop_m3Query.setLogKeyword(searchVo.getSearchQuery().toCharArray());
//		shop_m3Query.setQueryModifier("diver");
//		//shop_m3Query.setRecommend(searchVo.getSearchQuery().toCharArray());
//		
//		int queryCount = 5;
//		if(searchVo.getSearchType().equals("view")){ //일반검색이 아닌 경우
//			queryCount = 4;
//		}
//		querySet = new QuerySet(queryCount);
//		
//		querySet.addQuery(group_m3Query);
//		querySet.addQuery(price_m3Query);
//		querySet.addQuery(tab_m3Query);
//		querySet.addQuery(shop_m3Query);
//		if(searchVo.getSearchType().equals("")){ //일반검색인 경우
//			querySet.addQuery(md_m3Query);
//		}
//		
//		CommandSearchRequest.setProps(searchVo.getSearchIp(), searchVo.getSearchPort(), 10000, 1, 30); //응답시간,min pool size, max pool size 값설정
//		CommandSearchRequest command = new CommandSearchRequest(searchVo.getSearchIp(), searchVo.getSearchPort());
//
//		returnCode = command.request(querySet);
//
//		//System.out.print("-- wiz error0 : " + returnCode + "--");
//		if (returnCode < 0) {
//			resultlist = new Result[1];
//			resultlist[0] = new Result();
//		}else{
//			resultlist = command.getResultSet().getResultList();
//		}
//
//		return resultlist;
//		
//	}
//	
//	//카테고리 검색
//	public Result[] getCateSearch(SearchDqVo searchVo) throws IRException{
//		//QueryParser parser = new QueryParser();
//		
//		Query group_m3Query = null; //쿼리를 담는 부분
//		Query price_m3Query = null; //쿼리를 담는 부분
//		Query tab_m3Query = null; //쿼리를 담는 부분
//		Query shop_m3Query = null; //쿼리를 담는 부분
//		
//		Result [] resultlist = null;
//		
//		ArrayList<WhereSet> whereList_shop = new ArrayList<>();
//		ArrayList<FilterSet> filterList_shop = new ArrayList<>();
//		ArrayList<GroupBySet> groupList_shop = new ArrayList<>();
//		
//		
//		SelectSet[] shop_selectSet = null;
//		WhereSet[] shop_whereSet = null; //검색에서 검색을 할 필드를 설정하는데 필요한 변수
//		OrderBySet[] orderbys_shop = null;
//		FilterSet[] filterSet_shop = null;
//		GroupBySet[] groupSet_shop =  null;
//		
//		String selectNm = "";
//		String sortNm = "";
//		String filterNm = "";
//    	if(searchVo.getDevicesType().equals("mobile")){
//    		selectNm = "WEB_MOBILE_GB_MO_PRC";
//    		sortNm = "SORT_WEB_MOBILE_GB_MO_PRC";
//    		filterNm = "FILTER_WEB_MOBILE_GB_MO_PRC";
//    	}else{
//    		selectNm = "WEB_MOBILE_GB_PC_PRC";
//    		sortNm = "SORT_WEB_MOBILE_GB_PC_PRC";
//    		filterNm = "FILTER_WEB_MOBILE_GB_PC_PRC";
//    	}
//    	
//		//상품 그룹 SelectSet 지정=====================================================================================================
//		shop_selectSet = new SelectSet[]{
//			new SelectSet(selectNm, Protocol.SelectSet.NONE)
//		};
//		//상품 그룹 SelectSet 지정=====================================================================================================
//		
//		//상품 그룹 WhereSet 지정=====================================================================================================
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//		if(!searchVo.getCateLcode().equals("")){
//			whereList_shop.add(new WhereSet ("IDX_CTG_NO_L", Protocol.WhereSet.OP_HASALL, searchVo.getCateLcode(), 1));	//대 카테고리 코드
//		}else if(!searchVo.getCateMcode().equals("")){
//			whereList_shop.add(new WhereSet ("IDX_CTG_NO_M", Protocol.WhereSet.OP_HASALL, searchVo.getCateMcode(), 1));	//중 카테고리 코드
//		}else{
//			whereList_shop.add(new WhereSet ("IDX_CTG_NO_S", Protocol.WhereSet.OP_HASALL, searchVo.getCateScode(), 1));	//소 카테고리 코드
//		}
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//		if(searchVo.getDevicesType().equals("mobile")){
//			whereList_shop.add(new WhereSet ("WEB_MOBILE_GB_CD", Protocol.WhereSet.OP_HASANY, "00 20"));	//전체, 모바일
//		}else{
//			whereList_shop.add(new WhereSet ("WEB_MOBILE_GB_CD", Protocol.WhereSet.OP_HASANY, "00 10"));	//전체, PC
//		}
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//		
//		shop_whereSet = new WhereSet[whereList_shop.size()];
//		for (int i = 0; i < whereList_shop.size(); i++) {
//			shop_whereSet[i] = whereList_shop.get(i);
//		}
//		//상품 그룹 WhereSet 지정=====================================================================================================
//		
//		//if(searchVo.getSearchType().equals("")){ //일반검색인 경우
//			//상품 그룹 OrderBySet 지정=====================================================================================================
//			orderbys_shop = new OrderBySet[1];
//			orderbys_shop[0] = new OrderBySet(false, sortNm, Protocol.OrderBySet.OP_NONE);
//			//상품 그룹 OrderBySet 지정=====================================================================================================
//			    
//			//상품 그룹 GroupBySet 지정=====================================================================================================
//			groupList_shop.add(new GroupBySet("GROUP_CTG_NM_LMS", (byte)(Protocol.GroupBySet.OP_COUNT | Protocol.GroupBySet.ORDER_COUNT), "DESC", ""));
//			groupList_shop.add(new GroupBySet("GROUP_BND_NM", (byte)(Protocol.GroupBySet.OP_COUNT | Protocol.GroupBySet.ORDER_COUNT), "DESC", ""));
//			
//			groupSet_shop = new GroupBySet[groupList_shop.size()];
//			for(int i = 0; i < groupList_shop.size(); i++){
//				groupSet_shop[i] = groupList_shop.get(i);
//			}
//	        //상품 카테고리 그룹 카테고리 GroupBySet 지정=====================================================================================================
//	
//			//상품 카테고리 그룹, 최대값 쿼리=====================================================================================================
//			group_m3Query = new Query("","");
//			group_m3Query.setSelect(shop_selectSet);
//			group_m3Query.setWhere(shop_whereSet);
//			group_m3Query.setOrderby(orderbys_shop);
//			if(!groupList_shop.isEmpty()) group_m3Query.setGroupBy(groupSet_shop);
//			group_m3Query.setFrom("DCG"); // 사용할 콜렉션에 요청한다.
//			group_m3Query.setResult(0, 0); //페이지 결
//			//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
//			group_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD));
//			//유의어 /동의어 확장 사용
//			group_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM));
//			group_m3Query.setPrintQuery(false);
//			//group_m3Query.setLoggable(true);
//			group_m3Query.setDebug(true);
//			//group_m3Query.setQueryModifier("diver");
//			
//			
//			//상품 최소값 OrderBySet 지정=====================================================================================================
//			orderbys_shop = new OrderBySet[1];
//			orderbys_shop[0] = new OrderBySet(true, sortNm, Protocol.OrderBySet.OP_NONE);
//			//상품 최소값 OrderBySet 지정=====================================================================================================
//			
//			//상품 최소값 쿼리=====================================================================================================
//			price_m3Query = new Query("","");
//			price_m3Query.setSelect(shop_selectSet);
//			price_m3Query.setWhere(shop_whereSet);
//			price_m3Query.setOrderby(orderbys_shop);
//			price_m3Query.setFrom("DCG"); // 사용할 콜렉션에 요청한다.
//			price_m3Query.setResult(0, 0); //페이지 결
//			//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
//			price_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD));
//			//유의어 /동의어 확장 사용
//			price_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM));
//			price_m3Query.setPrintQuery(false);
//			//price_m3Query.setLoggable(true);
//			price_m3Query.setDebug(true);
//			price_m3Query.setQueryModifier("diver");
//			
//		//}
//		//상품 SelectSet 지정=====================================================================================================
//		shop_selectSet = new SelectSet[]{
//			new SelectSet("GOODS_ID", Protocol.SelectSet.NONE),	 
//			new SelectSet("GOODS_NM", Protocol.SelectSet.NONE),	
//			new SelectSet("BND_NM_KO", Protocol.SelectSet.NONE), 
//			new SelectSet("IMG_SEQ", Protocol.SelectSet.NONE), 
//			new SelectSet("IMG_PATH", Protocol.SelectSet.NONE), 
//			new SelectSet("PR_WDS_SHOW_YN", Protocol.SelectSet.NONE), 
//			new SelectSet("PR_WDS", Protocol.SelectSet.NONE),        
//			new SelectSet("FREE_DLVR_YN", Protocol.SelectSet.NONE), 
//			new SelectSet("COUPON_YN", Protocol.SelectSet.NONE), 
//			new SelectSet("IS_NEW", Protocol.SelectSet.NONE),    
//			new SelectSet("IS_BEST", Protocol.SelectSet.NONE),    
//			new SelectSet("SOLD_OUT_YN", Protocol.SelectSet.NONE), 
//			new SelectSet("IS_HOT_DEAL", Protocol.SelectSet.NONE), 
//			new SelectSet("WEB_MOBILE_GB_PC_PRC", Protocol.SelectSet.NONE),   
//			new SelectSet("WEB_MOBILE_GB_PC_PRMT_PRC", Protocol.SelectSet.NONE),   
//			new SelectSet("WEB_MOBILE_GB_MO_PRC", Protocol.SelectSet.NONE),   
//			new SelectSet("WEB_MOBILE_GB_MO_PRMT_PRC", Protocol.SelectSet.NONE),
//			new SelectSet("PC_SALE_PCT", Protocol.SelectSet.NONE),
//			new SelectSet("MO_SALE_PCT", Protocol.SelectSet.NONE),
//			new SelectSet("IS_GONG_GU", Protocol.SelectSet.NONE),
//			new SelectSet("BULK_ORD_END_YN", Protocol.SelectSet.NONE)
//			
//		};
//		//상품 SelectSet 지정=====================================================================================================
//		
//		//상품 WhereSet 지정=====================================================================================================
//		//혜택
//		if(searchVo.getDevicesType().equals("mobile")){
//			if(!searchVo.getSearchBenefit().equals("")){
//				String indexNm ="";
//				if(searchVo.getSearchBenefit().equals("coupon")){ //쿠폰
//					indexNm = "IDX_COUPON_YN";
//				}else if(searchVo.getSearchBenefit().equals("gonggu")){ //딜
//					indexNm = "IDX_IS_GONG_GU";
//				}else if(searchVo.getSearchBenefit().equals("free")){ //무료배송
//					indexNm = "IDX_FREE_DLVR_YN";
//				}
//				if(!indexNm.equals("")){
//					whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//					whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//					whereList_shop.add(new WhereSet (indexNm , Protocol.WhereSet.OP_HASALL, "Y" ,1));
//					whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//				}	
//			}
//		}else{
//			if(searchVo.getSearchBenefitPC() != null){
//				String[] searchArea = searchVo.getSearchBenefitPC();
//				int whereCont = 0;
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//				for(int a = 0; a < searchArea.length; a++){
//					if(searchArea[a].equals("coupon")){
//						if(whereCont > 0){
//							whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//						}
//						whereList_shop.add(new WhereSet ("IDX_COUPON_YN" , Protocol.WhereSet.OP_HASALL, "Y" ,1)); 
//						whereCont ++;
//					}
//					if(searchArea[a].equals("gonggu")){
//						if(whereCont > 0){
//							whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//						}
//						whereList_shop.add(new WhereSet ("IDX_IS_GONG_GU" , Protocol.WhereSet.OP_HASALL, "Y" ,1)); 
//						whereCont ++;
//					}
//					if(searchArea[a].equals("free")){
//						if(whereCont > 0){
//							whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//						}
//						whereList_shop.add(new WhereSet ("IDX_FREE_DLVR_YN" , Protocol.WhereSet.OP_HASALL, "Y" ,1)); 
//						whereCont ++;
//					}
//				}
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//	    	}
//			
//		}
//		
//		int whereSetChk = 0;
//		if(searchVo.getSearchLcate() != null || searchVo.getSearchMcate() != null || searchVo.getSearchScate() != null ||
//				searchVo.getSearchBrand() != null || searchVo.getSearchPremium() != null ||
//						searchVo.getSearchStore() != null || searchVo.getSearchDesigner() != null){
//			
//			whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//			whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//			
//			//소 카테고리
//			if(searchVo.getSearchScate() != null){
//				if(whereSetChk > 0)  whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//				for(int d=0; d < searchVo.getSearchScate().length; d++){
//					
//					whereList_shop.add(new WhereSet ("IDX_CTG_NM_LMS" , Protocol.WhereSet.OP_HASALL, searchVo.getSearchScate()[d] ,1));
//					if(d < searchVo.getSearchScate().length-1){
//						whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//					}
//				}
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//				whereSetChk++;
//			}
//			//브랜드
//			if(searchVo.getSearchBrand() != null){
//				if(whereSetChk > 0)  whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//				for(int d=0; d < searchVo.getSearchBrand().length; d++){
//					
//					whereList_shop.add(new WhereSet ("IDX_BND_NM" , Protocol.WhereSet.OP_HASALL, searchVo.getSearchBrand()[d] ,1));
//					if(d < searchVo.getSearchBrand().length-1){
//						whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//					}
//				}
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//				whereSetChk++;
//			}
//			//프리미엄
//			if(searchVo.getSearchPremium() != null){
//				if(whereSetChk > 0)  whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//				for(int d=0; d < searchVo.getSearchPremium().length; d++){
//					
//					whereList_shop.add(new WhereSet ("IDX_PRMT_BND_NM" , Protocol.WhereSet.OP_HASALL, searchVo.getSearchPremium()[d] ,1));
//					if(d < searchVo.getSearchPremium().length-1){
//						whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//					}
//				}
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//				whereSetChk++;
//			}
//			//스토어
//			if(searchVo.getSearchStore() != null){
//				if(whereSetChk > 0)  whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//				for(int d=0; d < searchVo.getSearchStore().length; d++){
//					
//					whereList_shop.add(new WhereSet ("IDX_STR_NM_FD" , Protocol.WhereSet.OP_HASALL, searchVo.getSearchStore()[d] ,1));
//					if(d < searchVo.getSearchStore().length-1){
//						whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//					}
//				}
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//				whereSetChk++;
//			}
//			//디자이너
//			if(searchVo.getSearchDesigner() != null){
//				if(whereSetChk > 0)  whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//				for(int d=0; d < searchVo.getSearchDesigner().length; d++){
//					
//					whereList_shop.add(new WhereSet ("IDX_DSGNR_NM_FD" , Protocol.WhereSet.OP_HASALL, searchVo.getSearchDesigner()[d] ,1));
//					if(d < searchVo.getSearchDesigner().length-1){
//						whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//					}
//				}
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//			}
//			whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//		}
//
//		shop_whereSet = new WhereSet[whereList_shop.size()];
//		for (int i = 0; i < whereList_shop.size(); i++) {
//			shop_whereSet[i] = whereList_shop.get(i);
//		}
//		//상품 WhereSet 지정=====================================================================================================
//		
//		//상품 FilterSet 지정=====================================================================================================
//		//가격
//		if(searchVo.getButtonPrice() != null && searchVo.getSearchStartPrice().equals("") && searchVo.getSearchEndPrice().equals("")){
//			String[] btn_prc_Array = searchVo.getButtonPrice();
//			String[] btn_prc_Array2;
//			StringBuilder btn_prc_name = new StringBuilder();
//			for(int i=0;i<btn_prc_Array.length;i++){ // ~5만원,  5~10만원, 9만원~
//				btn_prc_Array2 =  btn_prc_Array[i].split("~"); // [0]="",[1]5만원 // [0]=5,[1]만원 //[0]=9만원,[1]="" 
//				String start = "";
//				String end = "";
//				if(!btn_prc_Array2[0].equals("")){
//					if(btn_prc_Array2[0].indexOf("만원") <0){
//						start = btn_prc_Array2[0] + "만원";
//					}else{
//						start = btn_prc_Array2[0];
//					}
//				}else{
//					start = "0";
//				}
//				if(btn_prc_Array2.length ==1){
//					if(!btn_prc_Array2[0].equals("")){
//						end = "999999999";
//					}
//				}else{
//					end = btn_prc_Array2[1];
//				}
//				
//				btn_prc_name.append(start.replaceAll("만원", "0000")).append("/").append(end.replaceAll("만원", "0000")).append("/");
//    		}
//			
//			String[] arrayPrice = btn_prc_name.toString().split("/");
//			
//			filterList_shop.add(new FilterSet(Protocol.FilterSet.OP_RANGE, filterNm,  arrayPrice)); 
//		}else if(searchVo.getButtonPrice() == null && (!searchVo.getSearchStartPrice().equals("") || !searchVo.getSearchEndPrice().equals(""))){
//			String start = searchVo.getSearchStartPrice().replaceAll(",", "");
//			String end = searchVo.getSearchEndPrice().replaceAll(",", "");
//        	String[] price = {start, end};
//        	
//			filterList_shop.add(new FilterSet(Protocol.FilterSet.OP_RANGE, filterNm,  price)); 
//		}
//		
//		
//		filterSet_shop = new FilterSet[filterList_shop.size()];
//		for(int i = 0; i < filterList_shop.size(); i++){
//			filterSet_shop[i] = filterList_shop.get(i);
//		}
//        //상품 FilterSet 지정=====================================================================================================
//		
//		//상품 탭 카테고리 쿼리=====================================================================================================
//		groupList_shop.clear();
//		groupList_shop.add(new GroupBySet("GROUP_IS_STORE", (byte)(Protocol.GroupBySet.OP_COUNT |Protocol.GroupBySet.ORDER_COUNT), "DESC", ""));
//		groupList_shop.add(new GroupBySet("GROUP_IS_DESIGNER", (byte)(Protocol.GroupBySet.OP_COUNT |Protocol.GroupBySet.ORDER_COUNT), "DESC", ""));
//		groupList_shop.add(new GroupBySet("GROUP_IS_PRMT", (byte)(Protocol.GroupBySet.OP_COUNT |Protocol.GroupBySet.ORDER_COUNT), "DESC", ""));
//		
//		groupSet_shop = new GroupBySet[groupList_shop.size()];
//		for(int i = 0; i < groupList_shop.size(); i++){
//			groupSet_shop[i] = groupList_shop.get(i);
//		}
//		
//		tab_m3Query = new Query("","");
//		tab_m3Query.setSelect(shop_selectSet);
//		tab_m3Query.setWhere(shop_whereSet);
//		//tab_m3Query.setOrderby(orderbys_shop);
//		tab_m3Query.setFrom("DCG"); // 사용할 콜렉션에 요청한다.
//		tab_m3Query.setResult(0, 0); //페이지 결과
//		if(!filterList_shop.isEmpty()) tab_m3Query.setFilter(filterSet_shop);
//		if(!groupList_shop.isEmpty()) tab_m3Query.setGroupBy(groupSet_shop);
//		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
//		tab_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD));
//		//유의어 /동의어 확장 사용
//		tab_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM));
//		tab_m3Query.setPrintQuery(false);
//		//tab_m3Query.setLoggable(true);
//		tab_m3Query.setDebug(true);
//		tab_m3Query.setQueryModifier("diver");
//		
//		
//		//상품 WhereSet 지정=====================================================================================================
//		//카테고리
//		if(!searchVo.getSearchCategory().equals("")){
//			String indexNm ="";
//			if(searchVo.getSearchCategory().equals("store")){ //스토어
//				indexNm = "IDX_IS_STORE";
//			}else if(searchVo.getSearchCategory().equals("designer")){ //디자이너
//				indexNm = "IDX_IS_DESIGNER";
//			}else if(searchVo.getSearchCategory().equals("prmt")){ //프리미엄
//				indexNm = "IDX_IS_PRMT";
//			}
//			if(!indexNm.equals("")){
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_AND));
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//				whereList_shop.add(new WhereSet (indexNm , Protocol.WhereSet.OP_HASALL, "Y" ,1));
//				whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//			}
//		}
//		shop_whereSet = new WhereSet[whereList_shop.size()];
//		for (int i = 0; i < whereList_shop.size(); i++) {
//			shop_whereSet[i] = whereList_shop.get(i);
//		}
//		//상품 WhereSet 지정=====================================================================================================
//		
//		//상품 OrderBySet 지정=====================================================================================================
//		orderbys_shop = new OrderBySet[1];
//		if(searchVo.getSearchSort().equals("best")){  //인기순
//            orderbys_shop[0] = new OrderBySet(true, "SORT_BEST_RANK", Protocol.OrderBySet.OP_POSTWEIGHT);
//        }else if(searchVo.getSearchSort().equals("date")){  //신상품순
//            orderbys_shop[0] = new OrderBySet(true, "SORT_SYS_REG_DTM", Protocol.OrderBySet.OP_POSTWEIGHT);
//        }else if(searchVo.getSearchSort().equals("lowprice")){  //낮은 가격순
//        	orderbys_shop[0] = new OrderBySet(false, sortNm, Protocol.OrderBySet.OP_POSTWEIGHT);
//        }else if(searchVo.getSearchSort().equals("highprice")){  //높은 가격순
//        	orderbys_shop[0] = new OrderBySet(true, sortNm, Protocol.OrderBySet.OP_POSTWEIGHT);
//        }else if(searchVo.getSearchSort().equals("comment")){   //상품리뷰
//            orderbys_shop[0] = new OrderBySet(true, "SORT_GOODS_COMMENT_CNT", Protocol.OrderBySet.OP_POSTWEIGHT);
//        }else{   //가중치순+인기순
//            orderbys_shop[0] = new OrderBySet(true, "SORT_BEST_RANK", Protocol.OrderBySet.OP_PREWEIGHT);
//        }
//		//상품 OrderBySet 지정=====================================================================================================
//
//		//상품 쿼리=====================================================================================================
//		shop_m3Query = new Query("","");
//		shop_m3Query.setSelect(shop_selectSet);
//		shop_m3Query.setWhere(shop_whereSet);
//		shop_m3Query.setOrderby(orderbys_shop);
//		if(!filterList_shop.isEmpty()) shop_m3Query.setFilter(filterSet_shop);
//		shop_m3Query.setFrom("DCG"); // 사용할 콜렉션에 요청한다.
//		shop_m3Query.setResult(searchVo.getSearchDisplay() *(searchVo.getPageNumber()-1), (searchVo.getSearchDisplay() *searchVo.getPageNumber())-1);//페이지 결과
//		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
//		shop_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD));
//		//유의어 /동의어 확장 사용
//		//shop_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM));
//		//문서랭킹/카테로리 랭킹 사용
//		//shop_m3Query.setRankingOption((byte)(Protocol.RankingOption.DOCUMENT_RANKING | Protocol.RankingOption.CATEGORY_RANKING ));
//		//shop_m3Query.setCategoryRankingOption((byte)(Protocol.CategoryRankingOption.QUASI_SYNONYM| Protocol.CategoryRankingOption.EQUIV_SYNONYM |Protocol.CategoryRankingOption.MULTI_TERM_WHITESPACE ));
//		shop_m3Query.setPrintQuery(false);
//		shop_m3Query.setDebug(true);
//		//shop_m3Query.setLoggable(true);
//		//shop_m3Query.setLogKeyword(searchVo.getSearchQuery().toCharArray());
//		//shop_m3Query.setQueryModifier("diver");
//		//shop_m3Query.setRecommend(searchVo.getSearchQuery().toCharArray());
//
//		//String queryStr = parser.queryToString( shop_m3Query );
//		//System.out.println("queryStr = " + queryStr);
//		int queryCount = 4;
//		/*if(searchVo.getSearchType().equals("view")){ //일반검색이 아닌 경우
//			queryCount = 1;
//		}*/
//		querySet = new QuerySet(queryCount);
//		querySet.addQuery(group_m3Query);
//		querySet.addQuery(price_m3Query);
//		querySet.addQuery(tab_m3Query);
//		querySet.addQuery(shop_m3Query);
//		
//		/* 데모 작업을 위해 검색엔진 응답시간 10으로 변경
//		CommandSearchRequest.setProps(searchVo.getSearchIp(), searchVo.getSearchPort(), 10000, 1, 30); //응답시간,min pool size, max pool size 값설정
//		*/
//		CommandSearchRequest.setProps(searchVo.getSearchIp(), searchVo.getSearchPort(), 10, 1, 30);
//		CommandSearchRequest command = new CommandSearchRequest(searchVo.getSearchIp(), searchVo.getSearchPort());
//
//		returnCode = command.request(querySet);
//
//		//System.out.print("-- wiz error0 : " + ret + "--");
//		if (returnCode < 0) {
//			resultlist = new Result[1];
//			resultlist[0] = new Result();
//		}else{
//			resultlist = command.getResultSet().getResultList();
//		}
//
//		return resultlist;
//		
//	}
//	
//	//검색결과없을시 추천상품
//	public Result[] getRcmdSearch(SearchDqVo searchVo) throws IRException{
//		
//		Query md_m3Query = null; //쿼리를 담는 부분
//		
//		Result [] resultlist = null;
//		SelectSet[] shop_selectSet = null;
//		ArrayList<WhereSet> whereList_md = new ArrayList<>();
//		WhereSet[] md_whereSet = null; //MD상품
//		OrderBySet[] orderbys_md = null;	//MD정렬
//		
//		//상품 SelectSet 지정=====================================================================================================
//		shop_selectSet = new SelectSet[]{
//			new SelectSet("GOODS_ID", Protocol.SelectSet.NONE),	 
//			new SelectSet("GOODS_NM", Protocol.SelectSet.NONE),	
//			new SelectSet("BND_NM_KO", Protocol.SelectSet.NONE), 
//			new SelectSet("IMG_SEQ", Protocol.SelectSet.NONE), 
//			new SelectSet("IMG_PATH", Protocol.SelectSet.NONE), 
//			new SelectSet("PR_WDS_SHOW_YN", Protocol.SelectSet.NONE), 
//			new SelectSet("PR_WDS", Protocol.SelectSet.NONE),        
//			new SelectSet("FREE_DLVR_YN", Protocol.SelectSet.NONE), 
//			new SelectSet("COUPON_YN", Protocol.SelectSet.NONE), 
//			new SelectSet("IS_NEW", Protocol.SelectSet.NONE),    
//			new SelectSet("IS_BEST", Protocol.SelectSet.NONE),    
//			new SelectSet("SOLD_OUT_YN", Protocol.SelectSet.NONE), 
//			new SelectSet("IS_HOT_DEAL", Protocol.SelectSet.NONE), 
//			new SelectSet("WEB_MOBILE_GB_PC_PRC", Protocol.SelectSet.NONE),   
//			new SelectSet("WEB_MOBILE_GB_PC_PRMT_PRC", Protocol.SelectSet.NONE),   
//			new SelectSet("WEB_MOBILE_GB_MO_PRC", Protocol.SelectSet.NONE),   
//			new SelectSet("WEB_MOBILE_GB_MO_PRMT_PRC", Protocol.SelectSet.NONE),	
//			new SelectSet("PC_SALE_PCT", Protocol.SelectSet.NONE),
//			new SelectSet("MO_SALE_PCT", Protocol.SelectSet.NONE),
//			new SelectSet("IS_GONG_GU", Protocol.SelectSet.NONE),
//			new SelectSet("BULK_ORD_END_YN", Protocol.SelectSet.NONE)
//		};
//		//상품 SelectSet 지정=====================================================================================================
//		
//		
//		//MD WhereSet 지정=====================================================================================================
//		whereList_md.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//		whereList_md.add(new WhereSet ("IDX_ALL" , Protocol.WhereSet.OP_HASALL, "A"));
//		whereList_md.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//		
//		whereList_md.add(new WhereSet(Protocol.WhereSet.OP_AND));
//		whereList_md.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//		if(searchVo.getDevicesType().equals("mobile")){
//			whereList_md.add(new WhereSet ("WEB_MOBILE_GB_CD", Protocol.WhereSet.OP_HASANY, "00 20"));	//전체, 모바일
//		}else{
//			whereList_md.add(new WhereSet ("WEB_MOBILE_GB_CD", Protocol.WhereSet.OP_HASANY, "00 10"));	//전체, PC
//		}
//		whereList_md.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//		
//		md_whereSet = new WhereSet[whereList_md.size()];
//		
//		for (int i = 0; i < whereList_md.size(); i++) {
//			md_whereSet[i] = whereList_md.get(i);
//		}
//		//MD WhereSet 지정=====================================================================================================
//		
//		//MD OrderBySet 지정=====================================================================================================
//		orderbys_md = new OrderBySet[1];
//		orderbys_md[0] = new OrderBySet(true, "SORT_HITS", Protocol.OrderBySet.OP_PREWEIGHT);
//		
//		//MD 쿼리=====================================================================================================
//		md_m3Query = new Query("","");
//		md_m3Query.setSelect(shop_selectSet);
//		md_m3Query.setWhere(md_whereSet);
//		md_m3Query.setOrderby(orderbys_md);
//		//if(filterList_shop.size() > 0) shop_m3Query.setFilter(filterSet_shop);
//		md_m3Query.setFrom("DCG"); // 사용할 콜렉션에 요청한다.
//		md_m3Query.setResult(0,4);//페이지 결과
//		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
//		md_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD));
//		//유의어 /동의어 확장 사용
//		//shop_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM));
//		//문서랭킹/카테로리 랭킹 사용
//		//shop_m3Query.setRankingOption((byte)(Protocol.RankingOption.DOCUMENT_RANKING | Protocol.RankingOption.CATEGORY_RANKING ));
//		//shop_m3Query.setCategoryRankingOption((byte)(Protocol.CategoryRankingOption.QUASI_SYNONYM| Protocol.CategoryRankingOption.EQUIV_SYNONYM |Protocol.CategoryRankingOption.MULTI_TERM_WHITESPACE ));
//		md_m3Query.setPrintQuery(false);
//		md_m3Query.setDebug(true);
//		//shop_m3Query.setLoggable(true);
//		//shop_m3Query.setLogKeyword(searchVo.getSearchQuery().toCharArray());
//		//shop_m3Query.setQueryModifier("diver");
//		//shop_m3Query.setRecommend(searchVo.getSearchQuery().toCharArray());
//		
//		querySet = new QuerySet(1);
//		querySet.addQuery(md_m3Query);
//		
//		CommandSearchRequest.setProps(searchVo.getSearchIp(), searchVo.getSearchPort(), 10000, 1, 30); //응답시간,min pool size, max pool size 값설정
//		CommandSearchRequest command = new CommandSearchRequest(searchVo.getSearchIp(), searchVo.getSearchPort());
//
//		returnCode2 = command.request(querySet);
//
//		//System.out.print("-- wiz error0 : " + returnCode2 + "--");
//		if (returnCode2 < 0) {
//			resultlist = new Result[1];
//			resultlist[0] = new Result();
//		}else{
//			resultlist = command.getResultSet().getResultList();
//		}
//		
//		return resultlist;
//		
//	}
//	
//	//인기검색어
//	public List<SearchResultVo> getHotSearch(SearchDqVo searchVo){
//		Query query = new Query();
//		Result [] resultlist = null;
//		Result result = null;
//		List<SearchResultVo> searchList = new ArrayList<>();
//		
//		SelectSet[] selectSet = new SelectSet[]{
//			 new SelectSet("KEYWORD", Protocol.SelectSet.NONE),		 
//			 new SelectSet("RANKING", Protocol.SelectSet.NONE),
//			 new SelectSet("NOWDATE", Protocol.SelectSet.NONE)
//		};
//
//		WhereSet[] whereSet = null;
//		ArrayList<WhereSet> whereSetList = new ArrayList<>();
//		
//		whereSetList.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//		whereSetList.add(new WhereSet("IDX_TYPE", Protocol.WhereSet.OP_HASALL, "D"));
//		whereSetList.add(new WhereSet (Protocol.WhereSet.OP_BRACE_CLOSE));
//
//		whereSet = new WhereSet[whereSetList.size()];
//
//		for(int j = 0 ; j < whereSetList.size() ; j++) {
//
//			  whereSet[j] = whereSetList.get(j);
//		}
//		
//		OrderBySet[] orderBySet = new OrderBySet[]{
//			new OrderBySet(true, "SORT_RANKING", Protocol.OrderBySet.OP_NONE)
//		};
//		
//		query.setSelect(selectSet);
//		query.setWhere(whereSet);
//		query.setOrderby(orderBySet);
//		query.setFrom("HOTKEYWORD");
//		query.setResult(0,9);//페이지 결과
//		query.setDebug(true);
//		query.setPrintQuery(false);
//		
//		querySet = new QuerySet(1);
//		querySet.addQuery(query);
//
//		// 검색 서버로 검색 정보 전송
//		CommandSearchRequest.setProps(searchVo.getSearchIp(), searchVo.getSearchPort(), 5000, 20, 20);
//		CommandSearchRequest command = new CommandSearchRequest(searchVo.getSearchIp(), searchVo.getSearchPort());
//		
//		try {
//			returnCode = command.request(querySet);
//			
//			if(returnCode >= 0){
//				ResultSet results = command.getResultSet();
//				resultlist = results.getResultList();
//				result = resultlist[0];
//				searchList = sr.getHotResult(result);	
//			}
//		} catch (IRException e) {
//			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
//		}
//				
//		return searchList;
//		
//	}
//	
//	//자동완성
//	public List<SearchResultVo> getAutoSearch(SearchDqVo searchVo) throws IRException{
//
//		Query query = new Query();
//		Result [] resultlist = null;
//		Result result = null;
//		String corrected = "";	//한영변환 검색어
//		List<SearchResultVo> searchList = new ArrayList<>();
//		
//		SelectSet[] selectSet = new SelectSet[]{
//			 new SelectSet("KEYWORD", Protocol.SelectSet.NONE),
//	         new SelectSet("COUNT", Protocol.SelectSet.NONE)
//		};
//
//		WhereSet[] whereSet = null;
//		ArrayList<WhereSet> whereSetList = new ArrayList<>();
//		
//		whereSetList.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//		whereSetList.add(new WhereSet("IDX_KEYWORD", Protocol.WhereSet.OP_HASALL, searchVo.getSearchQuery()));
//		whereSetList.add(new WhereSet(Protocol.WhereSet.OP_OR));
//		whereSetList.add(new WhereSet("IDX_KEYWORD_CHO", Protocol.WhereSet.OP_HASALL, searchVo.getSearchQuery()));
//		whereSetList.add(new WhereSet (Protocol.WhereSet.OP_BRACE_CLOSE));
//
//		whereSet = new WhereSet[whereSetList.size()];
//
//		for(int j = 0 ; j < whereSetList.size() ; j++) {
//
//			whereSet[j] = whereSetList.get(j);
//		}
//		
//		OrderBySet[] orderBySet = new OrderBySet[]{
//			new OrderBySet(true, "SORT_COUNT", Protocol.OrderBySet.OP_NONE)
//		};
//		
//		query.setSelect(selectSet);
//		query.setWhere(whereSet);
//		query.setOrderby(orderBySet);
//		query.setFrom("SMARTMAKER");
//		query.setResult(0,9);//페이지 결과
//		query.setDebug(true);
//		query.setPrintQuery(false);
//		query.setResultModifier("typo");
//		query.setValue("typo-parameters", searchVo.getSearchQuery());
//		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
//		query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD));
//		
//		querySet = new QuerySet(1);
//		querySet.addQuery(query);
//
//		// 검색 서버로 검색 정보 전송
//		CommandSearchRequest.setProps(searchVo.getSearchIp(), searchVo.getSearchPort(), 5000, 20, 20);
//		CommandSearchRequest command = new CommandSearchRequest(searchVo.getSearchIp(), searchVo.getSearchPort());
//		
//		returnCode = command.request(querySet);
//		
//		if(returnCode >= 0){
//			ResultSet results = command.getResultSet();
//			resultlist = results.getResultList();
//			result = resultlist[0];
//			
//			int realSize = result.getRealSize();
//			
//			corrected = result.getValue("typo-result");
//
//            if (realSize <= 0 && !corrected.equals("") ) {
//            	
//            	whereSetList.clear();
//            	whereSetList.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//        		whereSetList.add(new WhereSet("IDX_KEYWORD", Protocol.WhereSet.OP_HASALL, corrected));
//        		whereSetList.add(new WhereSet(Protocol.WhereSet.OP_OR));
//        		whereSetList.add(new WhereSet("IDX_KEYWORD_CHO", Protocol.WhereSet.OP_HASALL, corrected));
//        		whereSetList.add(new WhereSet (Protocol.WhereSet.OP_BRACE_CLOSE));
//
//        		whereSet = new WhereSet[whereSetList.size()];
//
//        		for(int j = 0 ; j < whereSetList.size() ; j++) {
//
//        			whereSet[j] = whereSetList.get(j);
//        		}
//        		
//        		query = new Query("", "");
//        		query.setSelect(selectSet);
//        		query.setWhere(whereSet);
//        		query.setOrderby(orderBySet);
//        		query.setFrom("SMARTMAKER");
//        		query.setResult(0,9);//페이지 결과
//        		query.setDebug(true);
//        		query.setPrintQuery(false);
//        		
//        		
//        		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
//        		query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD));
//        		
//        		querySet = new QuerySet(1);
//        		querySet.addQuery(query);
//        		
//        		// 검색 서버로 검색 정보 전송
//        		CommandSearchRequest.setProps(searchVo.getSearchIp(), searchVo.getSearchPort(), 5000, 20, 20);
//        		command = new CommandSearchRequest(searchVo.getSearchIp(), searchVo.getSearchPort());
//        		
//        		returnCode = command.request(querySet);
//        		
//        		if(returnCode >= 0){
//        			results = command.getResultSet();
//        			resultlist = results.getResultList();
//        			result = resultlist[0];
//        		}else{
//        			resultlist = new Result[1];
//        			resultlist[0] = new Result();
//        		}
//        		
//            }
//			searchList = sr.getAutoResult(result);	
//		}else{
//			resultlist = new Result[1];
//			resultlist[0] = new Result();
//		}
//		
//				
//		return searchList;
//		
//	}
//	
//	
//	private List<WhereSet> setShopWhereSet(String searchQuery) {
//		
//		List<WhereSet> whereList_shop = new ArrayList<>();
//
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
//		whereList_shop.add(new WhereSet ("IDX_GOODS_ID", Protocol.WhereSet.OP_HASALL, searchQuery, 1));	//상품코드
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//		whereList_shop.add(new WhereSet ("IDX_GOODS_NM", Protocol.WhereSet.OP_HASALL, searchQuery,300));	//상품명
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//		whereList_shop.add(new WhereSet ("IDX_BND_NM_KO", Protocol.WhereSet.OP_HASALL, searchQuery,300));	//브랜드명
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//		whereList_shop.add(new WhereSet ("IDX_DSGNR_NM", Protocol.WhereSet.OP_HASALL, searchQuery,300));	//디자이너명
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//		whereList_shop.add(new WhereSet ("IDX_STR_NM", Protocol.WhereSet.OP_HASALL, searchQuery,300));	//스토어명
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//		whereList_shop.add(new WhereSet ("IDX_CTG_NM", Protocol.WhereSet.OP_HASALL, searchQuery,300));	//카테고리명
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//		whereList_shop.add(new WhereSet ("IDX_BND_NM_EN", Protocol.WhereSet.OP_HASALL, searchQuery,300));	//브랜드명영문
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//		whereList_shop.add(new WhereSet ("IDX_COMP_NM", Protocol.WhereSet.OP_HASALL, searchQuery,300));	//업체명
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_OR));
//		whereList_shop.add(new WhereSet ("IDX_TOTAL", Protocol.WhereSet.OP_HASALL, searchQuery,1));	//전체
//		whereList_shop.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
//		
//		return whereList_shop;
//
//	}
//	
//	
//	/*
//	 * 상품 검색 페이지 네비게이션
//	*/
//	 public String getPage(int pageSize, int currentPage, int total) {
//        int pageBlock = 10;
//        int totalPage = ((total-1)/pageSize)+1;
//        int prevPage = (currentPage-1)/pageBlock*pageBlock;
//        int nextPage = prevPage+pageBlock+1;
//        StringBuilder result = new StringBuilder();
//
//        if(total > 0) {
//
//            // 페이징 시작
//        	 result.append("<div class=\"page_nav\" id=\"goods_list_page\">");
//        	 if(currentPage != 1) {
//        		   // 첫 페이지
//        		 result.append("<a href=\"javascript:movePage(1);\" class=\"btn_paging first\">처음</a>");
//                if(prevPage > 0) {
//                	// 이전 페이지
//                	result.append("<a href=\"javascript:movePage("+ prevPage + ");\" class=\"btn_paging prev\">이전으로</a>");
//                } else {
//                	result.append("");
//                }
//            } else {
//            	result.append("");
//            }
//
//            for(int i=1+prevPage; i<nextPage && i<=totalPage; i++) {
//                if(i == currentPage) {
//                	result.append("<strong class=\"current\">"+ i +"</strong>");
//                    if((i != nextPage-1) && (i != totalPage)) {
//                    	result.append(" ");
//                    }
//                } else {
//                	result.append("<a href=\"javascript:movePage(" + i + ");\">"+ i +"</a>");
//                    if((i != nextPage-1) && (i != totalPage)) {
//                    	result.append(" ");
//                    }
//                }
//            }
//
//            if(totalPage > currentPage) {
//                if(totalPage >= nextPage) {
//                	// 다음 페이지
//                	result.append("<a href=\"javascript:movePage("+ nextPage + ");\" class=\"btn_paging next\"></a>");
//                } else {
//                	result.append("");
//                }
//                // 마지막 페이지
//                result.append("<a href=\"javascript:movePage("+ totalPage + ");\" class=\"btn_paging end\"></a>");
//            }
//            result.append("</div>");
//        }
//        return result.toString();
//    }
//	
//	public List<String> plist(String start, String end){
//		 int startInt = Integer.parseInt(start);
//	     int endInt = Integer.parseInt(end);
//	     List<String> plist = new ArrayList<>();
//	     
//	     int range = (endInt )/6;
//	     Map<Integer, String> map = new HashMap<>();
//	
//	     if(range >= 10000){
//             if(start.length() != end.length()){
//                    int count = 1;
//                     while (startInt <= endInt) {
//                            startInt = startInt +(range);
//                            map.put(count, startInt+"");
//                            count++;
//                    }
//             }       
//             for(int i=1; i < map.size(); i++){
//                    String curr = map.get(i);
//                    if(curr.length()>4) curr = curr.substring(0, curr.length()-4) ;
//                    String post = "";
//                    if(i < ( map.size()-1)){
//                            post = map.get(i+1);
//                            if(post.length()>4) post = post.substring(0, post.length()-4);
//                    }
//                    if(i==1){
//                            plist.add("~"+curr+"만원");
//                            plist.add(curr+"~"+post+"만원");
//                    }else if(i == ( map.size()-1)){
//                            plist.add(curr+"만원~");
//                    }else{
//                            plist.add(curr+"~"+post+"만원");
//                    }
//
//             }
//            /* for(int i=0; i < plist.size(); i++){
//                    System.out.println(plist.get(i));
//             }*/
//	     }
//	     
//	     return plist;
//	 }
//
//	public int getReturnCode() {
//		return returnCode;
//	}
//
//	public void setReturnCode(int returnCode) {
//		this.returnCode = returnCode;
//	}
//
//	public int getReturnCode2() {
//		return returnCode2;
//	}
//
//	public void setReturnCode2(int returnCode2) {
//		this.returnCode2 = returnCode2;
//	}
//
//	public char[] getStartTag() {
//		return startTag;
//	}
//
//	public void setStartTag(char[] startTag) {
//		this.startTag = startTag;
//	}
//
//	public char[] getEndTag() {
//		return endTag;
//	}
//
//	public void setEndTag(char[] endTag) {
//		this.endTag = endTag;
//	}
//	
}
