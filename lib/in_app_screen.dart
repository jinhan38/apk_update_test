// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// class InAppScreen extends StatefulWidget {
//   const InAppScreen({Key? key}) : super(key: key);
//
//   @override
//   State<InAppScreen> createState() => _InAppScreenState();
// }
//
// class _InAppScreenState extends State<InAppScreen> {
//   late InAppWebViewController webView;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('InAppWebView Example'),
//         ),
//         body: Container(
//             child: Column(children: <Widget>[
//               Expanded(
//                   child: InAppWebView(
//               initialUrlRequest:  "http://ovh.net/files/1Mio.dat",
//                     initialOptions: InAppWebViewGroupOptions(
//                       crossPlatform: InAppWebViewOptions(
//                           debuggingEnabled: true,
//                           useOnDownloadStart: true
//                       ),
//                     ),
//                     onWebViewCreated: (InAppWebViewController controller) {
//                       webView = controller;
//                     },
//                     onLoadStart: (InAppWebViewController controller, String url) {
//
//                     },
//                     onLoadStop: (InAppWebViewController controller, String url) {
//
//                     },
//                     onDownloadStart: (controller, url) async {
//                       print("onDownloadStart $url");
//                       final taskId = await FlutterDownloader.enqueue(
//                         url: url,
//                         savedDir: (await getExternalStorageDirectory()).path,
//                         showNotification: true, // show download progress in status bar (for Android)
//                         openFileFromNotification: true, // click on notification to open downloaded file (for Android)
//                       );
//                     },
//                   ))
//             ])),
//       ),
//     );
//   }
// }
