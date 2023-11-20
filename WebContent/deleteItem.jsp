<%@ page import="shop.VCDBean" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shopping Cart Item Removal Result</title>
    
    <style>
        .center {
            text-align: center;
        }
    </style>
    
</head>
<body bgcolor="#33CCFF">
<div class="center">
    <%
    	String deletedTitle = (String) request.getAttribute("deletedTitle");
        if (deletedTitle != null) {
    %>
            <b>VCD title = [<%= deletedTitle %>] removed from your shopping cart.</b>
    <%
        } else {
    %>
            <p>No item was removed from the cart.</p>
    <%
        }
    %>
    <br>
    <br>
    <a href="ShoppingServlet?action=VIEW">view</a> &nbsp;
    <a href="index.jsp">shopping</a> &nbsp;
    <a href="checkout.jsp">checkout</a> &nbsp;
    <a href="logout.jsp">logout/remove</a>
</div>
</body>
</html>
