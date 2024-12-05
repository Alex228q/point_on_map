import 'package:flutter/material.dart';
import 'package:point_on_map/screens/map_screen.dart';
import 'package:point_on_map/widgets/custom_button.dart';
import 'package:point_on_map/widgets/logo_lock.dart';
import 'package:point_on_map/widgets/social_sign_button.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = constraints.maxHeight;
          double screenWidth = constraints.maxWidth;
          
          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: screenHeight * 0.4,
                    color: Color.fromARGB(255, 248, 248, 243),
                  ),
                  Container(
                    height: screenHeight * 0.6,
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.7,
                          child: CustomButton(
                            text: 'Войти',
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MapScreen();
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: screenWidth * 0.7,
                          child: CustomButton(
                            text: 'Зарегистрироваться',
                            onTap: () {},
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: screenWidth * 0.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SocialSignButton(logoText: 'fb'),
                              SocialSignButton(logoText: 'in'),
                              SocialSignButton(logoText: 'g+'),
                              SocialSignButton(logoText: 'tw'),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Уже есть аккаунт? Войти',
                            style: TextStyle(
                              color: Color.fromARGB(255, 254, 28, 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                top: screenHeight * 0.315,
                child: LogoLock(),
              )
            ],
          );
        },
      ),
    );
  }
}
//Color.fromARGB(255, 254, 28, 8),