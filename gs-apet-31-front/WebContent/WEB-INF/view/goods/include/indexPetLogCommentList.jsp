<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
petLogList.totalCount = ${petSo.totalCount}
petLogList.totalPageCount =${petSo.rows}
petLogList.page = ${petSo.page}

 /* if(petLogList.totalCount >= petLogList.totalPageCount){
	$("#pegLogMoreBtn").hide();	     
}  */

var petLogTotalPageCount = ${petSo.totalPageCount};
var petLogPage = ${petSo.page};
console.log(petLogTotalPageCount, petLogPage );
if(petLogTotalPageCount == petLogPage){
	$("#pegLogMoreBtn").hide();
}else{
	$("#pegLogMoreBtn").show();
}
</script>
<input type="hidden" id="petLogCommentCnt" value="${petSo.totalCount}" />
<c:forEach items="${petLogReView}" var="petLog" varStatus="idx">
	<li name="petLogReviewli">
		<a class ="logPicBox" onclick ="petlogReviewDetail(${petLog.petLogNo} , this);return false;" href="#" data-idx="${idx.count + (petSo.rows*(petSo.page-1))}">
		<c:if test="${petLog.imgPath1 ne null && petLog.imgPath2 eq null}">
			<img src="${fn:indexOf(petLog.imgPath1, 'cdn.ntruss.com')> -1 ? petLog.imgPath1  : frame:optImagePath(petLog.imgPath1, frontConstants.IMG_OPT_QRY_757) }">
		</c:if>
		<c:if test="${petLog.imgPath1 ne null && petLog.imgPath2 ne null}">
			<img src="${fn:indexOf(petLog.imgPath1, 'cdn.ntruss.com')> -1 ? petLog.imgPath1  : frame:optImagePath(petLog.imgPath1, frontConstants.IMG_OPT_QRY_757) }""><span class="logIcon_pic i02"></span>
			<span class="logIcon_pic i02"></span>
		</c:if>
		<c:if test="${petLog.vdPath ne null && petLog.imgPath1 eq null}">
			<img src="${fn:indexOf(petLog.vdThumPath, 'cdn.ntruss.com')> -1 ? petLog.vdThumPath  : frame:optImagePath(petLog.vdThumPath, frontConstants.IMG_OPT_QRY_757) }"><span class="logIcon_pic i01"></span>
			<span class="logIcon_pic i01"></span>
		</c:if>
		</a>
	</li>			
</c:forEach>

			
			
								