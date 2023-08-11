<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>HScode 검색</title>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<body>
<h1>HScode 검색</h1>
<label for="searchInput1">HScode(2~6단위)</label>
<input type="text" id="searchInput1" minlength="2" maxlength="6" placeholder="숫자만 입력해주세요">
<br>
<label for="searchInput2">품명</label>
<input type="text" id="searchInput2">

<script>
  // CSV 파일 경로
  const csvFilePath = 'resources/HScode.csv';

  const btn = document.getElementById("search_btn");
  btn.addEventListener('click', function() {
    event.stopPropagation();
    console.log("함수시작");

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
            searchResult.innerHTML = '검색 결과: <tr>';
            for (let value of matchingValues) {
              searchResult.innerHTML += '<td>' + value + '</td>';
            }
            searchResult.innerHTML += '</tr>';
          } else {
            searchResult.innerHTML = '검색 결과: 해당 값이 없습니다.';
          }
        } else {
          searchResult.innerHTML = 'CSV 파일을 읽는 데 실패하였습니다.';
        }
      } else {
        console.log(" HTTP 응답 또는 요청실패")
      }
    };

    xhr.open('GET', csvFilePath, true);
    xhr.send();
  })
</script>

<button type = "button" id = "search_btn">검색</button>

<table border="1">
  <thead>
  <tr>
    <th>HScode(10단위)</th>
    <th>HScode(6단위)</th>
    <th>대분류</th>
    <th>상세품명</th>
  </tr>
  </thead>
  <tbody id="searchResult">
  </tbody>
</table>

</body>
</html>
