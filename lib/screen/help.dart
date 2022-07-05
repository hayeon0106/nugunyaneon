// 도움말

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nugunyaneon01/screen/loading.dart';
import 'package:nugunyaneon01/screen/wordcloud.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
            title: "STEP 1.\n보이스피싱으로 의심되는\n전화 통화를 녹음해 주세요.\n",
            body:
                "안드로이드 단말기의 경우,\n'통화 자동 녹음'\n기능을 켜시면 편리합니다.\n\n※ '통화 자동 녹음' 설정 방법:\n전화▶우측 상단 점▶설정\n▶통화 녹음▶통화 자동 녹음",
            image: Image.asset('image/recored.png'),
            decoration: getPageDecoration()),
        PageViewModel(
            title: "STEP 2.\n녹음 파일을\n업로드해 주세요.",
            body:
                "보이스피싱 탐지 Home 화면에 있는\n'녹음 파일을 업로드해 주세요.'\n\n버튼을 클릭하면,\n자동으로 녹음 파일이 있는\n저장소로 이동합니다.",
            image: Image.asset('image/upload.png'),
            decoration: getPageDecoration()),
        PageViewModel(
            title: "STEP 3.\n보이스피싱 유형별 빈출 단어를 확인하세요.",
            body: "\n보이스피싱 유형별 빈출 단어를 확인하시고,\n범죄 예방하세요.",
            image: Image.asset('image/page1.png'),
            decoration: getPageDecoration()),
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
      skip: const Text('Skip'),
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

  PageDecoration getPageDecoration() {
    return const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle:
            TextStyle(fontSize: 17, color: Color.fromARGB(510, 76, 167, 169)),
        imagePadding: EdgeInsets.only(top: 40),
        pageColor: Colors.white);
  }
}
