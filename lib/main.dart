// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import
import 'package:agva_app/Screens/Common/TermsCondition.dart';
import 'package:agva_app/Screens/User/DeviceDetails.dart';
import 'package:agva_app/Screens/User/DeviceList.dart';
import 'package:agva_app/Screens/User/UserHomeScreen.dart';
import 'package:agva_app/Screens/User/NotificationScreen.dart';
import 'package:agva_app/Service/SocketService.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'AuthScreens/SignIn.dart';
import 'AuthScreens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyAGeXq1HUM6_idigSAbWHolMNCdbjXTFJ8',
          appId: '1:679007550491:android:3a7d4bfafbaaa9f1e78cbe',
          messagingSenderId: '679007550491',
          projectId: 'agvaapp',
          storageBucket: 'agvaapp.appspot.com'));
  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseAnalytics.instance.logEvent(name: 'mycustomevent');
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message ${message.messageId}');
  }

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: false,
    sound: true,
  );
  runApp(MyApp());
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  // 'This channel is used for important notifications.', // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyApp extends StatefulWidget {
  static FirebaseInAppMessaging fiam = FirebaseInAppMessaging.instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelShowBadge: false,
                // color: Colors.transparent,
                icon: "@drawable/ic_launcher",
              ),
            ));
      //       Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen(title: '', body: '',
      // )));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
 
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(notification.title.toString()),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(notification.body.toString())],
                ),
              ),
            );
          },
        );
      
      }
    });

    getToken();
  }

  late String token;
  getToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
    print(' FCM Token: $token');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      routes: {
        "/signin": (context) => SignIn(),
        "/splash": (context) => const SplashScreen(),
        "/home": (context) => UserHomeScreen({}),
        "/devicedetails": (context) =>
            DeviceDetails('', SocketServices(), '', '', ''),
        "/tandc": (context) => TermsCondition(),
        "/devicelist": (context) => DeviceList(),
      },
    );
  }
}



// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   importance: Importance.high,
// );

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// class MyApp extends StatefulWidget {
//   final FirebaseAnalyticsObserver observer;

//   const MyApp({Key? key, required this.observer}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//     var initialzationSettingsAndroid =
//         AndroidInitializationSettings('@drawable/ic_launcher');
//     var initializationSettings =
//         InitializationSettings(android: initialzationSettingsAndroid);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 importance: Importance.high,
//                 priority: Priority.high,
//                 channelShowBadge: false,
//                 icon: "@drawable/ic_launcher",
//               ),
//             ));
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => NotificationScreen(
//               title: notification.title ?? '',
//               body: notification.body ?? '',
//             ),
//           ),
//         );
//       }
//     });

//     getToken();
//   }

//   late String token;
//   getToken() async {
//     token = (await FirebaseMessaging.instance.getToken())!;
//     print(' FCM Token: $token');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorObservers: [widget.observer],
//       initialRoute: "/splash",
//       routes: {
//         "/home": (context) => HomeScreen({}),
//         "/splash": (context) => SplashScreen(),
//       },
//     );
//   }
// }




