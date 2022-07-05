// 분석 결과 확인 화면

import 'package:flutter/material.dart';
import 'package:nugunyaneon01/screen/loading.dart';
import 'package:dio/dio.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  var analysisData; // 분석 결과를 받아올 String 객체
  int file_id = 0;
  int index = 0;

  List<String> tmpList = []; // 데이터를 map으로 변경하기 위한 임시 리스트
  Map<String, dynamic> dataMap = {}; // 분석한 데이터를 저장할 map

  List<String> conclusion = ["안전", "의심", "경고", "위험"];
  List<String> category = [
    "보이스피싱일 확률이 낮으니\n안심하셔도 됩니다.",
    "상대방과 금융 거래를 하거나\n개인정보를 알려주지 마십시오.\n\n더 자세한 사항은\n\n앱의 'Emergency' 메뉴에서\n'대응 방법'을 확인해 주세요.",
    "상대방과 금융 거래를 하거나\n개인정보를 알려주지 마십시오.\n\n더 자세한 사항은\n\n앱의 'Emergency' 메뉴에서\n'대응 방법'을 확인해 주세요.",
    "상대방과 금융 거래를 하거나\n개인정보를 알려주지 마십시오.\n\n더 자세한 사항은\n\n앱의 'Emergency' 메뉴에서\n'대응 방법'을 확인해 주세요."
  ];

  @override
  Widget build(BuildContext context) {
    // 계속 호출됨. 개선 필요
    loadData();
    setIndex();
    // 계속 호출됨. 개선 필요
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image(
          image: AssetImage('image/resultimage.png'), // 잡았다 너
          width: 500,
          height: 150,
        ),

        Padding(
          padding: EdgeInsets.only(bottom: 80),
        ),

        // 보이스피싱 확률에 따라 텍스트 출력
        // 예시: 금융대출사기 경고
        Text(dataMap['phishingType'] + ' ' + conclusion[index].toString(),
            style: TextStyle(
                fontSize: 25, color: Colors.red, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        Padding(
          padding: EdgeInsets.only(bottom: 30),
        ),

        Text('보이스피싱 확률 ' + dataMap['probability'].toString() + '%% 입니다.',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        Padding(
          padding: EdgeInsets.only(bottom: 80),
        ),

        Text(category[index],
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),

        Padding(
          padding: EdgeInsets.only(bottom: 30),
        ),

        // 돌아가기 버튼
        RaisedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              // main page의 뒤로가기 버튼을 pushReplacement 를 써주면 사라짐
              MaterialPageRoute(builder: (context) => Loading()),
            );
          },
          child: Text("\n돌아가기\n",
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(250, 255, 255, 101),
              ),
              textAlign: TextAlign.center),
          color: Color.fromARGB(510, 76, 167, 169),
        ),
      ])),
    );
  }

  loadData() async {
    Dio dio = Dio();
    final response = await dio
        .get('http://10.0.2.2:8000/nugunyaneon_app/analysis=' + 0.toString());
    //'http://10.0.2.2:8000/nugunyaneon_app/analysis=' + (file_id - 1).toString());
    if (response.statusCode == 200) {
      print("loadData: " + response.toString());
      setState(() {
        // json으로 변환해주는 코드가 필요한 듯 하다...
        analysisData = response.data.toString();
        usedData();
        print("dataMap: " + dataMap.toString());
        file_id += 1;
      });
    } else {
      throw Exception('failed to load data');
    }
  }

  usedData() {
    tmpList = spliteData(analysisData);
    makeMap(tmpList, dataMap);
  }

  // String으로 가져온 데이터를 ,(콤마)를 기준으로 분리
  List<String> spliteData(String data) {
    // 앞 뒤 {} 제거
    data = data.replaceAll('{', "");
    data = data.replaceAll('}', "");

    // 콤마로 구분해서 리턴
    return data.split(',');
  }

  // List<String>으로 만들어진 데이터를 Map으로 만드는 함수
  makeMap(List<String> data, Map<String, dynamic> dataMap) {
    // for 루프를 돌면서 리스트에 담긴 데이터에 접근
    for (int i = 0; i < data.length; i++) {
      // 리스트에 담긴 데이터를 :를 기준으로 분리
      List<String> tmp_data = data[i].split(':');

      // 로그
      print(tmp_data);

      // 분리한 데이터에서 양쪽 공백을 제거한 후에 Map에 담는다.
      dataMap[tmp_data[0].trim()] = tmp_data[1];
    }
  }

  setIndex() {
    double probability = double.parse(dataMap['probability']);
    if (probability <= 20.0) {
      //안전
      index = 0;
    } else if (probability <= 40.0) {
      // 의심
      index = 1;
    } else if (probability <= 60.0) {
      // 경고
      index = 2;
    } else {
      // 위험
      index = 3;
    }
  }
}
