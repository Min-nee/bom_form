<%@ page contentType ="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Creating BOM</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="resources/index_css.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        function btn_add(){
            var row_idx = parseInt($(".row_idx:last").text()) + 1;
            if(!row_idx){row_idx=1;}
            var str = "";

            str += "<tr>";
            str += "	<td style='text-align:center;' class=\"row_idx\">"+row_idx+"</td>";
            str += "	<td style='text-align:center;'><input type=\"text\"></td>";
            str += "	<td style='text-align:center;'><input type=\"text\"></td>";
            str += "	<td style='text-align:center;'><input type=\"text\"></td>";
            str += "	<td style='text-align:center;'><input type=\"text\"></td>";
            str += "	<td style='text-align:center;'><input type=\"text\"></td>";
            str += "	<td style='text-align:center;'><input type=\"text\"></td>";
            str += "	<td style='text-align:center;'><input type=\"text\"></td>";
            str += "	<td style='text-align:center;'>";
            str += "		<div class=\"btn\">";
            str += "			<button type='button' class='del_btn' onclick='del_btn(" + row_idx + ")'>삭제</button>";
            str += "		</div>";
            str += "	</td>";
            str += "</tr>";

            $("#content:last").append(str);
        }

        function del_btn(row_idx) {
            $("tr").filter(function() {
                return $(this).find("td:first-child").text() === row_idx.toString();
            }).remove();
        }
    </script>
</head>
<body>
    <h2 id = "BOM_title">Bill of Materials</h2>
    <h4 id = "bom">BOM</h4>
    <span id = "comp_span">
    <input type = "text" size = "50" placeholder="(선택사항)회사명을 입력하세요" style = "align-content: center;text-align: center">
    </span>
    <table style = "border : solid">
        <tr>
            <th>연번</th>
            <th>품명</th>
            <th>HS코드<br>(품목번호)</th>
            <th>원산지</th>
            <th>원산지 결정기준(선택)</th>
            <th>구매처</th>
            <th>증빙서류</th>
            <th>가격(선택)</th>
            <th><button onclick="btn_add()">행 추가</button></th>
        </tr>
        <tbody id="content">
        </tbody>
    </table>

</body>
</html>