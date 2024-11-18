<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

		<script type="text/javascript">

			$(document).ready(function(){
				createCompanyApiPermitIpListGrid();
			});
			// 등록 실행
			function fnInsertExec() {
				var pmtIp =  $("#pmtIp").val();
				if ( validate.check("companyApiPremitForm")  && ChkIP( $("#pmtIp").val() )) {
					var gridData = $("#apiPermitIpList").jqGrid('getRowData');
	            	if(gridData.length > 0){
		                for (var i = 0; i < gridData.length; i++) {
		                	if (gridData[i].pmtIp == pmtIp) {
		                		messager.alert("<spring:message code='admin.web.view.msg.company.already_regist' />", "Info", "info");
		                		return;
		                   }
		                }
	            	}
					
	            	messager.confirm('<spring:message code="column.confirm.api_key_one_create" />', function(r){
		                if (r){
		                	var options = {
								url : "<spring:url value='/company/insertApiPermitIp.do' />"
								, data : $("#companyApiPremitForm").serializeJson()
								, callBack : function(result){
									messager.alert("<spring:message code='admin.web.view.common.regist.final_msg' />", "Info", "info", function(){
										reloadApiPermitIpListGrid();
									});
								}
							};
							ajax.call(options);
		                }
	            	});
				}
			}
			
			// 삭제 실행
			function fnDeleteExec() {
				var grid = $("#apiPermitIpList");
				var selectedIDs = grid.getGridParam("selarrrow");
				
				//선택되지 않은경우
				if ( selectedIDs.length == 0 ) {
					messager.alert("<spring:message code='admin.web.view.common.select.object' />", "Info", "info");
					return;
				}
				var ipSeqs = new Array();
				for ( var i in selectedIDs ) {
					var rowData = grid.getRowData( selectedIDs[i] );
					ipSeqs.push(rowData.ipSeq);
				}
				
				var data = {  
						ipSeqs : ipSeqs
 				};
				

				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
	                if (r){
	                	var options = {
    						url : "<spring:url value='/company/deleteApiPermitIp.do' />"
    						, data : data
    						, callBack : function(result){
    							messager.alert("<spring:message code='admin.web.view.common.process.final_msg' />", "Info", "info", function(){
    								reloadApiPermitIpListGrid();
    							});
    						}
    					};
    					ajax.call(options);
	                }
            	});
			}
			
			// API 허용 IP 목록
            function createCompanyApiPermitIpListGrid(){
                var options = {
                    url : "<spring:url value='/company/companyApiPermitIpListGrid.do' />"
                    , height : 200
                    , multiselect : true
                    , searchParam : {
                    	compNo : '${company.compNo}'
                    }
                    , colModels : [
                          {name:"compNo", label:"<spring:message code='column.compNo' />", width:"120", align:"center", sortable:false,hidden:true } /* 업체명 */ 
                    	, {name:"ipSeq", label:"<spring:message code='column.srl_no' />",  key:true, width:"100", align:"center", sortable:false} /* 상품 번호 */
                    	, _GRID_COLUMNS.compNm
                    	, {name:"pmtIp", label:"<spring:message code='column.pmt_ip' />", width:"200", align:"center", sortable:false } /* IP */
                         
                        ]
                    , paging : false
                };
                grid.create("apiPermitIpList", options);
            }
			
         	// 조회
			function reloadApiPermitIpListGrid() {
				var options = {
						compNo : '${company.compNo}'
				}
				grid.reload( "apiPermitIpList", options );
			}

			function ChkIP(IPValue) {
				var rtn = true;
		        var ipPattern = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/;
		        var ipBool = IPValue.match(ipPattern); // IPvalue 오타
		       
		        if(IPValue == "0.0.0.0") {
		        	messager.alert("<spring:message code='admin.web.view.msg.company.info.ex_ip' arguments='"+IPValue+"' />", "Info", "info");
		            //return false;
		            rtn = false;
		        }
		        else if(IPValue == "255.255.255.255") {
		        	messager.alert("<spring:message code='admin.web.view.msg.company.info.ex_ip' arguments='"+IPValue+"' />", "Info", "info");
		            //return false;
		            rtn = false;
		        }
		        else if(IPValue == "*") {
		            //return true;
		            rtn = true;
		        }
		        else {
		            if(ipBool == null) {
		            	messager.alert("<spring:message code='admin.web.view.msg.company.info.form_invalid' />", "Info", "info");
		                //return false;
			            rtn = false;
		            }
		            else {
		                for (i = 1; i < 5; i++) {
		                    thisSegment = ipBool[i];
		                    if(i == 1) {
								if (thisSegment < 1 || thisSegment > 223) { //1번째칸 1~223
									
									messager.alert("<spring:message code='admin.web.view.msg.company.info.form_custom_invalid' arguments='"+"1~223.X.X.X"+"'/>", "Info", "info");
								 	//return false;
					           	 	rtn = false;
								}
							}else if(i == 2 || i == 3) {
								if (thisSegment < 0 || thisSegment > 254) { //2,3 번째칸 0~ 254
									messager.alert("<spring:message code='admin.web.view.msg.company.info.form_custom_invalid' arguments='"+"X.0~254.0~254.X"+"'/>", "Info", "info");
									//return false;
						            rtn = false;
								}
							}else {
								if (thisSegment < 1 || thisSegment > 254) { //4 번째칸 1~ 254
									messager.alert("<spring:message code='admin.web.view.msg.company.info.form_custom_invalid' arguments='"+"X.X.X.1~254"+"'/>", "Info", "info");
									 //return false;
						            rtn = false;
								}
		                    }
		                }
		            }
		        }
		        return rtn;
		    }
		</script>
			<form id="companyApiPremitForm" name="companyApiPremitForm" method="post" >
				<input type="hidden" name="compNo" id="compNo" value="${company.compNo}">
			<table class="table_type1 popup">
				<caption>API 허용 IP</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.goods.comp_nm"/></th>
						<td>
							${company.compNm}
						</td>
						<th><spring:message code="column.pmt_ip"/><strong class="red">*</strong></th>
						<td>
							<!-- 허용 IP -->
							<input type="text" class="validate[required]" name=pmtIp id="pmtIp" title="<spring:message code="column.pmt_ip"/>" value="" pattern="###.###.###.###"/>
						</td>
					</tr>
				</tbody>
			</table>
			</form>

			<div class="btn_area_center"> 
				<button type="button" class="btn btn-ok" onclick="fnInsertExec();"><spring:message code="column.api_key_one_create" /></button>
			</div>
			
			
			<div id="apiPermitIpView">
				<div class="mTitle mt30">
					<h2>API 허용 IP 목록</h2>
					<div class="buttonArea">
						<button type="button" onclick="fnDeleteExec();"  class="btn btn-add">삭제</button>
					</div>
				</div>
	
				<div class="mModule no_m">
					<table id="apiPermitIpList" ></table>
				</div>
			</div>
			

