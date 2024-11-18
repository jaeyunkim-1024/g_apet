var adrsNmValid;
var gbNmValid;
var mobileValid; 
var addrValid;
var addrDtlValid;
var deliReqValid;
var goodsRcvPstEtcValid;
var pblGatePswdValid; 

$(function(){
	var noneAddress = $("#noneAddressBox").css("display");
	adrsNmValid = $("[name=adrsNm]").val() != '' ? true : null; 
	gbNmValid = $("[name=gbNm]").val() != '' ? true : null; 
	mobileValid = $("[name=mobile]").val() != '' ? true : null;
	addrValid = $("[name=roadAddr]").val() != '' ? true : null;
	addrDtlValid = $("[name=roadDtlAddr]").val() != '' ? true : null;
	deliReqValid = $("[name=goodsRcvPstCd]").val() != '' ? true : null; 
	goodsRcvPstEtcValid = $("[name=goodsRcvPstCdInput]").val() != '' ? true : null; 
	pblGatePswdValid = $("[name=pblGateEntMtdCdInput]").val() != '' ? true : null;
	
	
		// 배송지가 없을 시 기본 배송지 자동 checked
		if(noneAddress){
			$("input[name=dftYn]").prop("checked" , true);
			$("input[name=dftYn]").val("Y");
			
			$("input[name=dftYn").on("click" , function(){
				return false;
			})
		}
		
		//수령 위치 코드 : 기타일 시 input 출력 
		$(document).on("change","[name='goodsRcvPstCdInput']",function(e){
			if( $("#rdo_dereq_msg").prop("checked") ) {
				$("#rdo_dereq_msg_box_my").show();
			}else{
				$("#rdo_dereq_msg_box_my").hide();
				$("input[name=goodsRcvPstEtcInput]").val('');
			}
		});
		//공동 현관 출입 방법 : 공동현관 비밀번호 입력일 시 패스워드 input 출력
		$(document).on("change","[name='pblGateEntMtdCdInput']",function(e){
			if( $("#rdo_dereq_pwd").prop("checked") ) {
				$("#rdo_dereq_pwd_box_my").show();
			}else{
				$("#rdo_dereq_pwd_box_my").hide();
				$("input[name=pblGatePswdInput]").val('');
			}
		});
		
		// 기본 배송지 설정
		$(document).on("change" , "input[name=dftYn]" , function(){
			if($("input[name=dftYn]").prop("checked")){
				$("input[name=dftYn]").val("Y");
			}else{
				$("input[name=dftYn]").val("N");
			}
		});
		
		// 휴대폰 번호 유효성 - 포커스 아웃 시점에만 체크
		$(document).on("blur" ,"input[name=mobile]" , function(){
			var value = $(this).val();
			if(value == ""){
				return;
			}
			var pattern = /[^0-9]/gi;
			var mobilePattern = /^01([0|1|6|7|8|9])([0-9]{7,8})$/						
			
		    if(!mobilePattern.test(value)){
		    	mobileValid = false;
		    }else{
		    	mobileValid = true;
		    }
			
		    if(pattern.test(value)){
		    	$(this).val(value.replace(pattern,""));
		    }
		    
			if(value.length > 20){
		    	$(this).val(value.substr(0 , 20))
			}
			console.log(value.length)
			if(value.length > 0) {
				if(mobileValid){
					$("#mobileValidate").hide();
				}else if (!btnDelChk && !mobileValid) {
					$("#mobileValidate").show();
				}	
			} else {
				mobileValid = false;
				$("#mobileValidate").hide();
			}
		});
		
		$(document).on("focus", "input[name=gbNm]", function(){
			if($("input[name=gbNm]").val() == "" && btnDelChk){
				gbNmValid = false;
				$("#addBtn").addClass("disabled");
			}	
			btnDelChk = false;
		});
		
		$(document).on("focus", "input[name=adrsNm]", function(){
			if($("input[name=adrsNm]").val() == "" && btnDelChk){
				adrsNmValid = false;
				$("#addBtn").addClass("disabled");
			}			
			btnDelChk = false;
		});
		
		$(document).on("focus", "input[name=mobile]", function(){
			if($("input[name=mobile]").val() == "" && btnDelChk){
				mobileValid = false;
				$("#mobileValidate").hide();	
				$("#addBtn").addClass("disabled");
			}
			btnDelChk = false;
		});
		
		$(document).on("focus", "input[name=roadDtlAddr]", function(){
			if($("input[name=roadDtlAddr]").val() == "" && btnDelChk){
				addrDtlValid = false;
				$("#addBtn").addClass("disabled");
			}	
			btnDelChk = false;
		});
		
		//IOS에서 한글->수자로 바꾸는 버트는 눌렀을때도 작동한다 change이벤트로 변경
		$(document).on("change input", "input[name=mobile]", function(){		
			$("#mobileValidate").hide();
		});
		
		// 배송지 명칭 유효성
		$(document).on("change input paste blur" , "input[name=gbNm]" , function(){
			var value = $(this).val();
		
			if(!value){
				gbNmValid = false;
			}else if(value.length > 20){
				$(this).val(value.substr(0 , 20));
				gbNmValid = false;
				$(this).change();
			}else{
				gbNmValid = true;
			}
		});
		
		//받는 사람 유효성
		$(document).on("change input paste blur" , "input[name=adrsNm]" , function(){
			var value = $(this).val();
			
			if(!value){
				adrsNmValid = false;
			}else if(value.length > 20){
				$(this).val(value.substr(0 , 20));
				adrsNmValid = false;
				$(this).change();
			}else{
				adrsNmValid = true;
			}
		});
		
		//휴대폰번호 유효성
		$(document).on("change input paste" , "input[name=mobile]" , function(){
			var value = $(this).val();
			
			if(!value){
				mobileValid = false;
			}else{
				mobileValid = true;
			}
		});
		
		// 주소 변경 시
		$(document).on("change input paste" , "input[name=roadAddr]" , function(){
			var value = $(this).val();
			if(!value){
				addrValid = false;
			}else{
				addrValid = true;
			}
		});
		
		//상세주소 유효성
		$(document).on("change input paste blur" , "input[name=roadDtlAddr]" , function(){
			var value = $(this).val();
			
			if(!value){
				addrDtlValid = false;
			}else if(value.length > 20){
				$(this).val(value.substr(0 , 20));
				addrDtlValid = false;
				$(this).change();
			}else{
				addrDtlValid = true;
			}
		});
		
		// 배송 요청 사항 변경 시 (상품 수령위치)
		$(document).on("change input paste" , "input[name=goodsRcvPstCd]" , function(){
			var value = $(this).val();
			if(!value){
				deliReqValid = false;
			}else{
				deliReqValid = true;
			}
		});
		
		// 상품 수령위치 입력필드(기타) 수정 시
		$(document).on("change input paste" , "input[name=goodsRcvPstCdInput] , input[name=goodsRcvPstEtcInput]" , function(){
			var value = $("input[name=goodsRcvPstCdInput]:checked").val();
			var inputValue = $("input[name=goodsRcvPstEtcInput]").val();
			if(value == '40' && !inputValue){
				goodsRcvPstEtcValid = false;
				$("#goodsRcvValid").show();
			}else{
				goodsRcvPstEtcValid = true
				//$("#goodsRcvValid").hide();
			}
		});
		
		// 공동현관 비밀번호 입력필드 수정 시
		$(document).on("change input paste" , "input[name=pblGateEntMtdCdInput] , input[name=pblGatePswdInput]" , function(){
			var value = $("input[name=pblGateEntMtdCdInput]:checked").val();
			var inputValue = $("input[name=pblGatePswdInput]").val();
			if(value == '10' && !inputValue){
				pblGatePswdValid = false;
				$("#pblGateValid").show();
			}else{
				pblGatePswdValid = true
				$("#pblGateValid").hide();
			}
		});
		
		// 배송 요청 사항 등록 버튼 활성화/비활성화
		$(document).on("change input paste" ,"#delist input" , function(){
			if(goodsRcvPstEtcValid && pblGatePswdValid){
				$("#deliReqAddBtn").prop("disabled" , false);
			}else{
				$("#deliReqAddBtn").prop("disabled" , true);
			}
		})
		
		// 배송지 등록 버튼 활성화
		$(document).on("change input paste blur" , "#addressul input" ,function(){
			if(adrsNmValid && gbNmValid && mobileValid && addrValid && addrDtlValid && deliReqValid){
				/*$("#addBtn").prop("disabled" , false)*/
				$("#addBtn").removeClass("disabled");
			}else{
				/*$("#addBtn").prop("disabled" , true)*/
				$("#addBtn").addClass("disabled");
			}
		});
		
		// 주소검색 클릭시 pop
		$(".btAdr").on("click", function(){
			openPostPop('cbPostPop');
			//openPostPop();
		});
	});
	
	function formArrParseJson(formData){
		var obj = null;
		if(formData){
			obj = {};
			$.each(formData , function(){
				obj[this.name] = this.value;
			});
		}
		return obj;
	}
	
	function moValidate(){
		var result;
		if(!(adrsNmValid && gbNmValid && mobileValid && addrValid && deliReqValid)){
			var msg;
			if(!deliReqValid){
				msg = "배송 요청 사항을 확인해주세요."
			}
			if(!addrValid){
				msg = "주소를 확인해주세요."
			}
			if(!mobileValid){
				msg = "휴대폰 번호를 확인해주세요."
			}
			if(!adrsNmValid){
				msg = "받는 사람을 확인해주세요."
			}
			if(!gbNmValid){
				msg = "배송지 명칭을 확인해주세요."
			}
			ui.toast(msg);
			result = false;
		}else{
			result = true;
		}
		return result;
	}
	
    /*
     * 우편번호 팝업
     */
    
    //디폴트 콜백
    var defaultCbPostOption = {
   		callBack : function(result){
   			$("#adrOn").text("["+result.zonecode+"]"+result.roadAddress);
			$("[data-selected='false']").show();
			$("#adrOff").hide();
			$("input[name=roadAddr]").val(result.roadAddress).change();
			$("input[name=prclAddr]").val(result.jibunAddress)
			$("input[name=postNoNew]").val(result.zonecode)
			$("input[name=roadDtlAddr]").val(result.addrDetail)
			
   		}
    } 
    
	// 주소 검색 pop
	function openPostPop(){
	//	window.open("/post/popupMoisPost?callBackFnc=defaultCbPostOption.callBack", "postPopup", "width=500, heigth=500");
    	
    	var options = {
			url : "/post/popupMoisPost?callBackFnc=defaultCbPostOption.callBack"
			, data : ''
			, dataType : "html"
			, done : function(html){
				$("#addLayers").html(html);
				$('#postPopLayer').removeClass('win');
				ui.popLayer.open("postPopLayer");
			} 
		}
		ajax.call(options);
		
	};
		
	var memberAddress = {
		dlvrDemandPop : function(){
			let mbrDlvraNo = $("#memberAddressForm").find("input[name=mbrDlvraNo]").val();
			var data = {
				callBackFnc : "memberAddress.callBackDlvrDemand"
				, mbrDlvraNo : mbrDlvraNo
				, popId : "popDeliReq"
			}
			
			if(!mbrDlvraNo){
				$.extend(data, $("#memberAddressForm").serializeJson());
			}
			var options = {
				url : "/mypage/service/includeDlvrDemand"
				, data : data
				, dataType : "html"
				, done : function(html){
					$("#popDeliReq").html(html);
					ui.popLayer.open("popDeliReq");
				}
			}
			ajax.call(options);
		}
		, callBackDlvrDemand : function(data){
			$("#memberAddressForm").find("input[name=goodsRcvPstCd]").val(data.goodsRcvPstCd);
			$("#memberAddressForm").find("input[name=goodsRcvPstEtc]").val(data.goodsRcvPstEtc);
			$("#memberAddressForm").find("input[name=pblGateEntMtdCd]").val(data.pblGateEntMtdCd);
			$("#memberAddressForm").find("input[name=pblGatePswd]").val(data.pblGatePswd);
			$("#memberAddressForm").find("input[name=dlvrDemand]").val(data.dlvrDemand);
			$("#memberAddressForm").find("input[name=dlvrDemandYn]").val("Y");
			
			$("#memberAddressForm").find("#goodsRcvPst").text(data.goodsRcvPstCd == '40' ? data.goodsRcvPstEtc : data.goodsRcvPstNm);
			$("#memberAddressForm").find("#pblGateEntMtd").text((data.pblGateEntMtdCd == '10')?(data.pblGateEntMtdNm+" "+data.pblGatePswd):data.pblGateEntMtdNm);
			$("#memberAddressForm").find("#dlvrDemand").text(data.dlvrDemand);
			
			$("#memberAddressForm").find("#aftDeliReq").show();
			$("#memberAddressForm").find("#insertDeliReq").hide();
			
			$("[name=roadDtlAddr]").change();
		} 
	}
	
