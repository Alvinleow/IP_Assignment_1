<%@ page import="shop.VCDBean" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shopping Cart Add Result</title>
    
    <style>
		.center {
		  text-align: center;
		}
	</style>
    
</head>
<body bgcolor="#33CCFF">
<!--     <center> -->
	<div class="center">
        <%
            VCDBean addedItem = (VCDBean) request.getAttribute("addedItem");
            if (addedItem != null) {
        %>
                <b><%= addedItem.getQuantity() %> item added to your shopping cart.</b>
        <%
            } else {
                out.println("<p>No item was added to the cart.</p>");
            }
        %>
        <br>
        <br>
        <a href="ShoppingServlet?action=VIEW">view</a> &nbsp;
        <a href="index.jsp">shopping</a> &nbsp;
        <a href="checkout.jsp">checkout</a> &nbsp;
        <a href="logout.jsp">logout/remove</a>
	</div>
<!--     </center> -->
</body>
</html>
