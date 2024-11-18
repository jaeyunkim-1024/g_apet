// 회원 상세 검색 -> 서브탭 객체들
const memberPayTabNm = "거래 내역";
const memberPetLogTabNm = "펫로그";
const memberGoodsReviewTabNm = "상품후기 내역";
const memberReplyTabNm = "댓글 내역";
const memberReportTabNm = "신고된 내역";
const memberTagFollowTabNm = "Tag팔로우내역";
const memberRecommandTabNm = "추천내역";
const memberFollowTabNm = "팔로우 내역";
const memberGoodsIoTabNm = "재입고 알림 내역";
const memberCsTabNm = "1:1문의 내역";

var memberTab = {
    mbrNo : 0
    ,   init : function(){
            memberTab.mbrNo = $("#memberInfoDiv [name='mbrNo']").val();
            waiting.start();
            var isSearch = memberTab.mbrNo != 0;
            if(memberTab.mbrNo != 0){
                $("#member-tab").tabs();
                var queryStr = $("#hidden-field").serialize();
    
                //기존 회원 관리
                memberTab.createTab(memberPayTabNm,"/member/memberPayView.do?"+queryStr,{id:'iframe-memberPayView',isSearch:isSearch});
                memberTab.createTab(memberPetLogTabNm,"/member/memberPetLogView.do?"+queryStr,{id:'iframe-memberPetLogView',isSearch:isSearch});
                memberTab.createTab(memberGoodsReviewTabNm,"/member/memberGoodsReview.do?"+queryStr,{id:'iframe-memberGoodsReview',isSearch:isSearch});
                memberTab.createTab(memberReplyTabNm,"/member/memberReplyView.do?"+queryStr,{id:'iframe-memberReplyView',isSearch:isSearch});
                memberTab.createTab(memberReportTabNm,"/member/memberReportView.do?"+queryStr,{id:'iframe-memberReportView',isSearch:isSearch});
                memberTab.createTab(memberTagFollowTabNm,"/member/memberTagFollow.do?"+queryStr,{id:'iframe-memberTagFollow',isSearch:isSearch});
                //보안진단 처리 : 주석으로 된 시스템 주요 정보 삭제
                memberTab.createTab(memberFollowTabNm,"/member/memberFollowView.do?"+queryStr,{id:'iframe-memberFollowView',isSearch:isSearch});
                memberTab.createTab(memberGoodsIoTabNm,"/member/memberGoodsIoView.do?"+queryStr,{id:'iframe-memberGoodsIoView',isSearch:isSearch});
                memberTab.createTab(memberCsTabNm,"/member/memberCsListView.do?"+queryStr,{id:'iframe-memberCsListView',isSearch:isSearch});
    
                //2021.03.08 기준 - 변경, 타 파트의 화면과 동일하게 구성(검색 조건 또한 서브탭에서 노출)
                $("#member-tab").tabs('select', memberPayTabNm);
            }
            waiting.stop();
    }
    , createTab : function(menuNm,menuUrl,attr){
        var obj = $("#member-tab");
        var id = attr.id;
        var isSearch = attr.isSearch;

        var content = isSearch ? '<iframe id="'+id+'" frameborder="0"  src="' + menuUrl + '" style="width:100%;overflow:hidden;height:950px;"></iframe>' :
            '<iframe id="'+id+'" frameborder="0"  src="' + menuUrl + '" style="width:100%;overflow:hidden;height:400px;"></iframe>' ;
        if (obj.tabs('exists', menuNm)) {
            obj.tabs('select', menuNm);
            var tab = obj.tabs('getSelected');
            obj.tabs('update', {
                tab: tab,
                options: {
                    title: menuNm,
                    content: content
                }
            });
        }
        else {
            obj.tabs('add', {
                title: menuNm,
                content: content,
                closable: false
            });
        }
    }
};

var twcTab = {
    mbrNo : 0
    ,   init : function(){
        twcTab.mbrNo = $("#memberInfoDiv [name='mbrNo']").val();
        //$("#member-twc-tab").tabs();

        //twcTab.createTab("상담 이력","/member/memberTwcCsListView.do","iframe-memberTwcCsListView");
        //twcTab.createTab("문자발송이력","/member/memberTwcSmsListView.do","iframe-memberTwcSmsListView");
        //twcTab.createTab("이관현황","/member/memberTwcEsacalationView.do","iframe-memberTwcEsacalationView");

        //$("#member-twc-tab").tabs('select', "상담 이력");
    }
    , createTab : function(menuNm,menuUrl,id){
        var obj = $("#member-twc-tab");

        var content = '<iframe id="'+id+'" frameborder="0"  src="' + menuUrl + '" style="width:100%;overflow:hidden;height:400px;"></iframe>';
        if (obj.tabs('exists', menuNm)) {
            obj.tabs('select', menuNm);
            var tab = obj.tabs('getSelected');
            obj.tabs('update', {
                tab: tab,
                options: {
                    title: menuNm,
                    content: content
                }
            });
        }
        else {
            obj.tabs('add', {
                title: menuNm,
                content: content,
                closable: false
            });
        }
    }
}

//회원 상세 - 댓글 내역 탭 및 신고된 내역 탭에서 상세

//어바웃펫 TV
var petTv = {
    detailLayerPop : function(aplySeq, loginId, rpl){
        var options = {
            url : "/contents/popupReplyWrite.do"
            , data : {
                aplySeq : aplySeq
                ,   loginId : loginId
            }
            , dataType : "html"
            , callBack : function(data) {
                var btnStr;
                var btnTxt = "등록";
                btnStr = "<button type=\"button\" onclick=\"petTv.save();\" class=\"btn\" style=\"background-color:#0066CC; border-color:#0066CC;\">" + btnTxt + "</button>";
                isInsertGb = true;
                if (rpl) {
                    btnTxt = "수정";
                    btnStr = "<button type=\"button\" onclick=\"petTv.save();\" class=\"btn\" style=\"background-color:#0066CC; border-color:#0066CC;\">" + btnTxt + "</button>"
                    btnStr += "<button type=\"button\" onclick=\"petTv.delete();\" class=\"btn btn-ok ml10\">삭제</button>";
                    isInsertGb = false;
                }
                var config = {
                    id : "apetReplyViewPop"
                    , width : 800
                    , height : 410
                    , title : "펫TV 댓글 쓰기"
                    , body : data
                    , button : btnStr
                }
                layer.create(config);
            }
        }
        ajax.call(options);
    }
    ,   detailReportPop : function(seq, loginId){
        var options = {
            url : "/contents/apetReplyRptpDetailView.do"
            , data : {
                aplySeq : seq
                , loginId : loginId
            }
            , dataType : "html"
            , callBack : function(data) {
                var config = {
                    id : "apetReplyRptpDetailViewPop"
                    , width : 800
                    , height : 650
                    , title : "펫TV 댓글 신고 상세"
                    , body : data
                    , button : "<button type=\"button\" onclick=\"petTv.saveReportPop();\" class=\"btn\" style=\"background-color:#0066CC; border-color:#0066CC;\">저장</button>"
                }
                layer.create(config);
            }
        }
        ajax.call(options);
    }
    ,   save : function(){
        if(validate.check("contsReplyDetailForm")) {
            var message = "등록 되었습니다.";
            var formData = $("#contsReplyDetailForm").serializeJson();

            if (formData.rplGb) {
                message = "수정 되었습니다."
            }

            var options = {
                url : "/contents/saveApetReply.do"
                , data : formData
                , callBack : function (data) {
                    var selectData = {
                        aply : data.contentsReplyPO.rpl
                        , rpl : data.contentsReplyPO.rpl
                        , aplySeq : data.contentsReplyPO.aplySeq
                        , contsStatCd : data.contentsReplyPO.contsStatCd
                        , loginId : data.contentsReplyPO.loginId
                        , replyRegrNm : $("#adminSessionUsrNm").val()
                        , replyGb : "R"
                        , sysRegDtm : data.contentsReplyPO.rplRegDtm != null ? data.contentsReplyPO.rplRegDtm : new Date().format("yyyy-MM-dd HH:mm:ss")
                        , sysUpdDtm : new Date().format("yyyy-MM-dd HH:mm:ss")
                    }

                    messager.alert(message,"Info","info",function(){
                        fnReloadMemberCommentList();
                        layer.close("apetReplyViewPop");
                        addGridRow("#memberCommentList", selectData);
                    });
                }
            };
            ajax.call(options);
        }
    }
    ,   saveReportPop : function(){
        var arrReplySeq = new Array();
        arrReplySeq.push($("#apetReplyRptpDetailForm input[name=aplySeq]").val());

        var sendData = {
            arrReplySeq : arrReplySeq
            ,   contsStatCd : $("#apetReplyRptpDetailForm input[name=contsStatCd]:checked").val()
        };
        var options = {
            url : "/contents/updateApetReplyContsStat.do"
            , data : sendData
            , callBack : function(data) {
                messager.alert("저장 되었습니다.", "Info", "info", function() {
                    //grid.reload("contsReplyList", options);
                    fnReloadMemberCommentList();
                    layer.close('apetReplyRptpDetailViewPop');
                });
            }
        };
        ajax.call(options);
    }
    ,   delete : function(){
        var formData = $("#contsReplyDetailForm").serializeJson();

        var options = {
            url : "/contents/deleteApetReply.do"
            , data : formData
            , callBack : function (data) {
                var selectData = {
                    aply : data.contentsReplyPO.rpl
                    , rpl : data.contentsReplyPO.rpl
                    , aplySeq : data.contentsReplyPO.aplySeq
                    , contsStatCd : data.contentsReplyPO.contsStatCd
                    , loginId : data.contentsReplyPO.loginId
                    , replyRegrNm : $("#adminSessionUsrNm").val()
                    , replyGb : "R"
                    , sysRegDtm : data.contentsReplyPO.rplRegDtm != null ? data.contentsReplyPO.rplRegDtm : new Date().format("yyyy-MM-dd HH:mm:ss")
                    , sysUpdDtm : new Date().format("yyyy-MM-dd HH:mm:ss")
                }

                messager.alert("삭제 되었습니다.","Info","info",function(){
                    fnReloadMemberCommentList();
                    layer.close("apetReplyViewPop");
                    var updateRowId = $("#memberCommentList tr[id="+gridRowId+"]").next("tr").attr("id");
                    setRowId = gridRowId;
                    if (replyGbData == "R") {
                        updateRowId = gridRowId;
                        setRowId = $("#memberCommentList tr[id="+gridRowId+"]").prev("tr").attr("id");
                    }
                    $("#memberCommentList").jqGrid("delRowData",updateRowId);
                    $("#memberCommentList").jqGrid("setCell",setRowId,"rpl","&nbsp;");
                    $("#memberCommentList").jqGrid("setCell",setRowId,"rplRegDtm","&nbsp;");
                    $("#memberCommentList").jqGrid("setCell",setRowId,"rplUpdDtm","&nbsp;");
                });
            }
        };
        ajax.call(options);
    }
};

var petLog = {
    detailLayerPop : function(petLogNo, contsStatCd, snctYn, petLogChnlCd, replyRptpGb, petLogAplySeq){
        var titles = "펫로그 상세";
        var options = {
            url : "/petLogMgmt/popupPetLogDetail.do"
            , data : {      petLogNo : petLogNo
                ,	contsStatCd : contsStatCd
                ,   snctYn : snctYn
                ,   petLogChnlCd : petLogChnlCd
                ,	replyRptpGb : replyRptpGb
                ,	petLogAplySeq : petLogAplySeq
            }
            , dataType : "html"
            , callBack : function (data ) {
                var config = {
                    id : "petLogDetail"
                    , width : 1050
                    , height : 630
                    , top : 200
                    , title : titles
                    , body : data
                    , button : "<button type=\"button\" onclick=\"petLog.save('detail',"+petLogNo+");\" class=\"btn btn-ok\" style=\"background-color:#0066CC; border-color:#0066CC;\">저장</button>"
                }
                layer.create(config);
            }
        }
        ajax.call(options);
    }
    ,   save : function(location,petLogNo){
        var addMsg="";
        if(location == "batch") addMsg="선택 ";
        messager.confirm(addMsg+"펫로그의 전시 상태를 변경합니다.",function(r){
            if(r){
                var contsStatUpdateGb = $("#contsStatUpdateGb").children("option:selected").val();
                var petLogNos = new Array();
                var snctYn = "";
                if(location == "batch"){//일괄 업데이트
                    var grid = $("#petlogList");
                    var selectedIDs = grid.getGridParam ("selarrrow");

                    for (var i = 0; i < selectedIDs.length; i++) {
                        var o = grid.getCell(selectedIDs[i], 'petLogNo');
                        petLogNos.push (o);
                    }
                }else{//팝업창에서 저장
                    petLogNos.push (petLogNo);
                    contsStatUpdateGb = $(":input:radio[name=detailContsStatCd]:checked").val();
                    /* snctYn = $(":input:checkbox[name=snct_yn]:checked").val();
                    if(snctYn == null || snctYn == ""){
                        snctYn = "N";
                    } */
                }

                var sendData = {
                    petLogNos : petLogNos
                    ,   contsStatUpdateGb:contsStatUpdateGb
                    /* , snctYn : snctYn */
                };

                var options = {
                    url : "/petLogMgmt/updatePetLog.do"
                    , data : sendData
                    , callBack : function(data ) {
                        messager.alert("수정 되었습니다.", "Info", "info", function(){
                            fnReloadMemberCommentList();
                            searchPetlogList ();
                            $("#contsStatUpdateGb").val("");
                            if(location != "batch"){
                                layer.close('petLogDetail');
                            }
                        });
                    }
                };
                ajax.call(options);
            }
        });
    }
};