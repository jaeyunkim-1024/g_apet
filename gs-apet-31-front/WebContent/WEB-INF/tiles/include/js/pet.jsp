<script type="text/javascript">

	var insert = "I";
	var update = "U";
	var gb = null;

	var init = {
			insert : function() {
				gb = insert;
			}
			, update : function() {
				gb = update;
			}
	}
	
	$(function() {
		if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
			$(".menubar").remove();	
			$("#footer").remove();
		}	
	});

	// AOS에서 키보드에 '이동'버튼 선택시 반려동물취소 팝업뜨는 현상때문에 추가
	$(document).on('keydown', ".moveStop", function(e) {
	  	if(e.keyCode === 13) {
			e.preventDefault();
	  	}
	});

	// 필수값 인풋의 x버튼 클릭시 다음버튼 비활성화
	$(document).on("click", ".btnDel", function(){
		if($(this).siblings().hasClass("required_item")) {
			if(typeof currStep != "undefined") {
				$("#nextBtn" + currStep).removeClass("a").addClass("gray").css("width", "100%");					
			} else {
				$("#saveButton").removeClass("a").addClass("gray").css("width", "100%");
			}
			$(this).siblings().val("").change();
		}
	});
	
	// 필수값 변경시
	$(document).on("input change paste", ".required_item", function(){
		var id = this.id;
		var name = this.name;
		var value = this.value;
		
		if(name == "petGbCd") {	// 강아지/고양이
			$("#petKindNm").val("");
			selectPetDaList(); 
		} else if(id == "petNm") {	// 펫 이름
			if(value.length > 10)	this.value = value.slice(0, 10);
		} else if(id == "birth") {	// 생년월일
			// TODO : 정리
			var maxLength = this.maxLength;

			var date = new Date();
		    var year = date.getFullYear();
		    var month = ("0" + (1 + date.getMonth())).slice(-2);
		    var day = ("0" + date.getDate()).slice(-2);
		    var nowDate = year + month + day;
		    
			var pattern = /^([0-9]{4})(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/ ;
			var numPattern = /^[0-9\ ]+$/;
			
			if(value.search(numPattern) == -1) {
				this.value = "";
				$("#errorTextArea").show().html("숫자만 입력해주세요.");
			} else if(value.length < 8) {
				$("#errorTextArea").show().html("생년월일 8자리를 입력해주세요.");
			} else if(value.length > 8) {
				this.value = value.slice(0, maxLength);
//					$("#errorTextArea").show().html("생년월일 8자리를 입력해주세요.");
			} else if(value.search(pattern) == -1) {
				this.value = "";
				$("#errorTextArea").show().html("생년월일 형식이 아닙니다.");
			} else if(value > nowDate) {
				this.value = "";
				$("#errorTextArea").show().html("오늘보다 큰 날짜는 입력할 수 없습니다.");
			} else {
				$("#errorTextArea").hide();	
			}
			
		} else if(id == "age" || id == "month") {
			// TODO : 정리
			var maxLength = this.maxLength;
			var pattern = /^[0-9\ ]+$/;
			
			if(value.search(pattern) == -1) {
				this.value = "";
			} else if(id == "month" && value > 12) {
				this.value = "";
				$("#errorTextArea").show().html("0~12개월까지 숫자를 입력해주세요.");
			} else if(value.length > 2) {
				this.value = value.slice(0, maxLength);
			} else {
				$("#errorTextArea").hide();	
			}
			
		}
		
		btnControl();
	});
	
	// 견종/묘종
	// TODO : 정리
	$(document).on("click", "#petKindNm", function(){
		ui.popLayer.open("popSample1");
		$("#petKindNoSearchArea").hide();
		$("#petKindSearchListArea").show();
		$("#petKindSearchList").html("");
		$("#petKindNmSearch").val("");
		window.setTimeout(function(){ $("#petKindNmSearch").focus(); }, 200); 
	});

	// 세/개월 또는 생년월일 라디오 선택
	$(document).on("click", "input[name=ageChoose]", function(){ ageControl(); })
	
	// 알러지 여부 선택
	$(document).on("click", "input[name=allergyYn]", function(){ allergyAreaControl(); })
	
	// 몸무게
	$(document).on("input change paste", "#weight", function(){
		var val = this.value;
		var pattern = /^(\d{1,3})([.]\d{0,1}?)?$/;
		
		if(val.search(pattern) == -1)	this.value = val.slice(0, val.length-1);
	});
	
	// 견종/묘종 검색 팝업 검색창
	$(document).on("input change paste", "#petKindNmSearch", function(){
		autoComplete(this.value);
	});

	var valid = {
		isEmpty : function(obj) {
			if(obj.val() == "" || typeof obj.val() == "undefined" || obj.val() == null)	return true;
			else																		return false;
		}
		, length : function(obj) {
			return obj.val().length;
		}
		, imgToast : function() {
			var flag = false;
			
			if(gb == insert) {
				var imgPathObj = ("${view.deviceGb}" != "${frontConstants.DEVICE_GB_30}") ? $("#imgPath") : $("#imgPathApp");
				flag = this.isEmpty(imgPathObj);
			} else if(gb == update) {
				var imgPathTemp = ("${view.deviceGb}" != "${frontConstants.DEVICE_GB_30}") ? $("#imgPathTemp") : $("#imgPathAppTemp");
				flag = this.isEmpty($("#imgPath")) && this.isEmpty(imgPathTemp); 
			}
			
			if(flag) {
				messager.toast({txt : "마이펫의 프로필 사진을 등록해주세요"});
				return false;
			}
		}
		, reqiredToast : function() {
			if(this.isEmpty($("#petNm")) || (this.isEmpty($("#age")) && this.isEmpty($("#month")) && this.length($("#birth")) != 8)) {
				messager.toast({txt : "필수 입력 정보를 모두 입력해주세요"});
				return false;
			}
		}
		, gifToast : function(exe) {
			if(exe == "gif" || exe == "GIF") {
				messager.toast({txt : "gif파일은 등록할 수 없어요."});
				return false;
			}
		}
	};

	// 개월수/생년월일 선택시
	function ageControl() {
		var ageChoose = $("input[name=ageChoose]:checked").val();
		
		if(ageChoose == 1) {	// 개월수
			$("#divAgeArea").show();
			$("#divBirthArea").hide();
			$("#birth").val("");
		} else {
			$("#divAgeArea").hide();
			$("#divBirthArea").show();
			$("#age, #month").val("");
		}
		
		$("#errorTextArea").hide();
		btnControl();
	}
	
	// 알러지 리스트 컨트롤
	function allergyAreaControl() {
		var yn = $("input[name=allergyYn]:checked").val();
		
		if(yn == "Y") {
			$("#allergyArea").show();
		} else {
			$("button[id^='allergyCd']").removeClass("active");
			setAllergyCds();
			$("#allergyArea").hide();
		}
	}
	 
	// 질환 선택정보 세팅
	function setWryDaCds() {
		var wryDaSelectList = new Array();
		$("button[name='wryDaCd']").each(function(index, item){ 
			if($(this).hasClass("active")) {
				wryDaSelectList.push(this.value);
			}
		})
		$("#wryDaCds").val(wryDaSelectList);
	}
	
	// 알러지 선택정보 세팅
	function setAllergyCds() {
		var allergySelectList = new Array();
		$("button[name='allergyCd']").each(function(index, item){ 
			if($(this).hasClass("active")) {
				allergySelectList.push(this.value);
			}
		})
		$("#allergyCds").val(allergySelectList);
	}

	// 검색어 자동완성
	function autoComplete(value) {
		var petGbCd = ("${vo.petGbCd}" != "") ? "${vo.petGbCd}" : $("input:radio[name=petGbCd]:checked").val();
		
		$.ajax({
            url : "<spring:url value='/my/pet/petSearchAutoComplete' />"
            , data : { petGbCd : petGbCd, petKindNm : value }
        })
        .done(function(json) {
        	json = JSON.parse(json);
        	var replace = "";
        	var length = json.DATA.ITEMS.length;
        	if(length > 0) {
        		$("#petKindNoSearchArea").hide();
        		$("#petKindSearchListArea").show();
				var html = [];
				for(var intIndex = 0; intIndex < length; intIndex++) {
					var item = json.DATA.ITEMS[intIndex];
					//var highlight = item.HIGHLIGHT.replaceAll("¶HS¶", "</span><span style='color:blue;font-weight:bold'>").replaceAll("¶HE¶", "</span><span style='color:gray'>");
					var highlight = item.HIGHLIGHT.replace(/¶HS¶/gi, "<span style='color:#669AFF;'>").replace(/¶HE¶/gi, "</span>");
					
					html.push(
						"<li class='log_flexBox'>",
							"<div>",
								"<div class='tit' onclick='setPetKindNm(\"" + item.KEYWORD + "\");' style='cursor: pointer'>",
// 										"<span style='color:gray'>",
										highlight,
// 										"</span>",
								"</div>",
							"</div>",
						"</li>"
					);
				}
				$("#petKindSearchList").html(html.join(""));
        	} else {
				if(value != "") {
					if(petGbCd == '${frontConstants.PET_GB_10}')	$("#petKindNoSearchTextArea").html("일치하는 견종이 없습니다.");
					else											$("#petKindNoSearchTextArea").html("일치하는 묘종이 없습니다.");
					$("#petKindNoSearchArea").show().removeAttr("style");
				} else {
					$("#petKindNoSearchArea").hide();
				}
        		$("#petKindSearchListArea").hide();
        	}
        })
        .fail(function(xhr, status, errorThrown) {
            console.log(status, errorThrown)
        })
	}
	
	// 품종 세팅
	function setPetKindNm(value) {
		$("#petKindNm").val(value);
		ui.popLayer.close('popSample1');
	}
	
	
	/*********************************************************************************/
	/******* APP 인터페이스 *************************************************************/
	/*********************************************************************************/
	function onOpenGallery(){
//			$(".back").css("display", "none");
		// 데이터 세팅
		toNativeData.func = "onOpenGallery";
		toNativeData.useCamera = "P";
		toNativeData.galleryType = "P";
		toNativeData.usePhotoEdit = "Y";
		toNativeData.editType = "S";
		let fileIds = new Array();
		if(imageResult != null) {
			fileIds[0] = imageResult.fileId;
			toNativeData.fileIds = fileIds;
		}
		toNativeData.maxCount = 1;
		toNativeData.callback = "onOpenGalleryCallback";
		// 호출
		toNative(toNativeData);
	}
	
	function onFileUpload() {
		// 데이터 세팅
		toNativeData.func = "onFileUpload";
		toNativeData.prefixPath = "/pet/" + $("#petNo").val();
		toNativeData.callback = "onFileUploadCallBack";
		// 호출
		toNative(toNativeData);
	}
</script>