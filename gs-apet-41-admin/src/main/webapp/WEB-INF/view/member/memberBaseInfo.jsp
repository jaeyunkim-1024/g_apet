<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<div id="memberInfoDiv">
    <c:if test="${not empty member}">
        <script type="text/javascript">
            //쿠폰 발급 팝업
            function couponListViewPop(){
                var options = {
                    url : '/promotion/couponListViewPop.do'
                    , data : {
                            mbrNo : '${member.mbrNo }'
                        ,   stId : '${member.stId }'
                        ,   stNm : '${member.stNm }'
                        ,   cpPvdMthCd : "${adminConstants.CP_PVD_MTH_40}"
                    }
                    , dataType : "html"
                    , callBack : function (data) {
                        var config = {
                            id : "couponListView"
                            , width : 1200
                            , height : 600
                            , title : "쿠폰 검색"
                            , body : data
                            , button : "<button type=\"button\" onclick=\"memberIssueCoupon();\" class=\"btn btn-ok\">쿠폰 발급</button>"
                        }
                        layer.create(config);
                    }
                }
                ajax.call(options);
            }
            //공통 쿠폰 팝업에서 호출 함수 -> Override
            function reloadCsMemberCouponPossibleListGrid(){
                var inqrHistNo = $("#hidden-field [name='inqrHistNo']").val();
            	
            	if($("#hidden-field [name='maskingUnlock']").val() === "${adminConstants.COMM_YN_N}")	inqrHistNo = null;
            	
                fnGetMemberBaseInShort(inqrHistNo);
            }

            //고객 상세 정보
            function fnGetMemberBaseDetail(){
                var data = {
                        mbrNo : "${member.mbrNo}"
                    ,   maskingUnlock : $("#hidden-field [name='maskingUnlock']").val()
                };

                var options = {
                    url : "<spring:url value='/member/memberDetailLayerPop.do' />"
                    ,	data : data
                    ,	dataType : "HTML"
                    ,	callBack : function(result){
                        var config = {
                            id : "memberDetailLayer"
                            , title : "고객 정보 상세"
                            , body : result
                            , button : "<button type='button' onclick='layer.close(\"memberDetailLayer\");' class='btn btn-ok'>확인</button>"
                        }
                        layer.create(config);
                    }
                };
                ajax.call(options);
            }

            $(function(){
                $(document).on("change","[name='mbrStatCd']",function(){
                    var t = "${adminConstants.MBR_STAT_30}";
                    $("#mbrStatUpdateBtn").prop("disabled",$("[name='mbrStatCd'] option:selected").val() == t);
                })

                //부당거래 정지 삭제
                $("[name='mbrStatCd'] option[value='${adminConstants.MBR_STAT_80}']").remove();

                var mbrStatCd = "${member.mbrStatCd}";
                fnControllMbrStatSelect(mbrStatCd);
            });
        </script>
    </c:if>
    <input type="hidden" name="stId" value="${member.stId}" readonly disabled />
    <form id="hidden-field" style="display:none;">
        <input type="text" name="maskingUnlock" value="${member.maskingUnlock}" />
        <input type="text" name="mbrNo" value="${member.mbrNo}" />
        <input type="text" name="stId" value="${member.stId}" />
        <input type="text" name="cnctHistNo" value="${cnctHistNo}" />
        <input type="text" name="inqrHistNo" value="${inqrHistNo}" />
        <input type="text" name="nickName" id="nickName" value="${member.nickNm}" />
    </form>

    <div class="mTitle mt30">
        <h2>회원 기본정보</h2>
        <c:if test="${not empty member}">
            <div class="buttonArea">
                <c:choose>
                    <c:when test="${member.dffcMbrYn eq adminConstants.COMM_YN_Y}">
                        <button type="button" onclick='fnMemberDffcMbrYn("${adminConstants.COMM_YN_N}");' class="btn btn-ok">강성고객 해제</button>
                    </c:when>
                    <c:otherwise>
                        <button type="button" onclick='fnMemberDffcMbrYn("${adminConstants.COMM_YN_Y}");' class="btn btn-add">강성고객 지정</button>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${member.maskingUnlock eq adminConstants.COMM_YN_Y}">
                        <button type="button" onclick="fnGetMemberBaseInShort();" class="btn btn-add">개인정보 숨김</button>
                    </c:when>
                    <c:otherwise>
                        <button type="button" onclick="fnUnlockPrivacyMasking();" class="btn btn-add">개인정보 해제</button>
                    </c:otherwise>
                </c:choose>
                <button type="button" onclick="fnGetMemberBaseDetail();" class="btn btn-add">고객상세 정보</button>
            </div>
        </c:if>
    </div>
    <form>
        <table class="table_type1">
            <colgroup>
                <col width="16%"/>
                <col width="20%"/>
                <col width="10%"/>
                <col width="16%"/>
                <col width="10%"/>
            </colgroup>
            <tbody>
            <tr>
                <th>User-no</th>
                <td>
                    <span>
                        ${member.mbrNo}
                    </span>
                </td>

                <th>회원등급</th>
                <td>
                    <span>
                        ${member.mbrGrdNm}
                    </span>
                </td>

                <th>회원 상태</th>
                <td>
                    <c:if test="${not empty member}">
                        <select name="mbrStatCd" class="w100" data-original="${member.mbrStatCd}">
                            <frame:select grpCd="${adminConstants.MBR_STAT_CD}" selectKey="${empty member.mbrStatCd ? '00' : member.mbrStatCd}" useYn="${adminConstants.COMM_YN_Y}" usrDfn1Val="${adminConstants.SHOW_YN_Y}" />
                        </select>
                        <label class="fRadio button ml10">
                            <button type="button" class="btn" id="mbrStatUpdateBtn" onclick="fnConfirmMbrStatUpdate();">변경</button>
                        </label>
                    </c:if>
                 </td>
            </tr>
            <tr>
                <th>ID</th>
                <td>
                    <span>${member.loginId}</span>
                </td>

                <th>회원명(닉네임)</th>
                <td>
                    <span id="mbr-nm-txt">${member.mbrNm}
                    	<c:if test="${not empty member.nickNm}">(${member.nickNm})</c:if>
                        <c:if test="${member.dffcMbrYn eq adminConstants.COMM_YN_Y}">
                            <span class="red" style="font-size:8px;">● 강성 고객</span>
                        </c:if>
                    </span>
                </td>

                <th>이메일<strong class="red">*</strong></th>
                <td>
                	<c:if test="${not empty member}">
	                    <span>${member.email}</span>
	                    <button type="button" class="btn ml10" onclick="emailUpdateViewPop();">변경</button>
	               	</c:if>
                </td>
            </tr>
            <tr>
                <th>휴대폰 번호 <strong class="red">*</strong></th>
                <td>
                    <c:if test="${not empty member}">
                        <span>${member.mobile}
                            <c:if test="${not empty member.mobileCd}">
                                ( ${member.mobileNm} )
                            </c:if>
                        </span>
                        <button type="button" class="btn" onclick="fnMobileHistoryLayerPop();"  >변경 이력</button>
                    </c:if>
                </td>

                <th>성별</th>
                <td>
                    <span>${member.gdGbNm}</span>
                </td>

                <th>가입일</th>
                <td>
                    <span><fmt:formatDate value='${member.joinDtm }' pattern='yyyy-MM-dd hh:mm:ss'/>
                </td>
            </tr>
            <tr>
                <th>반려동물</th>
                <td>
                    <c:if test="${not empty member}">
                        <span>${empty member.petSimpleInfo ? '-' : member.petSimpleInfo}</span>
                        <button type="button" class="btn ml30" onclick="fnMemberPetDetatilView();" >상세</button>
                    </c:if>
                </td>

                <th>관심 Tag</th>
                <td>
                    <c:if test="${not empty member}">
                        <span>
                            ${not empty member.tags ? member.tags : '등록 된 태그가 없습니다.' }
                        </span>
                    </c:if>
                </td>

                <th>보유쿠폰</th>
                <td>
                    <c:if test="${not empty member}">
                        <span id="cpCnt">${member.cpCnt} 매</span>
                        <button type="button" class="btn ml10" onclick="couponListViewPop();">쿠폰 발급</button>
                        <button type="button" class="btn" onclick="fnMemberCouopnLayerPop();"  >상세</button>
                    </c:if>
                </td>
            </tr>
            <tr>
            	<th>간편 카드</th>
                <td>
                    <c:if test="${not empty member}">
                        <span id="cardCnt">${member.cardCnt}</span> 개
                        <button type="button" class="btn ml10" onclick="fnSimpleMemberCardLayerPop();" >상세</button>
                    </c:if>
                </td>
                <th>우주코인</th>
                <td colspan="3">
                    <c:if test="${not empty member}">
                        <span>
                        <c:choose>
                        	<c:when test="${member.sktmpCnt > 0}">
                        		등록 됨
                        	</c:when>
                        	<c:otherwise>
                        		미등록
                        	</c:otherwise>
                        </c:choose>
                        </span>
                        <button type="button" class="btn ml10" onclick="fnSktmpLayerPop();" >상세</button>
                    </c:if>
                </td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">
                    <c:if test="${not empty member}">
                        <c:set var="addr" value="${member.maskingAddr}"/>
<%--                         <c:if test="${empty addr}"> --%>
<%--                             <c:set var="addr" value="${member.mbrDftDlvrPrclAddress}"/> --%>
<%--                         </c:if> --%>
                        <span>${empty addr ? '등록 된 주소지가 없습니다.' : addr }</span>
                        <c:if test="${not empty addr}">
                            <button type="button" class="btn ml10" onclick="fnMemberAddressViewPop();">배송지 확인</button>
                        </c:if>
                    </c:if>
                </td>
            </tr>
            </tbody>
        </table>
        <input type="hidden" name="stId" value="${member.stId}" readonly disabled />
    </form>
</div>