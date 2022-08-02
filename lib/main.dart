import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/layout/board_screen.dart';
import 'package:to_do_app/shared/cuibt/cubit.dart';
import 'package:to_do_app/shared/cuibt/states.dart';
import 'package:to_do_app/shared/network/notificationservice.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) => AppCubit()..createDatabase()),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'To_Do App',
              theme: ThemeData(
                appBarTheme: const AppBarTheme(color: Colors.white),
                scaffoldBackgroundColor: Colors.white,
                primarySwatch: Colors.blue,
              ),
              home: const BoardScreen(),
            );
          },
        ));
  }
}
