<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
    <t:putAttribute name="script">
        <script type="text/javascript" src="/js/jqueryFileDownload.js" charset="utf-8"></script>
        <script type="text/javascript">
            //유효성 체크 및 메세지
            let excelDownClickFlag = false;
            var msfValid = {
                    check : function(){
                        $(".customFormError").remove();
						return msfValid.radioCoulmnCheck() && msfValid.required();
                    }
               ,    radioCoulmnCheck : function(){
                        var valid = true;
                        //라디오 버튼 체크 된 컬럼 있는지 확인
                        if($("input[type='radio'][name='isSearch']:checked").length>0){
                            var checkNameArr = $("input[type='radio'][name='isSearch']:checked").val().split(",");
                            var id = $("input[type='radio'][name='isSearch']:checked").attr("id");

                            //조건별 일자
                            if(id == "colChangeDtmTh"){
                                var sd = $("#strtDtm").val();
                                var ed = $("#strtDtm").val();
                                if(sd =="" && ed == ""){
                                    valid = false;
                                    msfValid.empty("#periodChangeDtm");
                                }else if(sd =="" || ed == ""){
                                    valid = false;
                                    msfValid.invalidRange("#periodChangeDtm");
                                }
                                else {
                                    var diff = getDiffMonths(sd.replace(/-/g,''),ed.replace(/-/g,''));
                                    if(diff < 0 ){
                                        valid = false;
                                        msfValid.invalidAsc("#periodChangeDtm");
                                    }
                                }
                            }
                            // 방문 횟수,주문 건수, 주문 금액
                            else if(["isVisitTh","isOrdCntTh","isOrdAmtTh"].indexOf(id)>-1){
                                var lastEle = "";
                                if(id == "isVisitTh"){
                                    lastEle = "[name='visitEndCnt']";
                                }
                                if(id == "isOrdCntTh"){
                                    lastEle = "[name='ordCntEndVal']";
                                }
                                if(id == "isOrdAmtTh"){
                                    lastEle = "[name='ordAmtEndVal']";
                                }

                                var s_Dtm = $("[name='"+checkNameArr[0]+"']").val();
                                var e_Dtm = $("[name='"+checkNameArr[1]+"']").val();
                                var s_Cnt = $("[name='"+checkNameArr[2]+"']").val();
                                var e_Cnt = $("[name='"+checkNameArr[3]+"']").val();
                                if(s_Dtm == "" && e_Dtm == "" && s_Cnt == "" && e_Cnt == ""){
                                    valid = false;
                                    msfValid.empty(lastEle);
                                }else if((s_Cnt == "" && e_Cnt == "") || (s_Dtm == "" && e_Dtm == "")){
                                    valid = false;
                                    msfValid.empty(lastEle);
                                }else if(s_Cnt == "" || e_Cnt == "" || s_Dtm == "" || e_Dtm == ""){
                                    valid = false;
                                    msfValid.invalidRange(lastEle);
                                }else{
                                    var diff_dtm = getDiffMonths(s_Dtm.replace(/-/g,''),e_Dtm.replace(/-/g,''));
                                    var diff_cnt = parseInt(e_Cnt) - parseInt(s_Cnt);
                                    if(diff_dtm < 0){
                                        valid = false;
                                        msfValid.invalidAsc(lastEle);
                                    }
                                    	/* else if(diff_cnt < 1){
                                        valid = false;
                                        msfValid.invalidAsc(lastEle);
                                    	} */
                                    if(diff_cnt < 0){
                                    	valid = false;
                                    	messager.alert("검색 조건을 바르게 입력해 주세요.","Info","info");
                                    }	
                                }
                            }
                            //펫로그 TAG
                            else if(id == "isPetLogTagTh"){
                                var s_Dtm = $("[name='"+checkNameArr[0]+"']").val();
                                var e_Dtm = $("[name='"+checkNameArr[1]+"']").val();
                                var tagNm = $("[name='"+checkNameArr[2]+"']").val();
                                if(s_Dtm == "" && e_Dtm == "" && tagNm == ""){
                                    valid = false;
                                    msfValid.empty("[name='petLogTagNm']");
                                }else if(s_Dtm == "" || e_Dtm == "" || tagNm == ""){
                                    valid = false;
                                    msfValid.empty("[name='petLogTagNm']");
                                }else{
                                    var diff = getDiffMonths(s_Dtm.replace(/-/g,''),e_Dtm.replace(/-/g,''));
                                    if(diff < 0 ){
                                        valid = false;
                                        msfValid.invalidAsc("[name='petLogTagNm']");
                                    }
                                }
                            }else{
                                if(["infoRcvYn","mkngRcvYn","snsLnkCd","petLogRegsiterYn","petGbCd"].indexOf(checkNameArr[0]) == -1 ){
                                    var idx = checkNameArr.length - 1;
                                    var name = checkNameArr[idx];
                                    if($("[name='"+name+"']").val() == ""){
                                        valid = false;
                                        msfValid.empty("[name='"+name+"']");
                                    }
                                }
                            }
                        }
                        return valid;
                }
                    // 빈 값 입력
/*                ,     empty : function(selector){
                        if($(selector).closest("td").find(".formError").length == 0){
                            $(selector).closest("td").append(msfValid.getMessage('조건을 입력해주세요.'));
                        }
                    } */
                    // 오름 차순 아닐 때
                    ,   invalidAsc : function(selector){
                            if($(selector).closest("td").find(".formError").length == 0){
                                $(selector).closest("td").append(msfValid.getMessage('조건을 확인해주세요.'));
                            }
                    }
                        // 두개 모두 다 입력 안 했을 때
                    ,   invalidRange : function(selector){
                            if($(selector).closest("td").find(".formError").length == 0){
                                $(selector).closest("td").append(msfValid.getMessage('조건을 모두 입력해주세요.'));
                            }
                    }
                    ,   getMessage : function(txt){
                            var html = '';
                            html += '<div class="formError customFormError" style="opacity: 0.87; position: absolute; top: 110.4px; left: 512.962px; margin-top: 0px;">';
                            html += '<div class="formErrorContent">*'+txt+'<br></div>';
                            html += '</div>';
                            return html;
                    }
                    ,	required : function() {
                    		var flag = false;
                    		$(".required").each(function(){
                    			var value = this.value;
                    			if(value == "allSearch") {
                    				value = $("#searchColumnInput").val();
                    			}
                    			// 하나라도 값이 있으면 조회
                    			if(value != "") {
                    				console.log("if문 작동")
                    				flag = true;
                    			}
                    		});
                    		console.log(flag)
                    		return flag;
                    }
            };

            //그리드 생성
            function fnMemberListGrid(){
                var options = {
                    url : "<spring:url value='/member/memberListGrid.do' />"
                    ,   searchParam : fnGetSearchParam()
                    ,   colModels : [
                        _GRID_COLUMNS.mbrNo_b
                        , {name:"mbrNm", label:'<spring:message code="column.mbr_nm" />', width:"80", align:"center"}
                        , {name:"mbrNo", label:'<spring:message code="column.mbr_no" />', width:"80", align:"center", hidden:true}
                        , {name:"mbrGbCd", label:'회원 구분', width:"80", align:"center" ,formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MBR_GB_CD}" />"}}
                        , {name:"mbrStatCd", label:'<spring:message code="column.mbr_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MBR_STAT_CD}" />"}}
                        , {name:"mbrGrdCd", label:'<spring:message code="column.mbr_grd_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MBR_GRD_CD}" />"}}
                        , {name:"loginId", label:'<spring:message code="column.login_id" />', width:"200", align:"center"}
                        , {name:'mobile', label:'<spring:message code="column.mobile" />', width:'200', align:'center', sortable:false}
                        , {name:'email', label:'<spring:message code="column.email" />', width:'300', align:"center", sortable:false}
                    ]
                    ,   height : 400
                };
                grid.create("memberList",options);
            }
            
            //검색
            function fnMemberListGridReload(){

            	if(compareDateAlertOptions("strtDtm","endDtm","periodChangeDtm")){
            		return;
            	}else if(compareDateAlertOptions("visitStrtDtm","visitEndDtm","visitCheckOpt")){
            		return;
            	}else if(compareDateAlertOptions("ordCntAcptStrtDtm","ordCntAcptEndDtm","ordCntChkOpt")){
            		return;
            	}else if(compareDateAlertOptions("ordAmtAcptStrtDtm","ordAmtAcptEndDtm","ordAmtChkOpt")){
            		return;
            	}else if(compareDateAlertOptions("petLogSysRegStrtDtm","petLogSysRegEndDtm","petLogChkOpt")){
            		return;
            	}
            	//방문횟수, 주문건수, 주문금액 시작값,종료값 체크로직 추가. 20210809.
            	if(!msfValid.radioCoulmnCheck()) {            	
            		return;
            	}
            	grid.reload("memberList",{ url : "<spring:url value='/member/memberListGrid.do' />" , searchParam : fnGetSearchParam() });
            }
            //초기화
            function fnInitBtnOnClick(){

                resetForm("memberSearchForm");
                $("input[type='radio'][name='isSearch']:checked").prop("checked",false);
                $("#target-all-check").trigger("click");
                $(".tag-ul").hide();
                $("[name='tagNms']").blur();

                $(".formError").remove();
//                 grid.reload("memberList",{ url : "<spring:url value='/member/memberListGrid.do' />" , searchParam : fnGetSearchParam() });
                $("html").scrollTop(0);
            }
            //엑셀 다운로드
            function fnMemberNoExcelDownload(){
                excelDownLoad("mbrNoExcelDownload", "/member/mbrNoExcelDownload.do", fnGetSearchParam( ));
            }

            function excelDownLoad(id, url, data) {
                $("#" + id + "Form").remove();
                var html = [];
                html.push("<form name=\""+id+"Form\" id=\""+id+"Form\" action=\""+url+"\" method=\"post\">");
                if(data != null) {
                    if(data.constructor === Object){
                        for(var name1 in data){
                            html.push("<input type=\"hidden\" name=\""+name1+"\" value=\"" + data[name1] + "\">");
                        }
                    } else if(data.constructor === Array ){
                        for(var i in data){
                            for(var name2 in data[i]){
                                html.push("<input type=\"hidden\" name=\""+name2+"\" value=\"" + data[i][name2] + "\">");
                            }
                        }
                    }
                }
                html.push("</form>");
                $("body").append(html.join(''));

                $.fileDownload( $("#"+id+"Form").prop('action'),{
                    httpMethod: "POST",
                    data: $("#"+id+"Form").serialize(),
                    prepareCallback: function(url){
                        waiting.start();
                    },
                    successCallback: function( url ){
                        waiting.stop();
                    },
                    abortCallback : function(url){
                        waiting.stop();
                    },
                    failCallback: function(responseHtml,excelUrl){
                        waiting.stop();
                        alert("오류가 발생하였습니다.");
                    }
                });
            }

            function submitCallback(){
                alert("엑셀다운로드 완료");
            }

            //검색 파라미터 생성
            function fnGetSearchParam(){
                var result = $("#memberSearchForm").serializeJson();
            	if(!msfValid.radioCoulmnCheck()) {
            		result.isNotSearch = "${adminConstants.COMM_YN_Y}";
            		return result;
            	}
                result.endDtm = null;
                result.strtDtm = null;

                //라디오 버튼 체크 된 컬럼만 남기고 삭제
                var d_arr_1 = new Array();
                var d_arr_2 = new Array();

                $("input[type='radio'][name='isSearch']").not("input[type='radio'][name='isSearch']:checked").each(function(){
                    d_arr_1.push(this.value);
                });
                $("#colChangeDtm option").each(function(){
                    d_arr_2.push(this.value);
                });

                //조건별 일자 colChangeDtmTh
                var isColChangeDtmCheck = $("#colChangeDtmTh").prop("checked");
                if(isColChangeDtmCheck){
                    var idx = d_arr_2.indexOf(result.isSearch);
                    d_arr_2.splice(idx,1);
                }
                var d_arr = d_arr_1.join() + "," + d_arr_2.join();

                //조건 검색 위해 선택하지 않은 검색 조건 삭제
                var deleteKey = d_arr.split(",");
                for(i in deleteKey){
                    var key = deleteKey[i];
                    result[deleteKey[i]] = "";
                }

                //가입 환경 구분 코드
                var joinEnvCd2 = $("[name='joinEnvCd2']:checked").val();
                if(joinEnvCd2 == "APP"){
                    result.joinEnvCds = "${adminConstants.JOIN_ENV_APP_IOS}"+","+"${adminConstants.JOIN_ENV_APP_ANDROID}";
                }
                if(joinEnvCd2 == "MW"){
                    result.joinEnvCds = "${adminConstants.JOIN_ENV_WEB_MOB}";
                }
                if(joinEnvCd2 == "PC"){
                    result.joinEnvCds = "${adminConstants.JOIN_ENV_WEB_PC}";
                }

                if(parseInt(result.tagNos) == 0 ) {
                    result.tagNos = null;
                }else{
                    var tagNos = result.tagNos;
                    if(Array.isArray(tagNos)){
                        result.tagNos = tagNos.join();
                    }
                }

                //긴급 임시 처리 mbrNo에 문자열 들어갈시 null
                var mbrNo = result.mbrNo;
                if(/\D/.test(mbrNo)){
                    result.mbrNo = null;
                }
                
                //grid rows정보 추가
                result.page = $("#memberList").getGridParam("page"); 
                result.rows= $("#memberList").getGridParam("rowNum");
                
                return result;
            }

            //날짜 변경 이벤트 동적 할당
            function searchDateChange(select,strtDtmId,endDtmId) {
                var term = $(select).children("option:selected").val();
                if(term == "") {
                    $("#"+strtDtmId).val("");
                    $("#"+endDtmId).val("");
                } else if(term == "50") {
					setSearchDateThreeMonth(strtDtmId,endDtmId);
				} else {
                    setSearchDate(term, strtDtmId, endDtmId);
                }
                //$("#"+strtDtmId).trigger("change");
            }

            //화면 초기화
            function fnOnLoadDocument(){
                $("[name='snsLnkCd']").eq(0).val("${adminConstants.SNS_LNK_CD_ALL}");

                $("#visitCheckOpt , #ordCntChkOpt , #ordAmtChkOpt ,#petLogChkOpt").trigger("change");

                var $mbrGbCd = $("option[value=''] , option[value='${adminConstants.MBR_GB_CD_10}'] , option[value='${adminConstants.MBR_GB_CD_20}']");
                $("[name='mbrGbCd'] option").not($mbrGbCd).remove();

                $("[name='mbrStatCd'] option[value='${adminConstants.MBR_STAT_50}']").remove();
                $("[name='mbrStatCd'] option[value='${adminConstants.MBR_STAT_70}']").remove();
                $("[name='mbrStatCd'] option[value='${adminConstants.MBR_STAT_80}']").remove();

                var $onlyDemical = $(" [name='visitStrtCnt'] , [name='visitEndCnt'], [name='ordCntStrtVal'] , [name='ordCntEndVal'] , [name='ordAmtStrtVal'] , [name='ordAmtEndVal'] , [name='lastLoginDay'] ");
                $onlyDemical.bind("input change paste",function(){
                    var inputVal = $(this).val().replace(/\D/g,'');
                    $(this).val(inputVal);
                });
                fnMemberListGrid();
            }

            $(function(){

                fnOnLoadDocument();

                // '*조건' select 및 input 입력 이벤트
                $(document).on("change","#searchColumn",function(){
                    //전체 검색 일시, 전체 검색 분기 처리 변수 Y
                    var yn = $("#searchColumn option:selected").val() == "allSearch" ? "${adminConstants.COMM_YN_Y}" : "${adminConstants.COMM_YN_N}";
                    $("input[name='allSearchYn']").val(yn);

                    var $obj = $("#searchColumnInput , [name='mbrNo'] , [name='loginId'], [name='nickNm'], [name='mobile'], [name='mbrNm'], [name='email'], [name='rcomLoginId']");
                    $obj.val("");
                }).on("input change paste","#searchColumnInput",function(){
                    var arr = ["#searchColumnInput, [name='loginId']","[name='nickNm']","[name='mobile']","[name='mbrNm']","[name='email']","[name='rcomLoginId']"];
                    //전체 검색이지만, 문자열 입력되었을 시 mbrNo는 전체 검색 조건에 들어가면 안됨
                    if($("input[name='allSearchYn']").val() == "${adminConstants.COMM_YN_Y}" && parseInt($("#searchColumnInput").val()) != NaN){
                        arr.push("[name='mbrNo']");
                    }
                    $t = $(arr.join());

                    var name = $("#searchColumn option:selected").val();
                    if(name != 'allSearch'){
                        $t = $("#searchColumnInput , [name='"+name+"']");
                    }

                    var inputVal = $(this).val().replace(/\s/g,'');
                    if(name == "mbrNo"){
                        inputVal = $(this).val().replace(/\D/g,'');
                    }
                    $t.val(inputVal);
                });

                //조건별 일자
                $(document).on("click","#colChangeDtmTh",function(){
                    $("#colChangeDtm").trigger("change");
                }).on("change","#colChangeDtm",function(){
                    $("#colChangeDtmTh").val($("#colChangeDtm option:selected").val());
                    var arr = $("#colChangeDtm option:selected").val().split(",");
                    var strtDtmName = arr[0];
                    var endDtmName = arr[1];

                    var strtDtm = $("#colChangeDtm option:selected").data("strtDtm");
                    var endDtm = $("#colChangeDtm option:selected").data("endDtm");

                    $(this).next().find("input").attr("name",strtDtmName).prop("name",strtDtmName).val(strtDtm); // 시작날짜
                    $(this).next().next().find("input").attr("name",endDtmName).prop("name",endDtmName).val(endDtm); // 종료날짜
                    $('#periodChangeDtm').children("option").eq(5).prop("selected",true); //조건 변경시 셀렉트박스 옵션 초기화 - ('1개월')
                });

                //TAG 입력 이벤트
                $(document).on("input change paste","[name='petLogTagNm']",function(e){
                    var inputVal = $(this).val().replace(/#@/gi,'');
                    if(inputVal.indexOf(",")>-1){
                        e.preventDefault();
                        inputVal = inputVal.substring(0,inputVal.indexOf(","));
                        if($(".window-mask").length == 0){
                            $("[name='petLogTagNm']").val(inputVal);
                            messager.alert("Tag는 1개씩만 조회 가능합니다.","Info","Info");
                        }
                    }else{
                        $("[name='petLogTagNm']").val(inputVal.replace(/\s+/g,' '));
                    }
                });

                //관심 태그 select 퍼포먼스
                $(document).on("input change paste","#tagNms",function(){
                    var inputVal = $(this).val().replace(/#@/gi,'').replace(/\s+/g,' ').replace(/,+/g,',');
                    $("#tagNms").val(inputVal);
                });
                $(document).on("click","#selectVal",function(){
                    $('.tag-ul').toggle();
                }).on("click",".tag-ul li .interest-tag",function(){
                    var id = $(this).val();
                    $("#"+id).trigger("click");
                }).on("click",".tag-ul li input[type=checkbox]",function(){
                    $(this).parent().children(".interest-tag").prop("checked",$(this).is(":checked"));

                    var id = this.id;
                    var isCheck = $(this).is(":checked");

                    if(id === "target-all-check"){
                        $(".interest-tag").not(this).prop("checked",false);
                        $(".interest-tag").not(this).next().prop("checked",false);
                        $("#target-all-check-radio").prop("checked",true);
                        $("#target-all-check").prop("checked",true);
                        $("#selectVal").html($("#selectVal").data("origin"));
                        $(".tag-input-val").prop("disabled",false).prop("readonly",false).removeClass("readonly").val("");
                        $('.tag-ul').toggle();
                        $(".tag-input-val").focus();
                    }else{
                        $("#target-all-check-radio").prop("checked",false);
                        $("#target-all-check").prop("checked",false);
                        $("#selectVal").html("....&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▼");

                        var tagNms = [];
                        $(".interest-tag").each(function(idx){
                            if($(".interest-tag").eq(idx).is(":checked")){
                                tagNms.push($(".interest-tag").eq(idx).parent().find("span").text());
                            }
                        })
                        $("#tagNms").prop("disabled",true).prop("readonly",true).addClass("readonly").val(tagNms.join(","));
                    }
                });
            })
            
          $(document).ready(function(){
        	//데이트피커 날짜 변경시 셀렉박스 옵션 -'기간선택'으로 변경
        	newSetCommonDatePickerEventOptions('#strtDtm','#endDtm','#periodChangeDtm');
         	newSetCommonDatePickerEventOptions('#visitStrtDtm','#visitEndDtm','#visitCheckOpt');        	  
        	newSetCommonDatePickerEventOptions('#ordAmtAcptStrtDtm','#ordAmtAcptEndDtm','#ordAmtChkOpt');        	  
        	newSetCommonDatePickerEventOptions('#ordCntAcptStrtDtm','#ordCntAcptEndDtm','#ordCntChkOpt');        	  
        	newSetCommonDatePickerEventOptions('#petLogSysRegStrtDtm','#petLogSysRegEndDtm','#petLogChkOpt');
        	  // qa- 년도 선택범위 100년
        	  $("#colChangeDtm").trigger("change");
              $("input[name=birthStrtDtm]").datepicker("option", "yearRange", 'c-100:c');
              $("input[name=birthEndDtm]").datepicker("option", "yearRange", 'c-100:c');
              
              $(document).on("keydown","#memberSearchForm input",function(){
      			if ( window.event.keyCode == 13 ) {
    				fnMemberListGridReload();
    		  	}
              });
          })
            
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <style>
            .is-search-radio , .interest-tag{margin-bottom:4px;}
            .is-search-check{display:none;}
            .tag-ul{
                z-index:200;
                border:1px solid #d5d5d5;
                border-top:none;
                width:106px;
                display:none;
                position:absolute;
                background:white;
                margin-top:25px;
            }
            .visible-button{
                position:absolute;
                border: 1px solid #d5d5d5;
                width:106px;
                height:26px;
                text-align: left;
                padding-left: 15px;}
            .tag-input-val{
                height:60%;
                margin-left:110px;
            }
        </style>
        <div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
            <div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
                <form id="memberSearchForm">
                    <div id="hidden-field" style="display:none;">
                        <input type="text" name="mbrNo" />
                        <input type="text" name="loginId" />
                        <input type="text" name="nickNm" />
                        <input type="text" name="mobile" />
                        <input type="text" name="mbrNm" />
                        <input type="text" name="email" />
                        <input type="text" name="rcomLoginId"/>
                        <input type="text" name="allSearchYn" value="${adminConstants.COMM_YN_Y}" />
                    </div>
                    <table class="table_type1">
                        <caption>정보 검색</caption>
                        <colgroup>
                            <col width="10%"/>
                            <col width="40%"/>
                            <col width="10%"/>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th><span class="red">*</span>조건</th>
                                <td>
                                    <select id="searchColumn" class="w100 required">
                                        <option value="allSearch" selected>전체</option>
                                        <option value="mbrNo">User-no</option>
                                        <option value="loginId">ID</option>
                                        <option value="nickNm">닉네임</option>
                                        <option value="mobile">폰번호</option>
                                        <option value="mbrNm">이름</option>
                                        <option value="email">Email</option>
                                        <option value="rcomLoginId">추천인 ID</option>
                                    </select>
                                    <input type="text" id="searchColumnInput" class="w200 ml10" />	<!-- validate[required] -->
                                </td>

                                <th><span class="red">*</span>회원 유형</th>
                                <td>
                                    <select name="mbrGbCd" class="required">
                                        <frame:select grpCd="${adminConstants.MBR_GB_CD}" defaultName="전체"/>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <th><span class="red">*</span>회원 상태</th>
                                <td>
                                    <select name="mbrStatCd" id="mbrStatCd" title="<spring:message code="column.mbr_stat_cd"/>" class="required">
                                        <frame:select grpCd="${adminConstants.MBR_STAT_CD}" defaultName="전체"/>
                                    </select>
                                </td>

                                <th><span class="red">*</span>회원 등급</th>
                                <td>
                                    <select name="mbrGrdCd" id="mbrGrdCd" title="<spring:message code="column.mbr_grd_cd"/>" class="required">
                                        <frame:select grpCd="${adminConstants.MBR_GRD_CD}" defaultName="전체" />
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th><span class="red">*</span>성별</th>
                                <td>
                                    <select name="gdGbCd" class="required">
                                        <frame:select grpCd="${adminConstants.GD_GB}" defaultName="전체"/>
                                    </select>
                                </td>

                                <th><span class="red">*</span>가입 경로</th>
                                <td>
                                    <select name="joinPathCd" class="required">
                                        <frame:select grpCd="${adminConstants.JOIN_PATH}" excludeOption="${adminConstants.SELECT_PERIOD_10 }" defaultName="전체" />
                                    </select>

                                    <label class="fRadio ml5"><input type="radio" name="joinEnvCd2" value="" checked="checked"> <span id="span_전체">전체</span></label>
                                    <label class="fRadio"><input type="radio" name="joinEnvCd2" value="APP" > <span id="span_전체">APP</span></label>
                                    <label class="fRadio"><input type="radio" name="joinEnvCd2" value="MW" > <span id="span_전체">M web</span></label>
                                    <label class="fRadio"><input type="radio" name="joinEnvCd2" value="PC" > <span id="span_전체">PC web</span></label>
                                </td>
                            </tr>
                        <tr>
                            <!-- 2021.03.17 알림수신 동의는 당시 컨셉과 다른 개념. 검색할 수 없는 값 -->
                            <th>
                                <label>
                                    <input type="radio" class="is-search-radio" name="isSearch" value="infoRcvYn">
                                    <span>알림수신 동의</span>
                                </label>
                            </th>
                            <td>
                                <label class="fRadio">
                                    <input type="radio" name="infoRcvYn" value="" checked="checked">
                                    <span id="span_smsRcvYn_all">전체</span>
                                </label>
                                <label class="fRadio">
                                    <input type="radio" name="infoRcvYn" value="Y" >
                                    <span id="span_smsRcvYn_Y">수신</span>
                                </label>
                                <label class="fRadio">
                                    <input type="radio" name="infoRcvYn" value="N" >
                                    <span id="span_smsRcvYn_N">수신 거부</span>
                                </label>
                            </td>

                            <!-- 2021.03.17 마케팅 수신 여부로 변경 , 컬럼명은 유지 -->
                            <th>
                                <label>
                                    <input type="radio" class="is-search-radio"  name="isSearch" value="mkngRcvYn">
                                    <span>메일수신 동의</span>
                                </label>
                            </th>
                            <td>
                                <label class="fRadio">
                                    <input type="radio" name="mkngRcvYn" value="" checked="checked">
                                    <span id="span_mkngRcvYn_all">전체</span>
                                </label>
                                <label class="fRadio">
                                    <input type="radio" name="mkngRcvYn" value="${adminConstants.COMM_YN_Y}" >
                                    <span id="span_mkngRcvYn_Y">수신</span>
                                </label>
                                <label class="fRadio">
                                    <input type="radio" name="mkngRcvYn" value="${adminConstants.COMM_YN_N}" >
                                    <span id="span_mkngRcvYn_N">수신 거부</span>
                                </label>
                            </td>
                        </tr>

                        <tr>
                            <th>
                                <label>
                                    <input type="radio"  class="is-search-radio" name="isSearch" id="colChangeDtmTh" value="" />
                                    <span>조건별 일자</span>
                                </label>
                            </th>

                            <td colspan="3">
                                <select  id="colChangeDtm" class="w100">
                                    <option value="birthStrtDtm,birthEndDtm" data-strt-dtm="${strtDtm}" data-end-dtm="${today}">생일</option>
                                    <option value="joinStrtDtm,joinEndDtm" data-strt-dtm="${strtDtm}" data-end-dtm="${today}">가입일</option>
                                    <option value="dorantRlsStrtDtm,dorantRlsEndDtm" data-strt-dtm="${strtDtm}" data-end-dtm="${today}">휴면해제일</option>
                                    <option value="lastLoginStrtDtm,lastLoginEndDtm" data-strt-dtm="${strtDtm}" data-end-dtm="${today}">최종 로그인</option>
                                    <option value="gsptStartStrtDtm,gsptStartEndDtm" data-strt-dtm="${strtDtm}" data-end-dtm="${today}">정회원 전환일</option>
                                </select>
                                &nbsp;&nbsp;
                                <frame:datepicker startDate="strtDtm" endDate="endDtm" startValue="${strtDtm}" endValue="${today}"/>
                                <select class="w100 ml10" id="periodChangeDtm" onchange="searchDateChange(this,'strtDtm','endDtm');">
                                    <frame:select grpCd="${adminConstants.SELECT_PERIOD}" selectKey="${adminConstants.SELECT_PERIOD_40}" defaultName="기간선택" />
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <th>
                                <label>
                                    <input type="radio" class="is-search-radio" name="isSearch" id="isVisitTh" value="visitStrtDtm,visitEndDtm,visitStrtCnt,visitEndCnt">
                                    <span>방문 횟수</span>
                                </label>
                            </th>
                            <td colspan="3">
                                <frame:datepicker startDate="visitStrtDtm" endDate="visitEndDtm" startValue="${strtDtm}" endValue="${today}"/>
                                <select class="w100 ml10" id="visitCheckOpt" onchange="searchDateChange(this,'visitStrtDtm','visitEndDtm');">
                                    <frame:select grpCd="${adminConstants.SELECT_PERIOD}" selectKey="${adminConstants.SELECT_PERIOD_40}" defaultName="기간선택" />
                                </select>

                                <input type="text" class="w50 ml30" name="visitStrtCnt" value=""/> 회 ~ <input type="text" class="w50" name="visitEndCnt" value=""/> 회
                            </td>
                        </tr>

                        <tr>
                            <th>
                                <label>
                                    <input type="radio" class="is-search-radio" name="isSearch" id="isOrdCntTh" value="ordCntAcptStrtDtm,ordCntAcptEndDtm,ordCntStrtVal,ordCntEndVal">
                                    <span>주문 건수</span>
                                </label>
                            </th>
                            <td colspan="3">
                                <frame:datepicker startDate="ordCntAcptStrtDtm" endDate="ordCntAcptEndDtm" startValue="${strtDtm}" endValue="${today}"/>
                                <select class="w100 ml10" id="ordCntChkOpt" onchange="searchDateChange(this,'ordCntAcptStrtDtm','ordCntAcptEndDtm');">
                                    <frame:select grpCd="${adminConstants.SELECT_PERIOD}" selectKey="${adminConstants.SELECT_PERIOD_40}" defaultName="기간선택"/>
                                </select>

                                <input type="text" class="w50 ml30" name="ordCntStrtVal" value=""/> 회 ~ <input type="text" class="w50" name="ordCntEndVal" value=""/> 회
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <label>
                                    <input type="radio" class="is-search-radio" name="isSearch" id="isOrdAmtTh" value="ordAmtAcptStrtDtm,ordAmtAcptEndDtm,ordAmtStrtVal,ordAmtEndVal">
                                    <span>주문 금액</span>
                                </label>
                            </th>
                            <td colspan="3">
                                <frame:datepicker startDate="ordAmtAcptStrtDtm" endDate="ordAmtAcptEndDtm" startValue="${strtDtm}" endValue="${today}"/>
                                <select class="w100 ml10" id="ordAmtChkOpt" onchange="searchDateChange(this,'ordAmtAcptStrtDtm','ordAmtAcptEndDtm');">
                                    <frame:select grpCd="${adminConstants.SELECT_PERIOD}" selectKey="${adminConstants.SELECT_PERIOD_40 }" defaultName="기간선택" />
                                </select>

                                <input type="text" class="w50 ml30" name="ordAmtStrtVal" value=""/> 원 ~ <input type="text" class="w50" name="ordAmtEndVal" value=""/> 원
                            </td>
                        </tr>

                        <tr>
                            <th>
                                <label>
                                    <input type="radio" class="is-search-radio" name="isSearch" id="isPetLogTagTh" value="petLogSysRegStrtDtm,petLogSysRegEndDtm,petLogTagNm">
                                    <span>TAG</span>
                                </label>
                            </th>
                            <td colspan="3">
                                <frame:datepicker startDate="petLogSysRegStrtDtm" endDate="petLogSysRegEndDtm" startValue="${strtDtm}" endValue="${today}"/>
                                <select class="w100 ml10" id="petLogChkOpt" onchange="searchDateChange(this,'petLogSysRegStrtDtm','petLogSysRegEndDtm');">
                                    <frame:select grpCd="${adminConstants.SELECT_PERIOD}" selectKey="${adminConstants.SELECT_PERIOD_40}" defaultName="기간선택" />
                                </select>

                                <input type="text" class="w200 ml30" name="petLogTagNm" value=""/>
                            </td>
                        </tr>

                        <tr>
                            <th>
                                <label>
                                    <input type="radio" class="is-search-radio" name="isSearch" value="lastLoginDay">
                                    <span>장기 미로그인</span>
                                </label>
                            </th>
                            <td>
                                <input type="text" class="w50" name="lastLoginDay" value="" /> <span class="ml10">일 이상 로그인하지 않은 회원</span>
                            </td>

                            <th>
                                <label>
                                    <input type="radio" class="is-search-radio" name="isSearch" value="dormantAplDay">
                                    <span>휴면 전환 예정</span>
                                </label>
                            </th>
                            <td>
                                <select name="dormantAplDay" class="w100">
                                    <frame:select grpCd="${adminConstants.DORMANT_PERIOD}" selectKey="${adminConstants.DORMANT_7_DAY}" useYn="${adminConstants.COMM_YN_Y}" />
                                </select>
                                일 전 회원
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <label>
                                    <input type="radio" class="is-search-radio" name="isSearch" id="isSnsSearch" value="snsLnkCd" >
                                    <span>소셜 로그인</span>
                                </label>
                            </th>
                            <td>
                                <frame:radio name="snsLnkCd" grpCd="${adminConstants.SNS_GB}" defaultName="전체"/>
                            </td>

                            <th>
                                <label>
                                    <input type="radio" class="is-search-radio" name="isSearch" value="tagNos,tagNms">
                                    <span>관심 태그</span>
                                </label>
                            </th>
                            <td>
                                <button type="button" class="visible-button" id="selectVal" data-origin="직접 입력&nbsp;&nbsp;&nbsp;▼">직접 입력&nbsp;&nbsp;&nbsp;▼</button>
                                <ul class="tag-ul">
                                    <li></li>
                                    <li>
                                        <input type="radio" class="interest-tag" name="all-check" id="target-all-check-radio" value="target-all-check"/>
                                        <input type="checkbox" id="target-all-check" name="tagNos" value="0" style="display:none;"/>
                                        <span>직접 입력</span>
                                    </li>
                                    <c:forEach items="${tags}" var="tag" varStatus="status">
                                        <c:set var="cnt" value="${status.count}" />
                                        <li>
                                            <input type="radio" class="interest-tag" name="visible-radio_${cnt}" value="target-check-${cnt}" />
                                            <input type="checkbox" id="target-check-${cnt}" name="tagNos" value="${tag.dtlCd}" style="display:none;"/>
                                            <span>${tag.dtlNm}</span>
                                        </li>
                                    </c:forEach>
                                </ul>
                                <input type="text" class="tag-input-val" name="tagNms" id="tagNms" />
                            </td>
                        </tr>

                        <tr>
                            <th>
                                <label>
                                    <input type="radio" class="is-search-radio" name="isSearch" value="petGbCd">
                                    <span>반려 동물</span>
                                </label>
                            </th>
                            <td>
                                <select class="w100" name="petGbCd">
                                    <frame:select grpCd="${adminConstants.PET_GB}" defaultName="전체" useYn="${adminConstants.COMM_YN_Y}" usrDfn5Val="opt" />
                                </select>
                            </td>

                            <th>
                                <label>
                                    <input type="radio" class="is-search-radio" name="isSearch" value="petLogRegsiterYn" >
                                    <span>펫로그</span>
                                </label>
                            </th>
                            <td>
                                <label class="fRadio">
                                    <input type="radio" name="petLogRegsiterYn" value="${adminConstants.COMM_YN_Y}" checked >
                                    <span id="span_pet_log_register_Y">등록</span>
                                </label>
                                <label class="fRadio">
                                    <input type="radio" name="petLogRegsiterYn" value="${adminConstants.COMM_YN_N}" >
                                    <span id="span_pet_log_register_N">미등록</span>
                                </label>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
                <!-- 사이트 ID -->
                <select id="stIdCombo" name="stId" style="display:none;"><frame:stIdStSelect stId="1"/></select>

                <div class="btn_area_center">
                    <button type="button" onclick="fnMemberListGridReload();" class="btn btn-ok">검색</button>
                    <button type="button" onclick="fnInitBtnOnClick();" class="btn btn-cancel">초기화</button>
                </div>
            </div>
        </div>

        <div class="buttonArea mt30" style="text-align:right;">
            <button type="button" onclick="fnMemberNoExcelDownload();" class="btn btn-add btn-excel" id="excelDownBtn">
                <spring:message code="admin.web.view.common.button.download.excel"/>
            </button>
        </div>

        <div class="mModule" style="margin-top:10px;">
            <table id="memberList"></table>
            <div id="memberListPage"></div>
        </div>

    </t:putAttribute>
</t:insertDefinition>