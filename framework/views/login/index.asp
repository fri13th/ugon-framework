<script>
    function customValidation() {
      if (document.loginForm.userid.value.length < 1) {
        alert('아이디를 넣어 주세요.');
        document.loginForm.userid.focus();
        return false;
      }

      if (document.loginForm.password.value.length < 1) {
        alert('비밀번호를 넣어 주세요.');
        document.loginForm.password.focus();
        return false;
      }

      return true
    }

    function AlertMsg() {
      if (window.location.href.indexOf("msg") > -1 ){
        alert("로그인한 후에 사용할 수 있습니다")
      }
    }
  AlertMsg()
</script>
<form action="http://<%=Request.ServerVariables("SERVER_NAME")%>/secure/login/aspLogin" method="post" name="loginForm" onSubmit="return customValidation();" style="background-color:#f7f7f7;">
<!--input type="hidden" name="c" value="login" /-->
<!--input type="hidden" name="m" value="login" /-->
<input type=hidden name="referrer" value="<%=Session("referrer")%>">
아이디 <INPUT name=userid type=text class=inputtext size="40" maxLength=40><br/>
비밀번호 <INPUT name="password" type=password class="inputtext" size="40" maxLength="40">
<input type="checkbox" name="saveId" id="saveId" checked/><label for="saveId">아이디 저장</label>
<input type="checkbox" name="autoLogin" id="autoLogin" checked/><label for="autoLogin">자동 로그인</label>
<input type="hidden" name="authToken" id="authToken" value=""/>

<script>
    $("#saveid").on("click", function(e) {
        document.getElementById("autoLogin").disabled = !this.checked;
    });
    if (USA.cookie.get("saveId") == "true" && localStorage["userid"])
        document.getElementById("userid").value = localStorage["userid"];

    if (localStorage["autoLogin"] == "on") {
        document.getElementById("authToken").value = localStorage["authToken"];
        document.getElementById("userid").value = localStorage["userid"];
        document.getElementById("loginForm").submit()
    }

</script>
