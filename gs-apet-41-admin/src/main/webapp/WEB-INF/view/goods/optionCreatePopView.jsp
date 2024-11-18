<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">

			$(document).ready(function(){
			});

			function createOptionExec() {
				if ( validate.check("optionForm") ) {
					messager.confirm("<spring:message code='column.display_view.message.confirm_save' />",function(r){
						if(r){
							var orgAttrNo = "";
							var orgAttrNm = "";
							var options = {
									url : "<spring:url value='/goods/saveNewOption.do' />"
									, data : $("#optionForm").serializeJson()
									, callBack : function(result ) {
										console.log(result);
	
										if(result.result == '' ){
											messager.alert("<spring:message code='column.common.regist.final_msg' />", "Info", "info", function(){
												opener['reloadAttrListGrid']();
											});
										}else{
											orgAttrNo = result.result[0].attrNo ;
											orgAttrNm = result.result[0].attrNm;											
											messager.alert("<spring:message code='column.common.delete.final_msg' arguments='" + orgAttrNm + "' />", "Info", "info");
										}
										popupClose();
									}
								};
								ajax.call(options);
						}
					});
				}
			}

		</script>
	

		<form id="optionForm" name="optionForm" method="post" >

		<table class="table_type1">
			<caption>옵션 등록</caption>
			<tbody>
				<tr>
					<th scope="row"><spring:message code="column.goods.option_nm" /><strong class="red">*</strong></th>
					<td>
						<input class="validate[required]" type="text" id="attrNm" name="attrNm" value=""/>
					</td>
				</tr>

			</tbody>
		</table>
		</form>

