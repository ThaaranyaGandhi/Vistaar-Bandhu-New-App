import 'dart:async';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_security_checking/device_security_checking.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vistaar_bandhu_new_version/environment.dart';
import 'package:vistaar_bandhu_new_version/multilanguage.dart';
import 'package:vistaar_bandhu_new_version/providers/auth_provider.dart';
import 'package:vistaar_bandhu_new_version/providers/loan_provider.dart';
import 'package:vistaar_bandhu_new_version/providers/pvl_provider.dart';
import 'package:vistaar_bandhu_new_version/providers/enach_provider.dart';
import 'package:vistaar_bandhu_new_version/providers/welcomeKit_provider.dart';

import 'package:vistaar_bandhu_new_version/screens/home_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/login/login_screen.dart';
import 'package:vistaar_bandhu_new_version/service/app_di.dart';
import 'package:vistaar_bandhu_new_version/storage/app_pref.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/app_router.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';
import 'package:vistaar_bandhu_new_version/util/size_config.dart';


import 'base/base_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:upgrader/upgrader.dart';
// import 'package:in_app_update/in_app_update.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  /// DEV (or) PROD
  const String environment =
      String.fromEnvironment('EVNVIRONMENT', defaultValue: Environment.PROD);

  // print("EVNVIRONMENT = $environment");
  Environment().initConfig(environment);

  setupDI().then((value) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
    ]).then((_) {
      // runZoned(() {
      runApp(
        const VistaarApp(),
      );
      // });
    });
  });

  AwesomeNotifications().initialize(
      null, // icon for your app notification
      [
        NotificationChannel(
            channelKey: 'key1',
            channelName: 'Proto Coders Point',
            channelDescription: "Notification example",
            defaultColor: const Color(0XFF9050DD),
            ledColor: Colors.blue,
            playSound: true,
            enableLights: true,
            enableVibration: true)
      ]);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
}

class VistaarApp extends StatefulWidget {
  const VistaarApp({super.key});

  @override
  _VistaarAppState createState() => _VistaarAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _VistaarAppState? state =
        context.findAncestorStateOfType<_VistaarAppState>();
    state!.changeLocale(newLocale);
  }
}

class _VistaarAppState extends State<VistaarApp> with WidgetsBindingObserver {
// final  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Timer? timer;
  AppSharedPref pref = getIt<AppSharedPref>();
  //FIXME: to tbe fixed when vernacular needs to be implemented
  Locale? _locale;
  // Locale? _locale = const Locale.fromSubtags(languageCode: 'en');

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {}
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {}
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //message when open
    });

    //FIXME: Logout after inactivity of 30mins
    if (pref.userMobile.isNotEmpty) {
      timer = Timer.periodic(const Duration(minutes: 30), (Timer t) => _logOut());
    }
    // checkAppUpdate();
  }

  // Future<void> checkAppUpdate() async {
  //   print("checking update!");
  //   InAppUpdate.checkForUpdate().then((info) {
  //     debugPrint("info.updateAvailability: ${info.updateAvailability}");
  //     setState(() {
  //       if (info.updateAvailability == UpdateAvailability.updateAvailable) {
  //         print("update available");
  //         update();
  //       }
  //     });
  //   }).catchError((e) {
  //     print("Error: $e");
  //   });
  // }

  // void update() async {
  //   print("Updating");
  //   await InAppUpdate.startFlexibleUpdate();
  //   InAppUpdate.completeFlexibleUpdate().then((_) {}).catchError((e) {
  //     print("Error: $e");
  //   });
  // }

  void changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void checkRoot(BuildContext context) async {
    debugPrint("not rooted");
    if (await DeviceSecurityChecking().rootedDeviceChecking()) {
      showRootAlertDialog(context, 'Alert');
    } else {
      debugPrint("not rooted");
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  _logOut() {
    Provider.of<AuthProvider>(SizeConfig.cxt!, listen: false).clearUserData();
    Get.offNamedUntil(LoginScreen.routeName, (route) => false);
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    final multiLanugage = MultiLanguage();
    final localeKey = await multiLanugage.readLocaleKey();

    switch (localeKey) {
      case "hi":
        _locale = const Locale.fromSubtags(languageCode: 'hi');
        break;
      case "kn":
        _locale = const Locale.fromSubtags(languageCode: 'kn');
        break;
      case "ta":
        _locale = const Locale.fromSubtags(languageCode: 'ta');
        break;
      case "te":
        _locale = const Locale.fromSubtags(languageCode: 'te');
        break;
      default:
        _locale = const Locale.fromSubtags(languageCode: 'en');
    }
    setState(() {});
    debugPrint("updated localeKey = $localeKey");
    debugPrint("updated locale = $_locale");
  }

  @override
  Widget build(BuildContext context) {
    appLogger(Environment().config?.envParam, pref.userMobile);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BaseProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LoanProvider()),
        ChangeNotifierProvider(create: (_) => PvlProvider()),
        ChangeNotifierProvider(create: (_) => EnachProvider()),
        ChangeNotifierProvider(create: (_) => WelcomeKitProvider())
      ],
      child: Consumer<BaseProvider>(builder: (context, provider, _) {
        return UpgradeAlert(
          dialogStyle: UpgradeDialogStyle.cupertino,
          //  canDismissDialog: false,
          upgrader: Upgrader(
            durationUntilAlertAgain: const Duration(minutes: 2),
            debugDisplayAlways: true,
            debugLogging: true,
          ),
          child: GetMaterialApp(
            //   onReady: () => checkRoot(context),

            theme: ThemeData(
              useMaterial3: false,
              primaryColor: primaryColor,
              primarySwatch: Colors.blue,
            ),
            //added for implementing multilanguage
            localizationsDelegates: const[
              //class which loads translations from JSON files
              MultiLanguage.delegate,
              //class which loads translations from JSON files
              GlobalMaterialLocalizations.delegate,
              //Built-in localization of basic text for material widgets
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            locale: _locale,
            supportedLocales: const [
               Locale('en', 'US'), //English
               Locale.fromSubtags(languageCode: 'hi'), //hindi
               Locale.fromSubtags(languageCode: 'te'), //telugu
               Locale.fromSubtags(languageCode: 'kn'), //kannada
               Locale.fromSubtags(languageCode: 'ta'), //tamil
            ],
            localeResolutionCallback: (locale, supportLocales) {
              debugPrint(
                  "locale = $locale, supportedLocales = $supportLocales");
              for (var supportedLocaleLanguage in supportLocales) {
                if (supportedLocaleLanguage.languageCode ==
                        locale?.languageCode &&
                    supportedLocaleLanguage.countryCode ==
                        locale?.countryCode) {
                  return supportedLocaleLanguage;
                }
              }
              return supportLocales.first;
            },

            debugShowCheckedModeBanner: false,

            title: 'Vistaar Bandhu',
            home: pref.userMobile.isNotEmpty ? HomeScreen() : LoginScreen(),
           // home: pref.userMobile.isNotEmpty ? HomeScreen() : LoginScreen(),
            // home: LoginScreen(),
            onGenerateRoute: AppRouter.generateRoute,
          ),
        );
      }),
    );
  }

  void showRootAlertDialog(BuildContext context, String message) {
    Get.defaultDialog(
      title: message,
      content: const Text("Your device is rooted"),
      barrierDismissible: false,
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (await DeviceSecurityChecking().rootedDeviceChecking()) {
              exit(0);
            } else {
              Navigator.of(context).pop();
            }
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}
