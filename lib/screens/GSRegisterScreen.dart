// import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:shop_order/screens/GSLoginScreen.dart';
import 'package:shop_order/screens/GSVerificationScreen.dart';
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/GSWidgets.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:shop_order/main/utils/AppWidget.dart';
// import 'package:shop_order/utils/GSImages.dart';

class GSRegisterScreen extends StatefulWidget {
  static String tag = '/GSRegisterScreen';

  const GSRegisterScreen({super.key});

  @override
  GSRegisterScreenState createState() => GSRegisterScreenState();
}

class GSRegisterScreenState extends State<GSRegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode emailNode = FocusNode();
  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setStatusBarColor(appStore.isDarkModeOn ? scaffoldColorDark : Colors.white,
        statusBarIconBrightness: Brightness.dark);
  }

  @override
  void dispose() {
    setStatusBarColor(
        appStore.isDarkModeOn ? scaffoldColorDark : gs_primary_color,
        statusBarIconBrightness: Brightness.dark);
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBarWidget('',
          color: appStore.isDarkModeOn ? scaffoldColorDark : Colors.white),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Đăng ký",
              style: boldTextStyle(size: 25),
            ),
            16.height,
            // Row(
            //   children: [
            //     Container(
            //       width: context.width(),
            //       height: 50,
            //       decoration: boxDecorationWithRoundedCorners(
            //         borderRadius: radius(4),
            //         backgroundColor: appStore.isDarkModeOn ? scaffoldSecondaryDark : Colors.black,
            //       ),
            //       child: commonCacheImageWidget(gs_apple_icon, 24, width: 24),
            //     ).expand(),
            //     8.width,
            //     Container(
            //       width: context.width(),
            //       height: 50,
            //       decoration: boxDecorationWithRoundedCorners(
            //         borderRadius: radius(4),
            //         border: Border.all(color: Colors.grey[300]!),
            //       ),
            //       child: Image.asset(gs_google_icon, height: 24, width: 24),
            //     ).expand()
            //   ],
            // ),
            16.height,
            Form(
              key: formKey,
              child: Column(
                children: [
                  AppTextField(
                    autoFocus: false,
                    controller: emailController,
                    textFieldType: TextFieldType.EMAIL,
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: gs_primary_color)),
                      labelText: 'Địa chỉ Email',
                      labelStyle: secondaryTextStyle(size: 14),
                    ),
                    focus: emailNode,
                    nextFocus: firstNameNode,
                    keyboardType: TextInputType.text,
                  ),
                  16.height,
                  AppTextField(
                    autoFocus: false,
                    controller: firstNameController,
                    textFieldType: TextFieldType.NAME,
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: gs_primary_color)),
                      labelText: 'Họ và Tên',
                      labelStyle: secondaryTextStyle(size: 14),
                    ),
                    focus: firstNameNode,
                    nextFocus: lastNameNode,
                    keyboardType: TextInputType.text,
                  ),
                  16.height,
                  AppTextField(
                    autoFocus: false,
                    controller: lastNameController,
                    textFieldType: TextFieldType.NAME,
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: gs_primary_color)),
                      labelText: 'Last Name',
                      labelStyle: secondaryTextStyle(size: 14),
                    ),
                    focus: lastNameNode,
                    nextFocus: phoneNode,
                    keyboardType: TextInputType.text,
                  ),
                  20.height,
                  Row(
                    children: [
                      CountryCodePicker(
                        onChanged: print,
                        initialSelection: 'VN',
                        favorite: const ['+84', 'Vietnam'],
                        showCountryOnly: true,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                      ),
                      AppTextField(
                        autoFocus: false,
                        controller: phoneController,
                        textFieldType: TextFieldType.PHONE,
                        focus: phoneNode,
                        nextFocus: passwordNode,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: grey)),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: gs_primary_color)),
                          hintText: "Số điện thoại",
                          hintStyle: secondaryTextStyle(size: 14),
                        ),
                      ).expand()
                    ],
                  ),
                  16.height,
                  TextFormField(
                    controller: passwordController,
                    focusNode: passwordNode,
                    autofocus: false,
                    obscureText: showPassword ? false : true,
                    onFieldSubmitted: (term) {
                      passwordNode.unfocus();
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          showPassword = !showPassword;
                          setState(() {});
                        },
                        child: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: gs_primary_color),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: grey)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: gs_primary_color)),
                      labelStyle: secondaryTextStyle(size: 14),
                      labelText: "Mật Khẩu",
                    ),
                    validator: (val) {
                      if (val.isEmptyOrNull) {
                        return "Vui Lòng Nhập Mật Khẩu";
                      }
                      return null;
                    },
                  ),
                  16.height,
                  TextFormField(
                    controller: confirmPasswordController,
                    focusNode: confirmPasswordNode,
                    autofocus: false,
                    obscureText: showPassword ? false : true,
                    onFieldSubmitted: (term) {
                      passwordNode.unfocus();
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          showPassword = !showPassword;
                          setState(() {});
                        },
                        child: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: gs_primary_color),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: grey)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: gs_primary_color)),
                      labelStyle: secondaryTextStyle(size: 14),
                      labelText: "Confirm Password",
                    ),
                    validator: (val) {
                      if (val.isEmptyOrNull) {
                        return "Please enter confirm password";
                      }
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        return "Password do not match";
                      }
                      return null;
                    },
                  ),
                  50.height,
                  gsAppButton(
                    context,
                    'Tạo Tài Khoán',
                    () {
                      // validate

                      GSLoginScreen().launch(context);
                    },
                  ),
                ],
              ),
            ),
            16.height,
          ],
        ).paddingAll(16),
      ),
    );
  }
}
