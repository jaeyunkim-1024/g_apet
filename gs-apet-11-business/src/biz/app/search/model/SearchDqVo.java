package biz.app.search.model;

public class SearchDqVo  {
	
	private String searchIp = "";			//검색엔진 ip
	private int searchPort = 5555;			//검색엔진 port
	
	private String devicesType = "web";
	private String searchType = "";
	
	private String searchQuery = "";		//검색어
	private String searchCategory = "";		//카테고리
	private String searchSort = "";			//정렬
	private String[] searchBenefitPC; 		//PC혜택
	private String searchBenefit = "";		//Mibile혜택
	private int searchDisplay = 10;			//노출수
	private int pageSize = 10;				//노출수임시
	private int pageNumber = 1;				//현재페이지
	private String researchQuery = "";		//재검색어
	private String allsearchQuery = "";		//모든검색어
	private String buttonType = "";			//리스트 버튼모양
	private String listType = "";			//리스트모양 체크값

	private String[] buttonPrice;			//범위가격버튼
	private String searchPrice = "";		//가격		
	private String searchStartPrice = "";	//시작가격
	private String searchEndPrice = "";		//종료가격
	
	private String resultStartPrice = "";	//검색결과 시작가격
	private String resultEndPrice = "";		//검색결과 종료가격
	
	private String[] searchBrand = null;	//브랜드
	private String[] searchPremium = null;	//프리미엄
	private String[] searchStore = null; 	//스토어
	private String[] searchDesigner = null; //디자이너
	
	private String[] searchLcate = null;	//대 카테고리
	private String[] searchMcate = null;	//중 카테고리
	private String[] searchScate = null;	//소 카테고리
	
	private String cateLcode = "";			//대 카테고리코드
	private String cateMcode = "";			//중 카테고리코드
	private String cateScode = "";			//소 카테고리코드
	
	private int shop_totalSize = 0;			//상품 사이즈
	private int group_totalSize = 0;		//상품 그룹 사이즈
	private int tab_totalSize = 0;			//상품 탭 사이즈
	private int totalPage = 0;				//상품 총 페이지
	
	private String sCateShow = "";			//마지막 소카테 id값 기억 파라미터
	private String menuActive  = "";		//메뉴탭 클래스 엑티브 값
	
	public String getDevicesType() {
		return devicesType;
	}
	public void setDevicesType(String devicesType) {
		this.devicesType = devicesType;
	}
	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public int getShop_totalSize() {
		return shop_totalSize;
	}
	public void setShop_totalSize(int shop_totalSize) {
		this.shop_totalSize = shop_totalSize;
	}
	public int getGroup_totalSize() {
		return group_totalSize;
	}
	public void setGroup_totalSize(int group_totalSize) {
		this.group_totalSize = group_totalSize;
	}
	
	public int getTab_totalSize() {
		return tab_totalSize;
	}
	public void setTab_totalSize(int tab_totalSize) {
		this.tab_totalSize = tab_totalSize;
	}
	public String getSearchQuery() {
		return searchQuery;
	}
	public void setSearchQuery(String searchQuery) {
		this.searchQuery = searchQuery;
	}
	public String getSearchCategory() {
		return searchCategory;
	}
	public void setSearchCategory(String searchCategory) {
		this.searchCategory = searchCategory;
	}
	public String getSearchSort() {
		return searchSort;
	}
	public void setSearchSort(String searchSort) {
		this.searchSort = searchSort;
	}
	public String getSearchBenefit() {
		return searchBenefit;
	}
	public void setSearchBenefit(String searchBenefit) {
		this.searchBenefit = searchBenefit;
	}
	public int getSearchDisplay() {
		return searchDisplay;
	}
	public void setSearchDisplay(int searchDisplay) {
		this.searchDisplay = searchDisplay;
	}
	public int getPageNumber() {
		return pageNumber;
	}
	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}
	public String getResearchQuery() {
		return researchQuery;
	}
	public void setResearchQuery(String researchQuery) {
		this.researchQuery = researchQuery;
	}
	public String getAllsearchQuery() {
		return allsearchQuery;
	}
	public void setAllsearchQuery(String allsearchQuery) {
		this.allsearchQuery = allsearchQuery;
	}
	public String getSearchPrice() {
		return searchPrice;
	}
	public void setSearchPrice(String searchPrice) {
		this.searchPrice = searchPrice;
	}
	public String getSearchStartPrice() {
		return searchStartPrice;
	}
	public void setSearchStartPrice(String searchStartPrice) {
		this.searchStartPrice = searchStartPrice;
	}
	public String getSearchEndPrice() {
		return searchEndPrice;
	}
	public void setSearchEndPrice(String searchEndPrice) {
		this.searchEndPrice = searchEndPrice;
	}
	
	public String getResultStartPrice() {
		return resultStartPrice;
	}
	public void setResultStartPrice(String resultStartPrice) {
		this.resultStartPrice = resultStartPrice;
	}
	public String getResultEndPrice() {
		return resultEndPrice;
	}
	public void setResultEndPrice(String resultEndPrice) {
		this.resultEndPrice = resultEndPrice;
	}
	public String[] getSearchBrand() {
		//return searchBrand;
		
		//보안진단 처리-Public 메소드로부터 반환된 Private 배열
		String[] copySearchBrand = null;
		if(this.searchBrand != null) {
			copySearchBrand = new String[this.searchBrand.length];
			for(int i=0; i<this.searchBrand.length; i++) {
				copySearchBrand[i] = this.searchBrand[i]; 
			}
		}
		
		return copySearchBrand;
	}
	public void setSearchBrand(String[] searchBrand) {
		//this.searchBrand = searchBrand;
		//보안진단 처리-Private 배열에 Public 데이터 할당
		this.searchBrand = new String[searchBrand.length];
		for(int i=0; i<searchBrand.length; i++) {
			this.searchBrand[i] = searchBrand[i];
		}
	}
	public String[] getSearchPremium() {
		//return searchPremium;
		
		//보안진단 처리-Public 메소드로부터 반환된 Private 배열
		String[] copySearchPremium = null;
		if(this.searchPremium != null) {
			copySearchPremium = new String[this.searchPremium.length];
			for(int i=0; i<this.searchPremium.length; i++) {
				copySearchPremium[i] = this.searchPremium[i]; 
			}
		}
		
		return copySearchPremium;
	}
	public void setSearchPremium(String[] searchPremium) {
		//this.searchPremium = searchPremium;
		//보안진단 처리-Private 배열에 Public 데이터 할당
		this.searchPremium = new String[searchPremium.length];
		for(int i=0; i<searchPremium.length; i++) {
			this.searchPremium[i] = searchPremium[i];
		}
	}
	public String[] getSearchStore() {
		//return searchStore;
		
		//보안진단 처리-Public 메소드로부터 반환된 Private 배열
		String[] copySearchStore = null;
		if(this.searchStore != null) {
			copySearchStore = new String[this.searchStore.length];
			for(int i=0; i<this.searchStore.length; i++) {
				copySearchStore[i] = this.searchStore[i]; 
			}
		}
		
		return copySearchStore;
	}
	public void setSearchStore(String[] searchStore) {
		//this.searchStore = searchStore;
		//보안진단 처리-Private 배열에 Public 데이터 할당
		this.searchStore = new String[searchStore.length];
		for(int i=0; i<searchStore.length; i++) {
			this.searchStore[i] = searchStore[i];
		}
	}
	public String[] getSearchDesigner() {
		//return searchDesigner;
		
		//보안진단 처리-Public 메소드로부터 반환된 Private 배열
		String[] copySearchDesigner = null;
		if(this.searchDesigner != null) {
			copySearchDesigner = new String[this.searchDesigner.length];
			for(int i=0; i<this.searchDesigner.length; i++) {
				copySearchDesigner[i] = this.searchDesigner[i]; 
			}
		}
		
		return copySearchDesigner;
	}
	public void setSearchDesigner(String[] searchDesigner) {
		//this.searchDesigner = searchDesigner;
		//보안진단 처리-Private 배열에 Public 데이터 할당
		this.searchDesigner = new String[searchDesigner.length];
		for(int i=0; i<searchDesigner.length; i++) {
			this.searchDesigner[i] = searchDesigner[i];
		}
	}
	public String[] getSearchLcate() {
		//return searchLcate;
		
		//보안진단 처리-Public 메소드로부터 반환된 Private 배열
		String[] copySearchLcate = null;
		if(this.searchLcate != null) {
			copySearchLcate = new String[this.searchLcate.length];
			for(int i=0; i<this.searchLcate.length; i++) {
				copySearchLcate[i] = this.searchLcate[i]; 
			}
		}
		
		return copySearchLcate;
	}
	public void setSearchLcate(String[] searchLcate) {
		//this.searchLcate = searchLcate;
		//보안진단 처리-Private 배열에 Public 데이터 할당
		this.searchLcate = new String[searchLcate.length];
		for(int i=0; i<searchLcate.length; i++) {
			this.searchLcate[i] = searchLcate[i];
		}
	}
	public String[] getSearchMcate() {
		//return searchMcate;
		
		//보안진단 처리-Public 메소드로부터 반환된 Private 배열
		String[] copySearchMcate = null;
		if(this.searchMcate != null) {
			copySearchMcate = new String[this.searchMcate.length];
			for(int i=0; i<this.searchMcate.length; i++) {
				copySearchMcate[i] = this.searchMcate[i]; 
			}
		}
		
		return copySearchMcate;
	}
	public void setSearchMcate(String[] searchMcate) {
		//this.searchMcate = searchMcate;
		//보안진단 처리-Private 배열에 Public 데이터 할당
		this.searchMcate = new String[searchMcate.length];
		for(int i=0; i<searchMcate.length; i++) {
			this.searchMcate[i] = searchMcate[i];
		}
	}
	public String[] getSearchScate() {
		//return searchScate;
		
		//보안진단 처리-Public 메소드로부터 반환된 Private 배열
		String[] copySearchScate = null;
		if(this.searchScate != null) {
			copySearchScate = new String[this.searchScate.length];
			for(int i=0; i<this.searchScate.length; i++) {
				copySearchScate[i] = this.searchScate[i]; 
			}
		}
		
		return copySearchScate;
	}
	public void setSearchScate(String[] searchScate) {
		//this.searchScate = searchScate;
		//보안진단 처리-Private 배열에 Public 데이터 할당
		this.searchScate = new String[searchScate.length];
		for(int i=0; i<searchScate.length; i++) {
			this.searchScate[i] = searchScate[i];
		}
	}
	public String getSearchIp() {
		return searchIp;
	}
	public void setSearchIp(String searchIp) {
		this.searchIp = searchIp;
	}
	public int getSearchPort() {
		return searchPort;
	}
	public void setSearchPort(int searchPort) {
		this.searchPort = searchPort;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public String[] getSearchBenefitPC() {
		//return searchBenefitPC;
		
		//보안진단 처리-Public 메소드로부터 반환된 Private 배열
		String[] copySearchBenefitPC = null;
		if(this.searchBenefitPC != null) {
			copySearchBenefitPC = new String[this.searchBenefitPC.length];
			for(int i=0; i<this.searchBenefitPC.length; i++) {
				copySearchBenefitPC[i] = this.searchBenefitPC[i]; 
			}
		}
		
		return copySearchBenefitPC;
	}
	public void setSearchBenefitPC(String[] searchBenefitPC) {
		//this.searchBenefitPC = searchBenefitPC;
		//보안진단 처리-Private 배열에 Public 데이터 할당
		this.searchBenefitPC = new String[searchBenefitPC.length];
		for(int i=0; i<searchBenefitPC.length; i++) {
			this.searchBenefitPC[i] = searchBenefitPC[i];
		}
	}
	public String[] getButtonPrice() {
		//return buttonPrice;
		
		//보안진단 처리-Public 메소드로부터 반환된 Private 배열
		String[] copyButtonPrice = null;
		if(this.buttonPrice != null) {
			copyButtonPrice = new String[this.buttonPrice.length];
			for(int i=0; i<this.buttonPrice.length; i++) {
				copyButtonPrice[i] = this.buttonPrice[i]; 
			}
		}
		
		return copyButtonPrice;
	}
	public void setButtonPrice(String[] buttonPrice) {
		//this.buttonPrice = buttonPrice;
		//보안진단 처리-Private 배열에 Public 데이터 할당
		this.buttonPrice = new String[buttonPrice.length];
		for(int i=0; i<buttonPrice.length; i++) {
			this.buttonPrice[i] = buttonPrice[i];
		}
	}
	public String getCateLcode() {
		return cateLcode;
	}
	public void setCateLcode(String cateLcode) {
		this.cateLcode = cateLcode;
	}
	public String getCateMcode() {
		return cateMcode;
	}
	public void setCateMcode(String cateMcode) {
		this.cateMcode = cateMcode;
	}
	public String getCateScode() {
		return cateScode;
	}
	public void setCateScode(String cateScode) {
		this.cateScode = cateScode;
	}
	public String getsCateShow() {
		return sCateShow;
	}
	public void setsCateShow(String sCateShow) {
		this.sCateShow = sCateShow;
	}
	public String getListType() {
		return listType;
	}
	public void setListType(String listType) {
		this.listType = listType;
	}
	public String getButtonType() {
		return buttonType;
	}
	public void setButtonType(String buttonType) {
		this.buttonType = buttonType;
	}
	public String getMenuActive() {
		return menuActive;
	}
	public void setMenuActive(String menuActive) {
		this.menuActive = menuActive;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
}
