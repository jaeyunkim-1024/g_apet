<tiles:insertDefinition name="default">
    <tiles:putAttribute name="script.inline">
        <script type="text/javascript">
                //MEMBER_BASE 정보 조회
                function fnGetMember(){
                    if($("#mbrNo1").val() == "" && $("#gsptNo1").val() == ""){
                        $("#mbrGetResult").text("회원 번호 혹은 고객번호 입력");
                        return;
                    }

                    var options = {
                            url : "/gsr/getMemberBase"
                        ,   data : $("#searchList").serializeJson()
                        ,   done :  function(result){
                                var mb = result.mb;
                                var gs = result.gs;

                                $("#mbrGetResult").text(JSON.stringify(mb));
                                $("#gsGetResult").text(JSON.stringify(gs));
                        }
                    };
                    ajax.call(options);
                }

                //정보 set
                function fnSetGsrJoinCheckInfo(){
                    var data = JSON.parse($("#mbrGetResult").text());
                    for(var key in data){
                        $("#joinCheckList").find("[name='"+key+"']").val(data[key]);
                    }
                }
                function fnSetGsrJoinInfo(){
                    var data = JSON.parse($("#mbrGetResult").text());
                    for(var key in data){
                        $("#joinList").find("[name='"+key+"']").val(data[key]);
                    }
                }

                //GSR 포인트 조회
                function fnGetPoint(){
                    if($("#mbrNo2").val() == "" && $("#gsptNo2").val() == ""){
                        $("#pointResult").text("회원 번호 혹은 고객번호 입력");
                        return;
                    }
                    var options = {
                            url : "/gsr/getGsrMemberPoint"
                        ,   data : {mbrNo : $("#mbrNo2").val() , custNo : $("#gsptNo2").val() }
                        ,   done : function(result){
                                $("#pointResult").text(JSON.stringify(result));
                        }
                    };
                    ajax.call(options);
                }

                //가입 여부
                function fnGsIsJoin(){
                    var data = $("#joinCheckList").serializeJson();
                    var options = {
                            url : "/gsr/isGsrJoin"
                        ,   data: data
                        ,   done : function(result){
                                $("#joinCheckList").find("textarea").text(JSON.stringify(result));
                        }
                    };
                    ajax.call(options);
                }

                //회원 등록
                function fnGsRegister(){
                    var data = $("#joinList").serializeJson();
                    var options = {
                        url : "/gsr/joinToGsr"
                        ,   data: data
                        ,   done : function(result){
                            $("#joinList").find("textarea").text(JSON.stringify(result));
                        }
                    };
                    ajax.call(options);
                }

                //포인트 사용 적립
                function fnUseAccumPoint(){
                    var data = $("#useAccumPoint").serializeJson();
                    var url = data.url;
                    var options = {
                            url : data.url
                        ,   data : data
                        ,   done : function(result){
                                $("#useAccumPoint").find("textarea").text(JSON.stringify(result));
                        }
                    };
                    ajax.call(options);
                }
                //포인트 사용 적립 취소
                function fnUseAccumCancelPoint(){
                    var data = $("#useAccumCancelList").serializeJson();
                    var url = data.url;
                    var options = {
                            url : data.cancelUrl
                        ,   data : data
                        ,   done : function(result){
                                $("#useAccumCancelList").find("textarea").text(JSON.stringify(result));
                        }
                    };
                    ajax.call(options);
                }



                //긴급 -> JSON 파일로 업데이트
                function fnCorrection(){
                    var gsptNos = $("[name='gsptNos']").val();
                    var options = {
                            url : "/gsr/correction"
                        ,   data : { gsptNos : gsptNos }
                        ,   done : function(result){
                                $("#man").text(result.man.join());
                                $("#woman").text(result.woman.join());
                        }
                    };
                    ajax.call(options);
                }

               //연계 안 되어 있고, 인증했지만 성별 누락 - 이력으로 확인
                function fnCheck(){
                    var options = {
                        url : "/gsr/check"
                        ,   done : function(result){
                                alert(result.length);
                                var txt = "";
                                for(var i in result){
                                    txt += result[i].mbrNm + "," + result[i].mbrGrdNm + "," + result[i].mobile + "\n";
                                }
                                $("#jsonResult").text(txt);
                        }
                    };
                    ajax.call(options);
                }


                function petLogReViewPntAccum(){
                    var options = {
                            url : "/gsr/batch-accum"
                        ,   done : function(result){
                                console.dir(result);
                        }
                    };
                    ajax.call(options);
                }
        </script>
    </tiles:putAttribute>
    <tiles:putAttribute name="content">
        <style>
            .b-line .input input{width:30%;}
        </style>
        <main class="container page" id="container">
            <div class="inr">
                <!-- 본문 -->
                <div class="contents" id="contents">
                    <div class="fake-pop" style="width:40%;">
                        <div class="pct">
                            <div class="poptents">
                                <div class="member-input">
                                    <ul class="list" id="searchList">
                                        <li class="b-line">
                                            <strong class="tit"> * 회원 조회</strong>
                                            <div class="input flex tx-r">
                                                <input type="text" name="mbrNo" id="mbrNo1" placeholder="회원 번호" value="" style="margin-left:2%;height:10%;">
                                                <input type="text" name="gsptNo" ID="gsptNo1" placeholder="고객번호" value="" style="height:10%;">
                                                <a href="javascript:;" class="btn md" onclick="fnGetMember()">회원 조회</a>
                                            </div>
                                            <a href="javascript:;" class="btn md" onclick="fnSetGsrJoinCheckInfo();">가입 여부 정보 SET</a>
                                            <a href="javascript:;" class="btn md" onclick="fnSetGsrJoinInfo();">회원 등록 정보 SET</a>
                                            <strong class="tit"> * 회원 조회 응답</strong>
                                            <div class="textarea input">
                                                <textarea id="mbrGetResult"></textarea>
                                                <textarea style="margin-top:10px;" id="gsGetResult"></textarea>
                                            </div>
                                        </li>
                                    </ul>
                                    <ul class="list">
                                        <li class="b-line">
                                            <strong class="tit"> * 포인트 조회 파라미터</strong>
                                            <div class="input flex tx-r">
                                                <input type="text" name="custNo" id="gsptNo2" placeholder="고객번호" value="" style="height:10%;">
                                                <input type="text" name="mbrNo" id="mbrNo2" placeholder="회원 번호" value="" style="margin-left:2%;height:10%;">
                                                <a href="javascript:;" class="btn md" onclick="fnGetPoint();">포인트 조회</a>
                                            </div>
                                            <strong class="tit"> * 포인트 조회 응답</strong>
                                            <div class="textarea input">
                                                <textarea id="pointResult"></textarea>
                                            </div>
                                        </li>
                                    </ul>
                                    <ul class="list" style="margin-top:30px;" id="joinCheckList">
                                        <strong class="tit"> *회원 가입 여부</strong>
                                        <a href="javascript:;" class="btn md" onclick="fnGsIsJoin();">가입 여부</a>
                                        <li class="b-line" style="margin-top:20px;">
                                            <div class="input flex tx-r">
                                                <span class="tit">회원 번호 : </span>
                                                <input type="text" name="mbrNo" value="" style="height:10%;" />
                                            </div>
                                            <div class="input flex tx-r">
                                                <span class="tit">이름 : </span>
                                                <input type="text" name="mbrNm" value="" style="height:10%;" />
                                            </div>
                                            <div class="input flex tx-r">
                                                <span class="tit">핸드폰 번호 : </span>
                                                <input type="text" name="mobile" value="" style="height:10%;" />
                                            </div>
                                        </li>
                                        <li class="b-line">
                                            <div class="input flex tx-r">
                                                <span class="tit">생일 : </span>
                                                <input type="text" class="" name="birth" value="" style="height:10%;"/>
                                            </div>
                                        </li>
                                        <li class="b-line">
                                            <div class="input flex tx-r">
                                                <span class="tit">성별 : </span>
                                                <input type="text" class="" name="gdGbCd" value="" style="height:10%;"/>
                                            </div>
                                        </li>
                                        <li class="b-line">
                                            <div class="input flex tx-r">
                                                <span class="tit">CI : </span>
                                                <input type="text" class="" name="ciCtfVal" value="" style="height:10%;"/>
                                            </div>
                                        </li>
                                        <li class="b-line">
                                            <div class="textarea input">
                                                <textarea id=""></textarea>
                                            </div>
                                        </li>
                                    </ul>
                                    <ul class="list" id="joinList">
                                        <strong class="tit"> *회원 등록</strong>
                                        <a href="javascript:;" class="btn md" onclick="fnGsRegister();">가입</a>
                                        <li class="b-line" style="margin-top:20px;">
                                            <div class="input flex tx-r">
                                                <span class="tit">회원 번호 : </span>
                                                <input type="text" name="mbrNo" value="" style="height:10%;" />
                                            </div>
                                            <div class="input flex tx-r">
                                                <span class="tit">이름 : </span>
                                                <input type="text" name="mbrNm" value="" style="height:10%;" />
                                            </div>
                                            <div class="input flex tx-r">
                                                <span class="tit">핸드폰 번호 : </span>
                                                <input type="text" name="mobile" value="" style="height:10%;" />
                                            </div>
                                            <div class="input flex tx-r">
                                                <span class="tit">통신사 코드 : </span>
                                                <input type="text" name="mobileCd" value="" style="height:10%;" />
                                            </div>
                                        </li>
                                        <li class="b-line">
                                            <div class="input flex tx-r">
                                                <span class="tit">생일 : </span>
                                                <input type="text" class="" name="birth" value="" style="height:10%;"/>
                                            </div>
                                        </li>
                                        <li class="b-line">
                                            <div class="input flex tx-r">
                                                <span class="tit">성별 : </span>
                                                <input type="text" class="" name="gdGbCd" value="" style="height:10%;"/>
                                            </div>
                                        </li>
                                        <li class="b-line">
                                            <div class="input flex tx-r">
                                                <span class="tit">CI : </span>
                                                <input type="text" class="" name="ciCtfVal" value="" style="height:10%;"/>
                                            </div>
                                        </li>
                                        <li class="b-line">
                                            <div class="textarea input">
                                                <textarea id=""></textarea>
                                            </div>
                                        </li>
                                    </ul>
                                    <ul class="list" id="useAccumList">
                                        <li class="b-line">
                                            <strong class="tit"> 포인트 사용/적립</strong>
                                            <a href="javascript:;" class="btn md" onclick="fnUseAccumPoint();">포인트 사용/적립</a>
                                            <div class="input flex tx-r">
                                                <ul class="list" id="useAccumPoint">
                                                    <li class="b-line">
                                                        <div class="input flex tx-r">
                                                            <label>
                                                                <span>포인트 사용</span>
                                                                <input type="radio" class="" name="url" value="/gsr/useGsPoint" checked />
                                                            </label>
                                                            <label>
                                                                <span>포인트 적립</span>
                                                                <input type="radio" class="" name="url" value="/gsr/accumGsPoint" checked />
                                                            </label>
                                                        </div>
                                                    </li>
                                                    <li class="b-line">
                                                        <div class="input flex tx-r">
                                                            <span class="tit">고객 번호 : </span>
                                                            <input type="text" class="" name="custNo" value="" style="height:10%;"/>
                                                        </div>
                                                    </li>
                                                    <li class="b-line">
                                                        <div class="input flex tx-r">
                                                            <span class="tit">영수증 번호 : </span>
                                                            <input type="text" class="" name="rcptNo" value="" style="height:10%;"/>
                                                        </div>
                                                    </li>
                                                    <li class="b-line">
                                                        <div class="input flex tx-r">
                                                            <span class="tit">포인트 : </span>
                                                            <input type="text" class="" name="point" value="" style="height:10%;"/>
                                                        </div>
                                                    </li>
                                                    <li class="b-line">
                                                        <div class="input flex tx-r">
                                                            <span class="tit">판매 금액 : </span>
                                                            <input type="text" class="" name="saleAmt" value="" style="height:10%;"/>
                                                        </div>
                                                    </li>
                                                    <li class="b-line">
                                                        <div class="input flex tx-r">
                                                            <span class="tit">판매 일시(yyyyMMdd) : </span>
                                                            <input type="text" class="" name="saleDate" value="" style="height:10%;"/>
                                                        </div>
                                                    </li>
                                                    <li class="b-line">
                                                        <div class="input flex tx-r">
                                                            <span class="tit">판매 시간(HHmmss) : </span>
                                                            <input type="text" class="" name="saleEndDt" value="" style="height:10%;"/>
                                                        </div>
                                                    </li>
                                                    <li class="b-line">
                                                        <div class="textarea input">
                                                            <textarea id=""></textarea>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li>
                                    </ul>
                                    <ul class="list">
                                        <li class="b-line">
                                            <strong class="tit"> 포인트 사용/적립 취소</strong>
                                            <a href="javascript:;" class="btn md" onclick="fnUseAccumCancelPoint();">포인트 사용/적립 취소</a>
                                            <div class="input flex tx-r">
                                                <ul class="list" id="useAccumCancelList">
                                                    <li class="b-line">
                                                        <div class="input flex tx-r">
                                                            <label>
                                                                <span>포인트 사용 취소</span>
                                                                <input type="radio" class="" name="cancelUrl" value="/gsr/useCancelGsPoint" checked />
                                                            </label>
                                                            <label>
                                                                <span>포인트 적립 취소</span>
                                                                <input type="radio" class="" name="cancelUrl" value="/gsr/accumCancelGsPoint" />
                                                            </label>
                                                        </div>
                                                    </li>
                                                    <li class="b-line">
                                                        <div class="input flex tx-r">
                                                            <span class="tit">원 거래 번호 : </span>
                                                            <input type="text" class="" name="orgApprNo" value="" style="height:10%;"/>
                                                        </div>
                                                    </li>
                                                    <li class="b-line">
                                                        <div class="input flex tx-r">
                                                            <span class="tit">원 거래 일시 : </span>
                                                            <input type="text" class="" name="orgApprDate" value="" style="height:10%;"/>
                                                        </div>
                                                    </li>
                                                    <li class="b-line">
                                                        <div class="input flex tx-r">
                                                            <span class="tit">고객 번호 : </span>
                                                            <input type="text" class="" name="custNo" value="" style="height:10%;"/>
                                                        </div>
                                                    </li>
                                                    <li class="b-line">
                                                        <div class="input flex tx-r">
                                                            <span class="tit">영수증 번호 : </span>
                                                            <input type="text" class="" name="rcptNo" value="" style="height:10%;"/>
                                                        </div>
                                                    </li>
                                                    <li class="b-line">
                                                        <div class="input flex tx-r">
                                                            <span class="tit">포인트 : </span>
                                                            <input type="text" class="" name="point" value="" style="height:10%;"/>
                                                        </div>
                                                    </li>
                                                    <li class="b-line">
                                                        <div class="input flex tx-r">
                                                            <span class="tit">판매 금액 : </span>
                                                            <input type="text" class="" name="saleAmt" value="" style="height:10%;"/>
                                                        </div>
                                                    </li>
                                                    <li class="b-line">
                                                        <div class="input flex tx-r">
                                                            <span class="tit">판매 일시(yyyyMMdd) : </span>
                                                            <input type="text" class="" name="saleDate" value="" style="height:10%;"/>
                                                        </div>
                                                    </li>
                                                    <li class="b-line">
                                                        <div class="input flex tx-r">
                                                            <span class="tit">판매 시간(HHmmss) : </span>
                                                            <input type="text" class="" name="saleEndDt" value="" style="height:10%;"/>
                                                        </div>
                                                    </li>
                                                    <li class="b-line">
                                                        <div class="textarea input">
                                                            <textarea id=""></textarea>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li>
                                    </ul>

                                    <ul class="list">
                                        <button type="button" onclick="petLogReViewPntAccum()">포인트 일괄 지급</button>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </tiles:putAttribute>
</tiles:insertDefinition>