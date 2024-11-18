<t:insertDefinition name="contentsLayout">
    <t:putAttribute name="script">
        <script src="/js/event.js"></script>
        <script type="text/javascript">
            //퀴즈 목록 가져오기
            function fnGetQuizList(){
                var options = {
                        url : "<spring:url value='/event/listQuestionAndAnswerInfo.do' />"
                    ,   data : { eventNo : $("[name='eventNo']").val() }
                    ,   callBack : function(result){
                            var eventGbCd = $("[name='eventGbCd']:checked").val();
                            if(eventGbCd ==="${adminConstants.EVENT_GB_30}"){
                                $(".quiz-li").each(function(idx){
                                    $(this).find("select[name='qstTpCd']").trigger("change");
                                });
                            }

                            if(result.length>0){
                                result.forEach(function(o,idx){
                                    if(idx!=0){
                                        quiz.append();
                                    }
                                    var qstTpCd = o.qstTpCd;
                                    var qstNm = o.qstNm;
                                    var rplContents = o.rplContent.split(",");
                                    var rghtansYns = o.rghtansYn.split(",");
                                    var size  = rplContents.length;

                                    $(".quiz-li").last().find("option:selected").prop("selected",false);
                                    $(".quiz-li").last().find("[name='qstTpCd']").val(qstTpCd);
                                    $(".quiz-li").last().find("[name='qstTpCd']").trigger("change");


                                    var selector = qstTpCd === "${adminConstants.QST_TP_10}" ? "[type='checkbox']" : "[type='radio']";
                                    $(".quiz-li").last().find("[name='qstNm']").val(qstNm);

                                    if(qstTpCd === "${adminConstants.QST_TP_10}" || qstTpCd === "${adminConstants.QST_TP_20}"){
                                        $(".quiz-li").last().find(".rpl-ul").empty();
                                        $(".quiz-li").last().find("[name='rplCnt']").val(0);

                                        for(var i=0; i<size; i+=1){
                                            $(".rpl-innerTd").last().find("[name='quizAddEleBtn']").trigger("click");
                                            var rplContent = rplContents[i];
                                            var rghtansYn = rghtansYns[i];
                                            $(".quiz-li").last().find("[name='rplContents']").last().val(rplContent);

                                            if(rghtansYn==="${adminConstants.COMM_YN_Y}"){
                                                $(".quiz-li").last().find("dl").last().find("[name='rghtansYns']").last().val("true");
                                                $(".quiz-li").last().find("dl").last().find(selector).prop("checked",true);
                                            }else{
                                                $(".quiz-li").last().find("dl").last().find("[name='rghtansYns']").last().val("false");
                                                $(".quiz-li").last().find("dl").last().find(selector).prop("checked",false);
                                            }
                                        }
                                    }else{
                                        $(".quiz-li").last().find("[name='rplContents']").last().val(rplContents[0]);
                                    }
                                });
                            }
                    }
                };
                ajax.call(options);
            }

            //추가 필드 가져오기
            function fnGetAddFieldList(){
                var options = {
                        url : "<spring:url value='/event/listEventAddField.do' />"
                    ,   data : { eventNo : $("[name='eventNo']").val() }
                    ,   callBack : function(result){
                        if(result.length>0){
                            $(".addField-li").remove();
                            result.forEach(function(o,idx){
                                field.append();
                                $("[name='fldTpCd']").eq(idx).val(o.fldTpCd);
                                $("[name='fldTpCd']").eq(idx).trigger("change");
                                $("[name='fldDscrt']").eq(idx).val(o.fldDscrt);

                                var fldTpCd = parseInt(o.fldTpCd);
                                $(".addField-li").last().find("[name='fldNm']").val(o.fldNm);
                                if(fldTpCd===parseInt('${adminConstants.FLD_TP_CD_30}') || fldTpCd===parseInt('${adminConstants.FLD_TP_CD_40}') || fldTpCd===parseInt('${adminConstants.FLD_TP_CD_50}')){
                                    $(".addField-li").last().find("[name='fldVals']").remove();
                                    var fldVals = o.fldVal.split(",");
                                    for(var i in fldVals){
                                        var fldVal = fldVals[i];
                                        $(".addField-li").last().find("[name='fieldAddEleBtn']").trigger("click");
                                        $(".addField-li").last().find("[name='fldVals']").last().val(fldVal);
                                    }
                                }
                                else if(fldTpCd===parseInt("${adminConstants.FLD_TP_CD_60}")){
                                    $(".addField-li").last().find("[name='fldVals']:checked").prop("checked",false);
                                    $(".addField-li").last().find("#"+o.fldVal).prop("checked",true);
                                }else if(fldTpCd===parseInt("${adminConstants.FLD_TP_CD_70}")){
                                    $(".addField-li").last().find("[name='imgDscrt']").val(o.imgDscrt);
                                    $(".addField-li").last().find("[name='fldVals']").val(o.fldVal);
                                    var html = "<input type='hidden' name='originalPath' value='"+o.fldVal+"' />";
                                    $(".addField-li").last().find("[name='fldVals']").after(html);
                                }
                                else{
                                    $(".addField-li").last().find("[name='fldVals']").val(o.fldVal);
                                }
                            });
                        }
                    }
                };
                ajax.call(options);
            }

            //이벤트 등록
            function fnUpdateEvent(){
                if(isUpdate()){
                    var data = $("#eventDetailForm").serializeJson();
                    data.quizJsonStr = quiz.serializeJson().length != 0 ? JSON.stringify(quiz.serializeJson()) : "";
                    data.addFieldJsonStr = field.serializeJson().length != 0 ? JSON.stringify(field.filterData(field.serializeJson())) : "";
                    data.aplStrtDtm = getDateStr("aplStrt");
                    data.aplEndDtm = getDateStr("aplEnd");
                    var options = {
                        url : "<spring:url value='/event/eventUpdate.do' />"
                        ,   data : data
                        ,   callBack : function(result){
                                updateTab("/event/eventDetailView.do?eventNo="+result.vo.eventNo,"이벤트 상세");
                        }
                    };
                    ajax.call(options);
                }
            }

            //유효성 검사
            function isUpdate(){
                oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
                var isUpdate = $("[name='eventGbCd']:checked").val() === "${adminConstants.EVENT_GB_50}" ? validate.check("eventDetailForm") & quiz.validation(quiz.serializeJson())
                    : validate.check("eventDetailForm");
                return isUpdate;
            }

            //초기화 버튼 클릭
            function fnInitBtnOnClick(){
                resetForm("eventDetailForm");
                $("[name='eventTpCd']:checked").trigger("click");

                var $dt_input = $("[name='aplStrtDt'] , [name='aplEndDt']");
                var $dt_select = $("[name='aplStrtHr'] , [name='aplStrtMn'] , [name='aplEndHr'] , [name='aplEndMn']");
                $dt_input.val($dt_input.data("origin"));
                $dt_select.find("option").prop("selected",false);
                $dt_select.find("option[value='"+$dt_select.data("origin")+"']").prop("selected",true);

                $("html").scrollTop(0);
            }

            //최초 화면 초기화
            function fnOnLoadDocument(){
                setCommonDatePickerEvent("#aplStrtDt","#aplEndDt");

                EditorCommon.setSEditor('content','${adminConstants.EVENT_IMAGE_PATH}');

                $("[name='aplStrtDt']").data("origin",$("[name='aplStrtDt']").val());
                $("[name='aplStrtHr']").data("origin",$("[name='aplStrtHr'] option:selected").val());
                $("[name='aplStrtMn']").data("origin",$("[name='aplStrtDt'] option:selected").val());
                $("[name='aplEndDt']").data("origin",$("[name='aplEndDt']").val());
                $("[name='aplEndHr']").data("origin",$("[name='aplEndHr'] option:selected").val());
                $("[name='aplEndMn']").data("origin",$("[name='aplEndMn'] option:selected").val());

                field.init();
                quiz.init();

                var $trigger = $("[name='eventTpCd'] , [name='collectItemCd']");
                $trigger.trigger("change");

                if($("[name='eventTpCd']:checked").val() === "${adminConstants.EVENT_TP_20}"){
                    fnGetAddFieldList();
                    if($("[name='eventGbCd']:checked").val() === "${adminConstants.EVENT_GB_30}"){
                        fnGetQuizList();
                    }
                }

                //이벤트 응모형 임시로 HIDE
                $("[name='eventTpCd'][value='${adminConstants.EVENT_TP_20}']").parent().hide();
            }

            $(function(){
                //이벤트 유형,구분 변경 이벤트
                $(document).on("change","[name='eventTpCd']",function(){
                    var eventTpCd = $("[name='eventTpCd']:checked").val();

                    $("[name='eventGbCd']").not("[usrDfn1Val='"+eventTpCd+"']").parent().hide();
                    $("[name='eventGbCd'][usrDfn1Val='"+eventTpCd+"']").parent().show();

                    var $hideColumn = $("#pcImgView , #moImgView, input[name='collectItemCd'] , [name='loginRqidYn'] , [name='collectItemCd']" +
                        ",  #add-field-div , #quiz-div , [name='winDt']");
                    eventTpCd == "${adminConstants.EVENT_TP_10}" ? $hideColumn.parents("tr").hide() : $hideColumn.parents("tr").show();
                    $("[name='eventGbCd']").trigger("change");
                }).on("change","[name='eventGbCd']",function(){
                    var eventGbCd = $("[name='eventGbCd']:checked").val();
                    var $hideColumn =  $("#quiz-div");
                    eventGbCd == "${adminConstants.EVENT_GB_30}" ? $hideColumn.parents("tr").show() : $hideColumn.parents("tr").hide();
                });

                //추가 필드 - 이미지 삽입
                $(document).on("click","[name='goodsImageUploadBtn']",function(){
                    var idx = $(this).parents(".addField-li").index();
                    $("[name='fldVals']").eq(idx).val("");
                    fileUpload.image(function(result){
                        $("[name='fldVals']").eq(idx).val(result.filePath);
                    },'');
                })

                //수집 항목 변경 이벤트
                $(document).on("change","[name='collectItemCd']",function(){
                    var checkVal = [];
                    $("[name='collectItemCd']").each(function(idx){
                        var chk = $("[name='collectItemCd']").eq(idx);
                        if(chk.is(":checked")) checkVal.push(chk.val());
                    });
                    $("#clctItemCd_check").val(checkVal.join());
                });

                //퀴즈 - 라디오 버튼 ,체크박스 클릭 시
                $(document).on("click","dl label [type='radio'] , dl label [type='checkbox']",function(){
                    $(this).parents("dl").children("[name='rghtansYns']").val(this.checked);
                    if($(this).attr("type")==="radio"){
                        $("input[name='"+this.name+"']").each(function(idx,ele){
                            $(ele).parents("dl").children("[name='rghtansYns']").val(ele.checked);
                        });
                    }
                });

                //썸네일
                $(document).on("click","#dlgtImgAddBtn",function(){
                    var limitObj = {
                           width : thumbnailMaxWidth
                    };
                    fileUpload.imageCheck(fnResultImage,'dlgtImg',limitObj);
                })

                //최대 100자 입력 방지
                $(document).on("change paste input","#ttl ,#eventSubNm , #eventBnfts",function(){
                    var maxLength = 100;
                    var txt = $(this).val();
                    $(this).val(txt.substring(0,maxLength));
                });

                fnOnLoadDocument();
            })
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <form id="eventDetailForm">
            <table class="table_type1">
                <tr>
                    <th>이벤트 No.</th>
                    <td><input class="readonly w200" type="text" readonly="readonly" name="eventNo" value="${vo.eventNo}"/></td>

                    <th>이벤트 유형<span class="red">*</span></th>
                    <td>
                        <frame:radio name="eventTpCd" grpCd="${adminConstants.EVENT_TP}" selectKey="${vo.eventTpCd}" useYn="${commonConstants.USE_YN_Y}" />
                    </td>
                </tr>

                <!-- 이벤트 구분, 이벤트 타입 -->
                <tr>
                    <th>이벤트 구분<span class="red">*</span></th>
                    <td>
                        <frame:radio name="eventGbCd" grpCd="${adminConstants.EVENT_GB}" selectKey="${vo.eventGbCd}" useYn="${adminConstants.COMM_YN_Y}"/>
                    </td>

                    <th>이벤트 타입<span class="red">*</span></th>
                    <td>
                        <frame:radio name="eventGb2Cd" grpCd="${adminConstants.EVENT_GB2_CD}" selectKey="${vo.eventGb2Cd}" useYn="${commonConstants.COMM_YN_Y}" />
                    </td>
                </tr>

                <!-- 이벤트 타입 -->
                <tr>
                    <th>이벤트 명<span class="red">*</span></th>
                    <td>
                        <input type="text" class="validate[required] w200" id="ttl" name="ttl" value="${vo.ttl}" placeholder="이벤트 명을 입력해주세요." maxlength="100"/>
                        <label class="max100 red">(최대 100자)</label>
                    </td>

                    <!-- 이벤트 서브명-->
                    <th>이벤트 서브명 <span class="red">*</span></th>
                    <td>
                        <input type="text" class="w200 validate[required]" id="eventSubNm" name="eventSubNm" value="${vo.eventSubNm}" placeholder="이벤트 서브명을 입력해주세요." maxlength="100" />
                        <label class="max100 red">(최대 100자)</label>
                    </td>
                </tr>

                <tr>
                    <!-- 이벤트 혜택-->
                    <th>이벤트 혜택<span class="red">*</span></th>
                    <td>
                        <input type="text" class="w200 validate[required]" id="eventBnfts" name="eventBnfts" value="${vo.eventBnfts}" placeholder="이벤트 혜택을 입력해주세요." maxlength="100" />
                        <label class="max100 red">(최대 100자)</label>
                    </td>

                    <!-- 이벤트 상태 -->
                    <th>이벤트 상태<span class="red">*</span></th>
                    <td>
                        <select name="eventStatCd" id="eventStatCd" class="w200 validate[required]">
                            <frame:select grpCd="${adminConstants.EVENT_STAT}" selectKey="${vo.eventStatCd}" useYn="${adminConstants.COMM_YN_Y}"/>
                        </select>
                    </td>
                </tr>

                <!-- 응모 기간 , 당첨일 -->
                <tr>
                    <th>이벤트 기간<span class="red">*</span></th>
                    <td colspan="3">
                        <frame:datepicker startDate="aplStrtDt"
                                          startHour="aplStrtHr"
                                          startMin="aplStrtMn"
                                          startSec="aplStrtSec"
                                          endDate="aplEndDt"
                                          endHour="aplEndHr"
                                          endMin="aplEndMn"
                                          endSec="aplEndSec"
                                          startValue="${vo.aplStrtDtm}"
                                          endValue="${vo.aplEndDtm}"
                                          period="30" />
                    </td>
                </tr>

                <!--당첨자 발표일 -->
                <tr>
                    <th>당첨자 발표일</th>
                    <td colspan="3">
                        <frame:datepicker startDate="winDt" startValue="${vo.winDt}"/>
                    </td>
                </tr>

                <!-- 썸네일 이미지 -->
                <tr>
                    <th>
                        썸네일<span class="red">*</span>
                    </th>
                    <td colspan="3">
                        <div class="inner" style="display:flex;">
                            <img id="dlgtImgView" name="dlgtImgView" src="${frame:imagePath(vo.dlgtImgPath)}" class="thumb" alt="썸네일" />

                            <div style="margin-top:55px;display:flex;">
                                <div class="inner ml10">
                                    <button type="button" id="dlgtImgAddBtn" class="btn">수정</button> <!-- 찾기-->
                                    <button type="button" name="thumnailDelBtn" onclick="fnDeleteImage('dlgtImg');" id="dlgtImgDelBtn" class="btn">삭제</button> <!-- 삭제 -->
                                </div>

                                <p class="img-notice ml10" style="font-size:2px;"><span class="red" style="font-size:inherit;">배너사이즈 : 가로 900</span>(gif,png,jpg,jpeg)</p>
                                <input type="text" class="validate[required]" id="dlgtImgPath" name="dlgtImgPath"  value="${vo.dlgtImgPath}" style="visibility:hidden;" />
                                <input type="text" name="orgDlgtImgPath"  value="${vo.dlgtImgPath}" style="visibility:hidden;" />
                            </div>
                        </div>
                    </td>
                </tr>

                <!-- 내용 -->
                <tr>
                    <th>내용</th>
                    <td colspan="3">
                        <div class="mTitle">
                            <h3 class="center">HTML Editor</h3>
                        </div>
                        <textarea name="content" id="content" style="width:100%;">${vo.content}</textarea>
                    </td>
                </tr>

                <!-- 참고 사항 -->
                <tr>
                    <th>참고 사항</th>
                    <td colspan="3">
                        <input type="text" class="event-dscrt w500" id="eventDscrt" name="eventDscrt" value="${vo.eventDscrt}"/>
                    </td>
                </tr>

                <!-- 쿠폰 -->
                <tr>
                    <th>쿠폰</th>
                    <td colspan="3">
                        <input type="text" class="w200 readonly" name="cpNm" id="cpNm" value="${vo.cpNm}" readonly/>
                        <input type="hidden" class="w200 readonly" name="cpNo" id="cpNo" value="${vo.cpNo}"/>
                        <button type="button" class="btn ml10" onclick="fnCouponLayer();">쿠폰 검색</button>
                    </td>
                </tr>

                <tr>
                    <th>댓글 사용 여부</th>
                    <td colspan="3">
                        <frame:radio name="aplyUseYn" grpCd="${adminConstants.COMM_YN}" selectKey="${vo.aplyUseYn}" />
                    </td>
                </tr>

                <!-- S : 응모형 일 때, 구분 처리 항목 -->

                <!--팝업 상단 이미지(PC/MO) -->
                <tr>
                    <th>팝업 상단 이미지(PC)<span class="red">*</span></th>
                    <td>
                        <div class="inner" style="display:flex;">
                            <img id="pcImgView" name="pcImgView" src="${empty vo.pcImgPath ? '/images/noimage.png' : vo.pcImgPath}" class="thumb" alt="PC 상단 이미지" />
                            <div style="margin-top:55px;display:flex;">
                                <div class="inner ml10">
                                    <button type="button" onclick="fileUpload.goodsImage(fnResultImage,'pcImg');" class="btn">등록</button> <!-- 찾기-->
                                    <button type="button" name="pcImgDelBtn" onclick="fnDeleteImage('pcImg');" id="pcImgDelBtn" class="btn" style="display:none;">삭제</button> <!-- 삭제 -->
                                </div>
                                <input type="text" class="validate[required]" id="pcImgPath" name="pcImgPath"  value="${vo.pcImgPath}" style="visibility:hidden;" />
                            </div>
                        </div>
                    </td>

                    <th>팝업 상단 이미지(MO)<span class="red">*</span></th>
                    <td>
                        <div class="inner" style="display:flex;">
                            <img id="moImgView" name="moImgView" src="${empty vo.moImgPath ? '/images/noimage.png' : vo.moImgPath}" class="thumb" alt="PC 상단 이미지" />
                            <div style="margin-top:55px;display:flex;">
                                <div class="inner ml10">
                                    <button type="button" onclick="fileUpload.goodsImage(fnResultImage,'moImg');" class="btn">등록</button> <!-- 찾기-->
                                    <button type="button" name="moImgDelBtn" onclick="fnDeleteImage('moImg');" id="moImgDelBtn" class="btn" style="display:none;">삭제</button> <!-- 삭제 -->
                                </div>
                                <input type="text" class="validate[required]" id="moImgPath" name="moImgPath"  value="${vo.moImgPath}" style="visibility:hidden;" />
                            </div>
                        </div>
                    </td>
                </tr>

                <!--참여 시 로그인 여부 -->
                <tr>
                    <th>참여 시 로그인 여부</th>
                    <td colspan="3">
                        <frame:radio name="loginRqidYn" grpCd="${adminConstants.COMM_YN}" selectKey="${vo.loginRqidYn}" />
                    </td>
                </tr>

                <tr>
                    <th>퀴즈 등록<span class="red">*</span></th>
                    <td colspan="3">
                        <div class="mt10" id="quiz-div" style="display:inline-block;">
                            <!-- s :  +,- 버튼 div -->
                            <div class="buttonArea mt10" style="float:left;">
                                <button type="button" onclick="quiz.append();" class="btn">+</button>
                                <button type="button" onclick="quiz.remove();" class="btn">-</button>
                            </div>
                            <!-- e : 버튼 div -->

                            <!-- s : 퀴즈 등록 div -->
                            <div class="quiz-ul ml5" style="width:80%;float:left;">
                                <table class="table_sub mt10 quiz-li">
                                    <colgroup>
                                        <col width="25%"/>
                                        <col width="10%"/>
                                        <col width="40%"/>
                                        <col width="*" />
                                    </colgroup>
                                    <tbody class="quiz-body">
                                    <tr>
                                        <!-- 질문 -->
                                        <th rowspan="2" style="vertical-align:top;">
                                            <select class="w150" name="qstTpCd" onchange="quiz.onchange(this);">
                                                <frame:select grpCd="${adminConstants.QST_TP_CD}" selectKey="${adminConstants.QST_TP_10}"  />
                                            </select>
                                        </th>
                                        <th>질문</th>
                                        <td>
                                            <input type="text" class="w200 ml10" name="qstNm" value="" placeholder="" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <!-- 답변 -->
                                        <th>답변</th>
                                        <td>
                                            <div class="rpl-innerTd">
                                                <div class="buttonArea ml10 mt5" style="float:left;">
                                                    <button type="button" onclick="quiz.addEle(this);" class="btn">+</button>
                                                    <button type="button" onclick="quiz.delEle(this);" class="btn">-</button>
                                                    <input type="text" name="rplCnt" value=1 style="width:0px;visibility:hidden;"/>
                                                </div>
                                                <div class="ml10 rpl-ul" style="float:left;">
                                                    <dl>
                                                        <input type="text" name="rghtansYns" value="true" style="visibility:hidden;width:0px;" />
                                                        <label class="fCheck mt5">
                                                            <input type="checkbox" class="mt5" id="" name="" title="" checked="checked" value="true" /> <span>1.</span>
                                                            <input type="text" class="validate[required] w20 mt5" name="rplContents" value="" />
                                                        </label>
                                                    </dl>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!-- e : 퀴즈 등록 div -->
                        </div>
                    </td>
                </tr>

                <!--수집 항목 -->
                <tr>
                    <th>수집항목<span class="red">*</span></th>
                    <td colspan="3">
                        <frame:checkbox name="collectItemCd" grpCd="${adminConstants.EVENT_CLCT_ITEM_CD}" checkedArray="${adminConstants.EVENT_CLCT_ITEM_NAME}"/>
                        <input type="text" class="validate[required]" id="clctItemCd_check" value="$${adminConstants.EVENT_CLCT_ITEM_NAME}" style="visibility:hidden" />
                    </td>
                </tr>

                <!-- E : 응모형 일 때, 구분 처리 항목 -->

                <!-- SEO 정보 번호 -->
                <tr>
                    <th>SEO 정보번호</th>
                    <td colspan="3">
                        <div class="buttonArea" id="seoNoBtnArea">
                            <input type="hidden" class="validate[required] readonly w100" name="seoInfoNo" id="seoInfoNo" value="${vo.seoInfoNo}" readonly/>
                            <button type="button" class="btn" onclick="fnSeoInfoLayer();">SEO 정보 설정</button>
                        </div>
                    </td>
                </tr>

                <tr>
                    <th>추가 필드</th>
                    <td colspan="3">
                        <div class="add-field-div" id="add-field-div" style="display:flex;">
                            <!-- s :  +,- 버튼 div -->
                            <button type="button" onclick="field.append();" class="btn mt10" style="height:40%;">+</button>
                            <button type="button" onclick="field.remove();" class="btn mt10 ml5" style="height:40%;">-</button>
                            <!-- e : 버튼 div -->

                            <!-- s : 추가 필드 항목 div -->
                            <div class="mb10 ml10 addField-ul">
                                <table class="table_sub mt10 addField-li" style="width:70%">
                                    <colgroup>
                                        <col width="20%"/>
                                        <col width="10%"/>
                                        <col width="43%"/>
                                        <col width="*"/>
                                    </colgroup>
                                    <tbody>
                                    <tr>
                                        <th rowspan="2" style="vertical-align:top;">
                                            <select class="w100" name="fldTpCd" onchange="field.onchange(this);">
                                                <option value="00" selected>선택</option>
                                                <frame:select grpCd="${adminConstants.FLD_TP_CD}" />
                                            </select>
                                        </th>
                                        <!-- 필드명 -->
                                        <th>필드명</th>
                                        <td>
                                            <input type="text" class="w200" placeholder="선택,한줄 입력, 여러줄 입력" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>설명</th>
                                        <td><textarea name="fldDscrt" style="width:90%;"></textarea></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!-- e : 추가 필드 항목 div -->
                        </div>
                    </td>
                </tr>
            </table>
        </form>

        <div class="btn_area_center">
            <button type="button" class="btn btn-add" onclick="fnUpdateEvent();">수정</button>
            <button type="button" class="btn btn-ok" onclick="fnInitBtnOnClick();">초기화</button>
            <button type="button" class="btn btn-cancle" onclick="closeTab();">취소</button>
        </div>
    </t:putAttribute>
</t:insertDefinition>