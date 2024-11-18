<t:insertDefinition name="contentsLayout">
    <t:putAttribute name="script">
        <script src="/js/event.js"></script>
        <script type="text/javascript">
            var $hideColumn = null;
            //최초 화면 초기화
            function fnOnLoadDocument(){
                setCommonDatePickerEvent("#aplStrtDt","#aplEndDt");

                $("[name='eventGbCd'][usrDfn1Val='${adminConstants.EVENT_TP_20}']").parent().hide();
                EditorCommon.setSEditor('content','${adminConstants.EVENT_IMAGE_PATH}');
                $hideColumn.parents("tr").hide();

                $("#collectItemCd10").prop("checked",true);

                $("[name='aplStrtDt']").data("origin",$("[name='aplStrtDt']").val());
                $("[name='aplStrtHr']").data("origin",$("[name='aplStrtHr'] option:selected").val());
                $("[name='aplStrtMn']").data("origin",$("[name='aplStrtDt'] option:selected").val());
                $("[name='aplEndDt']").data("origin",$("[name='aplEndDt']").val());
                $("[name='aplEndHr']").data("origin",$("[name='aplEndHr'] option:selected").val());
                $("[name='aplEndMn']").data("origin",$("[name='aplEndMn'] option:selected").val());

                field.init();
                quiz.init();
            }

            //이벤트 등록
            function fnInsertEvent(){
                if(isInsert()){
                    var data = $("#eventInsertForm").serializeJson();
                    data.quizJsonStr = quiz.serializeJson().length != 0 ? JSON.stringify(quiz.serializeJson()) : "";
                    data.addFieldJsonStr = field.serializeJson().length != 0 ? JSON.stringify(field.filterData(field.serializeJson())) : "";
                    data.aplStrtDtm = getDateStr("aplStrt");
                    data.aplEndDtm = getDateStr("aplEnd");
                    console.dir(data);
                    var options = {
                            url : "<spring:url value='/event/eventInsert.do' />"
                        ,   data : data
                        ,   callBack : function(result){
                                //closeGoTab("이벤트 상세", "/event/eventDetailView.do?eventNo="+result.eventNo);
                                closeGoTab('이벤트 목록', '/event/eventListView.do');
                        }
                    };
                    ajax.call(options);
                }
            }

            //유효성 검사
            function isInsert(){
                oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
                var isInsert = $("[name='eventGbCd']:checked").val() === "${adminConstants.EVENT_GB_50}" ? validate.check("eventInsertForm") & quiz.validation(quiz.serializeJson())
                    : validate.check("eventInsertForm");
                return isInsert;
            }

            //초기화 버튼 클릭
            function fnInitBtnOnClick(){
                $("#eventTpCd10").trigger("click");
                resetForm("eventInsertForm");

                var $dt_input = $("[name='aplStrtDt'] , [name='aplEndDt']");
                var $dt_select = $("[name='aplStrtHr'] , [name='aplStrtMn'] , [name='aplEndHr'] , [name='aplEndMn']");
                $dt_input.val($dt_input.data("origin"));
                $dt_select.find("option").prop("selected",false);
                $dt_select.find("option[value='"+$dt_select.data("origin")+"']").prop("selected",true);

                $("html").scrollTop(0);
            }

            $(function(){
                $hideColumn = $("#pcImgView , #moImgView, input[name='collectItemCd'] , [name='collectItemCd']" +
                    ", #add-field-div , #quiz-div , [name='winDt']");
                fnOnLoadDocument();
				$(".se2_inputarea").height("700px");
                //이벤트 유형,구분 변경 이벤트
                $(document).on("change","[name='eventTpCd']",function(){
                    $("[name='eventGbCd']").prop("checked",false);
                    var eventTpCd = $("[name='eventTpCd']:checked").val();

                    $("[name='eventGbCd']").not("[usrDfn1Val='"+eventTpCd+"']").parent().hide();
                    $("[name='eventGbCd'][usrDfn1Val='"+eventTpCd+"']").parent().show();
                    $("[name='eventGbCd']:visible").eq(0).prop("checked",true);

                    eventTpCd == "${adminConstants.EVENT_TP_10}" ? $hideColumn.parents("tr").hide() : $hideColumn.parents("tr").show();
                    $("[name='eventGbCd']").trigger("change");
                }).on("change","[name='eventGbCd']",function(){
                    var eventGbCd = $("[name='eventGbCd']:checked").val();
                    var $hideColumn =  $("#quiz-div");
                    eventGbCd == "${adminConstants.EVENT_GB_30}" ? $hideColumn.parents("tr").show() : $hideColumn.parents("tr").hide();
                });

                //썸네일
                $(document).on("click","#dlgtImgAddBtn",function(){
                    var limitObj = {
                           width : thumbnailMaxWidth
                    };
                    fileUpload.imageCheck(fnResultImage,'dlgtImg',limitObj);
                })

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

                //최대 100자 입력 방지
                $(document).on("change paste input","#ttl ,#eventSubNm , #eventBnfts",function(){
                    var maxLength = 100;
                    var txt = $(this).val();
                    $(this).val(txt.substring(0,maxLength));
                });
            })
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <form id="eventInsertForm">
            <table class="table_type1">
                <tr>
                    <th>이벤트 No.</th>
                    <td><input class="readonly w200" type="text" readonly="readonly" disabled placeholder="자동 입력"/></td>

                    <th>이벤트 유형<span class="red">*</span></th>
                    <td>
                        <frame:radio name="eventTpCd" grpCd="${adminConstants.EVENT_TP}" selectKey="${adminConstants.EVENT_TP_10}" useYn="${adminConstants.COMM_YN_Y}" />
                    </td>
                </tr>

                <!-- 이벤트 구분, 이벤트 타입 -->
                <tr>
                    <th>이벤트 구분<span class="red">*</span></th>
                    <td>
                        <frame:radio name="eventGbCd" grpCd="${adminConstants.EVENT_GB}" selectKey="${adminConstants.EVENT_GB_10}"
                                     useYn="${adminConstants.COMM_YN_Y}"/>
                    </td>

                    <th>이벤트 타입<span class="red">*</span></th>
                    <td>
                        <frame:radio name="eventGb2Cd" grpCd="${adminConstants.EVENT_GB2_CD}"
                                     selectKey="${adminConstants.EVENT_GB2_CD_10}"
                                     useYn="${commonConstants.COMM_YN_Y}" />
                    </td>
                </tr>

                <!-- 이벤트 타입 -->
                <tr>
                    <th>이벤트 명<span class="red">*</span></th>
                    <td>
                        <input type="text" class="validate[required] w200" id="ttl" name="ttl" value="" placeholder="이벤트 명을 입력해주세요." maxlength="100"/>
                        <label class="max100 red">(최대 100자)</label>
                    </td>

                    <!-- 이벤트 서브명-->
                    <th>이벤트 서브명 <span class="red">*</span></th>
                    <td>
                        <input type="text" class="w200 validate[required]" id="eventSubNm" name="eventSubNm" value="" placeholder="이벤트 서브명을 입력해주세요." maxlength="100" />
                        <label class="max100 red">(최대 100자)</label>
                    </td>
                </tr>

                <tr>
                    <!-- 이벤트 혜택-->
                    <th>이벤트 혜택<span class="red">*</span></th>
                    <td>
                        <input type="text" class="w200 validate[required]" id="eventBnfts" name="eventBnfts" value="" placeholder="이벤트 혜택을 입력해주세요." maxlength="100" />
                        <label class="max100 red">(최대 100자)</label>
                    </td>

                    <!-- 이벤트 상태 -->
                    <th>이벤트 상태<span class="red">*</span></th>
                    <td>
                        <select name="eventStatCd" id="eventStatCd" class="w200 validate[required] readonly" readonly="true" disabled>
                            <frame:select grpCd="${adminConstants.EVENT_STAT}" selectKey="${adminConstants.EVENT_STAT_10}" useYn="${adminConstants.COMM_YN_Y}"/>
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
                                          startValue="${strtDtm}"
                                          endValue="${endDtm}"
                                           />
                    </td>
                </tr>

                <!--당첨자 발표일 -->
                <tr>
                    <th>당첨자 발표일</th>
                    <td>
                        <frame:datepicker startDate="winDt"/>
                    </td>
                </tr>

                <!-- 썸네일 이미지 -->
                <tr>
                    <th>
                        썸네일<span class="red">*</span>
                    </th>
                    <td colspan="3">
                        <div class="inner" style="display:flex;">
                            <img id="dlgtImgView" name="dlgtImgView" src="/images/noimage.png" class="thumb" alt="썸네일" />

                            <div style="margin-top:55px;display:flex;">
                                <div class="inner ml10">
                                    <button type="button" id="dlgtImgAddBtn"  class="btn">등록</button> <!-- 찾기-->
                                    <button type="button" name="thumnailDelBtn" onclick="fnDeleteImage('dlgtImg');" id="dlgtImgDelBtn" class="btn" style="display:none;">삭제</button> <!-- 삭제 -->
                                </div>

                                <p class="img-notice ml10" style="font-size:2px;"><span class="red" style="font-size:inherit;">배너사이즈 가로 : 900</span>(gif,png,jpg,jpeg)</p>
                                <input type="text" class="validate[required]" id="dlgtImgPath" name="dlgtImgPath"  value="" style="visibility:hidden;" />
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
                        <textarea name="content" id="content"  style="width:100%; min-height:400px;"></textarea>
                    </td>
                </tr>

                <!-- 참고 사항 -->
                <tr>
                    <th>참고 사항</th>
                    <td colspan="3">
                        <input type="text" class="event-dscrt w500" id="eventDscrt" name="eventDscrt"/>
                    </td>
                </tr>

                <!-- 쿠폰 -->
                <tr>
                    <th>쿠폰</th>
                    <td colspan="3">
                        <input type="text" class="w200 readonly" name="cpNm" id="cpNm" readonly/>
                        <input type="hidden" class="w200 readonly" name="cpNo" id="cpNo"/>
                        <button type="button" class="btn ml10" onclick="fnCouponLayer();">쿠폰 검색</button>
                    </td>
                </tr>

                <tr>
                    <th>댓글 사용 여부</th>
                    <td colspan="3">
                       <frame:radio name="aplyUseYn" grpCd="${adminConstants.COMM_YN}" selectKey="${adminConstants.COMM_YN_Y}" />
                    </td>
                </tr>

                <!-- S : 응모형 일 때, 구분 처리 항목 -->

                <!--팝업 상단 이미지(PC/MO) -->
                <tr>
                    <th>팝업 상단 이미지(PC)<span class="red">*</span></th>
                    <td>
                        <div class="inner" style="display:flex;">
                            <img id="pcImgView" name="pcImgView" src="/images/noimage.png" class="thumb" alt="PC 상단 이미지" />
                            <div style="margin-top:55px;display:flex;">
                                <div class="inner ml10">
                                    <button type="button" onclick="fileUpload.goodsImage(fnResultImage,'pcImg');" class="btn">등록</button> <!-- 찾기-->
                                    <button type="button" name="pcImgDelBtn" onclick="fnDeleteImage('pcImg');" id="pcImgDelBtn" class="btn" style="display:none;">삭제</button> <!-- 삭제 -->
                                </div>
                                <input type="text" class="validate[required]" id="pcImgPath" name="pcImgPath"  value="" style="visibility:hidden;" />
                            </div>
                        </div>
                    </td>

                    <th>팝업 상단 이미지(MO)<span class="red">*</span></th>
                    <td>
                        <div class="inner" style="display:flex;">
                            <img id="moImgView" name="moImgView" src="/images/noimage.png" class="thumb" alt="PC 상단 이미지" />
                            <div style="margin-top:55px;display:flex;">
                                <div class="inner ml10">
                                    <button type="button" onclick="fileUpload.goodsImage(fnResultImage,'moImg');" class="btn">등록</button> <!-- 찾기-->
                                    <button type="button" name="moImgDelBtn" onclick="fnDeleteImage('moImg');" id="moImgDelBtn" class="btn" style="display:none;">삭제</button> <!-- 삭제 -->
                                </div>
                                <input type="text" class="validate[required]" id="moImgPath" name="moImgPath"  value="" style="visibility:hidden;" />
                            </div>
                        </div>
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
                                            <input type="text" class="w200 ml10 validate[required]" name="qstNm" value="" placeholder="" />
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
                            <input type="text" class="validate[required] readonly w100" name="seoInfoNo" id="seoInfoNo" readonly/>
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
            <button type="button" class="btn btn-add" onclick="fnInsertEvent();">등록</button>
            <button type="button" class="btn btn-ok" onclick="fnInitBtnOnClick();">초기화</button>
            <button type="button" class="btn btn-cancle" onclick="closeTab();">취소</button>
        </div>
    </t:putAttribute>
</t:insertDefinition>