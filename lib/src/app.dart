import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:uryde/src/bloc/parking_violations_report_bloc.dart';
import 'package:uryde/src/screens/reservation.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Uryde',
          theme: _constructThemeData(theme),
          home: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: _constructAppBar(theme),
              body: const Reservation()),
        );
      },
    );
  }
}

// Constructing the general theme of the app
ThemeData _constructThemeData(ThemeData theme) {
  return ThemeData(
      // Define the default brightness and colors.
      primaryColor: const Color(0xFF009688),
      primaryColorDark: const Color(0xFF00796B),
      primaryColorLight: const Color(0xFFB2DFDB),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 14.sp,
          color: theme.primaryColor,
          fontFamily: 'open_sans',
        ),
        titleMedium: TextStyle(
          fontSize: 12.sp,
          color: theme.primaryColor,
          fontFamily: 'open_sans',
        ),
        titleSmall: TextStyle(
          fontSize: 10.sp,
          color: theme.primaryColor,
          fontFamily: 'open_sans',
        ),
        bodyLarge: TextStyle(
            fontSize: 14.sp,
            fontFamily: 'open_sans',
            color: theme.primaryColor),
        bodyMedium: TextStyle(
            fontSize: 12.sp,
            fontFamily: 'open_sans',
            color: theme.primaryColor),
        bodySmall: TextStyle(
            fontSize: 8.sp, fontFamily: 'open_sans', color: theme.primaryColor),
      ));
}

// Constructing the AppBar for the application
AppBar _constructAppBar(ThemeData theme) {
  return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        children: [
          IconButton(
              color: theme.primaryColor,
              onPressed: () {},
              /** The actual code will look something like below but
                           * I set it to empty function
                           * so that the button is visible
                           */
              // () {
              //  Navigator.pop(context);
              // },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFF009688),
              )),
          SizedBox(
            width: 2.w,
          ),
          const Text(
            'Deine Reservierung',
            style: TextStyle(color: Color(0xFF009688)),
          )
        ],
      ));
}
