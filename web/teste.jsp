<%
        if (request.getParameter("func") != null) {
            response.setContentType("text/html");
            int g;
            if (request.getSession().getAttribute("valor") != null) {
                g = Integer.parseInt(request.getSession().getAttribute("valor").toString()) + 1;
                request.getSession().setAttribute("valor", g);
            } else {
                request.getSession().setAttribute("valor", 1);
                g = 1;
            }
            out.println("count: " + g);



        } else {
            response.setContentType("text/html");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="js/jquery-1.3.1.min.js"></script>
        <script>
            $(document).ready(function(){

                $("td").click(function(){
                    var td=$(this);
                    $(td).hide();
                    $.post("teste.jsp", { func: "teste"}, function(msg){
                        $(td).text(msg);
                        $(td).show("slow");
                    });

                });
            });

        </script>
        <title>JSP Page</title>
        <style type="text/css">
            <!--
            .td {
                cursor: default;

            }
            -->
        </style>
    </head>
    <body>

        <h1>JSP Page</h1>

        <a href="http://www.google.com.br" class="stuff">Vai Sumir</a>
        <table>
            <tr>
                <td width="108">ads</td>
                <td width="109">dfds</td>
            </tr>
            <tr>
                <td>wrwer</td>
                <td>dfglvb</td>
            </tr>

        </table>
        <div id="mensagem">aki</div>

    </body>
</html>
<%}%>