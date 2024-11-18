<%--	
 - Class Name	: /sample/sampleTiles.jsp
 - Description	: TilesSample
 - Since		: 2020.12.17
 - Author		: KKB
--%>

<%-- 
사용 Tiles 지정
--%>
<tiles:insertDefinition name="common">
	<%-- 
	Tiles script.include put
	불 필요시, 해당 영역 삭제 
	--%>
	<tiles:putAttribute name="script.include" value="script.member"/> <!-- 지정된 스크립트 적용 -->
	
	<%-- 
	Tiles script.inline put
	불 필요시, 해당 영역 삭제 
	--%>
	<tiles:putAttribute name="script.inline">	
		<script type="text/javascript">
			console.log("별도의 스크립트 삽입 영역입니다.");
		</script>		
	</tiles:putAttribute>
	
	<%-- 
	Tiles content put
	--%>			
	<tiles:putAttribute name="content"> 
		<!-- content 내용 부분입니다.	-->	
		<!-- 필요에 따라 로케이션 추가 : jsp:include page="/WEB-INF/tiles/b2c/include/location.jsp" -->
		<main class="container page 1dep 2dep" id="container">
			<div class="inr">	
				<!-- 본문 -->
				<div class="contents" id="contents">
					<p>본문 1234 ABCD abcd</p>
					
				</div>
			</div>
		</main>
	</tiles:putAttribute>
	
	<%-- 
	Tiles popup put
	불 필요시, 해당 영역 삭제
	--%>
	<tiles:putAttribute name="popup">
		<!-- popup 내용 부분입니다. -->
	</tiles:putAttribute>
</tiles:insertDefinition>