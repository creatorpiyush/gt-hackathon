import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:gt_hackathon/custom_route.dart';
import 'package:gt_hackathon/features/home_page/main_page.dart';
import 'package:gt_hackathon/mock_data/mock_users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/auth';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String?> _loginUser(LoginData data) async {
    final prefs = await SharedPreferences.getInstance();

    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(data.name)) {
        return 'User not exists';
      }
      if (mockUsers[data.name] != data.password) {
        return 'Password does not match';
      }
      prefs
          .setBool("isLogin", true)
          .then((_) => prefs.setString("username", data.name));
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _signupConfirm(String error, LoginData data) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      // title: "GT Hackathon",
      logo: const AssetImage('assets/images/login_top.png'),
      validateUserImmediately: true,
      headerWidget: const Padding(
        padding: EdgeInsets.only(bottom: 36.0),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                  color: Color.fromRGBO(0, 77, 115, 1),
                  fontSize: 36,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.info_rounded,
                      color: Color.fromRGBO(204, 204, 204, 1),
                      weight: 16.0,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "Please use your existing train ticketing account credentials to log in.",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      theme: LoginTheme(
        primaryColor: Colors.white,
        logoWidth: MediaQuery.of(context).size.width,
        primaryColorAsInputLabel: false,
        cardInitialHeight: MediaQuery.of(context).size.height / 2,
        footerBottomPadding: MediaQuery.of(context).size.height / 6,
        footerTextStyle: const TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.6),
          fontSize: 16,
          fontFamily: 'Roboto-Regular',
        ),
        cardTheme: CardTheme(
          clipBehavior: Clip.antiAlias,
          color: const Color.fromRGBO(230, 253, 255, 1),
          surfaceTintColor: const Color.fromRGBO(230, 253, 255, 1),
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(46),
          ),
        ),
        bodyStyle: const TextStyle(
          color: Color.fromRGBO(157, 18, 18, 0.6),
          fontSize: 16,
          fontFamily: 'Roboto-Regular',
        ),
        buttonStyle: const TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.6),
          fontSize: 16,
          fontFamily: 'Roboto-Regular',
        ),
        textFieldStyle: const TextStyle(
          color: Color.fromRGBO(218, 19, 19, 0.6),
          fontSize: 16,
          fontFamily: 'Roboto-Regular',
        ),
        inputTheme: InputDecorationTheme(
          labelStyle: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.6),
            fontSize: 16,
            fontFamily: 'Roboto-Regular',
          ),
          counterStyle: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.6),
            fontSize: 16,
            fontFamily: 'Roboto-Regular',
          ),
          filled: true,
          fillColor: const Color.fromRGBO(255, 255, 255, 1),
          iconColor: const Color.fromRGBO(0, 0, 0, 0.6),
          contentPadding: const EdgeInsets.all(16),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(46),
            borderSide: const BorderSide(
              color: Color.fromRGBO(0, 77, 115, 1),
              width: 2,
            ),
          ),
        ),
        buttonTheme: LoginButtonTheme(
          backgroundColor: const Color.fromARGB(255, 124, 116, 116),
          elevation: 5,
          highlightElevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        errorColor: Theme.of(context).colorScheme.error,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto-Regular',
        ),
      ),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      navigateBackAfterRecovery: true,

      footer:
          "If you don’t have an existing train ticketing account, register here",

      onLogin: (loginData) async {
        debugPrint('Login info');
        debugPrint('Name: ${loginData.name}');
        debugPrint('Password: ${loginData.password}');
        return _loginUser(loginData);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(
          FadePageRoute(
            builder: (context) => const MainPage(),
          ),
        );
      },
      onRecoverPassword: (name) {
        debugPrint('Recover password info');
        debugPrint('Name: $name');
        return _recoverPassword(name);
      },
      // onSignup: (signupData) {
      //   debugPrint('Signup info');
      //   debugPrint('Name: ${signupData.name}');
      //   debugPrint('Password: ${signupData.password}');

      //   signupData.additionalSignupData?.forEach((key, value) {
      //     debugPrint('$key: $value');
      //   });
      //   if (signupData.termsOfService.isNotEmpty) {
      //     debugPrint('Terms of service: ');
      //     for (final element in signupData.termsOfService) {
      //       debugPrint(
      //         ' - ${element.term.id}: ${element.accepted == true ? 'accepted' : 'rejected'}',
      //       );
      //     }
      //   }
      //   return _signupUser(signupData);
      // },
      // onConfirmSignup: _signupConfirm,
      // onConfirmRecover: _signupConfirm,
      userValidator: (value) {
        if (!value!.contains('@') || !value.endsWith('.com')) {
          return "Email must contain '@' and end with '.com'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      additionalSignupFields: [
        const UserFormField(
          keyName: 'Username',
          icon: Icon(Icons.person_2),
        ),
        const UserFormField(keyName: 'Name'),
        const UserFormField(keyName: 'Surname'),
        UserFormField(
          keyName: 'phone_number',
          displayName: 'Phone Number',
          userType: LoginUserType.phone,
          fieldValidator: (value) {
            final phoneRegExp = RegExp(
              '^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}\$',
            );
            if (value != null &&
                value.length < 7 &&
                !phoneRegExp.hasMatch(value)) {
              return "This isn't a valid phone number";
            }
            return null;
          },
        ),
      ],
    );
  }
}
