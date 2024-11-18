<%--	
 - Class Name	: /sample/cdnView.jsp
 - Description	: cdn View
 - Since			: 2021.2.8
 - Author			: VALFAC
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {
		});
		
		<%-- 이미지 업로드 결과 --%>
		function resultImage (file ) {
			$("#directImgPath").val(file.filePath);
			$("#directImgNm").val(file.fileName);
			$("#directImgFlSz").val(file.fileSize);
			$("#directImgPathView").attr('src', file.filePath );	
		}
		
		<%-- 이미지 업로드 결과 --%>
		function rsltImage (file ) {
			$("#imgPath").val(file.filePath);
			$("#imgNm").val(file.fileName);
			$("#imgFlSz").val(file.fileSize);
			$("#imgPathView").attr('src', '/common/imageView.do?filePath=' + file.filePath );
		}
		function imageDownload(){
			if ($("#directImgPath").val() != '' && $("#directImgPath").val() != null) {
				var data = {
					  filePath : $("#directImgPath").val()
					, fileName : $("#directImgNm").val()
					, imgYn	: 'Y'
				}
				createFormSubmit("fileDownload", "/common/fileDownloadResult.do", data);
				
			}
		}
		
		function afterImageDownload(){
			if ($("#afterImgPath").val() != '' && $("#afterImgPath").val() != null) {
				var data = {
					  filePath : $("#afterImgPath").val()
					, fileName : $("#afterImgNm").val()
					, imgYn	: 'Y'
				}
				createFormSubmit("fileDownload", "/common/fileDownloadResult.do", data);
				
			}
		}
		
		function upload(){
			var options = {
				url : "<spring:url value='/sample/imageUpload.do' />",
				data : $("#uploadForm").serialize(),
				callBack : function(data) {
					$("#afterImgPath").val(data.file.filePath);
					$("#afterImgNm").val(data.file.fileName);
					$("#afterImgPathView").attr('src', '${frame:imagePath("' + data.file.filePath + '")}');
					
					let images = $("[class^='imgPathView']").each(function(index, element) {
						let cd = $(this).attr('class').split('imgPathView')[1];
						switch(cd){
						case '10':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_10)}');
							break;
						case '20':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_20)}');
							break;
						case '30':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_30)}');
							break;
						case '40':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_40)}');
							break;
						case '50':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_50)}');
							break;
						case '60':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_60)}');
							break;
						case '70':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_70)}');
							break;
						case '80':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_80)}');
							break;
						case '90':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_90)}');
							break;
						case '100':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_100)}');
							break;
						case '110':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_110)}');
							break;
						case '120':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_120)}');
							break;
						case '130':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_130)}');
							break;
						case '140':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_140)}');
							break;
						case '150':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_150)}');
							break;
						case '160':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_160)}');
							break;
						case '170':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_170)}');
							break;
						case '180':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_180)}');
							break;
						case '190':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_190)}');
							break;
						case '200':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_200)}');
							break;
						case '210':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_210)}');
							break;
						case '220':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_220)}');
							break;
						case '230':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_230)}');
							break;
						case '240':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_240)}');
							break;
						case '250':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_250)}');
							break;
						case '260':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_260)}');
							break;
						case '270':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_270)}');
							break;
						case '280':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_280)}');
							break;
						case '290':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_290)}');
							break;
						case '300':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_300)}');
							break;
						case '310':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_310)}');
							break;
						case '320':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_320)}');
							break;
						case '330':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_330)}');
							break;
						case '340':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_340)}');
							break;
						case '350':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_350)}');
							break;
						case '360':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_360)}');
							break;
						case '370':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_370)}');
							break;
						case '380':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_380)}');
							break;
						case '390':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_390)}');
							break;
						case '400':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_400)}');
							break;
						case '410':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_410)}');
							break;
						case '420':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_420)}');
							break;
						case '430':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", adminConstants.IMG_OPT_QRY_430)}');
							break;
						default:
							$(this).attr('src', '${frame:imagePath("' + data.file.filePath + '")}');
							break;
						}
					});
				}
			}
			ajax.call(options);
		}
		
		function imageDelete(){
			if ($("#directImgPath").val() != '' && $("#directImgPath").val() != null) {
				var options = {
					url : "<spring:url value='/sample/imageDelete.do' />",
					data : $("#uploadForm").serialize(),
					callBack : function(data) {
						$("#directImgPath").val('');
						$("#directImgNm").val('');
						$("#directImgPathView").attr('src', '/images/noimage.png' );
					}
				}
				ajax.call(options);
				
			}
		}
		
		function afterImageDelete(){
			if ($("#afterImgPath").val() != '' && $("#afterImgPath").val() != null) {
				var options = {
					url : "<spring:url value='/sample/afterImageDelete.do' />",
					data : $("#uploadForm").serialize(),
					callBack : function(data) {
						$("#afterImgPath").val('');
						$("#afterImgNm").val('');
						$("#afterImgPathView").attr('src', '/images/noimage.png');
						$("#imgPath").val('');
						$("#imgNm").val('');
						$("#imgFlSz").val('');
						$("#imgPathView").attr('src', '/images/noimage.png');
						$("[class^='imgPathView']").attr('src', '/images/noimage.png');
					}
				}
				console.log(options);
				ajax.call(options);
				
			}
		}
		
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion"
			data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect"
			style="width: 100%">
			<div title="image upload" style="padding: 10px">
				<div class="box">
					<div>
						<ul style="font-size: 13px;">
							<li style="margin-bottom: 5px;"><b>·</b> mobile app을 제외한 방식은 기존 veci 방식과 동일합니다.</li>
							<li style="margin-bottom: 5px;"><b>·</b> 1. temp 폴더에 upload -> fileUpload.image(callback)</li>
							<li style="margin-bottom: 5px;"><b>·</b> 2. 등록 및 수정 시</li>
							<li style="margin-bottom: 5px;"><b></b> &emsp;FtpImgUtil ftpImgUtil = new FtpImgUtil();</li>
							<li style="margin-bottom: 5px;"><b></b> &emsp;String filePath = ftpImgUtil.uploadFilePath(imgPath, "각 업무에서 정한 folder 명");</li>
							<li style="margin-bottom: 5px;"><b></b> &emsp;ftpImgUtil.upload(imgPath, filePath);</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<br/>
		<div class="easyui-accordion search-accordion"
			data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect"
			style="width: 100%">
			<div title="image download" style="padding: 10px">
				<div class="box">
					<div>
						<ul style="font-size: 13px;">
							<li style="margin-bottom: 5px;"><b>·</b> var data = {</li>
							<li style="margin-bottom: 5px;"><b></b> &emsp;filePath : $("#imgPath").val()</li>
							<li style="margin-bottom: 5px;"><b></b> &emsp;, fileName : $("#imgNm").val()</li>
							<li style="margin-bottom: 5px;"><b></b> &emsp;, imgYn	: 'Y'</li>
							<li style="margin-bottom: 5px;"><b></b> &emsp;}</li>
							<li style="margin-bottom: 5px;"><b></b> &nbsp;createFormSubmit("fileDownload", "/common/fileDownloadResult.do", data);</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<br/>
		<div class="easyui-accordion search-accordion"
			data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect"
			style="width: 100%">
			<div title="image delete" style="padding: 10px">
				<div class="box">
					<div>
						<ul style="font-size: 13px;">
							<li style="margin-bottom: 5px;"><b>·</b> @Autowired	private NhnObjectStorageUtil nhnObjectStorageUtil; (bean 주입 후 사용합니다.)</li>
							<li style="margin-bottom: 5px;"><b>·</b> &emsp;nhnObjectStorageUtil.delete(directImgPath)</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<br/>
		<form id="uploadForm" name="uploadForm" method="post">
		<table class="table_type1">
			<caption></caption>
			<tbody>
                <tr>
                    <%-- <th>Direct Upload</th>
                    <td>
						<div class="inner">
							<input type="hidden" id="directImgPath" class="required req_input2" name="directImgPath" value="" />
							<input type="hidden" id="directImgNm" name="directImgNm" value="" />
							<input type="hidden" id="directImgFlSz" name="directImgFlSz" value="" />
							<img id="directImgPathView" name="directImgPathView" src="/images/noimage.png" class="thumb" alt="" />
						</div>
						<div class="inner ml10" style="vertical-align:middle;">
							<!-- 파일선택 --> 
							<button type="button" class="btn" onclick="fileUpload.cdnImage(resultImage, 'series2');" ><spring:message code="column.fl_choice" /></button>
							<button type="button" class="btn" onclick="imageDownload();" >다운로드</button>
							<button type="button" class="btn" onclick="imageDelete();" >원본 삭제</button>
						</div>
					</td> --%>
                    <th>Upload</th>
                    <td colspan="3">
						<div class="inner">
							<input type="hidden" id="imgPath" class="required req_input2" name="imgPath" value="" />
							<input type="hidden" id="imgNm" name="imgNm" value="" />
							<input type="hidden" id="imgFlSz" name="imgFlSz" value="" />
							<img id="imgPathView" name="imgPathView" src="/images/noimage.png" class="thumb" alt="" />
						</div>
						<div class="inner ml10" style="vertical-align:middle;">
							<!-- 파일선택 --> 
							<button type="button" class="btn" onclick="fileUpload.image(rsltImage);" ><spring:message code="column.fl_choice" /></button>
							<img id="afterImgPathView" name="afterImgPathView" src="/images/noimage.png" class="thumb" alt="" />
							<input type="hidden" id="afterImgPath" class="required req_input2" name="afterImgPath" value="" />
							<input type="hidden" id="afterImgNm" name="afterImgNm" value="" />
							<button type="button" class="btn" onclick="afterImageDownload();" >다운로드</button>
							<button type="button" class="btn" onclick="afterImageDelete();" >원본 삭제</button>
						</div>
					</td>
                </tr>
                
			</tbody>
		</table>
		</form>
		<div class="btn_area_center mb30">
			<button type="button" onclick="upload();" class="btn btn-ok">업로드</button>
			<button type="button" onclick="updateTab();" class="btn btn-cancel">초기화</button>
		</div>
		<br/>
		<div class="easyui-accordion search-accordion"
			data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect"
			style="width: 100%">
			<div title="image optimizer" style="padding: 10px">
				<div class="box">
					<div>
						<ul style="font-size: 13px;">
							<li style="margin-bottom: 5px;"><b>·</b> frame function 사용합니다.</li>
							<li style="margin-bottom: 5px;"><b></b> &emsp;원본 CDN : '&#36;{frame:imagePath("' + filePath + '")}'</li>
							<li style="margin-bottom: 5px;"><b></b> &emsp;Optimizer : '&#36;{frame:optImagePath("' + filePath + '", CommonConstants.IMG_OPT_QRY_10)}'</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<table class="table_type1">
			<caption></caption>
			<tbody>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_10<br/>(type=m&w=244&h=137&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView10" src="/images/noimage.png" class="thumb" alt="" style="width: 244px;height: 137px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_20<br/>(type=m&w=388&h=188&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView20" src="/images/noimage.png" class="thumb" alt="" style="width: 388px;height: 188px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_30<br/>(type=m&w=178&h=178&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView30" src="/images/noimage.png" class="thumb" alt="" style="width: 178px;height: 178px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_40<br/>(type=m&w=750&h=176&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView40" src="/images/noimage.png" class="thumb" alt="" style="width: 750px;height: 176px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_50<br/>(type=m&w=650&h=472&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView50" src="/images/noimage.png" class="thumb" alt="" style="width: 650px;height: 472px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_60<br/>(type=m&w=70&h=70&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView60" src="/images/noimage.png" class="thumb" alt="" style="width: 70px;height: 70px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_70<br/>(type=f&w=490&h=279&quality=90&align=4)</th>
                    <td colspan="3">
						<img class="imgPathView70" src="/images/noimage.png" class="thumb" alt="" style="width: 490px;height: 279px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_80<br/>(type=m&w=404&h=227&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView80" src="/images/noimage.png" class="thumb" alt="" style="width: 404px;height: 227px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_90<br/>(type=m&w=375&h=211&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView90" src="/images/noimage.png" class="thumb" alt="" style="width: 375px;height: 211px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_100<br/>(type=m&w=750&h=422&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView100" src="/images/noimage.png" class="thumb" alt="" style="width: 750px;height: 422px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_110<br/>(type=m&w=280&h=280&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView110" src="/images/noimage.png" class="thumb" alt="" style="width: 280px;height: 280px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_120<br/>(type=m&w=460&h=296&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView120" src="/images/noimage.png" class="thumb" alt="" style="width: 460px;height: 296px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_130<br/>(type=m&w=325&h=236&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView130" src="/images/noimage.png" class="thumb" alt="" style="width: 325px;height: 236px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_140<br/>(type=m&w=750&h=362&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView140" src="/images/noimage.png" class="thumb" alt="" style="width: 750px;height: 362px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_150<br/>(type=m&w=388&h=218&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView150" src="/images/noimage.png" class="thumb" alt="" style="width: 388px;height: 218px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_160<br/>(type=m&w=317&h=317&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView160" src="/images/noimage.png" class="thumb" alt="" style="width: 317px;height: 317px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_170<br/>(type=m&w=375&h=375&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView170" src="/images/noimage.png" class="thumb" alt="" style="width: 375px;height: 375px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_180<br/>(type=m&w=388&h=236&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView180" src="/images/noimage.png" class="thumb" alt="" style="width: 388px;height: 236px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_190<br/>(type=m&w=375&h=181&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView190" src="/images/noimage.png" class="thumb" alt="" style="width: 375px;height: 181px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_200<br/>(type=m&w=677&h=381&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView200" src="/images/noimage.png" class="thumb" alt="" style="width: 677px;height: 381px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_210<br/>(type=m&w=500&h=500&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView210" src="/images/noimage.png" class="thumb" alt="" style="width: 500px;height: 500px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_220<br/>(type=m&w=90&h=90&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView220" src="/images/noimage.png" class="thumb" alt="" style="width: 90px;height: 90px;" />
					</td>
                </tr>
                <tr>
                    <td>LIVE 317X178<br/>CommonConstants.IMG_OPT_QRY_230<br/>(type=m&w=317&h=178&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView230" src="/images/noimage.png" class="thumb" alt="" style="width: 317px;height: 178px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_240<br/>(type=f&w=375&h=214&quality=90&align=4)</th>
                    <td colspan="3">
						<img class="imgPathView240" src="/images/noimage.png" class="thumb" alt="" style="width: 375px;height: 214px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_250<br/>(type=m&w=120&h=120&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView250" src="/images/noimage.png" class="thumb" alt="" style="width: 120px;height: 120px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_260<br/>(type=m&w=375&h=340&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView260" src="/images/noimage.png" class="thumb" alt="" style="width: 375px;height: 340px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_270<br/>(type=m&w=160&h=160&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView270" src="/images/noimage.png" class="thumb" alt="" style="width: 160px;height: 160px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_280<br/>(type=m&w=1010&h=360&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView280" src="/images/noimage.png" class="thumb" alt="" style="width: 1010px;height: 360px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_290<br/>(type=m&w=335&h=162&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView290" src="/images/noimage.png" class="thumb" alt="" style="width: 335px;height: 162px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_300<br/>(type=m&w=750&h=680&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView300" src="/images/noimage.png" class="thumb" alt="" style="width: 750px;height: 680px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_310<br/>(type=m&w=1200&h=94&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView310" src="/images/noimage.png" class="thumb" alt="" style="width: 1200px;height: 94px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_320<br/>(type=m&w=1200&h=250&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView320" src="/images/noimage.png" class="thumb" alt="" style="width: 1200px;height: 250px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_330<br/>(type=m&w=375&h=88&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView330" src="/images/noimage.png" class="thumb" alt="" style="width: 375px;height: 88px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_340<br/>(type=m&w=230&h=230&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView340" src="/images/noimage.png" class="thumb" alt="" style="width: 230px;height: 230px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_350<br/>(type=m&w=1200&h=226&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView350" src="/images/noimage.png" class="thumb" alt="" style="width: 1200px;height: 226px;" />
					</td>
                </tr>
                <tr>
                    <td>통장사본<br/>CommonConstants.IMG_OPT_QRY_360<br/>(type=m&w=1188&h=1682&quality=95&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView360" src="/images/noimage.png" class="thumb" alt="" style="width: 1188px;height: 1682px;" />
					</td>
                </tr>
                <tr>
                    <td>회원사진<br/>CommonConstants.IMG_OPT_QRY_370<br/>(type=m&w=720&h=720&quality=95&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView370" src="/images/noimage.png" class="thumb" alt="" style="width: 720px;height: 720px;" />
					</td>
                </tr>
                <tr>
                    <td>사업자 등록증<br/>CommonConstants.IMG_OPT_QRY_380<br/>(type=m&w=1440&h=2560&quality=95&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView380" src="/images/noimage.png" class="thumb" alt="" style="width: 1440px;height: 2560px;" />
					</td>
                </tr>
                <tr>
                    <td>이벤트 배너<br/>CommonConstants.IMG_OPT_QRY_390<br/>(type=m&w=1440&h=810&quality=95&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView390" src="/images/noimage.png" class="thumb" alt="" style="width: 1440px;height: 810px;" />
					</td>
                </tr>
                <tr>
                    <td>BO 대표 썸네일<br/>CommonConstants.IMG_OPT_QRY_400<br/>(type=m&w=200&h=160&quality=95&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView400" src="/images/noimage.png" class="thumb" alt="" style="width: 200px;height: 160px;" />
					</td>
                </tr>
                <tr>
                    <td>BO 영상 썸네일<br/>CommonConstants.IMG_OPT_QRY_410<br/>(type=m&w=100&h=100&quality=95&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView410" src="/images/noimage.png" class="thumb" alt="" style="width: 100px;height: 100px;" />
					</td>
                </tr>
                <tr>
                    <td>BO 상단노출이미지<br/>CommonConstants.IMG_OPT_QRY_420<br/>(type=m&w=108&h=88&quality=95&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView420" src="/images/noimage.png" class="thumb" alt="" style="width: 108px;height: 88px;" />
					</td>
                </tr>
                <tr>
                    <td>FO TV상세추천썸네일<br/>CommonConstants.IMG_OPT_QRY_430<br/>(type=m&w=130&h=73&quality=95&bgcolor=FFFFFF&extopt=3)</th>
                    <td colspan="3">
						<img class="imgPathView430" src="/images/noimage.png" class="thumb" alt="" style="width: 130px;height: 73px;" />
					</td>
                </tr>
			</tbody>
		</table>
    </div>
	</t:putAttribute>
</t:insertDefinition>