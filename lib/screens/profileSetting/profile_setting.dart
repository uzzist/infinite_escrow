import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/core/messages.dart';
import 'package:infinite_escrow/routes/routes.dart';
import 'package:provider/provider.dart';

import '../../core/models/profile.dart';
import '../../core/state/base_State.dart';

class ProfileSetting extends StatefulWidget {
  final bool isIconShow;

  ProfileSetting({super.key, this.isIconShow = true});

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  ProfileModel? profile;
  File? profileImage;

  @override
  initState() {
    super.initState();
    var http = HttpRequest();
    var value = http.getUserSync();
    profile = value;
  }

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
            decoration: BoxDecoration(color: ColorConstant.lightGreen),
            child: TextButton(
                onPressed: () {
                  var formData = {
                    'avatar': '',
                    'firstname': profile?.firstname.toString() ?? '',
                    'lastname': profile?.lastname.toString() ?? '',
                    'address': profile?.address.address.toString() ?? '',
                    'state': profile?.address.state.toString() ?? '',
                    'city': profile?.address.city.toString() ?? ''
                  };
                  if (formData['address'] == '') {
                    SnackBarMessage.errorSnackbar(
                        context, 'address is required');
                  } else if (formData['state'] == '') {
                    SnackBarMessage.errorSnackbar(context, 'state is required');
                  } else if (formData['city'] == '') {
                    SnackBarMessage.errorSnackbar(context, 'city is required');
                  } else {
                    var http = HttpRequest();
                    SnackBarMessage.showLoading(context);
                    if (profileImage != null) {
                      formData['file'] = profileImage!.path.toString();
                    }
                    http.updateProfile(formData).then((value) {
                      Navigator.pop(context);
                      if (value.success == true) {
                        http.saveUser(value.data['data']['user']);
                        var p =
                            ProfileModel.fromJson(value.data['data']['user']);
                        context.read<BaseState>().updateProfile(p);
                        SnackBarMessage.successSnackbar(
                            context, 'profile Updated');
                      } else {
                        SnackBarMessage.errorSnackbar(context, value.message);
                      }
                    }).catchError((e) {
                      Navigator.pop(context);
                      SnackBarMessage.errorSnackbar(
                          context, 'Something went wrong');
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Save Changes",
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
                      child: SvgPicture.asset(ImageConstant.save),
                    ),
                  ],
                )),
          ),
        ],
        appBar: customAppBar(
            title: "Profile Setting",
            titleColor: Theme.of(context).colorScheme.tertiary,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            isIconShow: widget.isIconShow),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile picture",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                Center(
                    child: Container(
                  margin: EdgeInsets.symmetric(vertical: 28),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Colors.grey.shade200,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        var result =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (result != null) {
                          setState(() {
                            profileImage = File(result.path ?? '');
                          });
                        }
                      },
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: profileImage == null
                          ? profile?.image == null
                              ? SvgPicture.asset(ImageConstant.profilePicture,
                                  fit: BoxFit.cover)
                              : Image.network(profile?.image ?? '')
                          : Image.file(profileImage!, fit: BoxFit.cover),
                    ),
                  ),
                )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "First Name",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customTextField(
                        hintTextColor: Theme.of(context).colorScheme.tertiary,
                        readonly: true,
                        value: profile?.firstname,
                        hintText: "",
                        prefixIcon: ImageConstant.person,
                        prefixIconColor:
                            Theme.of(context).colorScheme.secondary),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last Name",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customTextField(
                        onChange: (e) {
                          profile?.lastname = e;
                        },
                        readonly: true,
                        value: profile?.lastname,
                        hintText: "",
                        prefixIcon: ImageConstant.person,
                        hintTextColor: Theme.of(context).colorScheme.tertiary,
                        prefixIconColor:
                            Theme.of(context).colorScheme.secondary),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customTextField(
                        hintTextColor: Theme.of(context).colorScheme.tertiary,
                        prefixIconColor:
                        Theme.of(context).colorScheme.secondary,
                        value: profile?.email,
                        hintText: "",
                        prefixIcon: ImageConstant.email),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mobile Number",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    IntlPhoneField(
                      readOnly: true,
                      validator: (p) {},
                      enabled: false,
                      autovalidateMode: AutovalidateMode.disabled,
                      dropdownIcon: Icon(Icons.keyboard_arrow_down),
                      disableLengthCheck: false,
                      searchText: "Search country code or name",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 14,
                          fontFamily: FontConstant.jakartaMedium,
                          fontWeight: FontWeight.w500),
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
                      initialCountryCode: profile?.countryCode ?? 'NG',
                      initialValue: profile?.mobile ?? '',
                      onChanged: (phone) {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Address",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customTextField(
                      hintTextColor: Theme.of(context).colorScheme.tertiary,
                        prefixIconColor: Theme.of(context).colorScheme.secondary,
                        onChange: (e) {
                          profile?.address.address = e;
                        },
                        value: profile?.address.address,
                        hintText: "Enter your address",
                        prefixIcon: ImageConstant.address),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "State",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customTextField(
                      hintTextColor: Theme.of(context).colorScheme.tertiary,
                        prefixIconColor: Theme.of(context).colorScheme.secondary,
                        onChange: (e) {
                          profile?.address.state = e;
                        },
                        value: profile?.address.state,
                        hintText: "Enter your state",
                        prefixIcon: ImageConstant.address),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "City",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customTextField(
                      hintTextColor: Theme.of(context).colorScheme.tertiary,
                        prefixIconColor: Theme.of(context).colorScheme.secondary,
                        onChange: (e) {
                          profile?.address.city = e;
                        },
                        value: profile?.address.city,
                        hintText: "Enter your city",
                        prefixIcon: ImageConstant.address),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox customRadioButtonForProfileSetting({
    required RxString coin,
    required String typeName,
    required String value,
  }) {
    return SizedBox(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Radio(
                    activeColor: Color(0xff0E642B),
                    groupValue: coin.value,
                    value: value,
                    onChanged: (val) {
                      coin.value = val.toString();
                    }),
                SizedBox(width: 10),
                Text(
                  typeName,
                  style: TextStyle(
                      color: coin.value == value
                          ? Color(0xff0E642B)
                          : ColorConstant.midNight,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontConstant.jakartaMedium,
                      fontSize: 14),
                ),
              ],
            ),
          ),
          Divider(),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
