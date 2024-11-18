<script>
	//이벤트 참여자 목록 생성
	function creatParticipantGrid(){
		var searchParam = $("#searchForm").serializeJson();
		searchParam.eventNo = $("input[name=eventNo]").val();

		var options = {
				url : "/event/creatParticipantGrid.do"
			, height : 300
			, searchParam : searchParam
			, colModels : [
				  {name:"patiNo", hidden:true}
				, {name:"rowNum",label:'No.', width:"150", align:"center", sortable:false}
				, {name:"mbrNo",label:'회원 번호', width:"150", align:"center", sortable:false}
				, {name:"patirNm", label:'이름', width:"120", align:"center", sortable:false}
				, {name:"loginId", label:'아이디', width:"240", align:"left", sortable:false}
				, {name:"ctt", label:'휴대폰 번호', width:"120", align:"left", sortable:false , formatter:gridFormat.phonenumber}
				, {name:"sysUpdDtm", label:'참여 일시', width:"200", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
				, {name:"enryAply", label:'응모 댓글', width:"200", align:"center", sortable:false, formatter : function(cellvalue, options, rowObject){
						if(cellvalue != null){
							cellvalue = cellvalue.replace(/\r+|\s+|\n+/gi,' ');
							var length = cellvalue.length;
							if(length > 20){
								cellvalue = cellvalue.substring(0,17) + "...";
							}
						}
						return cellvalue;
					}}
			]
		};
		grid.create("eventParticipantList", options);
	}
	
	$(document).ready(function(){
		creatParticipantGrid();
	
		//숫자만 입력 가능
		$("input:text[numberOnly]").on("keyup", function() {
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		});
		
	});

</script>
<div class="mt30" id="eventParticipant">
	<form id="searchForm">
		<table class="table_type1">
			<tr>
				<!-- 이름 -->
				<th>이름</th>
				<td>
					<input class="w250" name="patirNm" type="text" />
				</td>
				<!-- 휴대폰 번호 -->
				<th>휴대폰 번호</th>
				<td>
					<input class="w250" name="ctt" type="text" numberOnly/>
				</td>
			</tr>
		</table>
	</form>
	<div class="btn_area_center mb30">
		<button type="button" name="searchBtn" class="btn">검색</button>
	</div>
	<div class="mt30">
		<table id="eventParticipantList"></table>
		<div id="eventParticipantListPage"></div>
	</div>
</div>