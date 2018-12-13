<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="payOk" method="GET">
<input type="hidden" name="cid" value="TC0ONETIME">
<input type="hidden" name="partner_order_id" value="testorder01">
사용자 아이디 : <input type="text" name="partner_user_id" value="testuser01"><br>
사는 물건 : <input type="text" name="item_name" value="모니터"><br>
개수 : <input type="text" name="quantity" value="1"><br>
가격 : <input type="text" name="total_amount" value="8000"><br>
세금 : <input type="text" name="vat_amount" value="10"><br>
할인 : <input type="text" name="tax_free_amount" value="100"><br>
   
<input type="hidden" name="approval_url" value="http://ec2-52-79-233-71.ap-northeast-2.compute.amazonaws.com:8081/spring/paysuccess">
<input type="hidden" name="cancel_url" value="http://ec2-52-79-233-71.ap-northeast-2.compute.amazonaws.com:8081/spring/paycancel">
<input type="hidden" name="fail_url" value="http://ec2-52-79-233-71.ap-northeast-2.compute.amazonaws.com:8081/spring/payfail">

<!-- 
<input type="hidden" name="approval_url" value="http://localhost:8081/spring/paysuccess">
<input type="hidden" name="cancel_url" value="http://localhost:8081/spring/paycancel">
<input type="hidden" name="fail_url" value="http://localhost:8081/spring/payfail">
 -->
<input type="submit" value="전송">
</form>

</body>
</html>