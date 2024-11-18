<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript" src="/_script/corner.js" ></script>
		<script type="text/javascript">
			var isApp = "${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}" || "${view.deviceGb}" == "${frontConstants.DEVICE_GB_20}";
			//화면 초기화
			function fnLoadDocument(){
				if(isApp){
					$("#footer").hide();
// 					$("#header_pc").removeClass("mode0");
// 					$("#header_pc").addClass("mode16");
// 					$("#header_pc").attr("data-header", "set22");
					$("#header_pc").addClass('logHeaderAc');
					$(".mo-heade-tit .tit").html("이벤트");
					$(".menubar").remove()
				}else{
					$(".uiTab").attr("class","uiTab a");
					var eventGb2Cd = "${eventGb2Cd}";

					//gnb 활성화 처리 임시 주석
					fnActiveGnbMenu(eventGb2Cd);
				}
			}

			//gnb 활성화
			function fnActiveGnbMenu(eventGb2Cd){
				var id = "liTag_00";
				if(eventGb2Cd =="${frontConstants.EVENT_GB2_CD_40}"){
					id = "liTag_10";
				}
				else if(eventGb2Cd == "${frontConstants.EVENT_GB2_CD_20}"){
					id = "liTag_20";
				}
				else if(eventGb2Cd == "${frontConstants.EVENT_GB2_CD_30}"){
					id = "liTag_30";
				}
				$(".tmenu ul li").removeClass("active");
				//$("#"+id).addClass("active");
			}

			$(function(){
				fnLoadDocument();
			})
		</script>
	</tiles:putAttribute>

	<tiles:putAttribute name="content">
		<jsp:include page="./commonEventContents.jsp"/>
	</tiles:putAttribute>
</tiles:insertDefinition>