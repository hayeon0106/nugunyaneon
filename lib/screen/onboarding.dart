// 맨 처음 도움말

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nugunyaneon01/permissions/request_permission.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
            title: "'누구냐 넌'",
            body:
                '\n\n통화 녹음 파일을 이용하여\n\n보이스피싱 범죄 유형 & 확률을\n\n신속·정확하게 알려드리는\n\n새로운 애플리케이션입니다.\n\n\n예) 기관사칭형 - 78%',
            image: Image.asset('image/page4.jpg'),
            decoration: getPageDecoration()),
        PageViewModel(
          title: '통화 녹음 파일 이용 동의\n(선택)',
          body:
              "사용자는 서비스 품질 향상과\n보이스피싱 범죄 예방에 기여하고자\n\n통화 녹음 음성 정보 이용 동의를\n선택하실 수 있습니다.\n\n\n※ 동의는 앱 설정에서 취소할 수 있으며,\n동의하지 않아도 앱 이용 가능합니다.",
          image: Image.asset('image/page2.png'),
          decoration: getPageDecoration(),
          footer: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed))
                    return Colors.redAccent;
                  return null;
                },
              ),
            ),
            // ElevatedButton.styleFrom(
            //   elevation: 1, // 버튼 입체감
            //   //   shape: RoundedRectangleBorder(),
            //   primary: Color.fromARGB(500, 76, 167, 169),
            // ), // styleFrom
            child: const Text(
              "동의 (선택)",
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(250, 255, 255, 101),
              ),
            ),
          ),
        ),
        PageViewModel(
            title: "단말기의 통화 설정에서\n'통화 자동 녹음'\n기능을 켜주세요.\n(권고)",
            body:
                "\n사용 중인 안드로이드 단말기의\n'통화 자동 녹음' 기능을 켜시면\n\n사용자가 보다 편리하게\n애플리케이션을 이용하실 수 있습니다.",
            image: Image.asset('image/page1.png'),
            decoration: getPageDecoration()),
      ],
      done: const Text('Done'),
      onDone: () {
        Navigator.of(context).pushReplacement(
          // main page의 뒤로가기 버튼을 pushReplacement 를 써주면 사라짐
          MaterialPageRoute(builder: (context) => RequestPermission()),
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
      curve: Curves.bounceOut, // 화면 넘어갈때 바운스하는 효과
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
