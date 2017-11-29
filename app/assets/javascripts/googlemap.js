
var map;
		var showItem = 0;//チャートに描画される項目の切り替えフラグ
		//チャートに描画される文字列 0~6で切り替え
		var itemName =	[
				 ["流れる水の量", "岸のようす", "魚が川を遡れるか"],
				 ["川原と水辺の植物","鳥の生息、すみ場","魚の生息、すみ場","川底の様子と底生生物"],
				 ["透明度","水のにおい","COD"],
				 ["けしき","ごみ","水との触れ合い","川のかおり","川の音"],
				 ["歴史と文化","水辺の近づきやすさ","日常的な利用","産業などの活動","環境の活動"],
				 ["自然なすがた", "ゆたかな生きもの", "水のきれいさ", "快適な水辺", "地域とのつながり"]
				];
		var markers = new Array();	//マーカーを格納する変数
		var infowindows = new Array();	//infowindowを格納する変数
		var infowindowFlag; //infowindowを多重に開けないようにするためのフラグ配列 
		var sur_names = new Array();	//jsonからのsurvey_nameを格納する多次元配列
		var site_names = new Array();	//jsonからのsite_nameを格納する
		var values = new Array();	//jsonからのvaluesを格納する多次元配列
		var zCounter = 0;		//infowindowのzindexを指定するための変数

		//googlemapAPIが読まれたときにコールバックされるマップ生成関数
		function initMap() {
			//data内のvalue1,2,3,.....i　を手動でarrayに変換する
			function convValues(data) {
				var values = new Array();
				//jsonからの読み出しだとstring型になっているようなのでintにキャストする
				values[0] = parseInt(data.value1);
				values[1] = parseInt(data.value2);
				values[2] = parseInt(data.value3);
				values[3] = parseInt(data.value4);
				values[4] = parseInt(data.value5);
				values[5] = parseInt(data.value6);
				values[6] = parseInt(data.value7);
				values[7] = parseInt(data.value8);
				values[8] = parseInt(data.value9);
				values[9] = parseInt(data.value10);
				values[10] = parseInt(data.value11);
				values[11] = parseInt(data.value12);
				values[12] = parseInt(data.value13);
				values[13] = parseInt(data.value14);
				values[14] = parseInt(data.value15);
				values[15] = parseInt(data.value16);
				values[16] = parseInt(data.value17);
				values[17] = parseInt(data.value18);
				values[18] = parseInt(data.value19);
				values[19] = parseInt(data.value20);
				values[20] = parseInt(data.value21);
				values[21] = parseInt(data.value22);
				values[22] = parseInt(data.value23);
				values[23] = parseInt(data.value24);
				values[24] = parseInt(data.value25);
				return values;
			}

			//markerにクリックイベントを取り付ける
			function setInfo (marker,id) {
				google.maps.event.addListener(
					marker, 'click',function(){
						//２つ以上のinfowindowを同じ地点に表示させない
						if(!infowindowFlag[id]) {
							//infowindowがない場合の処理
							infowindows[id].open(map,marker);
							infowindows[id].setZIndex(zCounter);	//Zindexを指定する(最後にクリックされたpinに対応するinfowindowが常に前に表示される）
							zCounter ++;				//Zindexカウンタを増やす
							//多重表示防止のためのフラグを立てる
							infowindowFlag[id]=true;
							
							//チャートを描くためのキャンバス生成と描画
							clearCanvas(id);
							drawChart(id);	
						}
					}
				);
				//infowindowが閉じられた際のリスナ
				google.maps.event.addListener(infowindows[id], 'closeclick', function() {
					infowindowFlag[id]=false;	//フラグをfalseにする
									//zindexカウンタを減らすならココ
         			});
			}

			//id番目のchartDivIDとその本文を返す関数(infowindowClickedの引数の値をforループの中でまわすとiが常に最新の値になるため分けた）
			function setChartDiv(id) {
				var chartDiv = "<div class=\"infoWindow\" onclick = infowindowClicked(id) id=\"chartDiv" + id + "\">hi this is no" + id + "infowindow";
				chartDiv += "</div>";
				return chartDiv;
			}

			//マップの配置
			var mapDiv = document.getElementById( "map-canvas" ) ;
			map = new google.maps.Map( mapDiv, {
				center: new google.maps.LatLng( 40.784068, 140.7789853 ) ,
				zoom: 11 ,
			} ) ;
			
			//JSONの読み込みとmarkerの配置
			//data内のlatlng、marker数の総数はここでしか使わないので、変数の数を増やさないためにここで一括でマーカー配置などを行う
			$.getJSON("data.json" , function(data) {	//ファイル名はべたうち
				//infowindowの表示状態フラグの配列を生成、初期化
				infowindowFlag = new Array(data.length);	//dataの個数の最大値とフラグの個数は一緒
				//値をすべてfalse(0)にする
				for(var i = 0;i<infowindowFlag.length;i++) {
					infowindowFlag[i] = false;
				}
				//マーカーの配置
				for (var i = 0; i < data.length; i++) {
					//後から使う値について配列に収める
					sur_names[i] = data[i].survey_name;		//調査名を配列に代入
					site_names[i] = data[i].site_name;		//調査地点名を配列に代入
					values[i] = convValues(data[i]);	//ステータスを配列に変換、代入
					markers[i] = new google.maps.Marker( {	//マーカーの生成
									map: map,
									position: new google.maps.LatLng(data[i].latitude, data[i].longitude ) ,
					});
					//infowindowの生成
					var chartDiv = setChartDiv(i);
					infowindows[i] = new google.maps.InfoWindow({
							content:chartDiv
					});
					setInfo(markers[i],i);	//クリックイベントを割り当てる(infowindowのopen)
				}
  			});		

			resizeHeight();
		}
		
	
	//infowindowがクリックされた時にzindexを一番新しい値に増やす処理
	function infowindowClicked(id) {
		console.log("clicked");
		var i = id.slice(-1);	//何故か文字列としてidが渡されてくるので、chartDiv0 の 数値の部分だけ切り取る
		infowindows[i].setZIndex(zCounter);	//Zindexを指定する(最後にクリックされたpinに対応するinfowindowが常に前に表示される）
		zCounter ++;				//Zindexカウンタをすすめる
	}
	
	
	//tgtid番のradarChartCanvasにチャートを描画する　（idが2なら radarChartCanvas2 をフックする
	function drawChart(tgtID) {
		var rc = new html5jp.graph.radar("radarChartCanvas"+tgtID);	//チャートを描くcanvas要素を指定
  		if( ! rc ) { return; }
		//良い方法が思いつかないのでshowItemの値に応じて場合分けする
		if(showItem == 0) {	//流れる水の量 ~ 魚が川を遡れるか
			 var items = [
				["自然", values[tgtID][0],values[tgtID][1],values[tgtID][2]]
			];
		}
		if(showItem == 1) {	//川辺と水辺の植物 ~ 川底の様子と底生生物
			 var items = [
				["自然", values[tgtID][3],values[tgtID][4],values[tgtID][5],values[tgtID][6]]
			];
		}
		if(showItem == 2) {	//透視度 ~ COD
			 var items = [
				["水", values[tgtID][7],values[tgtID][8],values[tgtID][9]]
			];
		}
		if(showItem == 3) {	//けしき ~ 川の音
			 var items = [
				["水辺", values[tgtID][10],values[tgtID][11],values[tgtID][12],values[tgtID][13],values[tgtID][14]]
			];
		}
		if(showItem == 4) {	//歴史と文化 ~ 環境の活動
			 var items = [
				["地域", values[tgtID][15],values[tgtID][16],values[tgtID][17],values[tgtID][18],values[tgtID][19]]
			];
		}
		if(showItem == 5) {	//歴史と文化
			 var items = [
				["総合平均", values[tgtID][20],values[tgtID][21],values[tgtID][22],values[tgtID][23],values[tgtID][24]]
			];
		}
		
		//表示される項目名をItemNameから持ってくる
  		var params = {
			 aCap: itemName[showItem] , 	//表示する文字列配列
			 aMax: 3			//項目の最大値
  		}
 		rc.draw(items, params);	//チャートの描画
	}

	//id番のchartDivをフックして、要素の子要素をすべて削除してcanvasを生成し直す。例：idが2なら chartDiv2 をフックする
	function clearCanvas(tgtID) {
		//（canvas内に描画した絵以外にも、文字列等がdrawchartでは生成されているが、それのID等がわからないためすべて削除する）
		$(document.getElementById('chartDiv' + tgtID)).empty();
		$(document.getElementById('chartDiv' + tgtID)).append("<div style=\"text-align:center\">" + sur_names[tgtID] +":" + site_names[tgtID] + "</div>");
		$(document.getElementById('chartDiv' + tgtID)).append("<canvas width=\"400\" height=\"300\" id=\"radarChartCanvas" + tgtID + "\"></canvas>");	
	}

	//チャートに表示する項目を変更して、すでに表示されているウィンドウがあれば書き換える
	function changeItem(item) {
		showItem = item;
		//すでに表示されているinfowindowのチャートを書き換える
		for(var i=0;i<infowindowFlag.length;i++) {
			if(infowindowFlag[i]) {
				clearCanvas(i);
				drawChart(i);
			}
		}
	}
	
	//radiobuttonのfunction、valueに格納された値に対応したchangeItemを表示する
	$(function() {
/*
   	 $('#mode input[type=radio]').change( function() {
   	 		console.log(this.value);
        	changeItem(this.value);
   	 });
*/
   	 $("input[name=item_select]").on("change", function () {
   	 	var value = $("input[name=item_select]:checked").val();
   	 	console.log("item_select: " + value);
        changeItem(value);
   	 });
})