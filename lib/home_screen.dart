import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _localPath;
  bool downloading = false;
  int count = 0;
  int total = 0;

  String fileName = "app-release-update.apk";

  String url =
      "https://docs.google.com/uc?export=download&id=1hNm3M56wpL0Dcwi6GUaQx2c7fUMaqpXH";

  @override
  void initState() {
    _prepareSaveDir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () async {
              setState(() {
                downloading = true;
              });
              String path = "$_localPath$fileName";
              bool exists = await File(path).exists();
              if (exists) {
                await File(path).delete();
              }

              await Dio().download(
                url,
                path,
                onReceiveProgress: (count, total) {
                  this.count = count;
                  this.total = total;
                  setState(() {});
                },
              );

              setState(() {
                downloading = false;
                count = 0;
                total = 0;
              });
            },
            child: const Text("다운로드"),
          ),
          ElevatedButton(
            onPressed: () async {
              bool exists = await File("$_localPath$fileName").exists();
              if (!exists) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("파일을 다운받으세요"),
                  ),
                );
                return;
              }
              await const MethodChannel("android")
                  .invokeMethod("update", "$_localPath$fileName");
            },
            child: const Text("업데이트"),
          ),
          if (downloading) ...[
            Center(
              child:
                  Text(count == 0 ? "다운로드 준비중..." : "download : $count/$total"),
            ),
            const Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }

  void dir() async {
    final Directory tempDir = await getTemporaryDirectory();
    print('tempDir : $tempDir');

    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    print('appDocumentsDir : $appDocumentsDir');
  }

  Future<void> _prepareSaveDir() async {
    _localPath = "/sdcard/download/";
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }
}
