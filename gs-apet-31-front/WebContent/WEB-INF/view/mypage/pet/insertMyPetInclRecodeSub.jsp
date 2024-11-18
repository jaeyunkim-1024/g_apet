<tiles:insertDefinition name="mypage">
	<jsp:include page="/WEB-INF/tiles/include/js/common_mo.jsp"/> <!-- MO scalable 스크립트 적용 -->
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript" 	src="/_script/file.js"></script>
		<script type="text/javascript">
		$(function(){
			if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
				//Device 뒤로가기 버튼 기능을 웹에서 처리시 사용(Y:웹에서 백기능 처리, N:앱에서 처리)-호출 함수
				fncDeviceBackWebUse("fncGoBack");
			}
			
			//바텀시트 오픈 시 스크롤 lock
			if(ui.check_brw.mo()){
				setTimeout(function(){
					$("[data-sid = 'ui-datepickers'], .ui-datepicker-trigger, .select-pop").click(function(){
						ui.lock.using(true);
						setTimeout(function(){
							$(".ui-datepicker-close, .ui-state-default").click(function(){
								console.log("unlock!!")
								ui.lock.using(false);
							});
							$(".ui-datepicker").click(function(){
								$(".ui-state-default").click(function(){
									console.log("unlock!!")
									ui.lock.using(false);
								});
							});
						},500);
					});
				},500);
			}
			
			var deviceGb = "${view.deviceGb}";
			if(deviceGb != "PC"){
				$(".mode0").remove();
				$("#footer").remove();
				$(".menubar").remove();
			}else{
				$(".mode7").remove();
			}
			
			$("#extraInput").hide();
			$('[name=inclDt]').datepicker('option','dateFormat','yy.mm.dd');
			$('[name=inclDt]').datepicker("option" , "maxDate" , "0");
			$(".btSel").html("투약명을 선택해주세요.");
			$("[name=inclKindCd]").val("");
			$("[name=insertBtn]").addClass("disabled");
			
			
			$(document).on("click" , "#datepicerIcon" , function(){
				$("[name=inclDt]").trigger("click");
			});
			
			$(document).on("change", "[name=inclKindCd]" , function(){
				var value = $(this).val();
				var itemNm = $(this).find("option:selected").text();
				if(value == "9999"){
					$("#extraInput").show();
					$("input[name=itemNm]").val("");
				}else{
					$("#extraInput").hide();
					$("input[name=itemNm]").val(itemNm);
				}
			});
			
			// 진료병원 유효성
			$(document).on("change input paste" , "#trmtHsptNm" , function(){
				if($(this).val().length > 10){
					/* ui.toast("진료 병원명은 10자까지 입력할 수 있어요.")
					$(this).val($(this).val().substr(0 , 10)); */

					if("${view.os}"=="${frontConstants.DEVICE_TYPE_20}"){ //IOS
					ui.toast("진료 병원명은 10자까지 입력할 수 있어요.",{
						bot:150
					})
					$(this).val($(this).val().substr(0 , 10));
				}else{
					ui.toast("진료 병원명은 10자까지 입력할 수 있어요.");
					$(this).val($(this).val().substr(0 , 10));
				}
				}
			})
			
			$(document).on("input change paste" , "[name=itemNm]" , function(){
				var value = $(this).val();
				if(value.length > 10){
					/* ui.toast("투약명 10자까지 입력 가능합니다.")
					$(this).val(value.substr(0,10)); */
					if("${view.os}"=="${frontConstants.DEVICE_TYPE_20}"){ //IOS
						ui.toast("투약명 10자까지 입력 가능합니다.",{
							bot:320
						})
						$(this).val($(this).val().substr(0 , 10));
					}else{
						ui.toast("투약명 10자까지 입력 가능합니다.");
						$(this).val($(this).val().substr(0 , 10));
					}
					
				}
			});
			
			$(document).on("input change paste" , "#memo" , function(){
				var value = $(this).val();
				if(value.length > 500){
					ui.toast("특이사항은 500자까지 입력할 수 있어요.");
					$(this).val(value.substr(0 , 500));
				}
			});
			
			$(document).on("change input" , "input , select" , function(){
				var inclKindCd = $("[name=inclKindCd]").find("option:selected").val();
				var inclDt = $("[name=inclDt]").val();
				var itemNm = $("[name=itemNm]").val();
				if(inclKindCd && inclDt && itemNm){
					$("[name=insertBtn]").removeClass("disabled");
				}else{
					$("[name=insertBtn]").addClass("disabled");
				}
			});
			
			/*$(document).on("click" , "#cancleBtn , #backBtn" , function(e){
				e.preventDefault();
				var msg;
				if('${recode.inclNo}'){
					msg = "투약 정보 수정을 취소할까요?";
				}else{
					msg = "투약 등록을 취소할까요?";
				}
				ui.confirm(msg , {
					ycb : function(){
						//history.go(-1);
						storageHist.goBack("/my/pet/indexMypetInclRecode?petNo=" + $("#petNo").val());
					}
					, ybt : "예"
					, nbt : "아니오"
				});
			});*/
			
			$(document).on("click" , "button" , function(e){
				e.preventDefault();
			});
			
			if('${recode.inclNo}'){
				inputSet();	
			}

		});
		
		function validate(){
			var msg;
			var result;
			
			if(!$("#itemNm").val() || !$("[name=inclDt]").val() ){
				msg = "필수 입력 정보를 모두 입력해주세요.";
				result = false;
			}else{
				result = true;
			}
			
			if(msg){
				ui.toast(msg);
			}
			
			return result;
		}
		

		// 투약 기록 INSERT / UPDATE
		function insertInclRecode(){
			var obj = null;
			var formData = $("#inclInsertForm").serializeArray();
			if(formData){
				obj = {};
				$.each(formData , function(){
					if(this.value){
						obj[this.name] = this.value;
					}else{
						obj[this.name] = null;
					}
				});
			}
			if($("[name=inclDt]").val() != ""){
				var inclyear = obj.inclDt.substr(0,4);
				var inclmonth = obj.inclDt.substr(5,2);
				var inclday = obj.inclDt.substr(8,2);
				obj.inclDt = inclyear + "-" + inclmonth + "-" + inclday;
			}
			
			var options = {
				url : "<spring:url value ='/my/pet/insertMyPetInclRecode'/>"
				, data : obj
				, done : function(result){
					if(result > 0){
						var msg;
						var updateYn;
						if($("#inclNo").val()){
							updateYn = "Y";
						}else{
							updateYn = "N";
						}
						//location.href = "/my/pet/indexMypetInclRecode?petNo=" + $("#petNo").val() + "&updateYn="+updateYn;
						storageHist.goBack("/my/pet/indexMypetInclRecode?petNo=" + $("#petNo").val() + "&updateYn="+updateYn);
					}
				}
			}
			if(validate()){
				ajax.call(options);
			}
		}
		
		function inputSet(){
			var inclDt = "${recode.inclDt}";
			var y = inclDt.substr(0, 4);
			var m = inclDt.substr(4, 2);
			var d = inclDt.substr(6, 2);
			var date = new Date(y, m-1, d);
			
			$(".btSel").trigger("click");
			$(".pop-select").find("button[value='${recode.inclKindCd}']").trigger("click");
			// 접종일
			$("[name=inclDt]").datepicker("setDate" , date).change();
			
			$("#itemNm").val("${recode.itemNm}");
		}
		
		function fncGoBack(){
			var msg = "";
			if('${recode.inclNo}'){
				msg = "투약 정보 수정을 취소할까요?";
			}else{
				msg = "투약 등록을 취소할까요?";
			}
			
			ui.confirm(msg , {
				ycb : function(){
					//history.go(-1);
					storageHist.goBack("/my/pet/indexMypetInclRecode?petNo=" + $("#petNo").val());
					//storageHist.goHistoryBack(storageReferrer.get());
				}
				, ybt : "예"
				, nbt : "아니오"
			});
		}
		
		//PC에서 투약명을 선택해주세요  누르면 options 닫히게  APETQA-6295
		$(function(){
			if('${view.deviceGb}' == "${frontConstants.DEVICE_GB_10}"){
			    $('.btSel').click(function(){
					var id = $(".pop-select:visible").data("select-pop");
					$(".pop-select").removeClass("on").fadeOut(100,function(){
						$(this).remove();
						ui.lock.using(false);
						$(".cusDim").removeClass('dimOn');
					});
					$("select[name="+id+"]").closest(".select-pop").find(".btSel").attr("tabindex","0").focus().removeClass("open");
					$("body").removeClass("isPopSelect");
			    });
			}
		});
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<c:set var = "title" value ="${recode.inclNo eq null ? '투약 등록' : '투약 수정' }"/>
		<div class="wrap" id="wrap">
		<!-- mobile header -->
		<header class="header pc cu mode7 noneAc" data-header="set9">
			<div class="hdr">
				<div class="inr">
					<div class="hdt">
						<button id ="backBtn" class="mo-header-backNtn" data-content="" data-url="fncGoBack()" onclick="fncGoBack();">뒤로</button>
						<div class="mo-heade-tit"><span class="tit">${title }</span></div>
					</div>
				</div>
			</div>
		</header>
		<!-- // mobile header -->
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page login lnb" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<div class="pc-tit">
						<h2>${title }</h2>
					</div>
					<form id="inclInsertForm">
						<input type ="hidden" id="inclNo" name ="inclNo" value="${recode.inclNo }">
						<input type ="hidden" name="inclGbCd" value="${frontConstants.INCL_GB_40 }">
						<input type ="hidden" id="petNo" name="petNo" value="${petBase.petNo }">
					<div class="fake-pop">
						<div class="pct">
							<div class="poptents">
								<!-- 회원 정보 입력 -->
								<div class="member-input po-reSet-layer">
								<div class="check_mark_legend"><span>*</span>필수 입력 정보</div>
									<ul class="list">
										<li>
											<strong class="tit requied">종류</strong>
											<div class="cusDim" style="position: relative;">
												<span class="select-pop w100">
													<select class="sList" name="inclKindCd" data-select-title="투약 종류 선택">
														<c:forEach items ="${subInclList }" var="subIncl">
														<option value="${subIncl.dtlCd }">${subIncl.dtlNm }</option>
														</c:forEach>
													</select>
												</span>
											</div>
										</li>
										<li id="extraInput">
											<strong class="tit">투약명 직접입력</strong>
											<div class="input">
												<input type="text" id="itemNm" name="itemNm" placeholder="투약종류를 직접 입력해주세요.">
											</div>
										</li>
										<li>
											<strong class="tit requied">투약일</strong>
											<section class="sect" data-sid="ui-datepickers" class="ui-datepicker">
												<span class="datepicker_wrap uiDate">
													<input type="text" readonly="readonly" class="datepicker" name="inclDt" title="투약일" placeholder ="날짜를 선택해주세요."/>
													<button type="button" id ="datepicerIcon" class="ui-datepicker-trigger" data-content="" data-url="">달력</button>
												</span>
											</section>
										</li>
										<li>
											<strong class="tit">진료병원</strong>
											<div class="input">
												<input type="text" id ="trmtHsptNm" name="trmtHsptNm" placeholder="병원명을 입력해주세요" value ="${recode.trmtHsptNm }">
											</div>
										</li>
										<li>
											<strong class="tit pc-pSet-t1">특이사항 메모</strong>
											<div class="textarea"><textarea id="memo" name="memo" placeholder="투약 시 마이펫의 증상이나 부작용 등 접종에 대한 기록을 남겨주세요" style="height:180px;">${recode.memo }</textarea></div>
										</li>
									</ul>
								</div>
								<!-- // 회원 정보 입력 -->
								<!-- 웹에서만 보이는 버튼 -->
								<div class="exchange-area onWeb_b">
									<div class="btnSet space pc-reposition pc-no-border">
										<button id="cancleBtn" class="btn lg d" data-content="" data-url="fncGoBack()" onclick="fncGoBack();">취소</button>
										<button id="insertBtn" name="insertBtn" class="btn lg a" onclick="insertInclRecode();return false;" data-content="" data-url="/my/pet/insertMyPetInclRecode">
										<c:if test="${empty recode.inclNo  }">등록</c:if>
										<c:if test="${not empty recode.inclNo  }">저장</c:if>
										</button>
									</div>
								</div>
								<c:if test ="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
									<div class="exchange-area">
										<div class="btnSet space pc-reposition pc-no-border" style="padding:0px;">
											<button id="insertBtnMo" name="insertBtn" class="btn lg a" onclick="insertInclRecode();return false;" data-content="" data-url="/my/pet/insertMyPetInclRecode">
											<c:if test="${empty recode.inclNo  }">등록</c:if>
											<c:if test="${not empty recode.inclNo  }">저장</c:if>
											</button>
										</div>
								</c:if>
								<!-- // 웹에서만 보이는 버튼 -->
							</div>
						</div>
					</div>
					</form>
				</div>
			</div>
		</main>
		
		<%-- <jsp:include page="/WEB-INF/tiles/include/floating.jsp">
			<jsp:param name="floating" value="talk" />
		</jsp:include> --%>

		<!-- 하단메뉴 -->
		<!-- <include class="menubar" data-include-html="../inc/menubar.html"></include> -->
		<!-- 푸터 -->
		<!-- <include class="footer" data-include-html="../inc/footer.html"></include> -->

	</div>
	</tiles:putAttribute>
</tiles:insertDefinition>


