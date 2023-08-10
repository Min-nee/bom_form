<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>HScode 검색</title>
</head>
<body>
<h1>HScode 검색</h1>
<label for="searchInput1">HScode(2~6단위)</label>
<input type="text" id="searchInput1" minlength="2" maxlength="6" placeholder="숫자만 입력해주세요">
<br>
<label for="searchInput2">품명</label>
<input type="text" id="searchInput2">

<button onclick="searchValue()">검색</button>
<div id="searchResult"></div>

<script>
  // CSV 파일 경로
  const csvFilePath = 'resources/HScode.csv';

  // CSV 파일을 읽고 값을 검색하는 함수
  function searchValue() {
    const searchKeyword1 = document.getElementById('searchInput1').value;
    const searchKeyword2 = document.getElementById('searchInput2').value;
    const searchResult = document.getElementById('searchResult');

    // CSV 파일을 XMLHttpRequest를 사용하여 비동기적으로 읽기
    const xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        if (xhr.status === 200) {
          const csvData = xhr.responseText;
          const lines = csvData.split('\n');

          let matchingValues = [];

          for (let line of lines) {
            const values = line.split(',');
            const targetValue1 = values[1].trim(); // HScode(2~6단위)
            const targetValue2 = values[3].trim(); // 품명

            if (targetValue1.startsWith(searchKeyword1) && targetValue2.includes(searchKeyword2)) {
              matchingValues.push(values.join(', '));

              console.log('Search Keyword 1:', searchKeyword1);
              console.log('Search Keyword 2:', searchKeyword2);
              console.log('Target Value 1:', targetValue1);
              console.log('Target Value 2:', targetValue2);


            }
          }

          // 검색 결과
          if (matchingValues.length > 0) {
            searchResult.innerHTML = '검색 결과: <ul>';
            for (let value of matchingValues) {
              searchResult.innerHTML += '<li>' + value + '</li>';
            }
            searchResult.innerHTML += '</ul>';
          } else {
            searchResult.innerHTML = '검색 결과: 해당 값이 없습니다.';
          }
        } else {
          searchResult.innerHTML = 'CSV 파일을 읽는 데 실패하였습니다.';
        }
      }
    };

    xhr.open('GET', csvFilePath, true);
    xhr.send();
  }
</script>

<!-- getcsv 2nd ver -->
<script>
  function getCSV() {
    $("#content").empty();
    $.ajax({
      url : "/chapter25_ajax/csv.do",	 	// 읽어올 정보(경로)
      dataType : "text",					// 읽을 정보의 타입
      type : "post", 						// 읽을 방식
      success : function(data){			// 성공시 할 일(콜백)

        var csvs = data.split(",");
        var member = null;
        var result = '';

        for(var i=0; i<csvs.length; i++) {
          member = csvs[i].split(",");
          result += "<tr>";
          for(var j=0; j<member.length; j++) {
            result += "<td>" + member[j] + "</td>";
          }
          result += "</tr>";
        }

        $("#content").append(result);
        $("#typeCheck").text("CSV 가져오기");

      },
      error : function(){// 에러 발생 시 할 일(콜백)
        alert("실패!");
      }
    });
  }
</script>

<table border="1">
  <thead>
  <tr>
    <th>HScode(10단위)</th>
    <th>HScode(6단위)</th>
    <th>대분류</th>
    <th>상세품명</th>
  </tr>
  </thead>
  <tbody id="content">
  </tbody>
</table>

</body>
</html>
