<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>
<%@ page import="com.study.spring.dto.orderDto2"%>

<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	<style>
	img.ui-datepicker-trigger {
                margin-left:5px; vertical-align:middle; cursor:pointer;
                }

	</style>
	
	<style>

            .cssHeaderRow {
                background-color: #2A94D6;
            }
            .cssTableRow {
                background-color: #F0F1F2;
            }
            .cssOddTableRow {
                background-color: #F0F1F2;
            }
            .cssSelectedTableRow {
                font-size: 20px;
                font-weight:bold;
            }
            .cssHoverTableRow {
                background: #ccc;
            }
            .cssHeaderCell {
                color: #FFFFFF;
                font-size: 16px;
                padding: 10px !important;
                border: solid 1px #FFFFFF;
            }
            .cssTableCell {
                font-size: 16px;
                padding: 10px !important;
                border: solid 1px #FFFFFF;
            }
            .cssRowNumberCell {
                text-align: center;
            }
        </style>
        
	<%
  		String cst_id = request.getParameter("cst_id");
  		String fromDate = request.getParameter("fromDate");
  		String toDate = request.getParameter("toDate");
  		
  		System.out.println("jsp cst_id : " + cst_id);
  		System.out.println("jsp fromDate : " + fromDate);
  		System.out.println("jsp toDate : " + toDate);
  		
  		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyyMMdd", Locale.KOREA );
		Date currentTime = new Date ();
		String mTime = mSimpleDateFormat.format ( currentTime );
  	%>
  	
  	
    <script type="text/javascript">
      $(function() {
    	  $.datepicker.setDefaults($.datepicker.regional['ko']); 

    	    $('#fromDate').datepicker({
    	    	//changeYear: true, 
    	    	changeMonth: true, 
    	        nextText: '다음 달',
    	        prevText: '이전 달',
    	        buttonImage: "images/calendar.gif", // 버튼 이미지

    	        //showButtonPanel: true, 
    	        //currentText: '오늘', 
    	        //closeText: '닫기', 
    	        dateFormat: "yy/mm/dd",
    	         
    	    	onClose: function( selectedDate ) {    
                	// 시작일(fromDate) datepicker가 닫힐때
                	// 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                	$("#toDate").datepicker( "option", "minDate", selectedDate );
            	}   

    	    });
    	    
    	    $('#toDate').datepicker({
    	    	//changeYear: true, 
    	    	changeMonth: true, 
    	        nextText: '다음 달',
    	        prevText: '이전 달',
    	        buttonImage: "images/calendar.gif", // 버튼 이미지
    	        
    	        //showButtonPanel: true, 
    	        //currentText: '오늘', 
    	        //closeText: '닫기', 
    	        dateFormat: "yy/mm/dd",

    	    	onClose: function( selectedDate ) {
               		// 종료일(toDate) datepicker가 닫힐때
               		// 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
               		$("#fromDate").datepicker( "option", "maxDate", selectedDate );
            	} 

    	    });
    	});
      </script>
      
      <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
      <script type="text/javascript">
	    google.charts.load('current', {'packages':['table']});
	    google.charts.setOnLoadCallback(drawTable);
	    
	    var orderprices = [];
	    var dates;
	    var datesize;
    
      function drawTable() {
    	var dataTable = new google.visualization.DataTable();
        var queryString3 = $("#searchData").serialize(); // <- 이것만 사용
        

        $.get("./cstChartResult?"+queryString3, function(data) {
		        // 데이터에서 좌표 값을 가지고 마커를 표시합니다
		        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다

		        //alert( "success" );   
		        
		        
		    })
		    .done(function(data) {
		        //alert( "second success" );
		       
		       //clusterer.clear();
		       console.log(data);
		       console.log(data.result.length);
		       

		       var dataLength = data.result.length;
		       var Direction;
		       
		        dataTable.addColumn('string', '날짜');
				dataTable.addColumn('number', '배송요금');
				dataTable.addColumn('string', '방향');
				dataTable.addColumn('string', '방식');
				//dataTable.addColumn('string', '송장번호');
				
				for(var i=0; i< dataLength; i++){
					if(data.result[i].direction == 1){
						Direction = "편도";		
					} else{
						Direction = "왕복";
					}
					
					if(data.result[i].orderkinds == 1){
						Kinds = "선불";		
					} else if(data.result[i].orderkinds == 2){
						Kinds = "후불";
					} else{
						Kinds = "포인트";
					}
					
				dataTable.addRows([
					
					[data.result[i].finished_DeliveryTime, data.result[i].orderPrices, Direction, Kinds]

		        ]);
				}
				
				var cssClassNames = {
	                    'headerRow': 'cssHeaderRow',
	                    'tableRow': 'cssTableRow',
	                    'oddTableRow': 'cssOddTableRow',
	                    'selectedTableRow': 'cssSelectedTableRow',
	                    'hoverTableRow': 'cssHoverTableRow',
	                    'headerCell': 'cssHeaderCell',
	                    'tableCell': 'cssTableCell',
	                    'rowNumberCell': 'cssRowNumberCell'
	                    	
	                };
	                
	                var options = {
	                    showRowNumber: true,
	                    cssClassNames: cssClassNames,
	                    width: '100%',
	                    height: '100%'
	                };
	                
	                
		        var table = new google.visualization.Table(document.getElementById('table_div'));

		        table.draw(dataTable, options);

		        
		    });

      }
      

    </script>
  </head>
  <body>
  	<%-- <c:forEach items="${result}" var="result">
  		${result.orderPrices }
  	</c:forEach> --%>
  	
 	<!-- <button onclick="test()">오늘</button> -->
 	
  	<form id="searchData" name="searchData" onsubmit="drawTable();" method="GET">
  		<input type="hidden" name="cst_id" value=<%=cst_id%>>
  		<%if(fromDate == null){ %>
  			<input type="text" name="fromDate" id="fromDate"  size="8" style = "text-align:center;"placeholder="시작일">	
  		<%} else{%>
  			<input type="text" name="fromDate" id="fromDate"  size="8" style = "text-align:center;" value=<%=fromDate%>>
  		<%} %>
  		~
  		<%if(toDate == null){ %>
  			<input type="text" name="toDate" id="toDate"  size="8" style = "text-align:center;" placeholder="종료일">	
  		<%} else{%>
  			<input type="text" name="toDate" id="toDate"  size="8" style = "text-align:center;" value=<%=toDate%>>
  		<%} %>
  		
  		
  		<input type="submit" value="검색">
  		</form>

	 
    <div id="table_div" ></div>

  </body>
</html>