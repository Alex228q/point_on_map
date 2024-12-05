import 'package:flutter/material.dart';

class LogoLock extends StatelessWidget {
  const LogoLock({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          color: Color.fromARGB(255, 254, 28, 8),
        ),
        padding: EdgeInsets.all(30),
        child: Icon(
          Icons.lock,
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }
}
