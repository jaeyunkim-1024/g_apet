const optSelect = "option:selected";
const thumbnailMaxWidth = 900;
const thumbnailMaxHeight = 405;
const thumbnailMaxSize = 1024*1024*5;
/*
  * 응모 이벤트 등록 > 신청하기 팝업 > '추가 필드' 제어 객체
  */
var field = {
    html : ''
    ,	colgroup : ''
    ,	options : []
    ,	size : 0
    ,	htmlMap : {}
    ,	fldNmHtml : '<th>필드명</th><td><input type="text" class="w200" name="fldNm" value="" /></td></tr>'
    ,	ele : {
        '30' : '<input type="text" class="w20 ml5 mt5" name="fldVals" style="text-align:center;" placeholder="" />'
        ,	'40' : '<input type="text" class="w20 ml5 mt5" name="fldVals" style="width:100px;text-align:center;" placeholder="" />'
        ,	'50' : '<input type="text" class="w20 ml5 mt5" name="fldVals" style="width:100px;text-align:center;" placeholder="" />'
    }
    ,	init : function(){
            $("select[name='fldTpCd'] option").each(function(){
                var o = {
                        text : $(this).text()
                    ,	value : $(this).val()
                };
                field.htmlMap[$(this).val()]='';
                field.options.push(o);
            });

            field.html = $(".addField-ul").html();
            field.colgroup = '<colgroup><col width="20%"/><col width="10%"/><col width="55%"/><col width="*"/></colgroup>';
            field.size = field.options.length;

            field.setDef();
            field.setOneLine();
            field.setMultiLine();
            field.setRdo();
            field.setChk();
            field.setSel();
            field.setFile();
            field.setImg();
            field.setNotice();
    }
    ,	getHeadTr : function(idx,rowspan){
        var html = '';
        html += '<tr>';
        html += rowspan != undefined ? '<th style="vertical-align:top;" rowspan="'+rowspan+'">' : '<th style="vertical-align:top;">';
        html += '<select class="w100" name="fldTpCd" onchange="field.onchange(this);">';

        for(var i=0; i<field.size; i+=1){
            var selected = i===idx ? 'selected' : '';
            var text = field.options[i].text;
            var value = field.options[i].value;
            html += '<option value="'+value+'" '+selected+'>'+text+'</option>';
        }
        html += '</select></th>';
        html += field.fldNmHtml;

        html += '<th>설명</th>';
        html += '<td>';
        html += '<textarea name="fldDscrt" style="width:90%;"></textarea>';
        html += '</td>';
        html += '</tr>';

        return html;
    }
    ,	setDef : function(){
        field.htmlMap['00'] = '';
        field.htmlMap['00'] += field.getHeadTr(0,2);
    }
    ,	setOneLine : function(){
        field.htmlMap['10'] = '';
        field.htmlMap['10'] += field.getHeadTr(1,2);
    }
    ,	setMultiLine : function(){
        field.htmlMap['20'] = '';
        field.htmlMap['20'] += field.getHeadTr(2,2);
    }
    ,	setRdo : function(){
        field.htmlMap['30'] = '';
        field.htmlMap['30'] += field.getHeadTr(3,3);

        field.htmlMap['30'] += '<tr>';
        field.htmlMap['30'] += '<th>항목</th>';
        field.htmlMap['30'] += '<td>';

        field.htmlMap['30'] += '<div class="buttonArea mt10 ml5">';
        field.htmlMap['30'] += '<button type="button" name="fieldAddEleBtn" onclick="field.addEle(this);" class="btn">+</button>';
        field.htmlMap['30'] += '<button type="button" name="fieldDelEleBtn" onclick="field.delEle(this);" class="btn ml5">-</button>';
        field.htmlMap['30'] += '</div>';
        field.htmlMap['30'] += '<div class="inputArea mt10">';
        field.htmlMap['30'] += field.ele['30'] + field.ele['30']+ field.ele['30'];
        field.htmlMap['30'] += '</div>';
        field.htmlMap['30'] += '</td>';
        field.htmlMap['30'] += '</tr>';
    }
    ,	setChk : function(){
        field.htmlMap['40'] = '';
        field.htmlMap['40'] += field.getHeadTr(4,3);

        field.htmlMap['40'] += '<tr>';
        field.htmlMap['40'] += '<th>항목</th>';
        field.htmlMap['40'] += '<td>';

        field.htmlMap['40'] += '<div class="buttonArea ml5 mt10">';
        field.htmlMap['40'] += '<button type="button" name="fieldAddEleBtn" onclick="field.addEle(this);" class="btn">+</button>';
        field.htmlMap['40'] += '<button type="button" name="fieldDelEleBtn" onclick="field.delEle(this);" class="btn ml5">-</button>';
        field.htmlMap['40'] += '</div>';
        field.htmlMap['40'] += '<div class="inputArea mt10">';
        field.htmlMap['40'] += field.ele['40'] + field.ele['40']+ field.ele['40'];
        field.htmlMap['40'] += '</div>';
        field.htmlMap['40'] += '</td>';
        field.htmlMap['40'] += '</tr>';
    }
    ,	setSel : function(){
        field.htmlMap['50'] = '';
        field.htmlMap['50'] += field.getHeadTr(5,4);

        field.htmlMap['50'] += '<tr>';
        field.htmlMap['50'] += '<th>항목</th>';
        field.htmlMap['50'] += '<td>';

        field.htmlMap['50'] += '<div class="buttonArea ml5 mt10">';
        field.htmlMap['50'] += '<button type="button" name="fieldAddEleBtn" onclick="field.addEle(this);" class="btn">+</button>';
        field.htmlMap['50'] += '<button type="button" name="fieldDelEleBtn" onclick="field.delEle(this);" class="btn ml5">-</button>';
        field.htmlMap['50'] += '</div>';
        field.htmlMap['50'] += '<div class="inputArea mt10">';
        field.htmlMap['50'] += field.ele['50'] + field.ele['50'] + field.ele['50'] + field.ele['50'];
        field.htmlMap['50'] += '</div>';
        field.htmlMap['50'] += '</td>';
        field.htmlMap['50'] += '</tr>';
    }
    ,	setFile : function(idx){
        field.htmlMap['60'] = '';
        field.htmlMap['60'] += field.getHeadTr(6,3);

        field.htmlMap['60'] += '<tr>';
        field.htmlMap['60'] += '<th>유형</th>';
        field.htmlMap['60'] += '<td>';


        field.htmlMap['60'] += '<div class="type-file" >';
        if(idx != undefined){
            field.htmlMap['60'] += '<label class="fRadio ml20"><input type="radio" id="fileTypeImg" name="fldVals'+idx+'" title="이미지" value="fileTypeImg" checked="checked" /> <span>이미지</span></label>';
            field.htmlMap['60'] += '<label class="fRadio ml20"><input type="radio" id="fileTypeDocu" name="fldVals'+idx+'" title="문서" value="fileTypeDocu" /> <span>문서</span></label>';
            field.htmlMap['60'] += '<label class="fRadio ml20"><input type="radio" id="fileTypeImgAndDocu" name="fldVals'+idx+'" title="이미지/문서" value="fileTypeImgAndDocu" /> <span>이미지/문서</span></label>';
        }else{
            field.htmlMap['60'] += '<label class="fRadio ml20"><input type="radio" id="fileTypeImg" name="fldVals0" title="이미지" value="fileTypeImg" checked="checked" /> <span>이미지</span></label>';
            field.htmlMap['60'] += '<label class="fRadio ml20"><input type="radio" id="fileTypeDocu" name="fldVals0" title="문서" value="fileTypeDocu" /> <span>문서</span></label>';
            field.htmlMap['60'] += '<label class="fRadio ml20"><input type="radio" id="fileTypeImgAndDocu" name="fldVals0" title="이미지/문서" value="fileTypeImgAndDocu" /> <span>이미지/문서</span></label>';
        }

        field.htmlMap['60'] += '</div>';
        field.htmlMap['60'] += '</td>';
        field.htmlMap['60'] += '</tr>';
    }
    ,	setImg : function(){
        field.htmlMap['70'] = '';
        field.htmlMap['70'] += field.getHeadTr(7,3);

        field.htmlMap['70'] += '<tr>';
        field.htmlMap['70'] += '<th>항목</th>';
        field.htmlMap['70'] += '<td>';

        field.htmlMap['70'] += '<div>';
        field.htmlMap['70'] += '<input type="text" class="w200 readonly" readonly="readonly" id="goodsImgPath" name="fldVals" title="" value="" />';
        field.htmlMap['70'] += '<button type="button" class="btn btn-add ml10" name="goodsImageUploadBtn" >찾아보기</button>';
        field.htmlMap['70'] += '</div>';
        field.htmlMap['70'] += '<div class="mt5">';
        field.htmlMap['70'] += '<span>이미지 설명</span>';
        field.htmlMap['70'] += '<input type="text" name="imgDscrt" class="w20 ml5" placeholder="이벤트 이미지입니다." />';
        field.htmlMap['70'] += '</div>';

        field.htmlMap['70'] += '</td>';
        field.htmlMap['70'] += '</tr>';
    }
    ,	setNotice : function(){
        field.htmlMap['80'] = '';
        field.htmlMap['80'] += field.getHeadTr(8,3);

        field.htmlMap['80'] += '<tr>';
        field.htmlMap['80'] += '<th>항목</th>';
        field.htmlMap['80'] += '<td>';

        field.htmlMap['80'] += '<textarea style="width:90%;" name="fldVals" title="" value="" />';
        field.htmlMap['80'] += '</td>';
        field.htmlMap['80'] += '</tr>';
    }
    ,	append : function(){
        $(".addField-ul").append(field.html);
    }
    ,	remove : function(){
        if($(".addField-li").length>1){
            $(".addField-li").last().remove();
        }
    }
    ,	onchange : function(ele){
        let html = '';
        let type = $(ele).val();
        html += field.colgroup;
        html += '<tbody>';
        if(type === "60"){
            let idx = $(ele).parents(".addField-li").index();
            field.setFile(idx);
        }
        html += field.htmlMap[type];
        html += '</tbody>';
        $(ele).parents(".table_sub").empty().append(html);
    }
    ,	addEle : function(ele){
        let type = $(ele).parents(".table_sub").find(".w100").val();
        let txtBox = field.ele[type];
        $(ele).parent().next().append(txtBox);
    }
    ,	delEle : function(ele){
        if($(ele).parent().next().find("input").length>1){
            $(ele).parent().next().find("input").last().remove();
        }
    }
    ,	reset : function(){
        $(".addField-li").remove();
        field.append();
    }
    ,	serializeJson : function () {
        let eventAddFields = [];
        $(".addField-li").each(function(idx){
            var obj = $(this).serializeJson();
            obj.fldGrp = idx+1;
            if(obj.fldTpCd === "60"){
                let key = "fldVals"+idx;
                obj.fldVals = obj[key];
            }
            if(typeof(obj.fldVals)==="object"){
                obj.fldVals =  obj.fldVals.join(";");
            }

            if(obj.fldTpCd != "00"){
                eventAddFields.push(obj);
            }
        });
        return eventAddFields;
    }
    ,	filterData : function(arr){
        let result = [];
        arr.forEach(function(item){
            if(item.fldTpCd != "00" && (item.fldVals != "" || item.fldGrp != "" || item.fldValsPath != "" ) ){
                result.push(item);
            }
        });
        return result;
    }
};

/*
 * 응모 이벤트 등록 > 신청하기 팝업 > '퀴즈 등록' 제어 객체
 */
var quiz = {
    html : ""
    ,	htmlMap : {
        chk : ""
        ,	rdo : ""
        ,	txt : ""
    }
    ,	init : function(){
        quiz.html = $(".quiz-ul").html();
        quiz.setChk();
        quiz.setRdo();
        quiz.setTxt();
    }
    ,	setChk : function(){
        var html = '';
        html += '<div class="rpl-innerTd">';
        html += '<div class="buttonArea ml10 mt5" style="float:left;">';
        html += '<button type="button" name="quizAddEleBtn" onclick="quiz.addEle(this);" class="btn">+</button>';
        html += '<button type="button" onclick="quiz.delEle(this);" class="btn ml5">-</button>';
        html += '<input type="text" name="rplCnt" value=1 style="width:0px;visibility:hidden;"/>';
        html += '</div>		';
        html += '<div class="ml10 rpl-ul" style="float:left;">';
        html += '<dl>';
        html += '<input type="text" name="rghtansYns" value="true" style="visibility:hidden;width:0px;" /> ';
        html += '<label class="fCheck mt5">';
        html += '<input type="checkbox" class="mt5" id="" name="" title="" checked="checked" value="true" /> <span>1.</span>';
        html += '<input type="text" class="validate[required] w20 mt5" name="rplContents" value="" />';
        html += '</label>';
        html += '</dl>';
        html += '</div>';
        html += '</div>';
        quiz.htmlMap.chk = html;
    }
    ,	setRdo : function(){
        var html = '';
        html += '<div class="rpl-innerTd">';
        html += '<div class="buttonArea ml10 mt5" style="float:left;">';
        html += '<button type="button" name="quizAddEleBtn" onclick="quiz.addEle(this);" class="btn">+</button>';
        html += '<button type="button" onclick="quiz.delEle(this);" class="btn ml5">-</button>';
        html += '<input type="text" name="rplCnt" value=1 style="width:0px;visibility:hidden;"/>';
        html += '</div>';
        html += '<div class="ml10 rpl-ul" style="float:left;">';
        html += '<dl>';
        html += '<input type="text" name="rghtansYns" value="true" style="visibility:hidden;width:0px;"/> ';
        html += '<label class="fRadio mt5">';
        html += '<input type="radio" class="mt5" id="" name="rplContentsRdo" title="" checked="checked" /> <span>1.</span>';
        html += '<input type="text" class="validate[required] w20 mt5" name="rplContents" value="" />';
        html += '</label>';
        html += '</dl>';
        html += '</div>';
        html += '</div>';
        quiz.htmlMap.rdo = html;
    }
    ,	setTxt : function(){
        var html = '';
        html += '<div class="rpl-innerTd">';
        html += '<input type="text" class="validate[required] w200 ml10 mt5" name="rplContents" value="" />';
        html += '</div>';
        quiz.htmlMap.txt = html;
    }
    ,	append : function(){
        $(".quiz-ul").append(quiz.html);
    }
    ,	remove : function(){
        if($(".quiz-li").length>1){
            $(".quiz-li").last().remove();
        }
    }
    ,	onchange : function(ele){
            var key = $(ele).find(optSelect).data("usrdfn1");
            $(ele).parents(".quiz-body").find(".rpl-innerTd").replaceWith(quiz.htmlMap[key]);
            if(key === 'rdo'){
                var rdoGrpIdx = $(ele).parents(".quiz-li").index();
                $(ele).parents(".quiz-li").find("input[name='rplContentsRdo']").attr("name","rplContentsRdo"+rdoGrpIdx);
            }
    }

    ,	addEle : function(ele){
        var key = $(ele).parents(".quiz-body").find("select[name='qstTpCd'] option:selected").data("usrdfn1");
        var dl = '';
        var no = $(ele).parents(".rpl-innerTd").find("dl").length+1;

        var cnt = parseInt($(ele).parent().children("[name='rplCnt']").val())+1;
        $(ele).parent().children("[name='rplCnt']").val(cnt);
        if(key==="chk"){
            dl += '<dl>';
            dl += '<input type="text" name="rghtansYns" value="false" style="visibility:hidden;width:0px;" /> ';
            dl += '<label class="fCheck mt5">';
            dl += '<input type="checkbox" class="mt5" id="" name="" title="" /> <span>'+no+'.</span>';
            dl += '<input type="text" class="validate[required] w20 mt5" name="rplContents" value="" />';
            dl += '</label>';
            dl += '</dl>';
        }else if(key==="rdo"){
            var rdoGrpIdx = $(ele).parents(".quiz-li").index();
            dl += '<dl>';
            dl += '<input type="text" name="rghtansYns" value="false" style="visibility:hidden;width:0px;" /> ';
            dl += '<label class="fRadio mt5">';
            dl += '<input type="radio" class="mt5" id="" name="rplContentsRdo'+rdoGrpIdx+'" title="" /> <span>'+no+'.</span>';
            dl += '<input type="text" class="validate[required] w20 mt5" name="rplContents" value="" />';
            dl += '</label>';
            dl += '</dl>';
        }
        $(ele).parents(".rpl-innerTd").find(".rpl-ul").append(dl);
    }
    ,	delEle : function(ele){
        var length = $(ele).parents(".rpl-innerTd").find("dl").length;
        if(length>1){
            $(ele).parents(".rpl-innerTd").find("dl").last().remove();
            var cnt = parseInt($(ele).parent().children("[name='rplCnt']").val())-1;
            $(ele).parent().children("[name='rplCnt']").val(cnt);
            if(length==2){
                $(ele).parents(".rpl-innerTd").find("dl").find("label").find("input").prop("checked",true);
            }
        }
    }
    ,	reset : function(){
        $(".quiz-li").remove();
        quiz.append();
    }
    ,	serializeJson : function(){
        var questionInfos = [];
        $(".quiz-li").each(function(){
            var obj = $(this).serializeJson();
            obj.rplCnt = obj.rplCnt === undefined ? 1 : obj.rplCnt;
            if(parseInt(obj.rplCnt)>1){
                obj.rghtansYns = obj.rghtansYns.join(";").replace(/true/gi,'Y').replace(/false/gi,'N');
                obj.rplContents = obj.rplContents.join(";");
            }else {
                obj.rghtansYns = "Y";
            }

            if(obj.qstNm != ""){
                questionInfos.push(obj);
            }
        });

        return questionInfos;
    }
    ,	validation : function(arr){
            var result = true;
            arr.forEach(function(o){
                if(o.qstNm==="" || o.rghtansYns.indexOf("Y")===-1 ) {
                    result = false;
                }else if(o.rplContents===""){
                    result = false;
                }else if( typeof(o.rplContents)==="object" && o.rplContents.indexOf("")>-1 ){
                    result = false;
                }
            });
            if(result) result = arr.length != 0;
            return result;
    }

};

// json 모든 이스케이프 문자 치환
var  jsonEscapeStr = {
    escape : function(str){
        return str.replace(/&quot;/gi,"\"").replace(/&#039;/gi,"\'").replace(/&nbsp;/gi," ").replace(/&lt;/gi,"<").replace(/&gt;/gi,">").replace(/&amp;/gi,"&").replace(/&#035;/gi,"#");
    }
    // 쌍 따옴표
    ,	quotes : function(str){
        return str.replace(/&quot;/gi,"\"");
    }
    // 홀 따옴표
    ,	quot : function(str){
        return str.replace(/&#039;/gi,"\'");
    }
    // 공백
    ,	nbsp : function(str){
        return str.replace(/&nbsp;/gi," ");
    }
    // 부등호
    ,	ineQualitySign : function(str){
        return str.replace(/&lt;/gi,"<").replace(/&gt;/gi,">");
    }
    // 앰퍼샌드
    ,	amp : function(str){
        return str.replace(/&amp;/gi,"&");
    }
    // #
    ,	sharp : function(str){
        return str.replace(/&#035;/gi,"#");
    }
};

//xss 관련 객체
var xss = {
    /*
     @param : Object o->객체, String[] keys xss 처리 안할 key
     */
        getXssObject : function(o,keys) {
            let exceptObj = {};

            if(keys != undefined){
                if(typeof(keys)==="object"){
                    let size = keys.length;
                    for(let i =0; i<size; i+=1){
                        let key = keys[i];
                        let eleValue = o[key];
                        exceptObj = xss.replaceEscape(eleValue,exceptObj,key);
                    }
                }
                if(typeof(keys)==="string"){
                    exceptObj[keys] = String(o[keys]).replace(/&quot;/gi,"\"").replace(/&#039;/gi,"\'").replace(/&nbsp;/gi," ").replace(/&lt;/gi,"<").replace(/&gt;/gi,">").replace(/&amp;/gi,"&").replace(/&#035;/gi,"#");
                }
            }


            let obj = {};
            for(let key in o){
                let eleValue = o[key];
                obj[key] = xss.applyXss(eleValue);
            }
            o = keys != undefined ? o = $.extend(obj,exceptObj) : obj ;

            return o;
    }
    // html 에디터 내 escape 문자 치환
    ,   replaceEscape : function(eleValue,exceptObj,key){
            if(typeof(eleValue) === "object" && eleValue != []){
                for(let j in eleValue){
                    if(eleValue[j] != ""){
                        eleValue[j] = String(eleValue[j]).replace(/&quot;/gi,"\"").replace(/&#039;/gi,"\'").replace(/&nbsp;/gi," ").replace(/&lt;/gi,"<").replace(/&gt;/gi,">").replace(/&amp;/gi,"&").replace(/&#035;/gi,"#");
                    }
                }
                exceptObj[key] = eleValue;
            }
            if(typeof(eleValue) === "string" && eleValue != ""){
                exceptObj[key] = String(eleValue).replace(/&quot;/gi,"\"").replace(/&#039;/gi,"\'").replace(/&nbsp;/gi," ").replace(/&lt;/gi,"<").replace(/&gt;/gi,">").replace(/&amp;/gi,"&").replace(/&#035;/gi,"#");
            }

            return exceptObj;
    }
    // 스크립트 치환 해야하는 값 변경 적용
    ,   applyXss : function(eleValue){
            if(typeof(eleValue) === "object" && eleValue != [] ){
                for(let i in eleValue){
                    if(eleValue[i] != ""){
                        eleValue[i] = String(eleValue[i]).replace(/<+\/*[script|php|%]*[a-zA-Zㄱ-힣\s\'\"=<?>]*[?\/>]*>/gi,"").replace(/\"/gi,"'");
                    }

                }
            }
            if(typeof(eleValue) === "string" && eleValue != "" ){
                eleValue = String(eleValue).replace(/<+\/*[script|php|%]*[a-zA-Zㄱ-힣\s\'\"=<?>]*[?\/>]*>/gi,"").replace(/\"/gi,"'");;
            }

            return eleValue;
    }
};

// 이미지 업로드
function fnResultImage(file, objId) {
    var fileExe = file.fileExe.toLowerCase();
    var target = ["png","gif","jpeg","jpg"];
    if(target.indexOf(fileExe) > -1){
        $("#" + objId + "Path").val(file.filePath);
        $("#" + objId + "View").attr('src', '/common/imageView.do?filePath=' + file.filePath );
        $("#" + objId + "DelBtn").show();
    }else{
        messager.alert("등록 불가능한 확장자 입니다.","Info");
    }
};
// 이미지 삭제
function fnDeleteImage (id) {
    $("#" + id + "Path").val("");
    $("#" + id + "View").attr('src', '/images/noimage.png' );
    $("#" + id + "DelBtn").hide();
};

//seo 팝업
function fnSeoInfoLayer(){
    var options = {
        url : '/display/seoInfoPop.do'
        , data : {seoInfoNo : $("[name='seoInfoNo']").val() }
        , dataType : "html"
        , callBack : function (result) {
            var addBtnTxt = $("[name='seoInfoNo']").val() != "" ? "수정" : "등록" ;
            var config = {
                id : "seoInfoDetail"
                , width : 960
                , height : 700
                , top : 70
                , title : "SEO 상세정보"
                , button : "<button type=\"button\" onclick=\"updateSeoInfoPopup();\" class=\"btn btn-add\">"+addBtnTxt+"</button>" + "<button type=\"button\" onclick=\"fnResetSeoForm();\" class=\"btn btn-ok ml10\">초기화</button>"
                , body : result
            };
            layer.create(config);
            $("#seoInfoDetail_dlg-buttons").find(".btn-cancel").hide();
        }
    };
    ajax.call(options);
}
//seo 팝업 콜백
function callBackSaveSeoInfo(seoInfoNo) {
    $("[name='seoInfoNo']").val(seoInfoNo);
}

//쿠폰 검색 팝업
function fnCouponLayer(){
    var options = {
            cpPvdMthCd : "40"
        ,   isReadonlyCpPvdMthCd : true
        ,   callBack : function(result){
                var cp = result[0];
                $("[name='cpNo']").val(cp.cpNo);
                $("[name='cpNm']").val(cp.cpNm);
        }
    };
    layerCouponList.create(options);
}