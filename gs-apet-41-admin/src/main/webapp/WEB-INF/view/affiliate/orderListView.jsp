<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
    <t:putAttribute name="script">
        <script type="text/javascript">
            $(function(){
                messager.alert("TO-DO","Info");
            })
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        진행중
    </t:putAttribute>
</t:insertDefinition>