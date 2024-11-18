<style>  
.bannerType { border-collapse:collapse; }  
.bannerType th, .bannerType td { border:1px solid black; }
</style>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
			<table class="table_type1 bannerType" style="width:100%">
				<caption>배너 타입별 상세</caption>
				<colgroup>
					<col style="width:5%">
					<col style="width:20%">
					<col style="width:35%">
					<col style="width:5%">
					<col style="width:13%">
					<col style="width:13%">
				</colgroup>
				<tbody>
					 <tr>
				        <td colspan="1">NO</td>
				        <td colspan="1">배너 타입명</td>
				        <td colspan="1">이미지 위치</td>
				        <td colspan="2">디바이스</td>
				        <td colspan="1">노출 사이즈</td>
				        <td colspan="1">실제 사이즈 </td>
	      			</tr>
					<tr>
						<td rowspan="3">1</td>
						<td rowspan="3">띠 배너</td>
						<td rowspan="3">띠 배너</td>
						<td colspan="2" >모바일</td>
						<td>375x88(해상도에 따라 가변)</td>
						<td>750x176</td>
					</tr>
					<tr>
			          	<td colspan="2">PC</td>
						<td>1200x94</td>
						<td>1200x94</td>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td rowspan="3">2</td>
						<td rowspan="3">샵 메인,특별기획전</td>
						<td rowspan="3">샵>메인<br>샵>서브메인>특별기획전<br>진행중인 이벤트(PC만)</td>
						<td colspan="2">모바일</td>
						<td>375x340(해상도에 따라 가변)</td>
						<td>750x680</td>
					</tr>
					<tr>
			          	<td colspan="2">PC</td>
						<td>1010x360</td>
						<td>1010x360</td>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td rowspan="3">3</td>
						<td rowspan="3">샵 서브메인 기획전 및 상세</td>
						<td rowspan="3">샵 > 서브메인 > 기획전<br>샵 > 서브메인 > 기획전 > 상세</td>
						<td colspan="2">모바일</td>
						<td>335x162<br>375x181</td>
						<td>750x362</td>
					</tr>
					<tr>
			          	<td colspan="2">PC</td>
						<td>1010x210<br>1200x250</td>
						<td>1200x250</td>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td rowspan="3">4</td>
						<td rowspan="3">이벤트</td>
						<td rowspan="3">샵 > 서브메인 > 진행중인 이벤트</td>
						<td colspan="2">모바일 </td>
						<td>335x162</td>
						<td>750x362</td>
					</tr>
					<tr>
			          	<td colspan="2">PC</td>
						<td>1010x360</td>
						<td>1010x360</td>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td rowspan="3">5</td>
						<td rowspan="3">샵 카테고리 메인</td>
						<td rowspan="3">샵 > 카테고리 > 메인</td>
						<td colspan="2">모바일 </td>
						<td>375x211</td>
						<td>750x422</td>
					</tr>
					<tr>
			          	<td colspan="2">PC</td>
						<td>1010x360</td>
						<td>1010x360</td>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td rowspan="3">6</td>
						<td rowspan="3">TV 상단</td>
						<td rowspan="3">TV > 최상단 <br>* 이미지 / 영상 등록 가능<br>* 이미지는 포스터를 제외하고 텍스트 포함X</td>
						<td colspan="2">모바일 </td>
						<td rowspan="2">325x236 (가변)</td>
						<td rowspan="2">650x472</td>
					</tr>
					<tr>
			          	<td colspan="2">PC</td>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td rowspan="3">7</td>
						<td rowspan="3">펫스쿨 홈</td>
						<td rowspan="3"> TV > 펫스쿨 홈<br>* 화면 재진입시 작아진 배너타입으로 노출(모바일)</td>
						<td colspan="2">모바일</td>
						<td>기본 : 375x211<br>작은 배너 : 375x88</td>
						<td>기본 : 750x422<br>작은 배너 : 750x176</td>
					</tr>
					<tr>
			          	<td colspan="2">PC</td>
						<td>1200x226</td>
						<td>1200x226</td>
					</tr>
				</tbody>
			</table>