import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:handover/data/notification/local_notification.dart';
import 'package:handover/presentation/screens/traking/tracking_bloc.dart';
import 'package:handover/presentation/screens/traking/tracking_screen.dart';

final LocalNotification _flutterLocalNotifications = LocalNotification();

@pragma('vm:entry-point')
void onBackgroundNotificationClicked(NotificationResponse response) {
  print(">>> notification background clicked");
}

void onForegroundNotificationClicked(NotificationResponse message) {
  print(">>> foreground clicked");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await _flutterLocalNotifications.initNotification(
      onBackgroundNotificationClicked, onForegroundNotificationClicked);
  await _flutterLocalNotifications.requestPermission();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => TrackingBloc(),
        child: const TrackingScreen(),
      ),
    );
  }
}
