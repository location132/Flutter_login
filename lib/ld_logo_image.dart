import 'package:flutter/material.dart';

class LogoImage extends StatefulWidget {
  const LogoImage({
    super.key,
  });

  @override
  State<LogoImage> createState() => _LogoImageState();
}

class _LogoImageState extends State<LogoImage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("LOGO있는 자리"),
        Text('로고 밑에 텍스트'),
      ],
    );
  }
}
