<strong class="tit">소셜 로그인 연동</strong>
<div class="flex-wrap">
    <div class="txt">네이버 로그인 연결</div>
    <c:set var="naverSnsUuid" value="${snsInfo[frontConstants.SNS_LNK_CD_10].snsUuid}" />
    <c:choose>
        <c:when test="${not empty naverSnsUuid}">
            <a href="javascript:void(0);" class="btn sm " onclick="sns.disconnect('${naverSnsUuid}',${frontConstants.SNS_LNK_CD_10})" data-content="${mbrNo}" data-url="/snsLogin?chnlId=${frontConstants.SNS_LNK_CD_10}">해제하기</a>
        </c:when>
        <c:otherwise>
            <a href="javascript:void(0);" class="btn sm " onclick="sns.connect(${frontConstants.SNS_LNK_CD_10})" data-content="${mbrNo}" data-url="/snsLogin?chnlId=${frontConstants.SNS_LNK_CD_10}"
            >연결하기</a>
        </c:otherwise>
    </c:choose>
</div>
<div class="flex-wrap">
    <div class="txt">카카오 로그인 연결</div>
    <c:set var="kakaoSnsUuid" value="${snsInfo[frontConstants.SNS_LNK_CD_20].snsUuid}" />
    <c:choose>
        <c:when test="${not empty kakaoSnsUuid}">
            <a href="javascript:void(0);" class="btn sm " onclick="sns.disconnect('${kakaoSnsUuid}',${frontConstants.SNS_LNK_CD_20})" data-content="${mbrNo}" data-url="/snsLogin?chnlId=${frontConstants.SNS_LNK_CD_20}">해제하기</a>
        </c:when>
        <c:otherwise>
            <a href="javascript:void(0);" class="btn sm " onclick="sns.connect(${frontConstants.SNS_LNK_CD_20})" data-content="${mbrNo}" data-url="/snsLogin?chnlId=${frontConstants.SNS_LNK_CD_20}"
            >연결하기</a>
        </c:otherwise>
    </c:choose>
</div>
<div class="flex-wrap">
    <div class="txt">구글 로그인 연결</div>
    <c:set var="googleSnsUuid" value="${snsInfo[frontConstants.SNS_LNK_CD_30].snsUuid}" />
    <c:choose>
        <c:when test="${not empty googleSnsUuid}">
            <a href="javascript:void(0);" class="btn sm " onclick="sns.disconnect('${googleSnsUuid}',${frontConstants.SNS_LNK_CD_30})" data-content="${mbrNo}" data-url="/snsLogin?chnlId=${frontConstants.SNS_LNK_CD_30}">해제하기</a>
        </c:when>
        <c:otherwise>
            <a href="javascript:void(0);" class="btn sm " onclick="sns.connect(${frontConstants.SNS_LNK_CD_30})" data-content="${mbrNo}" data-url="/snsLogin?chnlId=${frontConstants.SNS_LNK_CD_30}"
            >연결하기</a>
        </c:otherwise>
    </c:choose>
</div>
<div class="flex-wrap">
    <div class="txt">애플 로그인 연결</div>
    <c:set var="appleSnsUuid" value="${snsInfo[frontConstants.SNS_LNK_CD_40].snsUuid}" />
    <c:choose>
        <c:when test="${not empty appleSnsUuid}">
            <a href="javascript:void(0);" class="btn sm " onclick="sns.disconnect('${appleSnsUuid}',${frontConstants.SNS_LNK_CD_40})" data-content="${mbrNo}" data-url="/snsLogin?chnlId=${frontConstants.SNS_LNK_CD_40}">해제하기</a>
        </c:when>
        <c:otherwise>
            <a href="javascript:void(0);" class="btn sm " onclick="sns.connect(${frontConstants.SNS_LNK_CD_40})" data-content="${mbrNo}" data-url="/snsLogin?chnlId=${frontConstants.SNS_LNK_CD_40}"
            >연결하기</a>
        </c:otherwise>
    </c:choose>
</div>