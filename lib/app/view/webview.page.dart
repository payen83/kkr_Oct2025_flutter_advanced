import 'package:flutter/material.dart';
import 'package:flutter_advanced_2025/app/constant/color.constant.dart';
import 'package:flutter_advanced_2025/app/widget/drawer.widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatelessWidget {
  const WebviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: kShrineBrown900,
        backgroundColor: kShrinePink100,
        title: Text('Webview'),
      ),
      drawer: DrawerWidget(),
      body: Center(
        child: TextButton(onPressed: ()=>{
          Navigator.push(context, 
          MaterialPageRoute(builder: (context) => DisplayWebWidget()))
        }, child: Text('Click here to open website', style: TextStyle(fontSize: 20, color: kShrineBrown900),)),
      ),
    );
  }
}

class DisplayWebWidget extends StatefulWidget {
  const DisplayWebWidget({super.key});

  @override
  State<DisplayWebWidget> createState() => _DisplayWebWidgetState();
}

class _DisplayWebWidgetState extends State<DisplayWebWidget> {
  late final WebViewController webViewController;

  @override
  void initState(){
    super.initState();
    final PlatformWebViewControllerCreationParams params = const PlatformWebViewControllerCreationParams();
    webViewController = WebViewController.fromPlatformCreationParams(params)..loadRequest(Uri.parse('https://www.google.com'));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: webViewController);
  }
}