<tiles:insertDefinition name="default">
    <tiles:putAttribute name="script.inline">
        <script type="text/javascript">
            //특수문자, 특정문자열(sql예약어) 제거
            function checkSearchedWord(obj){
                obj.value = obj.value+" ";
                //특수문자 제거
                if(obj.value.length >0){
                    var expText = /[%=><]/ ;
                    if(expText.test(obj.value) == true){
                        obj.value = obj.value.split(expText).join("");
                    }
                    //체크 문자열
                    var sqlArray = new Array( //sql 예약어
                        "OR", "SELECT", "INSERT", "DELETE", "UPDATE", "CREATE", "DROP", "EXEC", "UNION",  "FETCH", "DECLARE", "TRUNCATE"
                    );

                    var regex;
                    var regex_plus ;
                    for(var i=0; i<sqlArray.length; i++){
                        regex = new RegExp("\\s" + sqlArray[i] + "\\s","gi") ;
                        if (regex.test(obj.value)) {
                            obj.value =obj.value.replace(regex, "");
                            alert("\"" + sqlArray[i]+"\"와(과) 같은 특정문자로 검색할 수 없습니다.");
                        }
                        regex_plus = new RegExp( "\\+" + sqlArray[i] + "\\+","gi") ;
                        if (regex_plus.test(obj.value)) {
                            obj.value =obj.value.replace(regex_plus, "");
                            alert("\"" + sqlArray[i]+"\"와(과) 같은 특정문자로 검색할 수 없습니다.");
                        }
                    }
                }

                return obj.value = obj.value;
            }

            //주소검색
            function searchUrlJuso(){
                $("#resultData").hide();
                var frm = document.AKCFrm;
                frm.keyword.value = checkSearchedWord(frm.keyword); // 특수문자 및 sql예약어 제거, 20160912
                $("#keyword").val(validateJuso($("#keyword").val())); //공백 및 특수문자 제거
                $("#keyword").val(regExpCheckJuso($("#keyword").val()));

                $.ajax({
                    url :"https://www.juso.go.kr/addrlink/addrLinkApiJsonp.do"  //인터넷망
                    ,type:"post"
                    ,data:$("#AKCFrm").serialize()
                    ,dataType:"jsonp"
                    ,crossDomain:true
                    ,success:function(xmlStr){
                        if(navigator.appName.indexOf("Microsoft") > -1){
                            var xmlData = new ActiveXObject("Microsoft.XMLDOM");
                            xmlData.loadXML(xmlStr.returnXml)
                        }else{
                            var xmlData = xmlStr.returnXml;
                        }
                        $(".popSearchNoResult").html("");
                        var errCode = $(xmlData).find("errorCode").text();
                        var errDesc = $(xmlData).find("errorMessage").text();

                        var totalCount = $(xmlData).find("totalCount").text();
                        var currentPage = $(xmlData).find("currentPage").text();

                        if( parseInt(totalCount) > 1000 && currentPage == "1" )
                            alert("검색 결과가 너무 많습니다(1,000건 이상)\n검색어 예를 참조하여 검색하시기 바랍니다.");

                        if(errCode != "0"){
                            alert(errDesc);
                        }else{
                            if(xmlStr != null){
                                makeList(xmlData);
                            }
                        }
                    }
                    ,error: function(xhr,status, error){
                        //alert("에러발생");
                        alert("검색에 실패하였습니다 \n 다시 검색하시기 바랍니다.");
                    }
                });

            }

            //검색결과
            function makeList(xmlStr){

                var htmlStr = "";
                if( $(xmlStr).find("totalCount").text() == "0" ){

                    htmlStr +=' ';
                    htmlStr += '<div class="popSearchNoResult" style="margin-top:10px; margin-bottom:5px;">';
                    htmlStr += '	검색된 내용이 없습니다.';
                    htmlStr += '</div>';
                    htmlStr +='';

                }else{

                    htmlStr += '<p class="text-guide">도로명주소 검색 결과 <strong>('+ $(xmlStr).find("totalCount").text()+'건)</strong></p>';
                    htmlStr += '<table class="data-col" style="margin-top:3px;">';
                    htmlStr += '	<caption>검색 결과</caption>';
                    htmlStr += '	<colgroup>';
                    htmlStr += '		<col style="width:8%">';
                    htmlStr += '		<col>';
                    htmlStr += '		<col style="width:11%">';
                    htmlStr += '		<col style="width:14%">';
                    htmlStr += '	</colgroup>';
                    htmlStr += '	<thead>';
                    htmlStr += '		<tr>';
                    htmlStr += '			<th scope="col">No</th>';
                    htmlStr += '			<th scope="col">도로명주소</th>';
                    htmlStr += '			<th scope="col">&nbsp;</th>';
                    htmlStr += '			<th scope="col">우편번호</th>';
                    htmlStr += '		</tr>';
                    htmlStr += '	</thead>';
                    htmlStr += '	<tbody>';

                    var currentPage = parseInt($(xmlStr).find("currentPage").text());
                    var countPerPage = parseInt($(xmlStr).find("countPerPage").text());
                    var listNum = (currentPage*countPerPage)-(--countPerPage);
                    var num = 0;
                    $(xmlStr).find("juso").each(function(){
                        num++;

                        var resultType = $("#resultType").val();

                        htmlStr += '<tr>';
                        htmlStr +='	<td class="subj" style="text-align:center;">'+(listNum++)+'</td>';

                        if( resultType == "1" ){

                            htmlStr += '	<td class="subj" colspan="2" id="roadAddrTd'+num+' style="text-align:left; padding-left: 5px; line-height: 0.5em;">';
                            htmlStr += '		<a href="javascript:setMaping(\''+num+'\')">';
                            htmlStr += '			<div tabindex="6">';
                            htmlStr += '				<div id="roadAddrDiv'+num+'"><b>'+$(this).find('roadAddr').text()+'</b></div>';
                            htmlStr += '			</div>';
                            htmlStr += '		</a>';
                            htmlStr += '		<span id="jibunAddrDiv'+num+'" style="display:none;">'+$(this).find('jibunAddr').text()+'</span>';
                            htmlStr +='		<div id="roadAddrPart1Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart1').text()+'</div>';
                            htmlStr +='		<div id="roadAddrPart2Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart2').text()+'</div>';
                            htmlStr +='		<div id="engAddrDiv'+num+'" style="display:none;">'+$(this).find('engAddr').text()+'</div>';
                            htmlStr += '	</td>';

                        }else if( resultType == "2" ){

                            htmlStr += '	<td class="subj" colspan="2" id="roadAddrTd'+num+' style="text-align:left; padding-left: 5px; line-height: 0.5em;">';
                            htmlStr += '		<a href="javascript:setMaping(\''+num+'\')">';
                            htmlStr += '			<div tabindex="6">';
                            htmlStr += '				<div id="roadAddrDiv'+num+'"><b>'+$(this).find('roadAddr').text()+'</b></div>';
                            htmlStr +='				<span style="font-size:11px;">[지번] <span id="jibunAddrDiv'+num+'">'+$(this).find('jibunAddr').text()+'</span></span>';
                            htmlStr += '			</div>';
                            htmlStr += '		</a>';
                            htmlStr +='		<div id="roadAddrPart1Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart1').text()+'</div>';
                            htmlStr +='		<div id="roadAddrPart2Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart2').text()+'</div>';
                            htmlStr +='		<div id="engAddrDiv'+num+'" style="display:none;">'+$(this).find('engAddr').text()+'</div>';
                            htmlStr += '	</td>';

                        }else if( resultType == "3" ){

                            htmlStr +='	<td class="subj" id="roadAddrTd'+num+' style="text-align:left; padding-left: 5px; line-height: 0.5em;">';
                            htmlStr +='		<a href="javascript:setMaping(\''+num+'\')">';
                            htmlStr +='			<div tabindex="6">';
                            htmlStr +='				<div id="roadAddrDiv'+num+'"><b>'+$(this).find('roadAddr').text()+'</b></div>';
                            htmlStr +='			</div>';
                            htmlStr +='		</a>';
                            htmlStr +='		<div id="detListDivX'+num+'" style="display:none;"><span style="font-size:11px;"> [상세건물명]'+$(this).find('detBdNmList').text()+' </span></div>';
                            htmlStr += '		<span id="jibunAddrDiv'+num+'" style="display:none;">'+$(this).find('jibunAddr').text()+'</span>';
                            htmlStr +='		<div id="roadAddrPart1Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart1').text()+'</div>';
                            htmlStr +='		<div id="roadAddrPart2Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart2').text()+'</div>';
                            htmlStr +='		<div id="engAddrDiv'+num+'" style="display:none;">'+$(this).find('engAddr').text()+'</div>';
                            htmlStr +='	</td>';
                            htmlStr +='	<td class="subj" style="text-align:center;">';
                            htmlStr +='		<div id="detDiv'+num+'" style="font-size:12px;">';
                            if($(this).find('detBdNmList').text() != ""){
                                htmlStr +='<a href="javascript:addrJuminRenew('+num+');">상세건물</br>보기</a>';
                            }
                            htmlStr +='		</div>';
                            htmlStr +='		<div id="detDivX'+num+'" style="display:none;"><a href="javascript:addrJuminRenewX('+num+');">닫기</a></div>';
                            htmlStr +='	</td>';

                        }else{

                            htmlStr +='	<td class="subj" id="roadAddrTd'+num+' style="text-align:left; padding-left: 5px; line-height: 0.5em;">';
                            htmlStr +='		<a href="javascript:setMaping(\''+num+'\')">';
                            htmlStr +='			<div tabindex="6">';
                            htmlStr +='				<div id="roadAddrDiv'+num+'"><b>'+$(this).find('roadAddr').text()+'</b></div>';
                            htmlStr +='				<span style="font-size:11px;">[지번] <span id="jibunAddrDiv'+num+'">'+$(this).find('jibunAddr').text()+'</span></span>';
                            htmlStr +='			</div>';
                            htmlStr +='		</a>';
                            htmlStr +='		<div id="detListDivX'+num+'" style="display:none;"><span style="font-size:11px;"> [상세건물명]'+$(this).find('detBdNmList').text()+' </span></div>';
                            htmlStr +='		<div id="roadAddrPart1Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart1').text()+'</div>';
                            htmlStr +='		<div id="roadAddrPart2Div'+num+'" style="display:none;">'+$(this).find('roadAddrPart2').text()+'</div>';
                            htmlStr +='		<div id="engAddrDiv'+num+'" style="display:none;">'+$(this).find('engAddr').text()+'</div>';
                            htmlStr +='	</td>';
                            htmlStr +='	<td class="subj" style="text-align:center;">';
                            htmlStr +='		<div id="detDiv'+num+'" style="font-size:12px;">';
                            if($(this).find('detBdNmList').text() != ""){
                                htmlStr +='<a href="javascript:addrJuminRenew('+num+');">상세건물</br>보기</a>';
                            }
                            htmlStr +='		</div>';
                            htmlStr +='		<div id="detDivX'+num+'" style="display:none;"><a href="javascript:addrJuminRenewX('+num+');">닫기</a></div>';
                            htmlStr +='	</td>';

                        }

                        htmlStr +='	<td class="subj" style="text-align:center" id="zipNoTd'+num+'"> ';
                        htmlStr +='		<div id="zipNoDiv'+num+'">'+$(this).find('zipNo').text()+'</div>';
                        htmlStr +='	</td>';
                        htmlStr +='	<input type="hidden" id="admCdHid'+num+'" value="'+$(this).find('admCd').text()+'">';
                        htmlStr +='	<input type="hidden" id="rnMgtSnHid'+num+'" value="'+$(this).find('rnMgtSn').text()+'">';
                        htmlStr +='	<input type="hidden" id="bdMgtSnHid'+num+'" value="'+$(this).find('bdMgtSn').text()+'">';
                        htmlStr +='	<input type="hidden" id="detBdNmListHid'+num+'" value="'+$(this).find('detBdNmList').text()+'"> ';
                        htmlStr +='	<input type="hidden" id="bdNmHid'+num+'" value="'+$(this).find('bdNm').text()+'"> ';
                        htmlStr +='	<input type="hidden" id="bdKdcdHid'+num+'" value="'+$(this).find('bdKdcd').text()+'"> ';
                        htmlStr +='	<input type="hidden" id="siNmHid'+num+'" value="'+$(this).find('siNm').text()+'">';
                        htmlStr +='	<input type="hidden" id="sggNmHid'+num+'" value="'+$(this).find('sggNm').text()+'"> ';
                        htmlStr +='	<input type="hidden" id="emdNmHid'+num+'" value="'+$(this).find('emdNm').text()+'"> ';
                        htmlStr +='	<input type="hidden" id="liNmHid'+num+'" value="'+$(this).find('liNm').text()+'"> ';
                        htmlStr +='	<input type="hidden" id="rnHid'+num+'" value="'+$(this).find('rn').text()+'"> ';
                        htmlStr +='	<input type="hidden" id="udrtYnHid'+num+'" value="'+$(this).find('udrtYn').text()+'">  ';
                        htmlStr +='	<input type="hidden" id="buldMnnmHid'+num+'" value="'+$(this).find('buldMnnm').text()+'">  ';
                        htmlStr +='	<input type="hidden" id="buldSlnoHid'+num+'" value="'+$(this).find('buldSlno').text()+'">  ';
                        htmlStr +='	<input type="hidden" id="mtYnHid'+num+'" value="'+$(this).find('mtYn').text()+'">  ';
                        htmlStr +='	<input type="hidden" id="lnbrMnnmHid'+num+'" value="'+$(this).find('lnbrMnnm').text()+'">   ';
                        htmlStr +='	<input type="hidden" id="lnbrSlnoHid'+num+'" value="'+$(this).find('lnbrSlno').text()+'">  ';
                        htmlStr +='	<input type="hidden" id="emdNoHid'+num+'" value="'+$(this).find('emdNo').text()+'">  ';
                        htmlStr +='</tr> ';
                    });

                    htmlStr += '	</tbody>';
                    htmlStr += "</table>";
                    htmlStr += '<div class="paginate" id="pageApi"></div>';
                }

                $(".popSearchNoResult").addClass("result");
                $(".popSearchNoResult").html(htmlStr);
                $(".result").show();
                $("#resultData").hide();
                $("#searchContentBox").css("height","");
                $("#searchContentBox").css("height","365px");

                pageMake(xmlStr);
            }

            // xml타입 페이지 처리 (주소정보 리스트 makeList(xmlData); 다음에서 호출)
            function pageMake(xmlStr){
                var total = $(xmlStr).find("totalCount").text(); // 총건수
                var pageNum =  $(xmlStr).find("currentPage").text();// 현재페이지
                var paggingStr = "";
                if(total < 1){
                }else{
                    var PAGEBLOCK= 10;
                    var pageSize= parseInt( $(xmlStr).find("countPerPage").text() );
                    var totalPages = Math.floor((total-1)/pageSize) + 1;
                    var firstPage = Math.floor((pageNum-1)/PAGEBLOCK) * PAGEBLOCK + 1;
                    if( firstPage <= 0 ) firstPage = 1;
                    var lastPage = firstPage-1 + PAGEBLOCK;
                    if( lastPage > totalPages ) lastPage = totalPages;
                    var nextPage = lastPage+1 ;
                    var prePage = firstPage-5 ;

                    if(totalPages > 1){
                        if( firstPage > PAGEBLOCK ){
                            paggingStr +=  "<a class='skip prev' href='javascript: $(\"#currentPage\").val("+prePage+");  searchUrlJuso();'>이전으로</a>  " ;
                        }
                        for( i=firstPage; i<=lastPage; i++ ){
                            if( pageNum == i )
                                paggingStr += "<strong>" + i + "</strong>  ";
                            else
                                paggingStr += "<a href='javascript:$(\"#currentPage\").val("+i+");  searchUrlJuso();'>" + i + "</a>  ";
                        }
                        if( lastPage < totalPages ){
                            paggingStr +=  "<a class='skip next' href='javascript: $(\"#currentPage\").val("+nextPage+");  searchUrlJuso();'>다음으로</a>";
                        }
                    }
                    $("#pageApi").html(paggingStr);
                }
            }

            // 검색주소 리턴
            function setParent(){
                var rtRoadAddr = $.trim($("#rtRoadAddr").val());
                var rtAddrPart1 = $.trim($("#rtAddrPart1").val());
                var rtAddrPart2 = $.trim($("#rtAddrPart2").val());
                var rtEngAddr = $.trim($("#rtEngAddr").val());
                var rtJibunAddr = $.trim($("#rtJibunAddr").val());
                var rtAddrDetail = $.trim($("#rtAddrDetail").val());
                var rtZipNo = $.trim($("#rtZipNo").val());
                var rtAdmCd = $.trim($("#rtAdmCd").val());
                var rtRnMgtSn = $.trim($("#rtRnMgtSn").val());
                var rtBdMgtSn = $.trim($("#rtBdMgtSn").val());
                var rtDetBdNmList = $.trim($("#rtDetBdNmList").val());
                var rtBdNm = $.trim($("#rtBdNm").val());
                var rtBdKdcd = $.trim($("#rtBdKdcd").val());
                var rtSiNm = $.trim($("#rtSiNm").val());
                var rtSggNm = $.trim($("#rtSggNm").val());
                var rtEmdNm = $.trim($("#rtEmdNm").val());
                var rtLiNm = $.trim($("#rtLiNm").val());
                var rtRn = $.trim($("#rtRn").val());
                var rtUdrtYn = $.trim($("#rtUdrtYn").val());
                var rtBuldMnnm = $.trim($("#rtBuldMnnm").val());
                var rtBuldSlno = $.trim($("#rtBuldSlno").val());
                var rtMtYn = $.trim($("#rtMtYn").val());
                var rtLnbrMnnm = $.trim($("#rtLnbrMnnm").val());
                var rtLnbrSlno = $.trim($("#rtLnbrSlno").val());
                var rtEmdNo = $.trim($("#rtEmdNo").val());

                var rtRoadFullAddr = rtAddrPart1;
                if(rtAddrDetail != "" && rtAddrDetail != null){
                    rtRoadFullAddr += ", " + rtAddrDetail;
                }
                if(rtAddrPart2 != "" && rtAddrPart2 != null){
                    rtRoadFullAddr += " " + rtAddrPart2;
                }

                var result = {
                    zonecode : rtZipNo, 			/*우편번호*/
                    roadAddress : rtRoadAddr, 		/*도로명주소 [서울특별시 강남구 논현로 508 (역삼동)]*/
                    roadAddressEnglish : rtEngAddr, /*영문 도로명주소 [508, Nonhyeon-ro, Gangnam-gu, Seoul]*/
                    jibunAddress : rtJibunAddr, 	/*지번주소 [서울특별시 강남구 역삼동 679 GS강남타워]*/
                    addrDetail : rtAddrDetail, 		/*고객입력 상세주소 [지하1층]*/
                    roadAddrPart1 : rtAddrPart1, 	/*도로명주소 [서울특별시 강남구 논현로 508]*/
                    roadAddrPart2 : rtAddrPart2, 	/*참고주소 [(역삼동)]*/
                    admCd : rtAdmCd, 				/*행정구역코드 [1168010100]*/
                    rnMgtSn : rtRnMgtSn, 			/*도로명코드 [116803121022]*/
                    bdMgtSn : rtBdMgtSn, 			/*건물관리번호 [1168010100106790001026822]*/
                    detBdNmList : rtDetBdNmList, 	/*상세건물명 []*/
                    bdNm : rtBdNm, 					/*건물명 [GS강남타워]*/
                    bdKdcd : rtBdKdcd, 				/*공동주택여부(1 : 공동주택, 0 : 비공동주택) [0]*/
                    siNm : rtSiNm, 					/*시도명 [서울특별시]*/
                    sggNm : rtSggNm, 				/*시군구명 [강남구]*/
                    emdNm : rtEmdNm, 				/*읍면동명 [역삼동]*/
                    liNm : rtLiNm, 					/*법정리명 []*/
                    rn : rtRn, 						/*도로명 [논현로]*/
                    udrtYn : rtUdrtYn, 				/*지하여부(0 : 지상, 1 : 지하) [0]*/
                    buldMnnm : rtBuldMnnm, 			/*건물본번 [508]*/
                    buldSlno : rtBuldSlno, 			/*건물부번 [0]*/
                    mtYn : rtMtYn, 					/*산여부(0 : 대지, 1 : 산) [0]*/
                    lnbrMnnm : rtLnbrMnnm, 			/*지번본번(번지) [679]*/
                    lnbrSlno : rtLnbrSlno, 			/*지번부번(호) [0]*/
                    emdNo : rtEmdNo, 				/*읍면동일련번호 [01]*/

                    <%--roadAddr : rtRoadAddr, 			/*전체 도로명주소 [서울특별시 강남구 논현로 508 (역삼동)]*/
                    roadAddrPart1 : rtAddrPart1, 	/*도로명주소 [서울특별시 강남구 논현로 508]*/
                    roadAddrPart2 : rtAddrPart2, 	/*참고주소 [(역삼동)]*/
                    addrDetail : rtAddrDetail, 		/*고객입력 상세주소 [지하1층]*/
                    engAddr : rtEngAddr, 			/*도로명주소(영문) [508, Nonhyeon-ro, Gangnam-gu, Seoul]*/
                    jibunAddr : rtJibunAddr, 		/*지번주소 [서울특별시 강남구 역삼동 679 GS강남타워]*/
                    zipNo : rtZipNo, 				/*우편번호 [06141]*/
                    admCd : rtAdmCd, 				/*행정구역코드 [1168010100]*/
                    rnMgtSn : rtRnMgtSn, 			/*도로명코드 [116803121022]*/
                    bdMgtSn : rtBdMgtSn, 			/*건물관리번호 [1168010100106790001026822]*/
                    detBdNmList : rtDetBdNmList, 	/*상세건물명 []*/
                    bdNm : rtBdNm, 					/*건물명 [GS강남타워]*/
                    bdKdcd : rtBdKdcd, 				/*공동주택여부(1 : 공동주택, 0 : 비공동주택) [0]*/
                    siNm : rtSiNm, 					/*시도명 [서울특별시]*/
                    sggNm : rtSggNm, 				/*시군구명 [강남구]*/
                    emdNm : rtEmdNm, 				/*읍면동명 [역삼동]*/
                    liNm : rtLiNm, 					/*법정리명 []*/
                    rn : rtRn, 						/*도로명 [논현로]*/
                    udrtYn : rtUdrtYn, 				/*지하여부(0 : 지상, 1 : 지하) [0]*/
                    buldMnnm : rtBuldMnnm, 			/*건물본번 [508]*/
                    buldSlno : rtBuldSlno, 			/*건물부번 [0]*/
                    mtYn : rtMtYn, 					/*산여부(0 : 대지, 1 : 산) [0]*/
                    lnbrMnnm : rtLnbrMnnm, 			/*지번본번(번지) [679]*/
                    lnbrSlno : rtLnbrSlno, 			/*지번부번(호) [0]*/
                    emdNo : rtEmdNo, 				/*읍면동일련번호 [01]*/--%>
                };

                // IE에서 opener관련 오류가 발생하는 경우, 부모창에서 지정한 이름으로 opener를 재정의
                if(opener == null || opener == undefined) opener = window.open("", "jusoPopup");

                opener.<c:out value="${param.callBackFnc}" />(result);
                window.open("about:blank","_self").close();
            }

            function setMaping(idx){
                $("#searchContentBox").css("height","365px");  // 로고 위치 지정

                var roadAddr = $("#roadAddrDiv"+idx).text()
                var addrPart1 = $("#roadAddrPart1Div"+idx).text();
                var addrPart2 = $("#roadAddrPart2Div"+idx).text();
                var engAddr = $("#engAddrDiv"+idx).text();
                var jibunAddr = $("#jibunAddrDiv"+idx).text();
                var zipNo = $("#zipNoDiv"+idx).text();
                var admCd = $("#admCdHid"+idx).val();
                var rnMgtSn = $("#rnMgtSnHid"+idx).val();
                var bdMgtSn = $("#bdMgtSnHid"+idx).val();
                var detBdNmList = $("#detBdNmListHid"+idx).val();
                var bdNm = $("#bdNmHid"+idx).val();
                var bdKdcd = $("#bdKdcdHid"+idx).val();
                var siNm = $("#siNmHid"+idx).val();
                var sggNm = $("#sggNmHid"+idx).val();
                var emdNm = $("#emdNmHid"+idx).val();
                var liNm = $("#liNmHid"+idx).val();
                var rn = $("#rnHid"+idx).val();
                var udrtYn = $("#udrtYnHid"+idx).val();
                var buldMnnm = $("#buldMnnmHid"+idx).val();
                var buldSlno = $("#buldSlnoHid"+idx).val();
                var mtYn = $("#mtYnHid"+idx).val();
                var lnbrMnnm = $("#lnbrMnnmHid"+idx).val();
                var lnbrSlno = $("#lnbrSlnoHid"+idx).val();
                var emdNo = $("#emdNoHid"+idx).val();

                $("#rtRoadAddr").val(roadAddr);
                $("#rtAddrPart1").val(addrPart1);
                $("#rtAddrPart2").val(addrPart2);
                $("#rtEngAddr").val(engAddr);
                $("#rtJibunAddr").val(jibunAddr);
                $("#rtZipNo").val(zipNo);
                $("#rtAdmCd").val(admCd);
                $("#rtRnMgtSn").val(rnMgtSn);
                $("#rtBdMgtSn").val(bdMgtSn);
                $("#rtDetBdNmList").val(detBdNmList);
                $("#rtBdNm").val(bdNm);
                $("#rtBdKdcd").val(bdKdcd);
                $("#rtSiNm").val(siNm);
                $("#rtSggNm").val(sggNm);
                $("#rtEmdNm").val(emdNm);
                $("#rtLiNm").val(liNm);
                $("#rtRn").val(rn);
                $("#rtUdrtYn").val(udrtYn);
                $("#rtBuldMnnm").val(buldMnnm);
                $("#rtBuldSlno").val(buldSlno);
                $("#rtMtYn").val(mtYn);
                $("#rtLnbrMnnm").val(lnbrMnnm);
                $("#rtLnbrSlno").val(lnbrSlno);
                $("#rtEmdNo").val(emdNo);

                $(".result").hide();
                $("#resultData").show();

                $("#addrPart1").html(addrPart1);
                $("#addrPart2").html(addrPart2);
                $("#rtAddrDetail").focus();
            }

            function init(){
                var browerName = navigator.appName;
                var browerAgent = navigator.userAgent;
                self.resizeTo(570, 520);
            }

            $(document).ready(function(){
                init();

                placeHolder();
                $('#searchRdNm').bind('click', function(){
                    $('.popWrap3').css({'display':'block','top':'21px','right':'121px'});
                });
                $('#popupClose2').bind('click', function(){
                    $('.popWrap3').css('display','none');
                });

                $('.choIdx a').click(function(event){
                    $('.choIdx a').removeClass('on');
                    if($(this).hasClass('off')){
                        return;
                    }else{
                        $(this).addClass('on');
                        event.preventDefault();
                        var target =this.hash;
                        var $target=$(target);
                        var top = $(target).position().top-106;
                        if(prevPosition ==0){
                            $('#roadNameList2').scrollTop(top);
                            prevPosition = top;
                        }else{
                            $('#roadNameList2').scrollTop(prevPosition+top);
                            prevPosition = prevPosition + top;
                        }

                        if($('#roadNameList2')[0].scrollHeight - $('#roadNameList2').scrollTop() == $('#roadNameList2').innerHeight()){
                            prevPosition = $('#roadNameList2').scrollTop();
                        }
                    }
                });
                $('#roadNameList2').children().css('display','none');
                $('#roadNameList2').scroll(function(){prevPosition = this.scrollTop;});
            });
            window.onresize = placeHolderPoint;

            function placeHolderPoint(){
                $(":input[placeholderTxt]").each(function(){
                    var labelId = "label"+this.id;
                    var objVal = $(this).val();
                    var placeTxt = $(this).attr("placeholderTxt");
                    var left = parseInt($(this).offset().left);
                    var top = parseInt($(this).offset().top);

                    $("#"+labelId).css({"left":left+"px","top":top+"px"});
                });
            }

            function placeHolder(){
                $(":input[placeholderTxt]").each(function(){
                    var labelId = "label"+this.id;
                    var objVal = $(this).val();
                    var placeTxt = $(this).attr("placeholderTxt");
                    var left = parseInt($(this).offset().left);
                    var top = parseInt($(this).offset().top);
                    $(this).after("<label for='"+this.id+"' id='"+labelId+"' style ='position:absolute;left:"+left+"px;top:"+top+"px; font-size:15px;color:#1898d2;font-weight:bold; padding-left:10px;padding-top:11px;'><b>"+placeTxt+"</b></label>");

                    if(objVal !=""){
                        $("#"+labelId).hide();
                    }

                    $(this).focus(function(){
                        $("#"+labelId).hide();
                    });

                    $(this).blur(function(){
                        if($(this).val() == ""){
                            $("#"+labelId).show();
                        }
                    });
                });
            }

            function addrDetailChk(){
                var evtCode = (window.netscape) ? ev.which : event.keyCode;
                if(evtCode == 63 || evtCode == 35 || evtCode == 38 || evtCode == 43 || evtCode == 92 || evtCode == 34){ // # & + \ " 문자제한
                    alert('특수문자 ? # & + \\ " 를 입력 할 수 없습니다.');
                    if(event.preventDefault){
                        event.preventDefault();
                    }else{
                        event.returnValue=false;
                    }
                }
            }

            function addrDetailChk1(obj){
                if(obj.value.length > 0){
                    var expText = /^[^?#&+\"\\]+$/;
                    if(expText.test(obj.value) != true){
                        alert('특수문자 ? # & + \\ " 를 입력 할 수 없습니다.');
                        obj.value="";
                    }
                }
            }

            function addrJuminRenew(idx){
                $("#detDivX"+idx).show();
                $("#detListDivX"+idx).show();
                $("#detDiv"+idx).hide();

                var docHeight = $("#resultList").height(); // 결과 DIV 높이 가져옴
                if(docHeight > 300){ // 높이가 310인 경우 로고 위치 조정
                    docHeight += 60;
                    $("#searchContentBox").css("height",docHeight+"px");// 로고 위치 지정
                }else{
                    $("#searchContentBox").css("365px");// 로고 위치 지정
                }
            }

            function addrJuminRenewX(idx){
                $("#detDivX"+idx).hide();
                $("#detListDivX"+idx).hide();
                $("#detDiv"+idx).show();

                var docHeight = $("#resultList").height(); // 결과 DIV 높이 가져옴
                if(docHeight > 300){ // 높이가 310인 경우 로고 위치 조정
                    docHeight += 60;
                    $("#searchContentBox").css("height",docHeight+"px");// 로고 위치 지정
                }else{
                    $("#searchContentBox").css("365px");// 로고 위치 지정
                }
            }

            $(function(){
                var docHeight = $("#resultList").height(); // 결과 DIV 높이 가져옴

                if(docHeight > 300){ // 높이가 310인 경우 로고 위치 조정
                    docHeight += 60;
                    $("#searchContentBox").css("height",docHeight+"px");// 로고 위치 지정
                }else{
                    $("#searchContentBox").css("365px");// 로고 위치 지정
                }

                $("#keyword").focus();

                //검색
                $("#keyword").on("keydown", function(event){
                    if (event.which == 13) {
                        event.keyCode = 0;
                        $("#currentPage").val(1);
                        searchUrlJuso();
                    }
                });

                //주소 검색
                $(document).on("click",".inputInfoTxt",function(){
                    searchUrlJuso();
                })
            });

            function trim(strSource) {
                return strSource.replace(/(^\s*)|(\s*$)/g, "");
            }

            /* function popClose(){
                window.close();
            } */
        </script>
    </tiles:putAttribute>
    <tiles:putAttribute name="content">
        <%-- 행정안전부 우편번호 조회 팝업 --%>
        <link rel="stylesheet" type="text/css" href="/_css/addrlink.css">

        <form name="rtForm" id="rtForm" method="post">
            <input type="hidden" name="inputYn" id="inputYn" value="Y"/>
            <input type="hidden" name="roadFullAddr" id="roadFullAddr"/> <!-- 전체 도로명주소 [서울특별시 강남구 논현로 508, 지하1층 (역삼동)] -->
            <input type="hidden" name="roadAddrPart1" id="roadAddrPart1"/> <!-- 도로명주소(참고항목 제외) [서울특별시 강남구 논현로 508] -->
            <input type="hidden" name="roadAddrPart2" id="roadAddrPart2"/> <!-- 도로명주소 참고항목 [(역삼동)] -->
            <input type="hidden" name="engAddr" id="engAddr"/> <!-- 도로명주소(영문) [508, Nonhyeon-ro, Gangnam-gu, Seoul] -->
            <input type="hidden" name="jibunAddr" id="jibunAddr"/> <!-- 지번주소 [서울특별시 강남구 역삼동 679 GS강남타워] -->
            <input type="hidden" name="zipNo" id="zipNo"/> <!-- 우편번호 [06141] -->
            <input type="hidden" name="addrDetail" id="addrDetail"/> <!-- 고객 입력 상세 주소 [지하1층] -->
            <input type="hidden" name="admCd" id="admCd" /> <!-- 행정구역코드 [1168010100] -->
            <input type="hidden" name="rnMgtSn" id="rnMgtSn" /> <!-- 도로명코드 [116803121022] -->
            <input type="hidden" name="bdMgtSn" id="bdMgtSn" /> <!-- 건물관리번호 [1168010100106790001026822] -->

            <input type="hidden" name="detBdNmList" id="detBdNmList" /> <!-- 상세건물명 -->
            <input type="hidden" name="bdNm" id="bdNm" /> <!-- 건물명 [GS강남타워] -->
            <input type="hidden" name="bdKdcd" id="bdKdcd" /> <!-- 공동주택여부(1 : 공동주택, 0 : 비공동주택) [0] -->
            <input type="hidden" name="siNm" id="siNm" /> <!-- 시도명 [서울특별시] -->
            <input type="hidden" name="sggNm" id="sggNm" /> <!-- 시군구명 [강남구] -->
            <input type="hidden" name="emdNm" id="emdNm" /> <!-- 읍면동명 [역삼동] -->
            <input type="hidden" name="liNm" id="liNm" /> <!-- 법정리명 -->
            <input type="hidden" name="rn" id="rn" /> <!-- 도로명 [논현로] -->
            <input type="hidden" name="udrtYn" id="udrtYn" /> <!-- 지하여부(0 : 지상, 1 : 지하) [0] -->
            <input type="hidden" name="buldMnnm" id="buldMnnm" /> <!-- 건물본번 [508] -->
            <input type="hidden" name="buldSlno" id="buldSlno" /> <!-- 건물부번 [0] -->
            <input type="hidden" name="mtYn" id="mtYn" /> <!-- 산여부(0 : 대지, 1 : 산) [0] -->
            <input type="hidden" name="lnbrMnnm" id="lnbrMnnm" /> <!-- 지번본번(번지) [679] -->
            <input type="hidden" name="lnbrSlno" id="lnbrSlno" /> <!-- 지번부번(호) [0] -->
            <input type="hidden" name="emdNo" id="emdNo" /> <!-- 읍면동일련번호 [01] -->
        </form>

        <form name="AKCFrm" id="AKCFrm" method="post">
            <input type="hidden" name="iframe"  value=""/>
            <input type="hidden" name="confmKey" value="<spring:eval expression="@bizConfig['fo.mois.post.confmKey']" />"/> <!-- 신청시 발급받은 승인키 -->
            <input type="hidden" name="encodingType"   value=""/>
            <input type="hidden" name="cssUrl" value=""/>
            <input type="hidden" name="resultType" value="4"/> <!-- 도로명주소 검색결과 화면 출력유형 1 : 도로명, 2 : 도로명+지번+상세보기(관련지번, 관할주민센터), 3 : 도로명+상세보기(상세건물명), 4 : 도로명+지번+상세보기(관련지번, 관할주민센터, 상세건물명) -->
            <input type="hidden" name="currentPage" id="currentPage" value="1"/><!-- 현재 페이지 번호 -->
            <input type="hidden" name="countPerPage" value="5"/> <!-- 페이지당 출력할 결과 Row 수 -->

            <input type="hidden" name="rtRoadAddr"  id="rtRoadAddr"  /> <!-- 전체 도로명주소 [서울특별시 강남구 논현로 508, 지하1층 (역삼동)] -->
            <input type="hidden" name="rtAddrPart1" id="rtAddrPart1" /> <!-- 도로명주소(참고항목 제외) [서울특별시 강남구 논현로 508] -->
            <input type="hidden" name="rtAddrPart2" id="rtAddrPart2" /> <!-- 도로명주소 참고항목 [(역삼동)] -->
            <input type="hidden" name="rtEngAddr"   id="rtEngAddr"   /> <!-- 도로명주소(영문) [508, Nonhyeon-ro, Gangnam-gu, Seoul] -->
            <input type="hidden" name="rtJibunAddr" id="rtJibunAddr" /> <!-- 지번주소 [서울특별시 강남구 역삼동 679 GS강남타워] -->
            <input type="hidden" name="rtZipNo" id="rtZipNo" /> <!-- 우편번호 [06141] -->
            <input type="hidden" name="rtAdmCd" id="rtAdmCd" /> <!-- 행정구역코드 [1168010100] -->
            <input type="hidden" name="rtRnMgtSn" id="rtRnMgtSn" /> <!-- 도로명코드 [116803121022] -->
            <input type="hidden" name="rtBdMgtSn" id="rtBdMgtSn" /> <!-- 건물관리번호 [1168010100106790001026822] -->

            <input type="hidden" name="rtDetBdNmList" id="rtDetBdNmList" /> <!-- 상세건물명 -->
            <input type="hidden" name="rtBdNm" id="rtBdNm" /> <!-- 건물명 [GS강남타워] -->
            <input type="hidden" name="rtBdKdcd" id="rtBdKdcd" /> <!-- 공동주택여부(1 : 공동주택, 0 : 비공동주택) [0] -->
            <input type="hidden" name="rtSiNm" id="rtSiNm" /> <!-- 시도명 [서울특별시] -->
            <input type="hidden" name="rtSggNm" id="rtSggNm" /> <!-- 시군구명 [강남구] -->
            <input type="hidden" name="rtEmdNm" id="rtEmdNm" /> <!-- 읍면동명 [역삼동] -->
            <input type="hidden" name="rtLiNm" id="rtLiNm" /> <!-- 법정리명 -->
            <input type="hidden" name="rtRn" id="rtRn" /> <!-- 도로명 [논현로] -->
            <input type="hidden" name="rtUdrtYn" id="rtUdrtYn" /> <!-- 지하여부(0 : 지상, 1 : 지하) [0] -->
            <input type="hidden" name="rtBuldMnnm" id="rtBuldMnnm" /> <!-- 건물본번 [508] -->
            <input type="hidden" name="rtBuldSlno" id="rtBuldSlno" /> <!-- 건물부번 [0] -->
            <input type="hidden" name="rtMtYn" id="rtMtYn" /> <!-- 산여부(0 : 대지, 1 : 산) [0] -->
            <input type="hidden" name="rtLnbrMnnm" id="rtLnbrMnnm" /> <!-- 지번본번(번지) [679] -->
            <input type="hidden" name="rtLnbrSlno" id="rtLnbrSlno" /> <!-- 지번부번(호) [0] -->
            <input type="hidden" name="rtEmdNo" id="rtEmdNo" /> <!-- 읍면동일련번호 [01] -->

            <input type="hidden" name ="searchType"    id="searchType" />
            <input type="hidden" name ="dsgubuntext"   id="dsgubuntext" />
            <input type="hidden" name ="dscity1text"   id="dscity1text" />
            <input type="hidden" name ="dscounty1text" id="dscounty1text" />
            <input type="hidden" name ="dsemd1text"    id="dsemd1text" />
            <input type="hidden" name ="dsri1text"     id="dsri1text" />
            <input type="hidden" name ="dsrd_nm1text"  id="dsrd_nm1text" />
            <input type="hidden" name ="dssan1text"    id="dssan1text" />

            <!-- 팝업윈도우 A .popLayer.win-->
            <article class="popLayer win a popWin1">
                <div class="pbd">
                    <div class="pct">
                        <main class="poptents">
                            <!-- 주소 검색 -->
                            <div class="address-search">
                                <div class="input del t2 drop" data-txt="주소검색">
                                    <input type="text" id="keyword" placeholder="텍스트 입력" value="">
                                    <div class="drop-list">
                                        <ul>
                                            <li><a href="javascript:;">서울특별시 강남구 <span>역삼</span> 동</a></li>
                                            <li><a href="javascript:;">서울특별시 강남구 <span>역삼</span> 동</a></li>
                                            <li><a href="javascript:;">서울특별시 강남구 <span>역삼</span> 동</a></li>
                                        </ul>
                                    </div>
                                </div>

                                <p class="validation-check">error message</p>
                                <div class="address-list">
                                    <ul>
                                        <li>
                                            <strong class="postal-code">07280</strong>
                                            <p class="t1"><span class="i1">도로명</span> 서울특별시 영등포구 선유로 75 (GS강서타워)</p>
                                            <p class="t2"><span class="i2">지번</span> 서울 특별시 영등포구 문래동6가 10 GS강서타워</p>
                                        </li>
                                        <li>
                                            <strong class="postal-code">07280</strong>
                                            <p class="t1"><span class="i1">도로명</span> 서울특별시 영등포구 선유로 75 (GS강서타워)</p>
                                            <p class="t2"><span class="i2">지번</span> 서울 특별시 영등포구 문래동6가 10 GS강서타워</p>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <p class="tip-text">아래와 같이 검색하면 더욱 정확한 결과가 검색 됩니다.</p>
                            <div class="hint-list">
                                <ul>
                                    <li>
                                        <p class="t1">도로명 + 건물번호</p>
                                        <p class="t2">예) 영동대로 513</p>
                                    </li>
                                    <li>
                                        <p class="t1">지역명(동/리) + 번지</p>
                                        <p class="t2">예) 삼성동 25</p>
                                    </li>
                                    <li>
                                        <p class="t1">지역명(동/리) + 건물명(아파트명)</p>
                                        <p class="t2">예) 삼성동 코엑스</p>
                                    </li>
                                </ul>
                            </div>
                            <!-- // 주소 검색 -->
                        </main>
                    </div>

                    <!-- 하단 고정 버튼 있을때 쓰세요
                        <div class="pbt">
                        <div class="bts">
                            <button type="button" class="btn xl d" onclick="ui.popLayer.close('popWin1');">취소</button>
                            <button type="button" class="btn xl a">등록</button>
                        </div>
                    </div>
                    -->

                </div>
            </article>

        </form>
    </tiles:putAttribute>
</tiles:insertDefinition>