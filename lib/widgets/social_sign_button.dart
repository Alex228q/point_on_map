import 'package:flutter/material.dart';

class SocialSignButton extends StatelessWidget {
  const SocialSignButton({super.key, required this.logoText});
  final String logoText;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: Color.fromARGB(255, 248, 248, 243),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {},
        child: Container(
          width: 50,
          height: 50,
          child: Center(
            child: Text(
              logoText,
              style: TextStyle(
                color: Color.fromARGB(255, 254, 28, 8),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//Color.fromARGB(255, 248, 248, 243),