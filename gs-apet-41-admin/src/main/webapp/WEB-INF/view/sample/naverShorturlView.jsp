<%--	
 - Class Name	: /sample/naverShorturlView.jsp
 - Description	: shorturl View
 - Since			: 2021.1.8
 - Author			: VALFAC
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {
		});
		
		function generate() {
			if(validate.check("shortUrlForm")) {
				var options = {
					url : "<spring:url value='/sample/getShortUrl.do' />",
					data : $("#shortUrlForm").serialize(),
					callBack : function(data) {
						$("#shortUrl").val(data);
					}
				}
				ajax.call(options);
			}
		}
		
		function headerGenerate() {
			if(validate.check("apiHeaderForm")) {
				var options = {
					url : "<spring:url value='/sample/getNaverApiHeader.do' />",
					data : $("#apiHeaderForm").serialize(),
					callBack : function(data) {
						$("#apigwTimestamp").val(data.split("||")[0]);
						$("#apigwSignature").val(data.split("||")[1]);
						// 인증 번호 입력 시간 카운트다운
					    $(".crtfCountDownArea").show();
					    var endTime = new Date();
					    endTime.setMinutes(endTime.getMinutes() + 5);
					    $(".crtfCountDownArea").countdown(endTime, function (event) {
					        var mm = event.strftime('%M');
					        var ss = event.strftime('%S');
					        $(".crtfCountDownArea").html(mm + ":" + ss);
					    }).on('finish.countdown', function () {
					        $(".crtfCountDownArea").hide();
					        $(".apigw").val('');
					    });
					}
				}
				ajax.call(options);
			}
		}
		
		function formReset() {
			$("#originUrl").val('');
			$("#shortUrl").val('');
		}
		
		function headerFormReset() {
			$("#apiHeaderForm")[0].reset();
		}
		
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion"
			data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect"
			style="width: 100%">
			<div title="Short URL" style="padding: 10px">
				<div class="box">
					<div>
						<ul style="font-size: 13px;">
							<li style="margin-bottom: 5px;"><b>·</b> ShortUrl 관련은 /gs-apet-41-admin/src/main/java/admin/web/view/sample/controller/SampleController.java 및 /gs-apet-41-admin/src/main/webapp/WEB-INF/view/sample/naverShorturlView.jsp 참고 부탁드립니다.</li>
							<li style="margin-bottom: 5px;"><b>·</b> NhnShortUrlUtil.getUrl(originUrl) 을 사용합니다.</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<br/>
		<form id="shortUrlForm" name="shortUrlForm" method="post">
		<table class="table_type1">
			<caption>Short URL</caption>
			<tbody>
                <tr>
                    <th>URL</th>
                    <td>
						<input type="text" id="originUrl" name="originUrl" class="validate[required] w600">
                    </td>
                    <th>Short URL</th>
                    <td>
                    	<input type="text" id="shortUrl" name="shortUrl" class="w300" readonly="readonly">
                    </td>
                </tr>
                
			</tbody>
		</table>
		</form>
		<div class="btn_area_center mb30">
			<button type="button" onclick="generate();" class="btn btn-ok">생성</button>
			<button type="button" onclick="formReset();" class="btn btn-cancel">초기화</button>
		</div>
		<br/>
		<div class="easyui-accordion search-accordion"
			data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect"
			style="width: 100%">
			<div title="naver api header" style="padding: 10px">
				<div class="box">
					<form id="apiHeaderForm" name="apiHeaderForm" method="post">
					<table class="table_type1">
						<tbody>
			                <tr>
			                    <th>URL</th>
			                    <td>
									<input type="text" id="apiUrl" name="apiUrl" class="validate[required] w500">
			                    </td>
			                    <th>Http method</th>
			                    <td>
			                    	<select name="mtd" id="mtd">
			                    		<option value="POST">POST</option>
			                    		<option value="GET">GET</option>
			                    		<option value="DELETE">DELETE</option>
			                    		<option value="PUT">PUT</option>
			                    	</select>
			                    </td>
			                </tr>
			                <tr>
			                	<th>
			                		x-ncp-apigw-timestamp
			                	</th>
			                	<td>
			                		<input type="text" id="apigwTimestamp" class="readonly apigw" readonly="readonly">
			                		<p class="crtfCountDownArea" style="float: right;color:red;width:15%;" ></p>
			                	</td>
			                	<th>
			                		x-ncp-apigw-signature-v2
			                	</th>
			                	<td>
			                		<input type="text" id="apigwSignature" class="readonly w500 apigw" readonly="readonly">
			                	</td>
			                </tr>
						</tbody>
					</table>
					</form>
				</div>
			</div>
		</div>
		<div class="btn_area_center mb30">
			<button type="button" onclick="headerGenerate();" class="btn btn-ok">생성</button>
			<button type="button" onclick="headerFormReset();" class="btn btn-cancel">초기화</button>
		</div>
    </div>
    
    
	</t:putAttribute>
</t:insertDefinition>