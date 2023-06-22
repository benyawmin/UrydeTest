/** This Screen Can Also be used instead of the AlertDialog when the request is
 * Sent
 */

// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// class ReportSent extends StatelessWidget {
//   final bool wasApiRequestSuccessful;
//   final ThemeData theme;
//   const ReportSent(
//       {super.key, required this.wasApiRequestSuccessful, required this.theme});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: wasApiRequestSuccessful
//           ?
//           // If the reporting request to the API (stream) was sent successfuly
//           Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   size: 10.h,
//                   Icons.check_outlined,
//                   color: Colors.green,
//                 ),
//                 Text(
//                   'Driver was successfully reported',
//                   style: TextStyle(color: theme.primaryColor),
//                 ),
//               ],
//             )
//           :
//           // If request to the API (stream) was not sent successfuly
//           Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   size: 10.h,
//                   Icons.cancel_outlined,
//                   color: Colors.red,
//                 ),
//                 /* I could also here get the response code from the api for the 
//               error message to be more descriptive */
//                 Text(
//                   'Something Went Wrong!',
//                   style: TextStyle(color: theme.primaryColor),
//                 )
//               ],
//             ),
//     );
//   }
// }
