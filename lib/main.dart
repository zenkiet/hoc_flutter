import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:google_fonts/google_fonts.dart';

// Source
import 'package:shop_order/main/store/AppStore.dart';
import 'package:shop_order/utils/AppConstants.dart';
// import 'package:shop_order/main/utils/AppColors.dart';

// Redirect
import 'package:shop_order/screens/GSWalkThroughScreen.dart';

AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setOrientationPortrait();

  await initialize();
  appStore.toggleDarkMode(value: getBoolAsync(DarkModePref));
  appStore.setLoggedIn(getBoolAsync(IsLoggedInSocialLogin));
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(), // Wrap your app
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zen Shop Order',
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false, //? xoá logo Debug

      home: GSWalkThroughScreen(),
    );
  }
}
