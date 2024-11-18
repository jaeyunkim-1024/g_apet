<script type="text/javascript">
    var termsList = null;
    var kRst = {};

    //디폴트 kcb 콜백
    var defaultOkCertOption = {
        callBack : function(data){
            kRst = data;
        }
    };

    // default 콜백 set kcb 콜백 SET
    function setOkCeretCallBack(callBack){
        if(callBack != undefined){
            defaultOkCertOption.callBack = callBack;
        }
    }

    //GSR 약관 동의 후, KCB 콜백 호출 전 , 유효성 검증
    function setGsInsertAndOkCertCallBack(callBack){
        defaultOkCertOption.callBack = function(data){
            var resultCode = data['RSLT_CD'];
            if(resultCode == "${frontConstants.CERT_OK}"){
                //기존에 인증한 값이 있는지 확인
                var options = {
                    url :"/mypage/info/ci-check"
                    ,	data : {ciCtfVal : data['CI'] , mbrNm : data['RSLT_NAME'] }
                    ,	done : function(result){
                            //유효성 통과시
                            if(result.resultCode == "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}"){
                                var mbrNm = data['RSLT_NAME'];
                                var mobile = data['TEL_NO'];
                                var birth = data['RSLT_BIRTHDAY'];
                                var ciCtfVal = data['CI'];
                                var diCtfVal = data['DI'];
                                var mobileCd = data['TEL_COM_CD'];
                                var ntnGbCd = "${frontConstants.NTN_GB_10}";
                                var gdGbCd = "${frontConstants.GD_GB_0}";

                                //본인 인증 후, 마케팅 수신여부 체크 -> 080
                                var mkngRcvYn = result.mkngRcvYn;

                                //내,외국인 확인
                                if(data.RSLT_NTV_FRNR_CD == "F"){
                                    ntnGbCd = "${frontConstants.NTN_GB_20}";
                                }
                                //성별 확인
                                if(data.RSLT_SEX_CD == "M"){
                                    gdGbCd = "${frontConstants.GD_GB_1}";
                                }

                                //내 정보 관리
                                $("#mobile , [name='mobile']").val(mobile);
                                $("#mbrNm , [name='mbrNm']").val(mbrNm);
                                $("[name='ciCtfVal']").val(ciCtfVal);
                                $("[name='ntnGbCd']").val(ntnGbCd);

                                var newData = {
                                        ciCtfVal : ciCtfVal
                                    ,   diCtfVal : diCtfVal
                                    ,   ntnGbCd : ntnGbCd
                                    ,   mobileCd : mobileCd
                                    ,   gdGbCd : gdGbCd
                                    ,   birth : birth
                                    ,   mbrNm : mbrNm
                                    ,   mobile : mobile
                                    ,   mkngRcvYn : mkngRcvYn
                                };

                                var options = {
                                    url : "/gsr/updateGsrConnectInfo"
                                    ,   data : newData
                                    ,   done : function(result){
                                            if(result.resultCode == "${exceptionConstants.ERROR_CODE_LOGIN_REQUIRED}"){
                                                location.href = "/logout";
                                            }
                                            var gsptNo = result.gsptNo;
                                            if($("#gsptNo").length > 0){
                                                $("#gsptNo").val(gsptNo);
                                            }
                                            newData.custNo = gsptNo;
                                            callBack(newData);
                                    }
                                };
                                waiting.start();
                                ajax.call(options);
                            }else{
                                var txt = result.resultMsg;
                                var config = {
                                        txt : txt
                                    ,	ybt : "확인"
                                };
                                if(result.resultCode == "${exceptionConstants.ERROR_IS_ALREADY_INTEGRATE}"){
                                    config.ycb = function(){
                                        window.location.href = "/logout?returnUrl=/indexLogin";
                                    };
                                }
                                ui.alert(config.txt,{
                                        ycb : config.ycb
                                    ,   ybt : "확인"
                                });
                            }
                    }
                };
                ajax.call(options);
            }else{
                if(resultCode != "${frontConstants.CERT_CANCEL}"){
                    ui.alert("<div id='alertContentDiv'>본인인증에 실패했습니다.</div>");
                }
            }
        }
    }

    //CI 인증 후, kcb 콜백 처리
    function okCertCallback(result){
        var data = JSON.parse(result);
        defaultOkCertOption.callBack(data);
    }

    /*
    option = {
            ciCtfVal : 회원 CI 값 ( 사용 X )
        ,   callBack : 본인 인증 없이 콜백 함수 -> 2021.05.27 : GS 정상 연동 되어있을 떄
        ,   okCertCallBack : 인증 후 콜백 -> 20210.05.27 : GS 정상 연동 안되어있을 떄 ( KCB 값 누락 || gspt_no 없을 때 || gspt 상태 혹은 사용 여부 N 일 떄)
    }
    변경 이력 :
    -최초 개발 : 최초에 CI 값으로 구분 지어서 callBack 호출
    -2021.05.26 -> GS 연동 이슈로 인해 서버에서 값 가져온 후 GS 관련 컬럼 및 KCB 관련 컬럼으로 분기 처리
     */
    var gk = {
        open : function(config) {
            var options = {
                    url : "/mypage/info/gsr-check"
                ,   done : function(result){
                        //GS 연계 관리 컬럼 확인(GSPT_NO null 체크 , GS 연동 여부, GS 상태 코드)
                        var gsptNoIsNotNull = result.gsptNo != null && result.gsptNo != '';

                        //현재 회원 의 GS 가입 필수 값 누락 여부 확인
                        var mbrNmNotNull = result.mbrNm != null && result.mbrNm != '';
                        var mobileNotNull = result.mobile != null && result.mobile != '';
                        var mobileCdNotNull = result.mobileCd != null && result.mobileCd != '';
                        var gdGbCdNotNull = result.gdGbCd != null && result.gdGbCd != '';
                        var birthNotNull = result.birth != null && result.birth != '';

                        //GS 가입 시 필수 정보 누락 여부
                        var isGsRequiredParamIsNotNull = (mbrNmNotNull && mobileNotNull && mobileCdNotNull && gdGbCdNotNull && birthNotNull);

                        //위 회원 정보 5개 컬럼 중 NULL 있지만 CI 값이 있을 경우, 최초 KCB 인증 후 업데이트 시 누락된 건
                        var ciCtfValNotNull = result.ciCtfVal != null && result.ciCtfVal != '';
                        var isCtfYnY = result.ctfYn == "${frontConstants.COMM_YN_Y}";

                        //GS 연동 처리 관리 컬럼
                        var gsptStatusOk = result.gsptUseYn == "${frontConstants.USE_YN_Y}" && result.gsptStateCd == "${frontConstants.GSPT_STATE_10}";

                        //gsptStatusOk true일 시 가입 된 회원 이거나 , 가입 당시 CRM서버가 죽어 가입 처리가 안된 회원들(후자인 경우 백단에서 자동으로 가입 시키고 API 호출 )
                        var check = isGsRequiredParamIsNotNull && ciCtfValNotNull && gsptStatusOk;

                        //GS 가입 혹은 연동해제 되어 재연동 해야하는 경우
                        if(!check){
                            var isShowGsTerm = false;

                            //GS 연동 해제 메세지 -> 약관 미노출
                            var txt = "<spring:message code='front.web.view.gsr.unconnected.join' />";
                            var ybt = "<spring:message code='front.web.view.common.msg.confirmation' />";
                            var nbt = "<spring:message code='front.web.view.gsr.unconnected.join.confirm.nbt' />";

                            //CI 값이 없으면 최초 가입 해야 하는 회원 : GS 가입 메세지 -> 약관 노출
                            if(!ciCtfValNotNull){
                                txt = "<spring:message code='front.web.view.gsr.todo.join' />";
                                nbt = "<spring:message code='front.web.view.common.msg.cancel' />";
                                isShowGsTerm = true;
                            }

                            //GS 가입 혹은 연동 해제 팝업
                            ui.confirm(txt,{
                                // 가입,연동해제알림 확인' 버튼 클릭 시
                                ycb:function(){
                                    //약관 노출 -> 어바웃펫 최초 가입인 회원 -> GS 약관 동의 및 KCB 처리
                                    if(isShowGsTerm){
                                        var opt = {
                                            url : "/introduce/terms/indexGsPointTerms"
                                            ,   dataType : "html"
                                            ,   done : function(html){
                                                $("#layers").html(html);

                                                $("#termsAgreeBtn").bind("click",function(){
                                                    setGsInsertAndOkCertCallBack(config.okCertCallBack);

                                                    $("#gsrPointTermsCloseBtn").trigger("click");
                                                    okCertPopup("02","${session.mbrNo}");
                                                });

                                                ui.popLayer.open("popGsPoint");
                                            }
                                        }
                                        ajax.call(opt);
                                    }
                                    //약관 미노출 -> 연동 해제 된 사람, KCB만 진행
                                    else{
                                        setGsInsertAndOkCertCallBack(config.okCertCallBack);
                                        okCertPopup("02","${session.mbrNo}");
                                    }
                                }
                                //가입 시에는 취소, 연동해제알림 일 때는 다음에 하기 버튼 클릭 시
                                ,   ncb : function(){
                                        //가입하기 취소시
                                        if(isShowGsTerm){
                                            if(config.ncb && typeof(config.ncb) == 'function'){
                                                config.ncb();
                                            }
                                        }
                                        //연동 해제 알림 - 다음에 하기 버튼 클릭 시
                                        else{
                                            var options = {
                                                    url : "/mypage/info/gsr-next-time"
                                                ,   done : function(result){
                                                        if(config.ncb && typeof(config.ncb) == 'function'){
                                                            config.ncb();
                                                        }
                                                }
                                            };
                                            ajax.call(options);
                                        }
                                }
                                ,   ybt:ybt
                                ,   nbt:nbt
                            });
                        }
                        //GS 가입 혹은 연동해제 되어 재연동 X -> 이미 가입되어잇는 사람
                        else{
                            config.callBack();
                        }

                }
            };
            ajax.call(options);
        }
    };

    function openTermsSetting(termsCd, settingYn){
        var options = {
            url : "/introduce/terms/indexGsPointTermsContents"
            , data : {
                termsCd : termsCd
                , settingYn : settingYn
            }
            , dataType : "json"
            , done : function(data){
                termsList = data.termsList;
                getTerms(0);
                selectTermsSet();
                ui.popLayer.open("termsContentPop");
            }
        }
        ajax.call(options)
    }

    function getTerms(index) {
        var terms = termsList[index];
        $("#termsLayers #termsNm").html(terms.termsNm);
        $("#termsLayers #selectTermsNm").val(index).prop("selected", true);
        $("#termsLayers #termsContents").html(terms.content);
    }

    function selectTermsSet() {
        var selectHtml = [];

        for(var intIndex = 0; intIndex < termsList.length; intIndex++) {
            var terms = termsList[intIndex];

            if(intIndex == 0) {
                selectHtml.push("<option value='" + intIndex + "' selected='selected'>현행 시행일자 : " + terms.termsStrtDt + "</option>");
            } else {
                selectHtml.push("<option value='" + intIndex + "'>" + terms.termsStrtDt + " ~ " + terms.termsEndDt + "</option>");
            }
        }
        $("#selectTermsNm").html(selectHtml);
    }

    $(function(){
        //약관 - 전문 보기 - select change 이벤트
        $(document).on("change","#selectTermsNm",function(){
            getTerms(this.value);
        });

        //약관 동의 체크박스 이벤트
        $(document).on("change","#allCheck",function(e){
            $("input[name=termsChk]").prop("checked", $(this).is(":checked"));
            $("#termsAgreeBtn").prop("disabled",!$(this).is(":checked"));
        }).on("change","input[name='termsChk']",function(){
            var isAllCheck = $("input[name='termsChk']").length == $("input[name='termsChk']:checked").length;
            $("#allCheck").prop("checked", isAllCheck);
            if(isAllCheck) $("#allCheck").trigger("change");
            else $("#termsAgreeBtn").prop("disabled",true);
        });
    })
</script>