import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/core/messages.dart';
import 'package:infinite_escrow/routes/routes.dart';

class ChangePassword extends StatefulWidget {
  bool isForget;
  String token;
  String email;

  ChangePassword(
      {super.key,
      required this.isForget,
      required this.email,
      required this.token});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  Map<String, String> form = {};
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        persistentFooterButtons: [
          Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(color: Color(0xffE7E9EA)),
            child: TextButton(
                onPressed: loading
                    ? () {}
                    : () {
                        if (widget.isForget) {
                          if (form['password'] == null ||
                              form['password'] == '') {
                            SnackBarMessage.errorSnackbar(
                                context, "Password Required");
                          } else if (form['repeatPassword'] !=
                              form['password']) {
                            SnackBarMessage.errorSnackbar(
                                context, "Password do not match");
                          } else {
                            setState(() {
                              loading = true;
                            });
                            var http = HttpRequest();
                            var data = {
                              'email': widget.email,
                              ''
                                  'password': form['password'] ?? "",
                              'token': widget.token
                            };
                            print(data.toString());
                            http.resetPassword(data).then((value) {
                              setState(() {
                                loading = false;
                              });
                              if (value.success == true) {
                                navigateToPage(LoginScreen());
                              } else {
                                SnackBarMessage.errorSnackbar(
                                    context, value.message);
                              }
                            });
                          }
                        } else {
                          if (form['password'] == null ||
                              form['password'] == '') {
                            SnackBarMessage.errorSnackbar(
                                context, "Password Required");
                          } else if (form['repeatPassword'] !=
                              form['password']) {
                            SnackBarMessage.errorSnackbar(
                                context, "Password do not match");
                          } else {
                            setState(() {
                              loading = true;
                            });
                            var http = HttpRequest();
                            var data = {
                              'password': form['password'] ?? "",
                              'current_password':
                                  form['current_password'] ?? "",
                            };
                            print(data.toString());
                            http.updatePassword(data).then((value) {
                              setState(() {
                                loading = false;
                              });
                              if (value.success == true) {
                                SnackBarMessage.successSnackbar(
                                    context, "Password updated");
                              } else {
                                SnackBarMessage.errorSnackbar(
                                    context, value.message);
                              }
                            });
                          }
                        }
                        // navigateToOffAllNextPage(BottomNavigationScreen());
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            !widget.isForget
                                ? "Change password"
                                : "Save Changes",
                            style: TextStyle(
                                color: ColorConstant.midNight,
                                fontSize: 17,
                                fontFamily: FontConstant.jakartaSemiBold,
                                fontWeight: FontWeight.w700)),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Icon(
                        Icons.arrow_forward,
                        color: ColorConstant.midNight,
                      ),
                    )
                  ],
                )),
          ),
        ],
        appBar: customAppBar(
            title: "Change Password",
            iconColor: Theme.of(context).colorScheme.tertiary,
            titleColor: Theme.of(context).colorScheme.tertiary,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !widget.isForget
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Password",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        customTextField(
                          hintTextColor: Theme.of(context).colorScheme.secondary,
                            prefixIconColor: Theme.of(context).colorScheme.primary,
                            onChange: (e) {
                              form['current_password'] = e;
                            },
                            hintText: "Current Password",
                            prefixIcon: ImageConstant.key)
                      ],
                    )
                  : Container(),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New Password",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  customTextField(
                      hintTextColor: Theme.of(context).colorScheme.secondary,
                      prefixIconColor: Theme.of(context).colorScheme.primary,
                      onChange: (e) {
                        form['password'] = e;
                      },
                      hintText: "New Password",
                      prefixIcon: ImageConstant.key)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Repeat Password",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  customTextField(
                      hintTextColor: Theme.of(context).colorScheme.secondary,
                      prefixIconColor: Theme.of(context).colorScheme.primary,
                      onChange: (e) {
                        form['repeatPassword'] = e;
                      },
                      hintText: "Repeat Password",
                      prefixIcon: ImageConstant.key)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "It's better to have:",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "-",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    " Upper & lower case letters",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "-",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    " Include symbol  and number(123\$&)",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "-",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    " More than 8 characters",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
