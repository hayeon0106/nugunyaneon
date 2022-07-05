import 'package:flutter/material.dart';
import 'package:nugunyaneon01/screen/login.dart';
import 'package:nugunyaneon01/screen/onboarding.dart';
import 'package:nugunyaneon01/screen/screen_upload.dart';
import 'package:nugunyaneon01/screen/result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'text'),
      home: OnBoardingPage(),
      //home: MyHomePage(),
      //home: Result()
    );
  }
}

//권한 동의 끝나고 나오는 페이지
class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("보이스피싱 감지 어플 '누구냐 넌'"),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // main screen 을 가운데로 이동
              children: [
                const Text(
                  'Main Screen',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      // main page의 뒤로가기 버튼을 pushReplacement 를 써주면 사라짐
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
                  },
                  child: const Text('어플 시작하기'),
                )
              ]),
        ));
  }
}
