<%--	
 - Class Name	: /sample/sampleVodView.jsp
 - Description	: 영상 예시
 - Since		: 2021.1.25
 - Author		: VLF
--%>
<tiles:insertDefinition name="common">
	<tiles:putAttribute name="content">	
<script type="text/javascript" 	src="/_script/file.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
	});
</script>
	<%-- <div class="content" style="padding-left: 20%;">
		<h2>■ 이미지 파일 다이렉트 업로드 & 다운로드 </h2>
		<span>1. 이미지 경로 : </span><input type="text" id="directImgPath" name="directImgPath" style="width: 800px;" class="required req_input2" title="영상" value="" readonly="readonly">
		<br/>
		<span>2. 이미지 크기 : </span><input type="text" id="directImgFlSz" name="directImgFlSz" title="<spring:message code="column.fl_sz"/>" value="" readonly="readonly">
		<br/>
		<span>3. 이미지 이름 : </span><input type="text" class="readonly" readonly="readonly" id="directImgNm" name="directImgNm" value=""  readonly="readonly"/>
		<br/>
		<br/>
		<img id="directImagPathView" alt="" src="../../_images/common/icon-img-profile-default-m@2x.png" onerror="" >
		<button type="button" style="" onclick="fileUpload.cdnImage(resultImage, 'series2');" class="btn">파일선택</button>
		<button type="button" style="" onclick="imageDownload();" class="btn">다운로드</button>
		<div style="display:none;">
			<input type="file" id="directImageUploadFile" name="directImageUploadFile" accept="image/*" onchange="vodUpload(this, vodCallback);">
		</div>
	</div>--%>
	<br/> 
	<div class="content" style="padding-left: 20%;">
		<h2>■ app 전용 업로드 </h2>
		<form method="post" id="multiUploadForm" encType="multipart/form-data">
			<input type="file" name="file1"/>
			<input type="file" name="file2"/>
			<input type="hidden" name="uploadType" id="uploadType" value="image"/>
			<input type="hidden" name="prefixPath" id="prefixPath" value="/abc/test"/>
			<button type="button" style="" onclick="multiUpload();" class="btn">업로드</button>
		</form>
	</div>
	<br/><br/><br/>
	<br/><br/><br/>
	<div class="content" style="padding-left: 20%;">
		<h2>■ 이미지 파일 업로드 & 다운로드 </h2>
		<form id="uploadForm" name="uploadForm" method="post">
		<span>1. 이미지 경로 : </span><input type="text" id="imgPath" name="imgPath" style="width: 800px;" class="required req_input2" title="영상" value="" readonly="readonly">
		<br/>
		<span>2. 이미지 크기 : </span><input type="text" id="imgFlSz" name="imgFlSz" title="<spring:message code="column.fl_sz"/>" value="" readonly="readonly">
		<br/>
		<span>3. 이미지 이름 : </span><input type="text" class="readonly" readonly="readonly" id="imgNm" name="imgNm" value=""  readonly="readonly"/>
		</form>
		<br/>
		<br/>
		<img id="imagPathView" style="width: 150px;" alt="" src="../../_images/common/icon-img-profile-default-m@2x.png" onerror="" >
		<button type="button" style="" onclick="fileUpload.image(rsltImage);" class="btn">파일선택</button>
		<button type="button" style="" onclick="upload();" class="btn">업로드</button>
		<input type="hidden" id="afterImgPath" class="required req_input2" name="afterImgPath" value="" />
		<input type="hidden" id="afterImgNm" name="afterImgNm" value="" />
		<img id="afterImgPathView" style="width: 150px;" alt="" src="../../_images/common/icon-img-profile-default-m@2x.png" onerror="" >
		<button type="button" style="" onclick="afterImageDownload();" class="btn">다운로드</button>
		<button type="button" style="" onclick="imageDelete();" class="btn">원본삭제</button>
		<div style="display:none;">
			<input type="file" id="imageUploadFile" name="imageUploadFile" accept="image/*" onchange="vodUpload(this, vodCallback);">
		</div>
	</div>
	<br/>
	<div class="table-type01 t2">
		<table class="">
			<tbody>
				<tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_10<br/>(type=m&w=244&h=137&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView10" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 244px;height: 137px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_20<br/>(type=m&w=388&h=188&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView20" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 388px;height: 188px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_30<br/>(type=m&w=178&h=178&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView30" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 178px;height: 178px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_40<br/>(type=m&w=750&h=176&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView40" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 750px;height: 176px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_50<br/>(type=m&w=650&h=472&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView50" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 650px;height: 472px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_60<br/>(type=m&w=70&h=70&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView60" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 70px;height: 70px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_70<br/>(type=f&w=490&h=279&quality=90&align=4)</th>
                    <td >
						<img class="imgPathView70" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 490px;height: 279px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_80<br/>(type=m&w=404&h=227&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView80" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 404px;height: 227px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_90<br/>(type=m&w=375&h=211&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView90" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 375px;height: 211px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_100<br/>(type=m&w=750&h=422&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView100" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 750px;height: 422px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_110<br/>(type=m&w=280&h=280&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView110" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 280px;height: 280px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_120<br/>(type=m&w=460&h=296&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView120" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 460px;height: 296px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_130<br/>(type=m&w=325&h=236&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView130" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 325px;height: 236px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_140<br/>(type=m&w=750&h=362&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView140" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 750px;height: 362px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_150<br/>(type=m&w=388&h=218&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView150" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 388px;height: 218px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_160<br/>(type=m&w=317&h=317&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView160" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 317px;height: 317px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_170<br/>(type=m&w=375&h=375&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView170" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 375px;height: 375px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_180<br/>(type=m&w=388&h=236&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView180" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 388px;height: 236px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_190<br/>(type=m&w=375&h=181&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView190" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 375px;height: 181px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_200<br/>(type=m&w=677&h=381&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView200" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 677px;height: 381px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_210<br/>(type=m&w=500&h=500&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView210" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 500px;height: 500px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_220<br/>(type=m&w=90&h=90&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView220" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 90px;height: 90px;" />
					</td>
                </tr>
                <tr>
                    <td>LIVE 317X178<br/>CommonConstants.IMG_OPT_QRY_230<br/>(type=m&w=317&h=178&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView230" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 317px;height: 178px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_240<br/>(type=f&w=375&h=214&quality=90&align=4)</th>
                    <td >
						<img class="imgPathView240" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 375px;height: 214px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_250<br/>(type=m&w=120&h=120&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView250" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 120px;height: 120px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_260<br/>(type=m&w=375&h=340&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView260" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 375px;height: 340px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_270<br/>(type=m&w=160&h=160&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView270" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 160px;height: 160px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_280<br/>(type=m&w=1010&h=360&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView280" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 1010px;height: 360px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_290<br/>(type=m&w=335&h=162&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView290" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 335px;height: 162px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_300<br/>(type=m&w=750&h=680&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView300" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 750px;height: 680px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_310<br/>(type=m&w=1200&h=94&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView310" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 1200px;height: 94px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_320<br/>(type=m&w=1200&h=250&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView320" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 1200px;height: 250px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_330<br/>(type=m&w=375&h=88&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView330" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 375px;height: 88px;" />
					</td>
                </tr>
                <tr>
                    <td>상품<br/>CommonConstants.IMG_OPT_QRY_340<br/>(type=m&w=230&h=230&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView340" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 230px;height: 230px;" />
					</td>
                </tr>
                <tr>
                    <td>배너<br/>CommonConstants.IMG_OPT_QRY_350<br/>(type=m&w=1200&h=226&quality=90&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView350" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 1200px;height: 226px;" />
					</td>
                </tr>
                <tr>
                    <td>통장사본<br/>CommonConstants.IMG_OPT_QRY_360<br/>(type=m&w=1188&h=1682&quality=95&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView360" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 1188px;height: 1682px;" />
					</td>
                </tr>
                <tr>
                    <td>회원사진<br/>CommonConstants.IMG_OPT_QRY_370<br/>(type=m&w=720&h=720&quality=95&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView370" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 720px;height: 720px;" />
					</td>
                </tr>
                <tr>
                    <td>사업자 등록증<br/>CommonConstants.IMG_OPT_QRY_380<br/>(type=m&w=1440&h=2560&quality=95&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView380" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 1440px;height: 2560px;" />
					</td>
                </tr>
                <tr>
                    <td>이벤트 배너<br/>CommonConstants.IMG_OPT_QRY_390<br/>(type=m&w=1440&h=810&quality=95&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView390" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 1440px;height: 810px;" />
					</td>
                </tr>
                <tr>
                    <td>BO 대표 썸네일<br/>CommonConstants.IMG_OPT_QRY_400<br/>(type=m&w=200&h=160&quality=95&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView400" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 200px;height: 160px;" />
					</td>
                </tr>
                <tr>
                    <td>BO 영상 썸네일<br/>CommonConstants.IMG_OPT_QRY_410<br/>(type=m&w=100&h=100&quality=95&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView410" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 100px;height: 100px;" />
					</td>
                </tr>
                <tr>
                    <td>BO 상단노출이미지<br/>CommonConstants.IMG_OPT_QRY_420<br/>(type=m&w=108&h=88&quality=95&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView420" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 108px;height: 88px;" />
					</td>
                </tr>
                <tr>
                    <td>FO TV상세추천썸네일<br/>CommonConstants.IMG_OPT_QRY_430<br/>(type=m&w=130&h=73&quality=95&bgcolor=FFFFFF&extopt=3)</th>
                    <td >
						<img class="imgPathView430" src="../../_images/common/icon-img-profile-default-m@2x.png" class="thumb" alt="" style="width: 130px;height: 73px;" />
					</td>
                </tr>
			</tbody>
		</table>
	</div>
	<script>
	// 이미지 업로드 결과
	function resultImage(result) {
		$("#directImagPathView").attr('src', result.filePath);
		$("#directImgPath").val(result.filePath);
		$("#directImgFlSz").val(result.fileSize);
		$("#directImgNm").val(result.fileName);
	}
	
	function rsltImage(result) {
		$("#imagPathView").attr('src', '/common/imageView?filePath=' + result.filePath);
		$("#imgPath").val(result.filePath);
		$("#imgFlSz").val(result.fileSize);
		$("#imgNm").val(result.fileName);
	}
	
	function imageDownload(){
		if ($("#directImgPath").val() != '' && $("#directImgPath").val() != null) {
			var data = {
				  filePath : $("#directImgPath").val()
				, fileName : $("#directImgNm").val()
			}
			createFormSubmit("fileDownload", "/common/fileNcpDownloadResult", data);
			
		}
	}
	
	function afterImageDownload(){
		if ($("#afterImgPath").val() != '' && $("#afterImgPath").val() != null) {
			var data = {
				  filePath : $("#afterImgPath").val()
				, fileName : $("#afterImgNm").val()
				, imgYn	: 'Y'
			}
			createFormSubmit("fileDownload", "/common/fileDownloadResult", data);
			
		}
	}
	
	function upload(){
		if ($("#imgPath").val() != '' && $("#imgPath").val() != null) {
			var options = {
				url : "<spring:url value='/sample/imageUpload' />",
				data : $("#uploadForm").serialize(),
				done : function(data){
					$("#afterImgPath").val(data.file.filePath);
					$("#afterImgNm").val(data.file.fileName);
					$("#afterImgPathView").attr('src', '${frame:imagePath("' + data.file.filePath + '")}');
					let images2 = $("[class^='imgPathView']").each(function(index, element) {
						let cd = $(this).attr('class').split('imgPathView')[1];
						console.log('cd' + index, cd);
						switch(cd){
						case '10':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_10)}');
							break;
						case '20':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_20)}');
							break;
						case '30':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_30)}');
							break;
						case '40':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_40)}');
							break;
						case '50':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_50)}');
							break;
						case '60':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_60)}');
							break;
						case '70':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_70)}');
							break;
						case '80':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_80)}');
							break;
						case '90':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_90)}');
							break;
						case '100':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_100)}');
							break;
						case '110':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_110)}');
							break;
						case '120':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_120)}');
							break;
						case '130':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_130)}');
							break;
						case '140':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_140)}');
							break;
						case '150':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_150)}');
							break;
						case '160':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_160)}');
							break;
						case '170':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_170)}');
							break;
						case '180':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_180)}');
							break;
						case '190':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_190)}');
							break;
						case '200':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_200)}');
							break;
						case '210':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_210)}');
							break;
						case '220':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_220)}');
							break;
						case '230':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_230)}');
							break;
						case '240':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_240)}');
							break;
						case '250':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_250)}');
							break;
						case '260':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_260)}');
							break;
						case '270':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_270)}');
							break;
						case '280':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_280)}');
							break;
						case '290':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_290)}');
							break;
						case '300':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_300)}');
							break;
						case '310':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_310)}');
							break;
						case '320':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_320)}');
							break;
						case '330':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_330)}');
							break;
						case '340':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_340)}');
							break;
						case '350':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_350)}');
							break;
						case '360':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_360)}');
							break;
						case '370':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_370)}');
							break;
						case '380':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_380)}');
							break;
						case '390':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_390)}');
							break;
						case '400':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_400)}');
							break;
						case '410':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_410)}');
							break;
						case '420':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_420)}');
							break;
						case '430':
							$(this).attr('src', '${frame:optImagePath("' + data.file.filePath + '", frontConstants.IMG_OPT_QRY_430)}');
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
	}
	
	function imageDelete(){
		if ($("#afterImgPath").val() != '' && $("#afterImgPath").val() != null) {
			var options = {
				url : "<spring:url value='/sample/imageDelete' />",
				data : {imgPath : $("#afterImgPath").val()},
				done : function(data){
					$("#afterImgPath").val('');
					$("#afterImgNm").val('');
					$("#afterImgPathView").attr('src', '../../_images/common/icon-img-profile-default-m@2x.png');
					$("#imagPathView").attr('src', '../../_images/common/icon-img-profile-default-m@2x.png');
					$("#imgPath").val('');
					$("#imgFlSz").val('');
					$("#imgNm").val('');
					$("[class^='imgPathView']").attr('src', '../../_images/common/icon-img-profile-default-m@2x.png');
				}
			}
			ajax.call(options);
		}
	}
	
	function multiUpload() {
		waiting.start();
		var url = '/common/fileUploadResult';
		
		$('#multiUploadForm').ajaxSubmit(
				{
					url : url,
					dataType : 'json',
					success : function(result) {
						waiting.stop();
						
					},
					error : function(xhr, status, error) {
						waiting.stop();
						if (xhr.status === 1000) {
							location.replace("/indexLogin");
						} else {
							alert("오류가 발생되었습니다. 관리자에게 문의하십시요.["
									+ xhr.status + "][" + error + "]");
						}
					}
				});

	}
	</script>
	</tiles:putAttribute>
</tiles:insertDefinition>