<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<tiles:insertDefinition name="header_only">

   <tiles:putAttribute name="script.include" value="script.petlog"/> <!-- 지정된 스크립트 적용 -->

	<%-- 
	Tiles script.inline put
	불 필요시, 해당 영역 삭제 
	--%>
	<tiles:putAttribute name="script.inline">
      <script type="text/javascript">
	  	$(function(){
			$("#header_pc").removeClass("mode0");
			$("#header_pc").addClass("mode7-1 noneAc");
			$(".mo-heade-tit .tit").html("위치 등록");	
			$(".mo-header-backNtn").attr("onClick", "self.close();");
			$(".btnDel").hide();
			$("#searchText").change(function(){
				//console.log("change");
				$("#addr_list").html("");
			});
			
			$("#searchText").on('keydown' , function(e){
				if(e.keyCode === 13){
					callSearchLocFunc('keyword');
				}
			})
			
			// ui lock  --- 04.09
			//ui.lock.using(true);
			
			// 위치정보 관련 체크 
			checkLocationSetting();	
			
			setTimeout(function(){
				$(".btnDel").trigger("click");
			}, 1000);

			// 테스트
			//var resultJson = '{"fileId":"111","imageToBase64":"sssssssssssss"}';
			//onOpenGalleryCallBack (resultJson); 
		});
	  	
		function callSearchLocFunc(funcNm) {
			if(funcNm =='keyword'){
				let keyword = $("#searchText").val();
				let callback = window["keywordCallBack"];
				let lat = $("#logLttd").val(); //위도
				let lng = $("#logLitd").val(); //경도
				//console.log(lat);
				//alert(pstInfoAgrYn+","+appLocAuthYn);
				// 둘 다 Y 일 때만 위치정보 활용.
				if( pstInfoAgrYn != "Y" || appLocAuthYn != "Y" ){
					lat = ''; //위도
					lng = ''; //경도
				}
				kakaoMap.keyword(keyword, callback, lat, lng);
			}else if("location"){ debugger;
				let callback = window["locationCallBack"];
				//let lat = $(".loc .lat").val();
				//let lng = $(".loc .lng").val();
				let lat = $("#logLttd").val(); //위도
				let lng = $("#logLitd").val(); //경도
				kakaoMap.location(callback, lat, lng);
			}
		}
		
		// 검색 결과 영역 셋팅.
		function setResultArea(status){
			//alert("setResultArea:"+status);
			//alert("setResultArea::appLocAuthYn:"+appLocAuthYn);
			if (status === kakao.maps.services.Status.OK) {  // 검색 결과 있을 때.
				$("#addr_list").html("");
				$(".noneBoxPoint.p2").addClass("onWeb_b");
				$(".noneBoxPoint.c2").addClass("onWeb_b");
				
				ui.lock.using(false);
				// 첫 진입 시 status는 blank , 검색어가 없이 검색시 status는 null
			}else if( status === kakao.maps.services.Status.ZERO_RESULT || status == null){
				// 결과 없음 표시
				$(".log_pointEnterList").hide();
				$("#addr_list").html("");
		    	$(".noneBoxPoint.c2").addClass("onWeb_b");
		    	$(".noneBoxPoint.p2").removeClass("onWeb_b");
		    	
		    	ui.lock.using(true);
			}else{
				// 위치정보 설정 표시
				$("#addr_list").html("");
				$(".noneBoxPoint.c2").removeClass("onWeb_b");
		    	$(".noneBoxPoint.p2").addClass("onWeb_b");
		    	
		    	ui.lock.using(true);
			}
			
			// 검색창 blocking 제거.
			$(".log_topBbox .input.drop").removeClass("block_area");
			
			
		}
		
		function keywordCallBack(data, status, pagination){
			setResultArea(status);
			
			if (status === kakao.maps.services.Status.OK) {
				// ui lock 해제 --- 04.09
				//ui.lock.using(false);
				
				var arrAddr = $.parseJSON(JSON.stringify(data));
				if( arrAddr.length > 20) console.log(arrAddr.length);

				for(var i in arrAddr) {
					var addr = arrAddr[i];
					//if(i==0) alert(JSON.stringify(addr));
					var addHtml = "\
						<li class='log_flexBox'>\
						<div>\
							<div class='tit' onclick='closePopup("+ JSON.stringify(addr) + ");'>"+ addr.place_name + "</div>\
							<div class='con'>"+ addr.road_address_name + "</div>\
						</div>\
					</li>";	
					
					$(".log_pointEnterList").show()
					$("#addr_list").append(addHtml);
					// 일단 20개까지만 로드하기로 함.
					if( i == 19 ) break; 					
				}
				//console.log(JSON.stringify(data));
		    }
		}
		
		function locationCallBack(result, status){
			if (status === kakao.maps.services.Status.OK) {
				//alert(JSON.stringify(result));
				var arrAddr = $.parseJSON(JSON.stringify(data));

				//alert(arrAddr.length);
				for(var i in arrAddr) {
					var addr = arrAddr[i];
					
					var addHtml = "\
						<li class='log_flexBox'>\
						<div>\
							<div class='tit' onclick='closePopup("+ JSON.stringify(addr) + ");'>"+ addr.place_name + "</div>\
							<div class='con'>"+ addr.road_address_name + "</div>\
						</div>\
					</li>";	
					
					$("#addr_list").append(addHtml);
					// 일단 20개까지만 로드하기로 함.
					if( i == 19 ) break; 					
				}
		    }
		}
		
		
		// 검색주소 리턴
		function closePopup(result){
			// IE에서 opener관련 오류가 발생하는 경우, 부모창에서 지정한 이름으로 opener를 재정의
			if(opener == null || opener == undefined) opener = window.open("", "locPopup");
			//alert(opener);
			opener.<c:out value="${param.callBackFnc}" />(result, '${gb}');
			window.open("about:blank","_self").close();
		}
		
      </script>

	</tiles:putAttribute>

	
	<%-- 
	Tiles content put
	--%>		
	<tiles:putAttribute name="content">
		<form id="petLogLocForm" name="petLogLocForm" method="post" onsubmit="return false;">
		<main class="container page" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents log made" id="contents">
					<!-- log head-->
					<div class="log_hanBoxTop">
						<a href="javascript:;" class="lhbt_btn l icon_al b"></a>
						<div class="tit"></div>
						<a href="javascript:;" class="lhbt_btn r active_color">완료</a><!-- 파란색 color 'active_color' class 추가-->
					</div>
					<!-- //log head-->
					<!-- input -->
					<!-- <div class="log_topBbox">
						<div class="input del"><input type="text" id="searchText" placeholder="위치를 검색하세요." value="">
						<a href="javascript:callSearchLocFunc('keyword');" class="lhbt_btn r active_color">검색</a>						
						</div>	
					</div> -->
					<div class="log_topBbox">
						<div class="input del t2 drop coms block_area" data-txt="검색">
							<input type="text" id="searchText" placeholder="위치를 검색해주세요" value="">
							<button type="button" class="btnDel" tabindex="-1" style="right: 41px;">삭제</button>
							<div class="inputInfoTxt" onclick="callSearchLocFunc('keyword');">검색</div>
							<input type="hidden" id="logLitd" name="logLitd" value="" /><!-- 경도 -->	
							<input type="hidden" id="logLttd" name="logLttd" value="" /><!-- 위도-->
						</div>
					</div>
					<!-- // input -->	
					<!-- 위치추천을 위해 서비스를 활성화해주세요. -->
					<div class="noneBoxPoint c2 onWeb_b">
						<div>
							<div class="noneBoxPoint_infoTxt t2">위치추천을 위해 서비스를 활성화해주세요.</div>
							<!-- button class="button_round4_blue">위치서비스 설정</button -->
							<a href="javascript:checkLocationSetting();" class="txt-link">위치서비스 설정</a>
						</div>
					</div>
					<!-- // 위치추천을 위해 서비스를 활성화해주세요 -->	
					<div class="noneBoxPoint p2 onWeb_b">
						<div>
							<span class="noneBoxPoint_img2"></span>
							<div class="noneBoxPoint_infoTxt" style="color:#666;">검색 결과가 없습니다.</div>
						</div>
					</div>			
					<!-- 위치등록 리스트??  -->
					<div class="log_pointEnterList" style ="display:none;">
						<ul id="addr_list">
						</ul>
					</div>
					<!-- // 위치등록 리스트?? -->
				</div>
			</div>
		</main>
	</form>
	<div id="layers">
		
	</div>
	</tiles:putAttribute>
	
</tiles:insertDefinition>