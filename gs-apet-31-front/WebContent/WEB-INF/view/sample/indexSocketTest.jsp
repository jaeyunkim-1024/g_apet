<tiles:insertDefinition name="default">
    <tiles:putAttribute name="script.inline">
        <script type="text/javascript">
            function fnCallSocket(){
                var sendMsg = $("form:visible").serializeJson();
                console.dir(sendMsg);
                sendMsg.dealGbCd = parseInt(sendMsg.dealGbCd);
                sendMsg.dealAmt = parseInt(sendMsg.dealAmt);
                sendMsg.useMpPnt = parseInt(sendMsg.useMpPnt);

                var options = {
                        url : "/sample/socket-open"
                    ,   data : sendMsg
                    ,   done : function(result){
                            var txt = JSON.stringify(result);
                            $("#result").empty();
                            $("#result").text(txt);
                    }
                };
                ajax.call(options);
            }

            function fnCallSample(){
                var sample = $("#sample").val();
                var options = {
                    url : "/sample/socket-open"
                    ,   data : {sample : sample}
                    ,   done : function(result){
                        var txt = JSON.stringify(result);
                        $("#result").empty();
                        $("#result").text(txt);
                    }
                };
                ajax.call(options);
            }

            $(function(){
                $(document).on("change","#mpSelect",function(){
                    var id = $("#mpSelect option:selected").val();
                    var $form = $("#"+id);
                    $("form").not($form).hide();
                    $form.show();
                });
            })
        </script>
    </tiles:putAttribute>
    <tiles:putAttribute name="content">
        <style>
            form table tr td{padding-left:10px;}
        </style>
        <div class="mt30 ml30">
            <table>
                <colgroup>
                    <col width="50%" />
                    <col />
                </colgroup>
                <thead>
                    <tr>
                        <th scope="col">카드 번호</th>
                        <th scope="col">CI 값</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th>
                            2490276205902510
                        </th>
                        <td>
                            /G5KfgRKyGq1oS0NW8tyS2Mf22hD1BfNJc4CbkTweSnsuxhzQE6iXdyLOfpTeeSdnAttNGDreVQfZZpumm3WIw==
                        </td>
                    </tr>
                    <tr>
                        <th>
                            2144217356372022
                        </th>
                        <td>
                            AXmK/UL/BngtC1A0b/7Svm9yco6Htm/SHUpowb5GbWj8BsWRBVeXBDdXmvfScXFCmclDbygi+HLYNI8z2sNSnQ==
                        </td>
                    </tr>
                    <tr>
                        <th>
                            2149889701902427
                        </th>
                        <td>
                            tarLwskRDJdqc1GbGro2sijMb+JX/hgLiMTGdBIqusfmRa6kgCZx1Nhj8xtyrh7CsWiIXe6nyqunqLEAOhczrQ==
                        </td>
                    </tr>
                    <tr>
                        <th>
                            2831651763312513
                        </th>
                        <td>
                            VNFB8ynQf5F7SWSozE+dIdaqv2giS1WnzRnBatjZQDz/0DmavevwOQP8F3ycy4spuJIn1lRp544xa07VAQ6N+w==
                        </td>
                    </tr>
                    <tr>
                        <th>
                            2165555560882518
                        </th>
                        <td>
                            vTwNid8tu3Gi0hfGfKkoR5uB8F7wJQLJ4c21ICaGN1fh6vwyYRINaqpnv2ugAp+zFSSq6MhCwChdipH7wOcO1g==
                        </td>
                    </tr>
                    <tr>
                        <th>
                            2100387321800449
                        </th>
                        <td>
                            fZpb4K+cwKQZP1cmIVFuGvU78uTYg4k7UHUjNfqufEaCG0Lg0txQEOQEjbGiE5y4UhlO/pVrF35MSFZokTu4Tg==
                        </td>
                    </tr>

                </tbody>
            </table>
            <!--
                2490276205902510	/G5KfgRKyGq1oS0NW8tyS2Mf22hD1BfNJc4CbkTweSnsuxhzQE6iXdyLOfpTeeSdnAttNGDreVQfZZpumm3WIw==
                2144217356372022	AXmK/UL/BngtC1A0b/7Svm9yco6Htm/SHUpowb5GbWj8BsWRBVeXBDdXmvfScXFCmclDbygi+HLYNI8z2sNSnQ==
                2149889701902427	tarLwskRDJdqc1GbGro2sijMb+JX/hgLiMTGdBIqusfmRa6kgCZx1Nhj8xtyrh7CsWiIXe6nyqunqLEAOhczrQ==
                2831651763312513	VNFB8ynQf5F7SWSozE+dIdaqv2giS1WnzRnBatjZQDz/0DmavevwOQP8F3ycy4spuJIn1lRp544xa07VAQ6N+w==
                2165555560882518	vTwNid8tu3Gi0hfGfKkoR5uB8F7wJQLJ4c21ICaGN1fh6vwyYRINaqpnv2ugAp+zFSSq6MhCwChdipH7wOcO1g==
                2100387321800449	fZpb4K+cwKQZP1cmIVFuGvU78uTYg4k7UHUjNfqufEaCG0Lg0txQEOQEjbGiE5y4UhlO/pVrF35MSFZokTu4Tg==

                제휴사코드	가맹점코드
                V798	1001
            -->
            <h2>샘플 전문 자체 호출 시</h2>
            <div style="margin-bottom: 50px;">
                <input type="text" type="text" id="sample"  style="width:500px;" value=""/>
                <button class="btn" type="button" onclick="fnCallSample();">샘플 호출</button>
            </div>

            <h2>전문 생성 후 호출</h2>
            <div>
                <select id="mpSelect">
                    <option value="0500" data-desc="통합 승인 조회 전문" data-res="0510" selected>통합 승인/조회 전문</option>
                    <option value="0620" data-desc="통합 승인 취소 전문" data-res="0630">통합 승인 취소 전문</option>
                </select>
                <button class="btn" type="button" onclick="fnCallSocket();">소켓 호출</button>
            </div>
            <div style="margin-top:30px;">
                <form id="0500">
                    <table>
                        <tr>
                            <th>Message Type</th>
                            <td><input type="text"   name="msgType" value="0500"/></td>
                        </tr>
                        <tr>
                            <th>거래 구분</th>
                            <td>
                                <label class="radio">
                                    <input type="radio" name="dealGbCd" checked value="000010" id="appr">
                                    <span class="txt">승인 요청</span>
                                </label>
                                <label class="radio">
                                    <input type="radio" name="dealGbCd" value="000020" id="selec">
                                    <span class="txt">조회 요청</span>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <th>거래 금액</th>
                            <td>
                                <input type="text" name="dealAmt" value=""/>
                            </td>
                        </tr>
                        <tr>
                            <th>사용 금액</th>
                            <td>
                                <input type="text" name="useMpPnt" value=""/>
                            </td>
                        </tr>
                        <tr>
                            <th>전문 전송 일시</th>
                            <td>
                                <input type="text" name="msgSndDtm" value="" placeholder="YYYYMMDDhhmmss"/>
                            </td>
                        </tr>
                        <tr>
                            <th>카드 번호(전달 받은 테스트 카드번호)</th>
                            <td>
                                <input type="text" name="cartNum" value="2490276205902510"/>
                            </td>
                        </tr>
                        <tr>
                            <th>거래 고유 번호</th>
                            <td>
                                <input type="text" name="dealNum" value="" placeholder="67+고유번호 10자리"/>
                            </td>
                        </tr>
                        <tr>
                            <th>단말</th>
                            <td>
                                <input type="text" name="device" value="1000000000"/>
                            </td>
                        </tr>
                        <tr>
                            <th>상품 코드(default:공백 4개)</th>
                            <td>
                                <input type="text" name="goodsType" value="8001"  />
                                <!-- 9101 , 8001-->
                            </td>
                        </tr>
                        <tr>
                            <th>사용자 ID 구분 코드</th>
                            <td>
                                <input type="text" name="userIdGbCd" value="08"/>
                                <!--
                                        00’ or  ‘  ‘ -> 사용자 ID  CHECK NO (아무것도 체크하지않음)
                                        ‘01’ ->  OTB
                                        ‘02’ ->  PIN & OTB
                                        ‘03’ ->  CI & OTB
                                        ‘04’ ->  연계정보(CI) (88 byte) & PIN & OTB
                                        ‘05’ ->  리얼멤버십카드번호
                                        ‘06’ ->  PIN & 리얼멤버십카드번호
                                        ‘07’ -> 연계정보(CI) (88 byte) & 리얼멤버십카드번호
                                        ‘08’ -> 연계정보(CI) (88 byte) & PIN & 리얼멤버십카드번호
                                        ‘09’ 미지정
                                        -->
                            </td>
                        </tr>
                        <tr>
                            <th>사용자 ID(스페이스 처리)</th>
                            <td>
                                <input type="text" name="userId" value=" "  />
                            </td>
                        </tr>
                        <tr>
                            <th>PIN 넘버</th>
                            <td>
                                <input type="text" name="pinNum" value="123456"  />
                            </td>
                        </tr>
                        <tr>
                            <th>통화 코드</th>
                            <td>
                                <input type="text" name="currNum" value="410"  />
                            </td>
                        </tr>
                        <tr>
                            <th>주민번호 연계정보</th>
                            <td>
                                <input type="text" name="ifInfo" value="/G5KfgRKyGq1oS0NW8tyS2Mf22hD1BfNJc4CbkTweSnsuxhzQE6iXdyLOfpTeeSdnAttNGDreVQfZZpumm3WIw=="/>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <form id="0620">

            </form>
        </div>

        <div class="mt30 ml30">
            <textarea id="result" style="height:auto;width:300px;"></textarea>
        </div>
    </tiles:putAttribute>
</tiles:insertDefinition>