import 'package:flutter/material.dart';
import 'package:nugunyaneon01/screen/loading.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _valueList = [
    '10',
    '20',
    '30',
    '40',
    '50',
    '60',
    '70',
    '80',
    '90',
    '100'
  ];
  var _selectedValue = '40';

  final _valueList2 = [
    '강원',
    '경기',
    '서울',
    '인천',
    '충북',
    '충남',
    '세종',
    '대전',
    '경북',
    '경남',
    '대구',
    '부산',
    '울산',
    '전북',
    '전남',
    '광주',
    '제주'
  ];
  var _selectedValue2 = '서울';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //Color.fromARGB(500, 76, 167, 169),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            // 키보드가 올라오면서 오버플로그 에러가 뜰때
            child: Column(children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 20, bottom: 0)),
              Center(
                child: Image(
                  image: AssetImage('image/people.jpg'),
                  width: 210.0, // 이미지 크기 조절
                  height: 190.0,
                ),
              ),
              Form(
                  child: Theme(
                data: ThemeData(
                    primaryColor: Colors.white,
                    inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0))), //텍스트 필드를 클릭했을때 밑줄이 굵은 색상으로 강조

                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      const Text(
                          "★ 안내 ★\n\n연령대와 거주 지역 정보로 개인 맞춤형\n보이스피싱 탐지 결과를 보여줍니다.\n\n"
                          "※ 현재 기능은 베타 버전으로\n빠른 시일 내에 해당 서비스를 시작할 예정입니다. ※",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),

                      Text("\n\n\n귀하의 '연령대'를 선택해주세요.\n",
                          style: TextStyle(fontSize: 17, color: Colors.black),
                          textAlign: TextAlign.center),

                      DropdownButton(
                          value: _selectedValue,
                          items: _valueList
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value.toString()),
                                  )) // map
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value.toString();
                              //print(_selectedValue);
                            });
                          }),

                      Text(
                        "\n\n귀하의 '거주 지역'을 선택해주세요.\n",
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),

                      DropdownButton(
                          value: _selectedValue2,
                          items: _valueList2
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value.toString()),
                                  )) // map
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedValue2 = value.toString();
                              //print(_selectedValue);
                            });
                          }),

                      // 버튼
                      SizedBox(
                        height: 30.0,
                      ), // 버튼이 너무 텍스트에 붙어 있어서 띄움
                      ButtonTheme(
                        minWidth: 80.0,
                        height: 40.0,
                        child: RaisedButton(
                          color: Color.fromARGB(510, 76, 167, 169),
                          child: Icon(
                            Icons.done,
                            color: Color.fromARGB(250, 255, 255, 101),
                            size: 35.0,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              // main page의 뒤로가기 버튼을 pushReplacement 를 써주면 사라짐
                              MaterialPageRoute(
                                  builder: (context) => Loading()),
                            );
                          },
                        ),
                      ),
                    ],

                    // 괄호를 건들면 안되는 부분
                  ),
                ),
              ))
            ]),
          );
        }, //builder
      ),
    );
  } //build
} //class