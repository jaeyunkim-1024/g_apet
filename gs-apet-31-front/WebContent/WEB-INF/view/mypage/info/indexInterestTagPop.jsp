<article class="comm popLayer a interestTagPop" id="interestTagPop">
    <div class="pbd">
        <div class="phd">
            <div class="in">
                <button class="mo-header-backNtn" id="interestTagPopBackBtn">뒤로</button>
                <h1 class="tit left">관심 태그 변경</h1>
                <button type="button" class="btnPopClose" id="interestTagPopCloseBtn">닫기</button>
            </div>
        </div>
        <div class="pct">
            <main class="poptents">
                <div class="tag-choise mt20">
                    <h2>
                        관심있는 태그를<br><span>최소 1개 이상</span> 선택해주세요.
                    </h2>
                    <p class="tag-txt mt60"></p>
                    <div class="filter-area t2">
                        <div class="filter-item">
                            <div class="tag" id="int-tag-list" style="text-align: center;height: auto;">
                                <c:forEach var="intTag" items="${interestTag}"  varStatus="stat">
                                	<c:if test="${stat.index < 10}">
                                    <button type="button" class="" data-id="${intTag.dtlCd}" data-content="${intTag.dtlCd}" onclick="tag.onClick(this);">${intTag.dtlNm}</button>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="pull">
                    <div class="bts">
                        <a href="javascript:void(0);" id="tagSaveBtn" class="btn lg a">저장</a>
                    </div>
                </div>
            </main>
        </div>
    </div>
</article>