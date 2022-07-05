import 'package:flutter/material.dart';
import 'package:nugunyaneon01/screen/login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';

// 첫번째 루트
class RequestPermission extends StatelessWidget {
  static const routeName = '/requestpermission';

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Text(
                  '\n★ 접근 권한 안내 ★\n\n\n\n\n연락처\n\n- 상대방 이름을 표시하는데 사용합니다.\n\n\n전화\n\n- 전화를 거는데 사용합니다.\n\n\n저장공간\n\n- 통화 녹음 파일을 불러오는데 사용합니다.\n\n\n\n\n확인\n',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromARGB(500, 76, 167, 169),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                onPressed: () async {
                  if (await () async {
                    Map<Permission, PermissionStatus> statuses = await [
                      Permission.contacts,
                      Permission.phone,
                      Permission.storage,
                    ].request();

                    bool permitted = true;

                    statuses.forEach((Permission, PermissionStatus) {
                      if (!PermissionStatus.isGranted) permitted = false;
                    });
                    return permitted;
                  }()) {
                    Navigator.of(context).pushReplacement(
                      // main page의 뒤로가기 버튼을 pushReplacement 를 써주면 사라짐
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );

                    SnackBar snackBar = SnackBar(
                      content: Text('모든 권한을 허용하셨습니다.'),
                    );
                    _key.currentState?.showSnackBar(snackBar);
                  } else {
                    SnackBar snackBar = SnackBar(
                      content: Text('모든 권한을 허용해 주세요.'),
                      action: SnackBarAction(
                        label: "앱 설정화면으로 이동합니다.",
                        onPressed: () {
                          _key.currentState?.hideCurrentSnackBar();
                          AppSettings.openAppSettings();
                        },
                      ),
                    );
                    _key.currentState?.showSnackBar(snackBar);
                  }
                },
              ),
            ],
          ),
        ));
  }
}
