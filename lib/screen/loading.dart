// 음성 파일 추가 화면

import 'package:flutter/material.dart';
import 'package:nugunyaneon01/screen/help.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:nugunyaneon01/screen/manual.dart';
import 'package:nugunyaneon01/screen/result.dart';
import 'package:nugunyaneon01/screen/settings.dart';
import 'package:nugunyaneon01/screen/wordcloud.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
// ============================ 변수 ============================ //
  int file_id = 0; // 파일 id default
  //bool isLoading = false; // 로딩 여부

  List<String> tmpList = []; // 데이터를 map으로 변경하기 위한 임시 리스트
  Map<String, dynamic> dataMap = {}; // 분석한 데이터를 저장할 map

  var analysisData; // 분석 결과를 받아올 String 객체
  var testData;

  PlatformFile default_file = PlatformFile(name: 'defualt', size: 0);
// ============================ 변수 ============================ //

// 앱을 켜는 순간 자동으로 사용자의 위치를 파악하는 것
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('보이스피싱 탐지'),
        backgroundColor: Color.fromARGB(510, 76, 167, 169),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('돋보기 버튼 클릭');
            },
          ),
        ],
      ),
// ============================ 메뉴 ============================ //
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('image/heart.png'),
                backgroundColor: Colors.white,
              ),
              accountName: Text('반갑습니다.'),
              accountEmail: Text('이동하려는 메뉴를 눌러주세요.'),
              decoration: BoxDecoration(
                color: Color.fromARGB(510, 76, 167, 169),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0)),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey[850],
              ),
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Loading()),
                );
                print('Home is clicked');
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: Icon(
                Icons.cloud,
                color: Colors.grey[850],
              ),
              title: Text('Data'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordCloud()),
                );
                print('Data is clicked');
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: Icon(
                Icons.emergency,
                color: Colors.grey[850],
              ),
              title: Text('Emergency'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Manual()),
                );
                print('Emergency is clicked');
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.grey[850],
              ),
              title: Text('Help'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpPage()),
                );
                print('Help is clicked');
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey[850],
              ),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
                print('Setting is clicked');
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),

// ============================ 결과 화면 ============================ //
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image(
          image: AssetImage('image/glessi.png'),
          width: 500,
          height: 150,
        ),
        Text("\n\n녹음 파일 속 상대방 발화를 분석하여\n\n보이스피싱 확률을 계산합니다.\n\n",
            style: TextStyle(fontSize: 15, color: Colors.black),
            textAlign: TextAlign.center),
        Text(
            "- 안전 (0 ~ 20%)\n\n- 의심 (21 ~ 40%)\n\n- 경고 (41 ~ 60%)\n\n- 위험 (61 ~ 100%)\n\n",
            style: TextStyle(
                fontSize: 15,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        Text("'의심' 이상의 결과가 나오면\n\n보이스피싱에 주의하세요!\n\n\n\n",
            style: TextStyle(fontSize: 15, color: Colors.black),
            textAlign: TextAlign.center),
        RaisedButton(
          onPressed: () async {
// ================= 파일 입력 =================
            print("파일 추가");
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              // 업로드 가능한 파일 확장자
              allowedExtensions: ['mp3', 'wav', 'm4a'],
            );
//----------------- 음성 파일 입력 받는 부분 -----------------//
// file 변수에 있는 데이터를 백에서 처리
            if (result != null) {
              PlatformFile file = result.files.single;
              // 파일 정보 로그
              print('PlatformFile: ');
              print(file);

              // 받아온 파일을 defualt_file에 저장
              default_file = file;
              // 파일 정보 로그
              postFile(default_file);
              Timer(Duration(seconds: 3), () {
                print("3초 지연");
                updateData(default_file);
              });
              print('file_id: ' + file_id.toString());
              print(analysisData.toString());
              // file_id 하나 증가
              file_id += 1;
            } else {
              // 아무런 파일도 선택되지 않음.
            }
            print(analysisData.toString());
            Timer(Duration(seconds: 30), () {
              Navigator.of(context).pushReplacement(
                // main page의 뒤로가기 버튼을 pushReplacement 를 써주면 사라짐
                MaterialPageRoute(builder: (context) => Result()),
              );
            });
          },
          child: Text("\n버튼을 클릭하여 녹음 파일을 업로드해 주세요.\n",
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

// ============================ 전송 함수 ============================ //
// ------------------- post 함수(데이터 업로드) -------------------
  postFile(PlatformFile file) async {
    // 데이터를 업로드할 url
    String url =
        'http://10.0.2.2:8000/nugunyaneon_app/analysis=' + file_id.toString();

    print("데이터 업로드 실행");

    // 업로드 할 데이터
    FormData formData = FormData.fromMap({
      "fileId": file_id,
      "fileName": file.name,
      "filePath": file.path,
      "file": await MultipartFile.fromFile(file.path.toString(),
          filename: file.name.toString()),
      "error": 'None',
      "probability": 1,
      "phishingType": 'None',
      "isAllowed": true,
    });

    // 로그
    String file_path = file.path.toString();
    print(file_path);

    // dio 옵션
    BaseOptions options = BaseOptions(
      contentType: 'multipart/form-data',
    );

    Dio dio = new Dio(options);

    // 업로드
    try {
      var response = await dio.post(
        url,
        data: formData,
      );

      print("응답: " + response.data.toString());
      print("업로드 완료");
    } catch (eee) {
      print(eee);
    }
  }

// ------------------- put 함수(데이터 업데이트) -------------------
  updateData(PlatformFile file) async {
    Dio dio = Dio();

    // 로그
    print("업데이트 할 데이터: " + file.toString());
    print("분석 실행");

    // 업데이트 할 데이터
    FormData formData = FormData.fromMap({
      "fileId": file_id - 1,
      "fileName": file.name,
      "filePath": file.path,
      "error": 'None',
      "probability": 1,
      "phishingType": 'None',
      "isAllowed": true,
    });

    // 업데이트 후 결과 반환
    final response = await dio.put(
        'http://10.0.2.2:8000/nugunyaneon_app/analysis=' +
            (file_id - 1).toString(),
        data: formData);

    // 오류가 없을 경우
    if (response.statusCode == 200) {
      // 로그
      print('업데이트 결과: ' + response.toString());

      // 데이터 가져온다.
      setState(() {
        analysisData = response.data.toString(); // 분석 결과
        usedData(); // 데이터 사용을 위한 전처리
        print(analysisData);
        print("분석 완료");
      });
    }
    // 오류 났을 경우
    else {
      throw Exception('failed to load data');
    }
  }

// ============================ 그 외 함수 ============================ //
  // 데이터를 사용하기 위한 전처리 함수
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

  timeSleep() {
    Timer(Duration(seconds: 3), () {
      print("3초 지연");
    });
  }

// ============================ 테스트 함수 ============================ //

// ------------------- load 함수 -------------------
  // loadData() async {
  //   Dio dio = Dio();
  //   final response = await dio.get(
  //       //'http://127.0.0.1:8000/nugunyaneonApp/test=' + (file_id - 1).toString());
  //       'http://192.168.0.235/nugunyaneonApp/test=' + (file_id - 1).toString());
  //   if (response.statusCode == 200) {
  //     print("loadData: " + response.toString());
  //     setState(() {
  //       // json으로 변환해주는 코드가 필요한 듯 하다...
  //       _getData2 = response;
  //     });
  //   } else {
  //     throw Exception('failed to load data');
  //   }
  // }
  // test() async {
  //   print("test 분석");
  //   Dio dio = Dio();
  //   final response =
  //       await dio.get('http://192.168.35.88/nugunyaneonApp/analysisAPI/');
  //   if (response.statusCode == 200) {
  //     print("test: " + response.toString());
  //     setState(() {
  //       // json으로 변환해주는 코드가 필요한 듯 하다...
  //       testData = response;
  //       print("test 분석 완료");
  //     });
  //   } else {
  //     throw Exception('failed to load data');
  //   }
  // }
}
