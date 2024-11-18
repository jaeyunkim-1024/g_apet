<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">  
<!-- <script type="text/javascript" src="/tools/jquery/jquery-ui-1.11.4/jquery-ui.min.js" charset="utf-8"></script> -->
		<style>
	         .custom-tabs-header{
	             border-top-style: none;
	             border-left-style: none;
	             border-right-style: none;
	             background: white;
	         }
	    </style>
		<script type="text/javascript">
			$(document).ready(function(){
				// 그리드 width 고정
                $(".panel").css("width", $("#tabs").width());
                
				createPetGrid();
				createInclGrid();
				createSubInclGrid();
				
// 				$("#tabs").tabs();

				//$(".pet_img").bighover();
				//$("#test").hover(function(){alert("???")})
				
			});
			
            $(document).on("click",".tabs li",function(){
                $(".tabs li").removeClass("tabs-selected");
                $(this).addClass("tabs-selected");
                
                $(".panel").hide();
                var obj = $(this).children("a").attr("href");
                $(obj).show();
            });
            
            $(document).on("change", "#inclStDt , #inclEnDt", function(e){
            	searchInclByDt()	
            })

            function searchInclByDt(){

            	
            	var starr = $("#inclStDt").val().split("-");
		    	var endarr = $("#inclEnDt").val().split("-");
		    	var stdate = new Date(starr[0], starr[1], starr[2] );
		    	var enddate = new Date(endarr[0], endarr[1], endarr[2] );

		    	var diff = enddate - stdate;
		    	var diffDays = parseInt(diff/(24*60*60*1000));
            	
		    	
		    	if($("#inclStDt").data("diffDays") == diffDays){
            		return;
            	}
		    	
		    	if(diffDays < 0 ){
		    		messager.alert("종료일이 시작일보다 크게 선택해 주세요", "Info", "info" );		    	
		    		$("#inclStDt").data("diffDays" , diffDays);
		    		return;
		    	} 
		    	
		    	if(diffDays > 90){
		    		messager.alert("기간 선택범위를 3개월로 선택해 주세요", "Info", "info" );
		    		$("#inclStDt").data("diffDays" , diffDays);
		    		return;
		    	}
		    	
	    		window.setTimeout(function(){
					reloadInclListGrid();
					reloadSubInclListGrid();
				}, 200)
            }
           
			function createPetGrid(){
				var options = {
					url : "<spring:url value='/member/petListGrid.do' />"
					, height : 200
					, searchParam : $("#petForm").serializeJson()
					, rownumbers : true
					, paging : false
					, sortname : 'sysRegDtm'
					, sortorder : 'DESC'
					, colModels : [
						{name:"mbrNo", hidden:true}
						, {name:"petGbCd",	label:'<spring:message code="column.gb_cd" />',		width:"120",	align:"center",	sortable:false, formatter:"select",	editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PET_GB}" />"}}
						, {name:"imgPath", 	label:'<spring:message code="column.pet_image" />',	width:"110",	align:"center",	sortable:false, formatter:imgPathFormat}
						, {name:"petNm", 	label:'<spring:message code="column.name" />', 		width:"120", 	align:"center", sortable:false}
						, {name:"petKindNm",label:'<spring:message code="column.pet_kind_nm" />',width:"110",	align:"center",	sortable:false}
						, {name:"age", 		label:'<spring:message code="column.pet_age" />', 	width:"120", 	align:"center", sortable:false, formatter:function(cellValue, options, rowObject){
							return cellValue + "살";
						}}
						, {name:"petGdGbCd",label:'<spring:message code="column.pet_gd_gb_cd" />',width:"110",	align:"center",	sortable:false, formatter:"select",	editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PET_GD_GB}" />"}}
						, {name:"weight", 	label:'<spring:message code="column.pet_weight" />',width:"120", 	align:"center", sortable:false, formatter:function(cellValue, options, rowObject){
							if(cellValue != null && cellValue != "")	return cellValue + "KG";
							else										return "";
						}}
						, {name:"petInclCnt",label:'<spring:message code="column.pet_incl_cnt" />',	width:"110",align:"center",	sortable:false}
						, {name:"diseaseNm", label:'<spring:message code="column.disease_nm" />',width:"170",	align:"center",	sortable:false}
						, {name:"allergyNm", label:'<spring:message code="column.allergy_nm" />',width:"170",	align:"center",	sortable:false}
						, {name:"petNo", 	label:'<spring:message code="column.pet_no" />', 	width:"120", 	align:"center", sortable:false}
						, {name:"sysRegDt", label:'<spring:message code="column.sys_reg_dt" />',width:"110",	align:"center",	sortable:false}
					]
					, gridComplete: function(){
						var gridData = $("#petList").jqGrid('getRowData');
						
						$(this).find("tr").each(function(index, item){
							var imgObj = $(this).find("td").eq(3).find("img");
							if(imgObj.attr("class") == "pet_img") {
								imgObj.bighover({"width":"500", "height":"500"});	
							}
						});
					}
					, onSelectRow : function(ids) {
						var rowdata = $("#petList").getRowData(ids);
						$("#petNo").val(rowdata.petNo);
						
						reloadInclListGrid();
						reloadSubInclListGrid();
					}
					,   loadComplete : function(res){
						res.data.length == 0 ? $("#pet-list-empty").show() : $("#pet-list-empty").hide();
					}
				};
				grid.create("petList", options);
			}
            
            function imgPathFormat(cellValue, options, rowObject) {
            	if(cellValue != null && cellValue != '') {
                	return '<img id="test'+ rowObject.petNo + '" src="${frame:imagePath("' + cellValue + '")}" class="pet_img" style="width:40px; height:40px;" onError="this.src=\'/images/noimage.png\'"  />';	
            	} else {
                	return '<img src="/images/noimage.png" style="width:40px; height:40px;" alt="" />';	
            	}
            }

			function createInclGrid(){
				var options = {
					url : "<spring:url value='/member/petInclListGrid.do' />"
					, height : 260
					, rownumbers : true
					, sortname : 'inclDt'
					, sortorder : 'DESC'
					, colModels : [
						{name:"petNo", hidden:true}
						, {name:"imgPath", hidden:true}
						, {name:"inclGbCd",	label:'<spring:message code="column.gb_cd" />',			width:"120",	align:"center",	sortable:false, formatter:"select",	editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.INCL_GB}" />"}}
						, {name:"inclNm", 	label:'<spring:message code="column.incl_nm" />',		width:"150",	align:"center",	sortable:false}
						, {name:"inclDt", 	label:'<spring:message code="column.incl_dt" />', 		width:"120", 	align:"center", sortable:false}
						, {name:"trmtHsptNm",label:'<spring:message code="column.trmt_hspt_nm" />',	width:"250",	align:"center",	sortable:false}
						, {name:"memo",		label:'<spring:message code="column.incl.memo" />', 		width:"500", 	align:"center", sortable:false}
						, {name:"ctfc",		label:'<spring:message code="column.incl_ctfc" />',		width:"110",	align:"center",	sortable:false, formatter:ctfcFormat}
					]
					,   loadComplete : function(res){
							if(res.data.length == 0){
								$("#inclListPage_right div").html("<span class='red'>조회결과가 없습니다.</span>");
							}
					}
				};
				grid.create("inclList", options);
			}
			
			function ctfcFormat(cellValue, options, rowObject) {
				if(cellValue == 'N') {
					return "─";
				} else {
					return "<button type='button' onclick='petInclCtfcImageLayerView(\"" + rowObject.imgPath + "\")' class='btn btn-add'>확인</button>";
				}
			}

			function petInclCtfcImageLayerView (imgPath) {
				var options = {
					url : "<spring:url value='/member/petInclCtfcImageLayerView.do' />"
					, data : { imgPath : imgPath }
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "petInclCtfcImageLayerView"
							, width : 1000
							, height : 800
							, top : 200
							, title : "예방접종 증명서"
							, body : data
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			}

			function createSubInclGrid(){
				var options = {
						url : "<spring:url value='/member/petInclListGrid.do' />"
						, height : 260
						, rownumbers : true
						, sortname : 'inclDt'
						, sortorder : 'DESC'
						, colModels : [
							{name:"petNo", hidden:true}
// 							, {name:"imgPath", hidden:true}
// 							, {name:"inclNo", 	label:'<spring:message code="column.incl_dt" />', 		width:"50", 	align:"center", sortable:false}
							, {name:"inclDt", 	label:'<spring:message code="column.incl_sub_dt" />', 		width:"120", 	align:"center", sortable:false}	
// 							, {name:"inclGbCd",	label:'<spring:message code="column.gb_cd" />',			width:"120",	align:"center",	sortable:false, formatter:"select",	editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.INCL_GB}" />"}}
							, {name:"inclNm", 	label:'<spring:message code="column.inject_nm" />',		width:"150",	align:"center",	sortable:false}
							, {name:"memo",		label:'<spring:message code="column.incl.memo" />', 		width:"500", 	align:"center", sortable:false}
							, {name:"trmtHsptNm",label:'<spring:message code="column.inject_hspt" />',	width:"250",	align:"center",	sortable:false}
						]
						,   loadComplete : function(res){
								if(res.data.length == 0){
									$("#subInclListPage_right div").html("<span class='red'>조회결과가 없습니다.</span>");
								}
						}
					};
					grid.create("subInclList", options);
			}
			
			function reloadInclListGrid(){
				$("#tabNo").val(1);
				var options = {
					searchParam : $("#petForm").serializeJson()
				};

				grid.reload("inclList", options);
			}

			function reloadSubInclListGrid(){
				$("#tabNo").val(2);
				var options = {
					searchParam : $("#petForm").serializeJson()
				};

				grid.reload("subInclList", options);
			}
			
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<form name="petForm" id="petForm" method="post">
			<input type="hidden" id="mbrNo" name="mbrNo" value="${mbrNo }" />
			<input type="hidden" id="petNo" name="petNo" />
			<input type="hidden" id="tabNo" name="tabNo" />
		
			<div class="mTitle">
	        	<h2>반려동물 정보</h2>
	    	</div>
			<div class="mt5 ml10" id="pet-list-empty" style="display:none;">
				<span class="red" style="font-size:13px;">조회결과가 없습니다.</span>
			</div>
			<div class="mModule">
				<table id="petList" class="grid"></table>
			</div>
												  
	        <div id="tabs" style="margin-top:30px;">
	            <div class="tabs-header custom-tabs-header">
	                <div class="tabs-wrap">
	                    <div style="background:white">
	                        <ul class="tabs" style="height: 26px;">
	                            <li class="tabs-first tabs-selected" onclick="reloadInclListGrid();">
	                                <a href="#tab1" class="tabs-inner" style="height: 25px; line-height: 25px;">
	                                    <span class="tabs-title">접종내역</span>
	                                    <span class="tabs-icon"></span>
	                                </a>
	                            </li>
	                            <li class="tabs-last" onclick="reloadSubInclListGrid();">
	                                <a href="#tab2" class="tabs-inner" style="height: 25px; line-height: 25px;">
	                                    <span class="tabs-title">투약기록</span>
	                                    <span class="tabs-icon"></span>
	                                </a>
	                            </li>
	                        </ul>
	                    </div>
	                </div>
	            </div>
				<div style="padding-top:10px;text-align: right;">
				<frame:datepicker required="Y" startDate="inclStDt"
 	 											  startValue="${frame:addMonth('yyyy-MM-dd', -1) }"
 	 											  endDate="inclEnDt"
 	 											  endValue="${frame:toDate('yyyy-MM-dd') }"
 	 											  />
				<button id ="hiddenSearchBtn" style ="display:none;"></button> 	 											  
				</div>
	            <div class="tabs-panels mt10">											  
	                <div id="tab1" class="panel panel-htop" style="display:block">
	                    <table id="inclList"></table>
	                    <table id="inclListPage"></table>
	                </div>
	                <div id="tab2" class="panel panel-htop" style="display:none;">
	                    <table id="subInclList"></table>
	                    <table id="subInclListPage"></table>
	                </div>
	            </div>
	        </div>
			
<!-- 			<div id="tabs"> -->
<!-- 				<ul> -->
<!-- 					<li><a href="#tab1">탭1</a></li> -->
<!-- 					<li><a href="#tab2">탭2</a></li> -->
<!-- 				</ul> -->
<!-- 				<div id="tab1"> -->
<!-- 					<table id="inclList"></table> -->
<!-- 	                <table id="inclListPage"></table> -->
<!-- 	            </div> -->
<!-- 				<div id="tab2"> -->
<!-- 	                <table id="healthCheckList"></table> -->
<!-- 	                <table id="healthCheckListPage"></table> -->
<!-- 				</div> -->
<!-- 			</div> -->
	
		</form>
	</t:putAttribute>
</t:insertDefinition>