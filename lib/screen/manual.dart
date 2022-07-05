// 메뉴얼

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nugunyaneon01/screen/loading.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final String _phoneNumber = '1332';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MaterialButton(
            onPressed: () async {
              final _call = 'tel:$_phoneNumber';
              final _text = 'tel:$_phoneNumber';
              if (await canLaunch(_call)) {
                await launch(_call);
              }
            },
            color: Colors.blue,
            child: Text(
              'Text Me',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class Manual extends StatelessWidget {
  const Manual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
            image: Image.asset(
              'image/blueright.jpg',
              width: 200,
              height: 200,
            ),
            title:
                "★ 피해를 입기 전 대응 방법 ★\n\n보이스피싱 '의심', '경고'\n혹은 '위험'이라고 앱에서 알려준 경우",
            body:
                "\n\n모르는 사람이 금융거래정보를 요구하거나\n현금지급기로 유인한다면, 보이스피싱입니다.\n\n금전적인 피해는 입지 않았지만\n금융거래정보가 유출되었다면,\n이를 즉시 해지하거나 폐기하세요.\n\n그리고 해당 번호를 차단하세요.",
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              bodyTextStyle: TextStyle(
                  fontSize: 17.0, color: Color.fromARGB(510, 76, 167, 169)),
              //  pageColor: Color.fromARGB(510, 76, 167, 169),
              //  imagePadding: EdgeInsets.only(top: 1.0),
            )

            //  decoration: getPageDecoration()
            ),
        PageViewModel(
            image: Image.asset('image/ring.png', width: 200, height: 200),
            title: "★ 피해를 입은 후 대응 방법 ★",
            body:
                "\n\n경찰청(112), 금융감독원(1332) 또는\n\n금융회사 콜센터를 통해\n\n신속히 사기계좌에 대해\n\n지급정지를 요청하세요.",
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              bodyTextStyle: TextStyle(
                  fontSize: 17.0, color: Color.fromARGB(510, 76, 167, 169)),
            )),
      ],
      // pages
      // widgetbuild
      //decoration: getPageDecoration()

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
      imagePadding: EdgeInsets.only(top: 40),
      pageColor: Color.fromARGB(510, 76, 167, 169),
      bodyTextStyle: TextStyle(fontSize: 17, color: Colors.white),
    );
  } // pageDecoration getPageDecoration

} //statefulwidget
