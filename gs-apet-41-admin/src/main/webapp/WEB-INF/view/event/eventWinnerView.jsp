<script>
	//이벤트 당첨자 목록
	function creatWinnerGrid(){
		var searchParam = {
			eventNo : $("input[name=eventNo]").val()
		};
		var options = {
				url : "/event/creatWinnerGrid.do"
			, height : 300
			, searchParam : searchParam
			, colModels : [
					{name:"winNo", hidden:true}
				,	{name : "no" , label:'No.', width:"150", align:"center", sortable:false}
				, 	{name:"rewardNm", label:'보상명', width:"300", align:"center", sortable:false}
				,	{name:"mbrNo", label:'회원번호', width:"120", align:"left", sortable:false}
				, 	{name:"ctt", label:'휴대폰 번호', width:"120", align:"left", sortable:false}
			]
		};
		grid.create("eventWinnerList", options);
	}
	
	$(document).ready(function(){
		//그리드 생성
		creatWinnerGrid();
	});
</script>
<div>
	<div class="mButton">
		<div class="rightInner">
			<c:choose>
				<c:when test="${empty vo.eventNo}" >
					<button class="btn" type="button" id="eventWinnerUploadBtn" value="insert">당첨자 등록</button>
				</c:when>
				<c:otherwise><button class="btn" type="button" id="eventWinnerUploadBtn" value="update">당첨자 수정</button></c:otherwise>
			</c:choose>
		</div>
	</div>
	<table id="eventWinnerList"></table>
	<div id="eventWinnerListPage"></div>
</div>