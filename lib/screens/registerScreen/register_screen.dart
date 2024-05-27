import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';

import '../../core/messages.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formData = {};
  bool loading = false;
  var hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: customAppBar(
            title: "",
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          iconColor: Theme.of(context).colorScheme.tertiary
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40, child: Image.asset(ImageConstant.hand)),
                Text(
                  "Create Account",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontConstant.jakartaBold,
                      fontSize: 32),
                ),
                SizedBox(height: 20),
                customTextField(
                    onChange: (value) {
                      formData['firstname'] = value;
                    },
                    hintText: "First Name",
                    prefixIcon: ImageConstant.person,
                    hintTextColor: Theme.of(context).colorScheme.secondary,
                    prefixIconColor: Theme.of(context).colorScheme.secondary
                ),
                SizedBox(height: 10),
                customTextField(
                    onChange: (value) {
                      formData['lastname'] = value;
                    },
                    hintTextColor: Theme.of(context).colorScheme.secondary,
                    prefixIconColor: Theme.of(context).colorScheme.secondary,
                    hintText: "Last Name",
                    prefixIcon: ImageConstant.person),
                SizedBox(height: 10),
                customTextField(
                    onSuffixTap: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    onChange: (value) {
                      formData['password'] = value;
                    },
                    hintText: "password",
                    obsecure: hidePassword,
                    suffixIcon: hidePassword
                        ? ImageConstant.showPassword
                        : ImageConstant.hidePassword,
                    prefixIcon: ImageConstant.key,
                    hintTextColor: Theme.of(context).colorScheme.secondary,
                    prefixIconColor:Theme.of(context).colorScheme.secondary
                ),
                SizedBox(height: 10),
                customTextField(
                    onChange: (value) {
                      formData['username'] = value;
                    },
                    hintText: "User Name",
                    prefixIcon: ImageConstant.account,
                    hintTextColor: Theme.of(context).colorScheme.secondary,
                    prefixIconColor: Theme.of(context).colorScheme.secondary
                ),
                SizedBox(height: 10),
                customTextField(
                    onChange: (value) {
                      formData['email'] = value;
                    },
                    hintText: "Email",
                    prefixIcon: ImageConstant.email,
                    hintTextColor: Theme.of(context).colorScheme.secondary,
                    prefixIconColor: Theme.of(context).colorScheme.secondary
                ),
                SizedBox(height: 10),
                IntlPhoneField(
                  dropdownIcon: Icon(Icons.keyboard_arrow_down),
                  disableLengthCheck: false,
                  searchText: "Search country code or name",
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 14,
                        fontFamily: FontConstant.jakartaMedium,
                        fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ),
                  initialCountryCode: 'NG',
                  onChanged: (phone) {
                    print(phone.number);
                    formData['mobile'] = phone.number;
                    formData['mobile_code'] = phone.countryCode;
                  },
                ),
                SizedBox(height: 30),
                Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(color: ColorConstant.lightGreen),
                  child: TextButton(
                      onPressed: loading
                          ? () {}
                          : () {
                              if (formData['firstname'] == null ||
                                  formData['firstname'] == '') {
                                SnackBarMessage.errorSnackbar(
                                    context, 'First name is Required');
                              } else if (formData['lastname'] == null ||
                                  formData['lastname'] == '') {
                                SnackBarMessage.errorSnackbar(
                                    context, 'Last name is Required');
                              } else if (formData['email'] == null ||
                                  formData['email'] == '') {
                                SnackBarMessage.errorSnackbar(
                                    context, 'Email is Required');
                              } else if (formData['mobile'] == null ||
                                  formData['mobile'] == '') {
                                SnackBarMessage.errorSnackbar(
                                    context, 'Mobile Number is Required');
                              } else if (formData['username'] == null ||
                                  formData['username'] == '') {
                                SnackBarMessage.errorSnackbar(
                                    context, 'Username Required');
                              } else if (formData['password'] == null ||
                                  formData['password'] == '') {
                                SnackBarMessage.errorSnackbar(
                                    context, 'Password Required');
                              } else {
                                setState(() {
                                  loading = true;
                                });
                                var formatBody = formData.map<String, String>(
                                    (key, value) =>
                                        MapEntry(key, value.toString()));
                                var http = HttpRequest();
                                http.registor(formatBody).then((value) {
                                  setState(() {
                                    loading = false;
                                  });
                                  if (value.success == true) {
                                    http.sendVerification(
                                        formData['email'].toString(), 'email');
                                    SnackBarMessage.successSnackbar(
                                        context, "Register successfully");
                                    navigateToPage(OTPScreen(
                                      email: formData['email'],
                                      type: 2,
                                      phone: formData['mobile'],
                                    ));
                                  } else {
                                    SnackBarMessage.errorSnackbar(
                                        context, value.message);
                                  }
                                });
                              }
                            },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          loading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text("Register",
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
                SizedBox(
                  height: 40,
                ),
                // customTextRich(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
