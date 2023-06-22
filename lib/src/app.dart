import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uryde/src/screens/report_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Uryde',
          theme: _constructThemeData(Theme.of(context)),
          home: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: _constructAppBar(Theme.of(context), context),
              body: ReportScreen()),
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
          fontWeight: FontWeight.bold,
          color: theme.primaryColor,
          fontFamily: 'open_sans',
        ),
        titleMedium: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: theme.primaryColor,
          fontFamily: 'open_sans',
        ),
        titleSmall: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: theme.primaryColor,
          fontFamily: 'open_sans',
        ),
        bodyLarge: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
            fontFamily: 'open_sans',
            color: theme.primaryColor),
        bodyMedium: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
            fontFamily: 'open_sans',
            color: theme.primaryColor),
        bodySmall: TextStyle(
            fontSize: 8.sp,
            fontWeight: FontWeight.normal,
            fontFamily: 'open_sans',
            color: theme.primaryColor),
      ));
}

// Constructing the AppBar for the application
AppBar _constructAppBar(ThemeData theme, BuildContext context) {
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
          Text(
            'Deine Reservierung',
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ));
}
