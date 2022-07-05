// 시각화 결과 출력 화면

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nugunyaneon01/screen/loading.dart';

class WordCloud extends StatelessWidget {
  const WordCloud({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
            image: Image.asset('image/detection.png', width: 200, height: 200),
            title: "보이스피싱 유형별 빈출 단어를\n\n시각화한 워드클라우드입니다.",
            body:
                "\n\n보이스피싱 범죄 확산을 막고\n\n개인의 범죄 예방을 돕는 목적으로\n\n이용자들에게 주기적으로\n\n업데이트한 자료를 제공합니다.",
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              bodyTextStyle: TextStyle(fontSize: 17.0, color: Colors.white),
              pageColor: Color.fromARGB(510, 76, 167, 169),
              imagePadding: EdgeInsets.only(top: 0.5),
            )),
        PageViewModel(
            image: Image.asset('image/sagi.png', width: 250, height: 250),
            title: "유형 1. 금융 대출 사기 유형",
            body:
                "1위 - '고객'\n\n2위 - '지금'\n\n3위 - '저희'\n\n4위 - '이제'\n\n5위 - '대출'\n\n⦙\n\n\n금융 대출 사기 유형은\n\n금융 업무처럼 보여야 하는 특성상\n\n'고객'과 '대출'이란 단어가 자주 등장합니다.",
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              bodyTextStyle: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              imagePadding: EdgeInsets.only(top: 1.0),
            )),
        PageViewModel(
            title: "유형 2. 수사기관 사칭 유형",
            image: Image.asset('image/saching.png', width: 250, height: 250),
            body:
                "1위 - '본인'\n\n2위 - '지금'\n\n3위 - '이제'\n\n4위 - '저희'\n\n5위 - '통장'\n\n⦙\n\n\n수사기관 사칭 유형은\n\n신분 확인과 대포 통장 도용을 이유로\n\n'본인'과 '통장'이란 단어가 자주 등장합니다.",
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              bodyTextStyle: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              imagePadding: EdgeInsets.only(top: 1.0),
            )),
        PageViewModel(
            title: "★ 주의 ★",
            image: Image.asset('image/levelup.png'),
            body:
                "\n\n500개의 데이터로 분석한\n\n보이스피싱 빈출 단어 결과입니다.\n\n모르는 분이 전화 통화로\n\n이러한 단어들을 사용한다면\n\n우선 의심하세요!\n\n\n\n",
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              bodyTextStyle: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              pageColor: Color.fromARGB(510, 76, 167, 169),
            )),
      ],
      done: const Text('Back'),
      onDone: () {
        Navigator.of(context).pushReplacement(
          // main page의 뒤로가기 버튼을 pushReplacement 를 써주면 사라짐
          MaterialPageRoute(builder: (context) => Loading()),
        );
      },
      next: const Icon(Icons.arrow_forward),
      showSkipButton: true,
      skip: const Text('skip'),
      dotsDecorator: DotsDecorator(
          color: Colors.cyan,
          size: const Size(10, 10),
          activeSize: Size(22, 10), // 버튼이 활성화되었을때 커지는 것
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          activeColor: Colors.red // 활성화되는 점의 색깔 지정
          ),
      curve: Curves.bounceOut,
      // 화면 넘어갈때 바운스하는 효과
    );
  }
}
