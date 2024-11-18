<strong class="tit requied mb"><spring:message code='front.web.view.mobile.phoneNumber'/></strong>
<div class="flex-wrap">
    <div class="txt">${mobile}</div>
    <a href="javascript:;" class="btn sm" onclick="mobileCert.cancel();"><spring:message code='front.web.view.common.msg.cancel'/></a>
</div>
<div class="certification">
    <div class="input  flex">
        <input type="text" value="${mobile}" id="tm" style="-webkit-text-fill-color:black;">
        <a href="javascript:;" class="btn md" id="sb" onclick="mobileCert.send();"><spring:message code='front.web.view.mobile.certificateNumber.send'/></a>
    </div>
    <div class="input  flex">
        <input type="text" id="ctfKey" name="ctfKey" placeholder="<spring:message code='front.web.view.mobile.certificateNumber.request'/>">
        <button type="button" class="expire" id="expire" tabindex="-1" style="display:none;" />
        <a href="javascript:;" class="btn md" onclick="mobileCert.verify(document.getElementById('ctfKey').value);"><spring:message code='front.web.view.mobile.certificateNumber.confirm'/></a>
    </div>
</div>