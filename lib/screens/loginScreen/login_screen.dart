import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';
import '../../core/messages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formData = {};
  var loading = false;
  var hidePassword = true;

  @override
  void initState() {
    super.initState();
    var http = HttpRequest();
    http.getToken().then((value) {
      if (value != '') {
        navigateToOffAllNextPage(BottomNavigationScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.2),
                SizedBox(height: 40, child: Image.asset(ImageConstant.hand)),
                Text(
                  "Login to\nInfiniteEscrow",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontFamily: FontConstant.jakartaBold,
                      fontSize: 32),
                ),
                SizedBox(height: 20),
                customTextField(
                    hintTextColor: Theme.of(context).brightness == Brightness.light
                            ? ColorConstant.darkestGrey
                            : ColorConstant.offWhite,
                    onChange: (e) {
                      setState(() {
                        formData['username'] = e;
                      });
                    },
                    hintText: "User Name",
                    prefixIcon: ImageConstant.account,
                    prefixIconColor: Theme.of(context).brightness == Brightness.light
                            ? ColorConstant.darkestGrey
                            : ColorConstant.offWhite),
                SizedBox(height: 20),
                customTextField(
                    hintTextColor: Theme.of(context).brightness == Brightness.light
                            ? ColorConstant.darkestGrey
                            : ColorConstant.offWhite,
                    onSuffixTap: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    onChange: (e) {
                      setState(() {
                        formData['password'] = e;
                      });
                    },
                    hintText: "Password",
                    obsecure: hidePassword,
                    suffixIcon: hidePassword
                        ? ImageConstant.showPassword
                        : ImageConstant.hidePassword,
                    prefixIcon: ImageConstant.key,
                    prefixIconColor: Theme.of(context).brightness == Brightness.light
                            ? ColorConstant.darkestGrey
                            : ColorConstant.offWhite),
                SizedBox(height: 30),
                Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(color: ColorConstant.lightGreen),
                  child: TextButton(
                      onPressed: loading
                          ? () {}
                          : () {
                              if (formData['username'] == null ||
                                  formData['username'] == '') {
                                SnackBarMessage.errorSnackbar(
                                    context, 'username is Required');
                              } else if (formData['password'] == null ||
                                  formData['password'] == '') {
                                SnackBarMessage.errorSnackbar(
                                    context, 'Password is Required');
                              } else {
                                var formatBody = formData.map<String, String>(
                                    (key, value) =>
                                        MapEntry(key, value.toString()));
                                var http = HttpRequest();
                                setState(() {
                                  loading = true;
                                });
                                http.login(formatBody).then((value) {
                                  setState(() {
                                    loading = false;
                                  });
                                  if (value.success == true) {
                                    navigateToOffAllNextPage(
                                        BottomNavigationScreen());
                                  } else {
                                    print(value.data['redirect']);
                                    if (value.data['redirect'] == 'sms') {
                                      http.sendVerification(
                                          value.data['user']['email'] ?? '',
                                          'phone');
                                      navigateToPage(OTPScreen(
                                        type: 3,
                                        phone:
                                            value.data['user']['mobile'] ?? '',
                                        email:
                                            value.data['user']['email'] ?? '',
                                      ));
                                    } else if (value.data['redirect'] ==
                                        'email') {
                                      http.sendVerification(
                                          value.data['user']['email'] ?? '',
                                          'email');
                                      navigateToPage(OTPScreen(
                                        type: 2,
                                        phone:
                                            value.data['user']['mobile'] ?? '',
                                        email:
                                            value.data['user']['email'] ?? '',
                                      ));
                                    } else {
                                      SnackBarMessage.errorSnackbar(
                                          context, value.message);
                                    }
                                  }
                                });
                              }
                            },
                      child: loading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text("Login",
                              style: TextStyle(
                                  color: ColorConstant.midNight,
                                  fontSize: 17,
                                  fontFamily: FontConstant.jakartaBold,
                                  fontWeight: FontWeight.w700))),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          navigateToPage(RegisterScreen());
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? ColorConstant.midNight
                                  : ColorConstant.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        )),
                    TextButton(
                        onPressed: () {
                          navigateToPage(ForgotScreen());
                        },
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? ColorConstant.midNight
                                  : ColorConstant.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
