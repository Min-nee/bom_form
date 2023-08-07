<%@ page contentType ="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>HScode 검색</title>
</head>
<body>
<h1>HScode 검색</h1>
<label for="searchInput">검색어:</label>
<input type="text" id="searchInput">
<button onclick="searchValue()">검색</button>
<div id="searchResult"></div>

<script>
  // CSV 파일 경로
  const csvFilePath = 'resources/HScode.csv';

  // CSV 파일을 읽고 값을 검색하는 함수
  function searchValue() {
    const searchKeyword = document.getElementById('searchInput').value;
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
            const targetValue = values[1]; // 6단위 검색

            if (targetValue.startsWith(searchKeyword)) {
              matchingValues.push(values.join(', '));
            }
          }

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


</body>
</html>
