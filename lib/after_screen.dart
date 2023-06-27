import 'package:flutter/material.dart';

class AfterScreen extends StatefulWidget {
  const AfterScreen({Key? key}) : super(key: key);

  @override
  State<AfterScreen> createState() => _AfterScreenState();
}

class _AfterScreenState extends State<AfterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(
          "업데이트 완료",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
