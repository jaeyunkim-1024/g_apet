<%--	
   - Class Name	: /sample/sampleTackingTool.jsp
   - Description: 트래킹 툴 샘플 화면
   - Since		: 2021.02.08
   - Author		: KKB
   --%>
<tiles:insertDefinition name="default">
   <tiles:putAttribute name="content">
      <style type="text/css">
          table {
		    border: 1px solid #ecedef;
		    border-collapse: collapse;
		  }
		  th, td {
		    border: 1px solid #ecedef;
		    padding: 10px;
		  }
      </style>
      <script type="text/javascript">
      $(document).ready(function(){
      });
      </script>
      <main class="container page" id="container">
         <div class="inr">
            <!-- 본문 -->
            <div class="contents" id="contents">
               	<br/>
               	<!-- S: 애드브릭스 -->
               	<div class="pageHeadPc">
					<div class="hdt">
						<h3 class="tit">[ 애드브릭스 ]</h3>
					</div>
					<br/>
				</div>
				<table style="border: #ecedef solid 1px; border-collapse: collapse;">
					<caption>애드브릭스</caption>
					<colgroup>
						<col>
						<col>
						<col style="text-align: center;">
					</colgroup>
					<tr>
						<th>구 분</th>
						<th>요 약</th>
						<th>상 세</th>
					</tr>
					<tr>
						<th>회원가입</th>
						<td>
							<p>회원가입이 최종 완료된 시점에 정보 전달</p>
						</td>
						<td>
							<button onclick="ui.popLayer.open('adbrixJoinPop')" class="btn sm b">회원가입 확인</button>
						</td>
					</tr>
					<tr>
						<th>상품검색</th>
						<td>
							<p>상품 상세보기한 시점에 정보 전달</p>
						</td>
						<td>
							<button onclick="ui.popLayer.open('adbrixSearchPop')" class="btn sm b">상품보기 확인</button>
						</td>
					</tr>
					<tr>
						<th>장바구니 담기</th>
						<td>
							<p>장바구니 담기가 완료된 시점에 정보 전달</p>
						</td>
						<td>
							<button onclick="ui.popLayer.open('adbrixCartPop')" class="btn sm b">장바구니 담기 확인</button>
						</td>
					</tr>
					<tr>
						<th>최초결제 완료</th>
						<td>
							<p>최초 결제가 완료된 시점에 정보 전달</p>
						</td>
						<td>
							<button onclick="ui.popLayer.open('adbrixFirstBuyPop')" class="btn sm b">최초결제 완료 확인</button>
						</td>
					</tr>
					<tr>
						<th>결제 완료</th>
						<td>
							<p>결제 완료된 시점에 정보 전달</p>
						</td>
						<td>
							<button onclick="ui.popLayer.open('adbrixBuyPop')" class="btn sm b">결제 완료 확인</button>
						</td>
					</tr>
				</table>
			 	<!-- E: 애드브릭스 -->
			 	
			 	<!-- S: 구글 애널리틱스 -->
				<div class="pageHeadPc">
					<div class="hdt">
						<h3 class="tit">[ 구글 애널리틱스 ]</h3>
					</div>
					<br/>
				</div>
				<table style="border: #ecedef solid 1px; border-collapse: collapse;">
					<caption>구글 애널리틱스</caption>
					<colgroup>
						<col>
						<col>
						<col style="text-align: center;">
					</colgroup>
					<tr>
						<th>구 분</th>
						<th>요 약</th>
						<th>상 세</th>
					</tr>
					<tr>
						<th>TypeA</th>
						<td>
							<p>테스트</p>
						</td>
						<td>
							<button onclick="ui.popLayer.open('typeAPop')" class="btn sm b">TypeA 확인</button>
						</td>
					</tr>
				</table>
				<!-- E: 구글 애널리틱스 -->
            </div>
         </div>
      </main>
      <div class="layers">
         <!-- S: 애드브릭스 설명-->
         <!-- 회원 가입 -->
         <article class="popLayer a adbrixJoinPop" id="adbrixJoinPop" >
            <div class="pbd">
               <div class="phd">
                  <div class="in">
                     <h1 class="tit">회원 가입</h1>
                     <button type="button" class="btnPopClose">닫기</button>
                  </div>
               </div>
               <div class="pct">
                  <main class="poptents">
                     <p>회원가입이 최종 완료된 시점에 정보 전달</p>
                     <P>호출 함수 : adbrix.join(param)</P>
                     <p>필수 : </p>
                     <P>옵션 : </P>
                     <p>
                        - 아래 데이터 중 * 표시가 된 것은 필수 전달 데이터 항목입니다.<br/>                               
                        - 아래 데이터는 테스트를 돕기 위해 임의로 채워진 테스트 데이터입니다.               
                     </p>
                     <br/>
                     <div>
                        <div>
                           <form name="adbrixJoinForm" id="adbrixJoinForm" >
                              <table>
                                 <colgroup>
                                    <col style="width: 200px;">
                                    <col>
                                 </colgroup>
                                 <tr>
                                    <th></th>
                                    <td>
                                       <input name="" type="text" placeholder="">
                                    </td>
                                 </tr>
                              </table>
                              <br>	                       
                              <button type="button" class="btn" onclick="adbrix.join();" >Call</button>
                           </form>
                        </div>
                     </div>
                  </main>
               </div>
            </div>
         </article>
         <!-- 상품 보기 -->
         <article class="popLayer a adbrixProductViewPop" id="adbrixProductViewPop" >
            <div class="pbd">
               <div class="phd">
                  <div class="in">
                     <h1 class="tit">상품 보기</h1>
                     <button type="button" class="btnPopClose">닫기</button>
                  </div>
               </div>
               <div class="pct">
                  <main class="poptents">
                     <p>상품 상세보기한 시점에 정보 전달</p>
                     <P>호출 함수 : adbrix.productView(param)</P>
                     <p>필수 : productId, productName, price, quantity</p>
                     <P>옵션 : category (구매상품 카테고리 정보)</P>
                     <p>
                        - 아래 데이터 중 * 표시가 된 것은 필수 전달 데이터 항목입니다.<br/>                               
                        - 아래 데이터는 테스트를 돕기 위해 임의로 채워진 테스트 데이터입니다.               
                     </p>
                     <br/>
                     <div>
                        <div>
                           <form name="adbrixProductViewForm" id="adbrixProductViewForm" >
                              <table>
                                 <colgroup>
                                    <col style="width: 200px;">
                                    <col>
                                 </colgroup>
                                 <tr>
                                    <th>*상품아이디</th>
                                    <td>
                                       <input name="productId" type="text" placeholder="*상품아이디">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>*상품명</th>
                                    <td>
                                       <input name="productName" type="text" placeholder="*상품명">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>*상품단가</th>
                                    <td>
                                       <input name="price" type="text" placeholder="*상품단가">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>*구매수량</th>
                                    <td>
                                       <input name="quantity" type="text" placeholder="*구매수량">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>상품 카테고리(A.B.C.D.E)</th>
                                    <td>
                                       <input name="category" type="text" placeholder="상품 카테고리(A.B.C.D.E)">
                                    </td>
                                 </tr>
                              </table>
                              <br>	                       
                              <button type="button" class="btn" >Call</button>
                           </form>
                        </div>
                     </div>
                  </main>
               </div>
            </div>
         </article>
         <!-- 상품검색 -->
         <article class="popLayer a adbrixSearchPop" id="adbrixSearchPop" >
            <div class="pbd">
               <div class="phd">
                  <div class="in">
                     <h1 class="tit">상품 검색</h1>
                     <button type="button" class="btnPopClose">닫기</button>
                  </div>
               </div>
               <div class="pct">
                  <main class="poptents">
                     <p>상품명을 검색한 시점에 정보 전달</p>
                     <P>호출 함수 : adbrix.search(param)</P>
                     <p>필수 : keyword, productId, productName, price, quantity</p>
                     <P>옵션 : category (구매상품 카테고리 정보)</P>
                     <P>비고 : 검색 결과 상위 5건 까지</P>
                     <p>
                        - 아래 데이터 중 * 표시가 된 것은 필수 전달 데이터 항목입니다.<br/>                               
                        - 아래 데이터는 테스트를 돕기 위해 임의로 채워진 테스트 데이터입니다.               
                     </p>
                     <br/>
                     <div>
                        <div>
                           <form name="adbrixSearchForm" id="adbrixSearchForm" >
                              <table>
                                 <colgroup>
                                    <col style="width: 200px;">
                                    <col>
                                 </colgroup>
                                 <tr>
                                    <th>*키워드</th>
                                    <td>
                                       <input name="keyword " type="text" placeholder="키워드">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>*상품아이디</th>
                                    <td>
                                       <input name="productId" type="text" placeholder="*상품아이디">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>*상품명</th>
                                    <td>
                                       <input name="productName" type="text" placeholder="*상품명">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>*상품단가</th>
                                    <td>
                                       <input name="price" type="text" placeholder="*상품단가">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>*구매수량</th>
                                    <td>
                                       <input name="quantity" type="text" placeholder="*구매수량">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>상품 카테고리(A.B.C.D.E)</th>
                                    <td>
                                       <input name="category" type="text" placeholder="상품 카테고리(A.B.C.D.E)">
                                    </td>
                                 </tr>
                              </table>
                              <br>	                       
                              <button type="button" class="btn" >Call</button>
                           </form>
                        </div>
                     </div>
                  </main>
               </div>
            </div>
         </article>
         <!-- 장바구니 담기 -->
         <article class="popLayer a adbrixCartPop" id="adbrixCartPop" >
            <div class="pbd">
               <div class="phd">
                  <div class="in">
                     <h1 class="tit">장바구니 담기</h1>
                     <button type="button" class="btnPopClose">닫기</button>
                  </div>
               </div>
               <div class="pct">
                  <main class="poptents">
                     <p>장바구니 담기가 완료된 시점에 정보 전달</p>
                     <P>호출 함수 : adbrix.cart(param)</P>
                     <p>필수 : productId, productName, price, quantity</p>
                     <P>옵션 : category (구매상품 카테고리 정보)</P>
                     <p>
                        - 아래 데이터 중 * 표시가 된 것은 필수 전달 데이터 항목입니다.<br/>                               
                        - 아래 데이터는 테스트를 돕기 위해 임의로 채워진 테스트 데이터입니다.               
                     </p>
                     <br/>
                     <div>
                        <div>
                           <form name="adbrixCartForm" id="adbrixCartForm" >
                              <table>
                                 <colgroup>
                                    <col style="width: 200px;">
                                    <col>
                                 </colgroup>
                                 <tr>
                                    <th>*상품아이디</th>
                                    <td>
                                       <input name="productId" type="text" placeholder="*상품아이디">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>*상품명</th>
                                    <td>
                                       <input name="productName" type="text" placeholder="*상품명">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>*상품단가</th>
                                    <td>
                                       <input name="price" type="text" placeholder="*상품단가">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>*구매수량</th>
                                    <td>
                                       <input name="quantity" type="text" placeholder="*구매수량">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>상품 카테고리(A.B.C.D.E)</th>
                                    <td>
                                       <input name="category" type="text" placeholder="상품 카테고리(A.B.C.D.E)">
                                    </td>
                                 </tr>
                              </table>
                              <br>	                       
                              <button type="button" class="btn" >Call</button>
                           </form>
                        </div>
                     </div>
                  </main>
               </div>
            </div>
         </article>
         <!-- 최초결제 완료 -->
         <article class="popLayer a adbrixFirstBuyPop" id="adbrixFirstBuyPop" >
            <div class="pbd">
               <div class="phd">
                  <div class="in">
                     <h1 class="tit">최초결제 완료</h1>
                     <button type="button" class="btnPopClose">닫기</button>
                  </div>
               </div>
               <div class="pct">
                  <main class="poptents">
                     <p>최초 결제가 완료된 시점에 정보 전달</p>
                     <P>호출 함수 : adbrix.firstBuy(param)</P>
                     <p>필수 : </p>
                     <P>옵션 : </P>
                     <p>
                        - 아래 데이터 중 * 표시가 된 것은 필수 전달 데이터 항목입니다.<br/>                               
                        - 아래 데이터는 테스트를 돕기 위해 임의로 채워진 테스트 데이터입니다.               
                     </p>
                     <br/>
                     <div>
                        <div>
                           <form name="adbrixFirstBuyForm" id="adbrixFirstBuyForm" >
                              <table>
                                 <colgroup>
                                    <col style="width: 200px;">
                                    <col>
                                 </colgroup>
                                 <tr>
                                    <th></th>
                                    <td>
                                       <input name="" type="text" placeholder="">
                                    </td>
                                 </tr>
                              </table>
                              <br>	                       
                              <button type="button" class="btn" >Call</button>
                           </form>
                        </div>
                     </div>
                  </main>
               </div>
            </div>
         </article>
         <!-- 결제 완료 -->
         <article class="popLayer a adbrixBuyPop" id="adbrixBuyPop" >
            <div class="pbd">
               <div class="phd">
                  <div class="in">
                     <h1 class="tit">결제 완료</h1>
                     <button type="button" class="btnPopClose">닫기</button>
                  </div>
               </div>
               <div class="pct">
                  <main class="poptents">
                     <p>결제가 완료된 시점에 정보 전달</p>
                     <P>호출 함수 : adbrix.buy(param)</P>
                     <p>필수 : orderId, productId, productName, price, quantity</p>
                     <P>옵션 : category (구매상품 카테고리 정보)</P>
                     <P>커스텀 : 첫구매 여부</P>
                     <p>
                        - 아래 데이터 중 * 표시가 된 것은 필수 전달 데이터 항목입니다.<br/>                               
                        - 아래 데이터는 테스트를 돕기 위해 임의로 채워진 테스트 데이터입니다.               
                     </p>
                     <br/>
                     <div>
                        <div>
                           <form name="adbrixBuyForm" id="adbrixBuyForm" >
                              <table>
                                 <colgroup>
                                    <col style="width: 200px;">
                                    <col>
                                 </colgroup>
                                 <tr>
                                    <th>*주문번호</th>
                                    <td>
                                       <input name="orderId" type="text" placeholder="*주문번호">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>*상품아이디</th>
                                    <td>
                                       <input name="productId" type="text" placeholder="*상품아이디">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>*상품명</th>
                                    <td>
                                       <input name="productName" type="text" placeholder="*상품명">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>*상품단가</th>
                                    <td>
                                       <input name="price" type="text" placeholder="*상품단가">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>*구매수량</th>
                                    <td>
                                       <input name="quantity" type="text" placeholder="*구매수량">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>상품 카테고리(A.B.C.D.E)</th>
                                    <td>
                                       <input name="product_category" type="text" placeholder="상품 카테고리(A.B.C.D.E)">
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>첫구매 여부</th>
                                    <td>
                                       <input name="firstYn" type="text" placeholder="첫구매 여부">
                                    </td>
                                 </tr>
                              </table>
                              <br>	                       
                              <button type="button" class="btn" >Call</button>
                           </form>
                        </div>
                     </div>
                  </main>
               </div>
            </div>
         </article>
         <!-- E: 애드브릭스 설명 -->
         
         <!-- S: 구글 애널리틱스 설명-->
         <!-- typeA -->
         <article class="popLayer a typeAPop" id="typeAPop" >
            <div class="pbd">
               <div class="phd">
                  <div class="in">
                     <h1 class="tit">typeA</h1>
                     <button type="button" class="btnPopClose">닫기</button>
                  </div>
               </div>
               <div class="pct">
                  <main class="poptents">
                     <p>typeA 정보 전달</p>
                     <P>호출 함수 : </P>
                     <p>필수 : </p>
                     <P>옵션 : </P>
                     <p>
                        - 아래 데이터 중 * 표시가 된 것은 필수 전달 데이터 항목입니다.<br/>                               
                        - 아래 데이터는 테스트를 돕기 위해 임의로 채워진 테스트 데이터입니다.               
                     </p>
                     <br/>
                     <div>
                        <div>
                           <form name="adbrixJoinForm" id="adbrixJoinForm" >
                              <table>
                                 <colgroup>
                                    <col style="width: 200px;">
                                    <col>
                                 </colgroup>
                                 <tr>
                                    <th></th>
                                    <td>
                                       <input name="" type="text" placeholder="">
                                    </td>
                                 </tr>
                              </table>
                              <br>	                       
                              <button type="button" class="btn" >Call</button>
                           </form>
                        </div>
                     </div>
                  </main>
               </div>
            </div>
         </article>
         <!-- E: 구글 애널리틱스 설명-->
      </div>
   </tiles:putAttribute>
</tiles:insertDefinition>