<script type="text/javascript">
    const ybt = "확인";
    const nbt = "취소";
    const message = "undefined Message";

    const messager = {
        alert : function(option){
            // 알럿창 띄우기
            const defaultAlertOption = {
                    ycb : function(){}
                ,	ybt : ybt
            };
            let alertMsg = option.txt ? option.txt : message;
            let alertConfig = $.extend(defaultAlertOption,option);
            ui.alert("<div id='alertContentDiv'>"+alertMsg+"</div>",{
                    ycb:function(){
                        alertConfig.ycb();
                        $(".popAlert").remove();
                    }
                ,   ybt:alertConfig.ybt
            });
        }
        ,	confirm : function(option){
                const defaultConfirmOption = {
                        ycb : function(){console.log("confirm-ok Callback");}
                    ,	ncb : function(){console.log("confirm-cancle Callback");}
                    ,	ybt : ybt
                    ,	nbt : nbt
                };
                let confirmMsg = option.txt ? option.txt : message;
                let confirmConfig = $.extend(defaultConfirmOption,option);
                ui.confirm(confirmMsg,{ // 컨펌 창 띄우기
                    ycb:confirmConfig.ycb,
                    ncb:confirmConfig.ncb,
                    ybt:confirmConfig.ybt,
                    nbt:confirmConfig.nbt
                });
        }
        , toast : function(option){	//toast 띄우기
        	ui.toast(option.txt,{
        		cls : 'abcd' , 
        		bot: option.bot ? option.bot : 74, //바닥에서 띄울 간격
        		sec:  option.sec ? option.sec : 3000 //사라지는 시간
        	})
        }
    };

    /*
     * 우편번호 팝업
     */

    //디폴트 콜백
    var defaultCbPostOption = {
        callBack : function(data){
            console.log(data);
        }
    }

    //콜백함수 set
    function setCbPostPopCallBack(callBack){
    	if(callBack != undefined){
    		defaultCbPostOption.callBack = callBack;
    	}	
    }
    
    //우편번호 콜백
    function cbPostPop(data){
    	defaultCbPostOption.callBack(data);
    }

    //레이어 팝업
    function layerPop(config){
        var option = {
                url : config.url
            ,   data : config.data != undefined ? config.data : {}
            ,   type : "GET"
            ,   dataType : "HTML"
            ,   done : function(html){
                    var alertConfg = {
                            txt : html
                    };
                    if(config.callBack != undefined){
                        alertConfg.ycb = config.callBack;
                    }
                    if(config.btnTxt != undefined){
                        alertConfg.ybt = config.btnTxt;
                    }
                    messager.alert(alertConfg);
            }
        };
        ajax.call(option);
    }
    
    
    //관심태그 정보 변경 시 액션로그 api호출 - 호출 예 : fncTagInfoLogApi({ url:"/join/indexTag", targetUrl:"/join/indexResult",callback:console.log(data) });
    function fncTagInfoLogApi(config){
 				
    	var option = {
                 url : "/commonTagAction"
               , type : "GET"
               , data : {
            	   	url : config.url,
            	   	targetUrl : config.targetUrl
            	 } 
               , done : function(data){
                     if(config.callback){
                         config.callback();
                     }else{
                         console.debug(data);
                     }
               }
		}; 
    	ajax.call(option);		
				
	}

    /*
     * SNS 로그인 ( 네이버, 카카오, 구글, 애플)
     */
    function snsLogin(snsLnkCd) {
    	 if('${view.deviceGb}' == 'APP' &&  !(snsLnkCd == 40 && '${view.os}' == '10')  ){
            toNativeData.func = "onSnsLogin";
            if(snsLnkCd == 10) toNativeData.loginType ="N" //N : 네이버, K : 카카오톡, G :구글, A:애플
            else if(snsLnkCd == 20) toNativeData.loginType ="K"
            else if(snsLnkCd == 30) toNativeData.loginType ="G"
            else if(snsLnkCd == 40) toNativeData.loginType ="A"
            toNative(toNativeData);
        }else{
            var url = "";
            var options = {
                url : "<spring:url value='/snsLogin' />",
                type:  'POST',
                data : {
                	snsLnkCd : snsLnkCd,
                    deviceTpCd  :$("#deviceTpCd").val(),
                    deviceToken : $("#appPushToken").val()
                },
                done : function(data){
                	
                	//로그인 app interface 호출 
					if('${view.deviceGb}' == 'APP'){
						toNativeData.func = 'onLogin';
						toNative(toNativeData);
					}
                	
                    window.location.href = data.goUrl;
                    return;
                }
            };
            ajax.call(options);
        }
    }

    //입력 제한 유효성
    function validateTxtLength(selector,maxLength){
        var id = selector.id;
        var txt = $(selector).val();
        var errorId = "error-"+id;
        var length = txt.length;
        if(length>maxLength){
            var msg = maxLength + "자 이내로 입력해주세요.";
            var html ="<p class='validation-check' id='"+errorId+"'>"+msg + "</p>";
            if($("#"+errorId).length == -0){
                $(selector).parent().after(html);
            }
        }else{
            $("#"+errorId).remove();
        }

        $(selector).val(txt.substring(0,maxLength));
    }

    // 초점 벗어날 때 유효성 검사
    var validWhenBlur = {
               loginId : function(target,callBack1, callBack2){
                   $.ajax({
                       url : "/common/check-id"
                       ,   type : "POST"
                       ,   data : {loginId : target}
                       ,   dataType : "JSON"
                   }).done(function(result){
                       if(parseInt(result)){
                           if(callBack1){
                        	   callBack1();
                           }else{
                               console.debug("undefined callBack");
                           }
                       }else{
                           if(callBack2){
                               callBack2();
                           }
                       }
                   });
                } 
            ,    nickNm : function(target,callBack){
                    $.ajax({
                        url : "/common/check-nickNm"
                        ,   type : "POST"
                        ,   data : {nickNm : target}
                        ,   dataType : "JSON"
                    }).done(function(result){
                            if(callBack){
                                callBack(result);
                            }else{
                                console.debug("undefined callBack");
                            }
                   });
            }
            ,   email : function(target,callBack){
                    $.ajax({
                            url : "/common/check-email"
                        ,   type : "POST"
                        ,   data : {email : target}
                        ,   dataType : "JSON"
                    }).done(function(result){
//                         if(parseInt(result)){
                            if(callBack){
                                callBack(result);
                            }else{
                                console.debug("undefined callBack");
                            }
//                         }
                    });
            }
            ,   rcomCd : function(target,callBack){
                    var data = {};
                    if(valid.email.test(target)){
                        data.rcomLoginId = target;
                    }else{
                        data.rcomCd = target;
                    }
                    $.ajax({
                        url : "/common/check-rcom"
                        ,   type : "POST"
                        ,   data : data
                        ,   dataType : "JSON"
                    }).done(function(result){
                        var r = parseInt(result);
                        if(r != 1){
                            if(callBack){
                                callBack();
                            }else{
                                console.debug("undefined callBack");
                            }
                        }
                    });
        },banWord : function(target,callBack){
			$.ajax({
				url : "/common/check-banWord"
				,type : "POST"
				,data : {
					loginId : target.loginId
					, nickNm : target.nickNm
				}
				,dataType : "JSON"
			}).done(function(result){
				if(callBack){
					callBack(result.returnCode);
				}else{
					console.debug("undefined callBack");
				}
			});
	}
    };

    //점유 인증 -> 현재 사용 X
    function fnOtpManageDetail(){
        return;
        var options = {
            url : "/common/opt"
            ,   type : "GET"
            ,	data : {mobile : $("#mobile").val() }
            ,   dataType : "HTML"
            ,   done : function(result){
                $("#mobile-li-default").hide();
                $("#mobile-li-cert").empty().append(result);
                $("#tm").bind("input chage paste",function(){
                    $("#tm").val($("#tm").val().replace(/\D/g,'').substring(0,11));
                });
                $("#ctfKey").bind("input chage paste",function(){
                    $("#ctfKey").val($("#ctfKey").val().replace(/\D/g,''));
                });
            }
        };
        //ajax.call(options);
    }
</script>