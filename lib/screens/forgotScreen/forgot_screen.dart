import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';

import '../../core/messages.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  var email = '';
  var loading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: customAppBar(
          title: "",
        ),
        backgroundColor: ColorConstant.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.15,
                ),
                SizedBox(
                  height: 40,
                  child: Image.asset(ImageConstant.yellowKey),
                ),
                Text(
                  "Forget Password",
                  style: TextStyle(
                      color: ColorConstant.midNight,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontConstant.jakartaBold,
                      fontSize: 32),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "For recover your password, please enter your username or email",
                  style: TextStyle(
                      color: ColorConstant.midNight,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontConstant.jakartaMedium,
                      fontSize: 14),
                ),
                SizedBox(height: 20),
                customTextField(
                    onChange: (e){
                      setState(() {
                        email = e;
                      });
                    },
                    hintText: "Username or Email",
                    prefixIcon: ImageConstant.account),
                SizedBox(height: 20),
                Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(color: ColorConstant.lightGreen),
                  child: TextButton(
                      onPressed:loading ? (){}: () {
                        Map<String, String> form = {};
                         form['value'] = email.toString();
                        var emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if(!emailValid.hasMatch(email)){
                          SnackBarMessage.errorSnackbar(context, "Email is not Valid");
                          return;
                        }
                        form['type'] = 'email';
                        setState(() {
                          loading = true;
                        });
                        var http = HttpRequest();
                        http.forgetPassword(form).then((value) {
                          setState(() {
                            loading = false;
                          });
                          if (value.success == true) {
                            navigateToPage(OTPScreen(email: email, type: 1,));
                          } else {
                            SnackBarMessage.errorSnackbar(
                                context, value.message);
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          loading? CircularProgressIndicator(
                            color: Colors.white,
                          ): Text("Send Password Code",
                              style: TextStyle(
                                  color: ColorConstant.midNight,
                                  fontSize: 17,
                                  fontFamily: FontConstant.jakartaSemiBold,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Icon(
                              Icons.arrow_forward,
                              color: ColorConstant.midNight,
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
