import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sikdang/common/component/custom_text_form_field.dart';
import 'package:sikdang/common/const/colors.dart';
import 'package:sikdang/common/layout/default_layout.dart';

import '../../common/view/root_tab.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    final emulatorIp = '192.168.0.106:3000';
    final simulatorIp = '192.168.0.106:3000';

    final ip = Platform.isIOS ? simulatorIp : emulatorIp;

    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                const SizedBox(height: 16),
                _SubTitle(),
                Image.asset(
                  'assets/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                TextFormField(
                  onChanged: (String value) {
                    username = value;
                  },
                  decoration: InputDecoration(
                    hintText: '이메일을 입력해주세요.', // Add hintText here
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  onChanged: (String value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '비밀번호를 입력해주세요.', // Add hintText here
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final rawString = '$username:$password';
                    print(rawString);
                    Codec<String, String> stringToBase64 = utf8.fuse(base64);
                    String token = stringToBase64.encode(rawString);
                    final resp = await dio.post('http://$ip/auth/login',
                        options: Options(
                            headers: {'authorization': 'Basic $token'}));
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RootTab(),
                      ),
                    );
                    print(resp.data);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: PRIMARY_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('로그인'),
                ),
                TextButton(
                  onPressed: () async {
                    final refreshToken =
                        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoicmVmcmVzaCIsImlhdCI6MTY5MDQ3MTIxOSwiZXhwIjoxNjkwNTU3NjE5fQ.7JqoFpPBfvM15z2xmstYQ76anMx-qQ2veVJV612OHAo";

                    final resp = await dio.post('http://$ip/auth/token',
                        options: Options(headers: {
                          'authorization': 'Bearer $refreshToken'
                        }));
                    print(resp.data);
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: Text('회원가입'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('환영합니다!',
        style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500));
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해주세요!\n 오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(fontSize: 16, color: BODY_TEXT_COLOR),
    );
  }
}
