<form action=main.jsp method=post>
    <table border=0>
        <tr>
            <td>
                目前页数：
                <font color=red><%=pageNO%></font>
            </td>
            <td>
                总页数：
                <font color=red><%=lastPage%></font>
            </td>
            <td>
                <a href=main.jsp?pageNO=<%=firstPage%>>【第一页】</a>
            </td>
            <td>
                <a href=main.jsp?pageNO=<%=prePage%>>【上一页】</a>
            </td>
            <td>
                <a href=main.jsp?pageNO=<%=nextPage%>>【下一页】</a>
            </td>
            <td>
                <a href=main.jsp?pageNO=<%=lastPage%>>【最后一页】</a>
            </td>
            <td>
                输入页次：
                <input type=text size=3 name=pageNO value="<%=pageNO %>">
            </td>
            <td>
                <input type=submit name=send value="送出">
            </td>
        </tr>
    </table>
</form>