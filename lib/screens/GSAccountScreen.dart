// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

// Source
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/utils/GSWidgets.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/main/utils/AppColors.dart';

// Redirect
import 'GSAddressScreen.dart';
import 'GSEditProfileScreen.dart';
// import '../temp/screens/GSHelpScreen.dart';
// import '../temp/screens/GSPromoScreen.dart';

class GSAccountScreen extends StatefulWidget {
  static String tag = '/GSAccountScreen';

  const GSAccountScreen({super.key});

  @override
  GSAccountScreenState createState() => GSAccountScreenState();
}

class GSAccountScreenState extends State<GSAccountScreen> {
  File? profileImage;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  dialogWidget(dialogContext) {
    return showDialog(
      barrierDismissible: true,
      context: dialogContext,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Thay đổi Avatar',
            style: primaryTextStyle(size: 20, weight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Take photo', style: primaryTextStyle(size: 16)).onTap(() {
                pickFromCamera();
                finish(context);
              }),
              20.height,
              Text('Choose photo', style: primaryTextStyle(size: 16)).onTap(() {
                pickFromGallery();
                finish(context);
              }),
            ],
          ),
        );
      },
    );
  }

  pickFromCamera() async {
    File image = File((await ImagePicker()
            .getImage(source: ImageSource.camera, imageQuality: 50))!
        .path);
    setState(() {
      profileImage = image;
    });
  }

  pickFromGallery() async {
    File image = File((await ImagePicker()
            .getImage(source: ImageSource.gallery, imageQuality: 50))!
        .path);

    setState(() {
      profileImage = image;
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            appStore.isDarkModeOn ? scaffoldColorDark : Colors.white,
        elevation: 1,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text("Tài khoản", style: boldTextStyle(size: 20)),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            profileImage != null
                ? Image.file(profileImage!,
                        width: 110, height: 110, fit: BoxFit.cover)
                    .cornerRadiusWithClipRRect(60)
                    .center()
                : Image.asset(
                    profileImage != null ? profileImage as String : gs_user,
                    width: 110,
                    height: 110,
                    fit: BoxFit.fill,
                  ).cornerRadiusWithClipRRect(60).center().paddingTop(16),
            8.height,
            Text("John", style: boldTextStyle(size: 18)),
            Text("John@gmail.com", style: secondaryTextStyle()),
            16.height,
            AppButton(
              color: gs_primary_color,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit_outlined, color: Colors.white),
                  8.width,
                  Text("Edit Profile",
                      style: boldTextStyle(color: Colors.white, size: 14)),
                ],
              ).paddingOnly(left: 16, right: 16),
              onTap: () {
                dialogWidget(context);
              },
            ),
            40.height,
            profileWidget("Profile Settings", "Change Your Basic Profile")
                .onTap(() {
              const GSEditProfileScreen().launch(context);
            }),
            // profileWidget("Promos", "Latest Promos from us").onTap(() {
            //   GSPromoScreen().launch(context);
            // }),
            profileWidget("My Address", "Your Address").onTap(() {
              GSAddressScreen().launch(context);
            }),
            // profileWidget(
            //         "Terms, Privacy, & Policy", "Things you may want to know")
            //     .onTap(() {}),
            // profileWidget("Help & Support", "Get support from Us").onTap(() {
            //   GSHelpScreen().launch(context);
            // }),
            8.height,
            Align(
                    alignment: Alignment.topLeft,
                    child: Text("Logout", style: boldTextStyle()))
                .paddingLeft(16)
          ],
        ),
      ).paddingBottom(16),
    );
  }
}
