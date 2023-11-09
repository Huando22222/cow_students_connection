import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/config/app_routes.dart';
import 'package:cow_students_connection/pages/register.dart';
import 'package:cow_students_connection/providers/account_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  //custom //////////////////////////////////
  final FirebaseAuth auth = FirebaseAuth.instance;
  var smsCode = "";
  get phone => context.read<AppRepo>().phone;
  get password => context.read<AppRepo>().password;
  ///////////////////////////////////////////
  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    /// Optionally you can use form to validate the Pinput
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Pinput Example'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(30, 60, 87, 1),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Directionality(
              // Specify direction if desired
              textDirection: TextDirection.ltr,
              child: Pinput(
                controller: pinController, length: 6,
                focusNode: focusNode,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                listenForMultipleSmsOnAndroid: true,
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 8),
                // validator: (value) {
                //   // return value == '2222' ? null : 'Pin is incorrect';
                //   print("code from validator: ${value}");
                //   return value == smsCode ? null : 'Pin is incorrect';
                // },
                ////////////////////////////////////////////////////////////
                // onClipboardFound: (value) {
                //   debugPrint('onClipboardFound: $value');
                //   pinController.setText(value);
                // },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
                },
                onChanged: (value) {
                  debugPrint('onChanged: $value');
                  print("value onchange : $value");
                  smsCode = value;
                  print("value code : $smsCode");
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: focusedBorderColor,
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  print("into tryCatch: $smsCode");
                  // Create a PhoneAuthCredential with the code
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: Register.verify,
                    smsCode: smsCode,
                  );

                  // Sign the user in (or link) with the credential
                  await auth.signInWithCredential(credential);
                  focusNode.unfocus();
                  formKey.currentState!.validate();

                  // Navigator.of(context).pushNamed(AppRoutes.login);
                  // print("${phone} ${password}");
                  // Gửi thông tin tài khoản và mật khẩu đến máy chủ localhost:3000

                  final response = await http.post(
                    Uri.parse(
                        '${AppConfig.baseUrl}user/register'), // Thay đổi URL và endpoint của bạn
                    // 'http://172.16.16.57:3000/user/register'), // Thay đổi URL và endpoint của bạn
                    body: {
                      'phone': phone, // Thay thế bằng tên người dùng
                      'password': password, // Thay thế bằng mật khẩu
                      'displayName': "",
                      "email": "",
                      "id": "",
                      "photoUrl": "",
                    },
                  );

                  if (response.statusCode == 200) {
                    // Xử lý phản hồi từ máy chủ (nếu cần)
                    context.read<AppRepo>().password = ""; // security hehhee

                    Navigator.of(context).pushNamed(AppRoutes.login);
                    print("register success ${phone} ${password}");
                  } else {
                    print(
                        'Lỗi khi gửi thông tin đến máy chủ: ${response.statusCode}');
                  }
                } catch (e) {
                  print("value code in catch ERROR: $smsCode");
                  print(
                    "wrong at OTP\n-----------------------------------------------------------",
                  );
                }
              },
              child: const Text('Validate'),
            ),
          ],
        ),
      ),
    );
  }
}
