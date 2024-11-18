<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		
		$(document).ready(function(){
			fncTermsCtg1();
			
			fncCreateTermsGrid();
			
            $(document).on("keydown","#termsSearchForm input",function(){
      			if ( window.event.keyCode == 13 ) {
      				fncSearchTermsGrid();
    		  	}
            });				
		});
		
		$(function(){
			//POC 구분 클릭 이벤트
			$("input:checkbox[name=arrPocGb]").click(function(){
				var all = false;
				if ( validation.isNull( $(this).val() ) ){
					all = true;
				}
				if ( $('input:checkbox[name="arrPocGb"]:checked').length == 0 ) {
					//$('input:checkbox[name="arrPocGb"]').eq(0).prop( "checked", true );
				} else {
					$('input:checkbox[name="arrPocGb"]').each( function() {
						if ( all ) {
							if ( validation.isNull( $(this).val() ) ) {
								$(this).prop("checked", true);
							} else {
								$(this).prop("checked", false);
							}
						} else {
							if ( validation.isNull($(this).val() ) ) {
								$(this).prop("checked", false);
							}
						}
					});
				}
			});
		});
		
		// 통합약관 그리드
		function fncCreateTermsGrid() {
			var options = {
				url : "<spring:url value='/appweb/termsListGrid.do' />"
				, height : 400
				, searchParam : fncSerializeFormData()
				, colModels : [
					{name:"termsNo", label:'No', width:"80", key:true, align:"center", sortable:false}
					, {name:"categoryNm", label:'<spring:message code="column.ctg_cd"/>', width:"200", align:"center", sortable:false}
					, {name:"pocGbNm", label:'<spring:message code="column.terms_pocgb"/>', width:"150", align:"center", sortable:false}
					, {name:"termsNm", label:'<spring:message code="column.terms_nm"/>', width:"150", align:"left", sortable:false}
					, {name:"termsVer", label:'<b><u><tt><spring:message code="column.version"/></tt></u></b>', width:"90", align:"center", classes:'pointer fontbold', sortable:false}
					, {name:"termsStrtDt", label:'<spring:message code="column.terms_appl_period"/>', width:"200", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject){
							var str = "";
							if(rowObject.endDtCmplYn == "Y"){
								str = cellvalue + " ~ " + rowObject.termsEndDt;
							}else{
								str = cellvalue + " ~";
							}
							
							return str;
						}
					}
					, {name:"useNm", label:'<spring:message code="column.use_yn"/>', width:"90", align:"center", sortable:false}
					, {name:"rqidNm", label:'<spring:message code="column.required"/>', width:"90", align:"center", sortable:false}
					, {name:"sysRegDtm", label:'<spring:message code="column.terms_dt_created"/>', width:'100', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd", sortable:false}
					, {name:"sysRegrNm", label:'<spring:message code="column.terms_writer"/>', width:'90', align:'center', sortable:false} 
					, {name:"pushMessageBtn", label:'<spring:message code="column.terms_version_up"/>', width:"100", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
							var str = "";
							if(rowObject.newYn == "Y"){
								str = '<button type="button" onclick="termsUpdateView('+ rowObject.termsNo +', \'Y\');" class="btn btn-add"><spring:message code="column.terms_ver_up"/></button>';
							}
							return str;
						}
					}
				]
				, multiselect : false
				, onCellSelect : function(id, cellidx, cellvalue) {
					if (cellidx == 4) {
						termsUpdateView(id, "N");
					}
				}
				, gridComplete : function() {
					$("#noData").remove();
					var grid = $("#termsList").jqGrid('getRowData');
					if(grid.length <= 0) {
						var str = "";
						str += "<tr id='noData' role='row' class='jqgrow ui-row-ltr ui-widget-content'>";
						str += "	<td role='gridcell' colspan='11' style='text-align:center;'>조회결과가 없습니다.</td>";
						str += "</tr>"
							
						$("#termsList.ui-jqgrid-btable").append(str);
					}
					
					//업데이트 내용 줄임말
					$("#termsList td[aria-describedby=termsList_termsNm]").css("text-overflow", "ellipsis"); // 줄임말
					$("#termsList td[aria-describedby=termsList_termsNm]").css("white-space", "nowrap"); // 한줄로 표기
					$("#termsList td[aria-describedby=termsList_termsNm]").css("overflow", "hidden"); // 스크롤 숨김
				}
			};
			
			grid.create("termsList", options);
		}
		
		//조회
		function fncSearchTermsGrid() {
			// 노출 POC 구분 필수 선택
			if ( $('input:checkbox[name="arrPocGb"]:checked').length == 0 ) {
				messager.alert("노출 POC 구분을 선택해 주세요.", "Info", "info");
			}
			
			var options = {
				searchParam : fncSerializeFormData()
			};

			grid.reload("termsList", options);
		}
		
		//데이터 셋팅
		function fncSerializeFormData() {
            var data = $("#termsSearchForm").serializeJson();
            if ( undefined != data.arrPocGb && data.arrPocGb != null && Array.isArray(data.arrPocGb) ) {
                $.extend(data, {arrPocGb : data.arrPocGb.join(",")});
            } else {
                // 전체를 선택했을 때 Array.isArray 가 false 여서 이 부분을 실행하게 됨.
                // 전체를 선택하면 검색조건의 모든 POC구분을 배열로 만들어서 파라미터 전달함.
                var arrPocGb = new Array();
                if ($("#arrPocGb_default").is(':checked')) {
                    $('input:checkbox[name="arrPocGb"]').each( function() {
                        if (! $(this).is(':checked')) {
                        	arrPocGb.push($(this).val());
                        }
                    });

                    $.extend(data, {arrPocGb : arrPocGb.join(",")});
                }
            }

            return data;
		}
		
		//검색 초기화
		function fncSearchReset() {
			resetForm("termsSearchForm");
			
			fncTermsCtg2();
			
			fncSearchTermsGrid();
		}
		
		//통합약관 등록 페이지
		function termsInsertView() {
			addTab('통합약관 신규등록', '/appweb/termsInsertView.do');
		}
		
		//통합약관 상세 페이지
		function termsUpdateView(termsNo, verUpYn) {
			addTab('통합약관 상세', '/appweb/termsUpdateView.do?termsNo='+termsNo+'&verUpYn='+verUpYn);
		}
		
		//약관 카테고리 1Depth 조회
		function fncTermsCtg1(){
			var options = {
				url : "<spring:url value='/appweb/getTermsCategoryList.do' />"
				, data : {}
				, callBack : function(result) {
					if(result.length != 0){
						termsCtgList = result;
						
						let htmlString = "";
						for(idx in termsCtgList){
							if(termsCtgList[idx].usrDfn1Val == ''){
								//htmlString += '<option value="'+result[idx].dtlCd+'" data-usrdfn1="'+result[idx].usrdfn1+'" title="'+result[idx].dtlNm+'">'+result[idx].dtlNm+'</option>';
								htmlString += '<option value="'+termsCtgList[idx].dtlCd+'" title="'+termsCtgList[idx].dtlNm+'"';
								htmlString += '>'+termsCtgList[idx].dtlNm+'</option>';
							}
                		}
						
						$("#termsCd1").append(htmlString);
					}
				}
			};
			ajax.call(options);
		}
		
		//약관 카테고리 2Depth 조회
		function fncTermsCtg2(){
			$("#termsCd2").html('<option value="">전체</option>');
			$("#termsCd3").html('<option value="">전체</option>');
			
			if($("#termsCd1").val() != ""){
				let htmlString = "";
				for(idx in termsCtgList){
					if($("#termsCd1").val() == termsCtgList[idx].usrDfn1Val && termsCtgList[idx].usrDfn2Val == ''){
						//htmlString += '<option value="'+result[idx].dtlCd+'" data-usrdfn1="'+result[idx].usrdfn1+'" title="'+result[idx].dtlNm+'">'+result[idx].dtlNm+'</option>';
						htmlString += '<option value="'+termsCtgList[idx].dtlCd+'" title="'+termsCtgList[idx].dtlNm+'"';
						htmlString += '>'+termsCtgList[idx].dtlNm+'</option>';
					}
        		}
				$("#termsCd2").append(htmlString);
			}
		}
		
		//약관 카테고리 3Depth 조회
		function fncTermsCtg3(){
			$("#termsCd3").html('<option value="">전체</option>');
			
			if($("#termsCd2").val() != ""){
				let htmlString = "";
				for(idx in termsCtgList){
					<%--if(($("#termsCd1").val()+$("#termsCd2").val()) == termsCtgList[idx].usrDfn1Val){--%>
					if($("#termsCd2").val() == termsCtgList[idx].usrDfn2Val){
						//htmlString += '<option value="'+result[idx].dtlCd+'" data-usrdfn1="'+result[idx].usrdfn1+'" title="'+result[idx].dtlNm+'">'+result[idx].dtlNm+'</option>';
						htmlString += '<option value="'+termsCtgList[idx].dtlCd+'" title="'+termsCtgList[idx].dtlNm+'"';
						htmlString += '>'+termsCtgList[idx].dtlNm+'</option>';
					}
        		}
				$("#termsCd3").append(htmlString);
			}
		}
		
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width: 100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding: 10px">
				<form name=termsSearchForm" id="termsSearchForm">
					<table class="table_type1">
						<caption>통합약관 검색</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.terms_category" /></th> <%-- 약관 카테고리 --%>
								<td colspan="3">
									<select name="termsCd1" id="termsCd1" onchange="fncTermsCtg2();">
										<option value="">전체</option>
									</select>
									<select name="termsCd2" id="termsCd2" onchange="fncTermsCtg3();">
										<option value="">전체</option>
									</select>
									<select name="termsCd3" id="termsCd3">
										<option value="">전체</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.terms_rqidyn" /></th> <%-- 동의 필수여부 --%>
								<td>
									<select name="rqidYn" id="rqidYn">
										<option value="">전체</option>
										<option value="Y">필수</option>
										<option value="N">선택</option>
									</select>
								</td>
								<th scope="row"><spring:message code="column.terms_useyn" /></th> <%-- 약관 사용여부 --%>
								<td>
									<select name="useYn" id="useYn">
										<frame:select grpCd="${adminConstants.USE_YN}" defaultName="전체"/>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.terms_pocgb" /></th> <%-- 노출 POC --%>
								<td colspan="3">
									<frame:checkbox name="arrPocGb" grpCd="${adminConstants.TERMS_POC_GB}" defaultName="전체" defaultId="arrPocGb_default"/>
								</td>
							</tr>
						</tbody>
					</table>
				</form>

				<div class="btn_area_center">
					<button type="button" onclick="fncSearchTermsGrid();" class="btn btn-ok">조회</button>
					<button type="button" onclick="fncSearchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		
		<div class="mModule">
			<div class="mButton">
				<div class="rightInner">
					<button type="button" onclick="termsInsertView();" class="btn btn-add"><spring:message code="column.terms_new_reg" /></button> <%-- 약관 신규등록 --%>
				</div>
			</div>

			<table id="termsList"></table>
			<div id="termsListPage"></div>
		</div>
		
	</t:putAttribute>
</t:insertDefinition>