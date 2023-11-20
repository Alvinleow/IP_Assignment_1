<%@ page import="shop.VCDBean" %>
<%@ page import="java.util.Vector" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Cart</title>
    
    <style>
    	table {
    		border: 0;
    		cellpadding: 0;
    		width: 100%;
            background-color: #FFFFFF;
            border-collapse: collapse;
    	}
		.center {
		  text-align: center;
		}
    </style>
    
</head>
<body bgcolor="#33CCFF">
    <!-- <center> -->
   
    	<%!
        // Helper method placed within a declaration block
        @SuppressWarnings("unchecked")
        private Vector<VCDBean> safeCastToVectorOfVCDBean(Object obj) {
            if (obj instanceof Vector<?>) {
                Vector<?> vec = (Vector<?>) obj;
                if (!vec.isEmpty() && vec.get(0) instanceof VCDBean) {
                    return (Vector<VCDBean>) vec;
                }
            }
            return new Vector<>();
        }
    	%>

        <%
        	Vector<VCDBean> buylist = safeCastToVectorOfVCDBean(session.getAttribute("cart"));
            if (buylist != null && !buylist.isEmpty()) {
                // Display the cart items
        %>
                <table>
                    <tr>
                        <td><b>VCD TITLE</b></td>
                        <td><b>ACTOR</b></td>
                        <td><b>PRICE</b></td>
                        <td><b>QUANTITY</b></td>
                        <td></td>
                    </tr>
                    <%
                        for (int index = 0; index < buylist.size(); index++) {
                            VCDBean item = buylist.elementAt(index);
                    %>
                        <tr>
                            <td><b><%= item.getTitle() %></b></td>
                            <td><b><%= item.getActor() %></b></td>
                            <td><b><%= item.getPrice() %></b></td>
                            <td><b><%= item.getQuantity() %></b></td>
                            <td>
                                <form name="deleteForm" action="ShoppingServlet" method="POST">
                                    <input type="submit" value="Delete">
                                    <input type="hidden" name="delindex" value="<%= index %>">
                                    <input type="hidden" name="action" value="DELETE">
                                </form>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                </table>
   	<div class="center">
                <a href="index.jsp">shopping</a>&nbsp;&nbsp;
                <a href="checkout.jsp">checkout</a>&nbsp;&nbsp;
                <a href="ShoppingServlet?action=LOGOUT">logout/remove</a>
	</div>
        <%
            } else {
            	out.println("<div class='center'>");
                out.println("<b>Shopping Cart Empty!</b><br><br>");
                out.println("<a href=\"index.jsp\">continue shopping?</a>");
                out.println("</div>");
            }
        %>
</body>
</html>
