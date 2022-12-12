import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class FirebaseNotification {
  late BuildContext context;
  bool isFlutterLocalNotificationsInitialized = false;
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel channel;

  Future<String?> getToken() async {
    var value = await FirebaseMessaging.instance.getToken();
    print("firebase token is $value");
    return value;
  }

  Future<void> configureFireBase(BuildContext context) async {
    this.context = context;
    flutterNotification(context);

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {
        intentToNextScreen(message.data);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("Notification Data ${message.data}");
      print("Notification Data ${message.notification?.title??''}");
      print("Notification Data ${message.notification?.body??''}");

      if (message.data["type"] != null && message.data["type"] == "Assigned") {


          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          if (notification != null && android != null) {
            _flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(channel.id, channel.name,
                      channelDescription: channel.description,
                      importance: Importance.max,
                      priority: Priority.high),
                ),
                payload: json.encode(message.data));
          }



      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      intentToNextScreen(message.data);
    });
  }

  Future<void> flutterNotification(BuildContext context) async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }

    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'Message notification',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var darwinInitializationSettings = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: darwinInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            onSelectNotification(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            break;
        }
      },
    );

    isFlutterLocalNotificationsInitialized = true;
  }

  intentToNextScreen(notification) {
    /*if (notification["ptype"] == 'SMS') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MessageDetailsScreen(
                args: MessageDetailsScreenArgs(
                    notification['pfrom'], notification['pfrom'], null),
              )));
    }*/
  }

  Future onSelectNotification(String? payload) async {
    if (payload != null) {
      intentToNextScreen(json.decode(payload));
    }
  }
}
