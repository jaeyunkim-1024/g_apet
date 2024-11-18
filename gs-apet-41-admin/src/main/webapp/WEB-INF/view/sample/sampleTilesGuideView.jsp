<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
			
			});

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="FO TILES 구성" style="padding:10px">
				<p> - meta : meta정보, css, script </p>
				<p> - header : headerPc.jsp, headerMo.jsp (넓이 1024px로 분기)</p>
				<p> - gnb : gnb.jsp </p>
				<p> - lnb : lnb.jsp </p>
				<p> - layerPop : layerPop.jsp </p>
				<p> - menubar : menubar.jsp </p>
				<p> - footer : footer.jsp </p>
				<p> - 본문 : 개발영역 (필요에 따라 location.jsp 추가) </p>
			</div>
		</div>
		<br/>
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="적용 예제" style="padding:10px">
				<p> - 샘플 URL : /sample/sampleTilesCommon/</p>
				<p> - 파일</p>
				<p>&nbsp; &nbsp; &nbsp; &nbsp;/gs-apet-31-front/resources/config/tiles/front_web.xml</p>
				<p>&nbsp; &nbsp; &nbsp; &nbsp;/gs-apet-31-front/src/front/web/view/sample/SampleController.java</p>
				<p>&nbsp; &nbsp; &nbsp; &nbsp;/gs-apet-31-front/WebContent/WEB-INF/tiles/b2c/indexLayout.jsp</p>
				<p>&nbsp; &nbsp; &nbsp; &nbsp;/gs-apet-31-front/WebContent/WEB-INF/view/sample/sampleTiles.jsp</p>
				<p>	- 참고 : taglib 과 constants는 webConstraints.jspf 파일에서 관리 되고 있습니다.</p>
			</div>
		</div>
	</t:putAttribute>
</t:insertDefinition>