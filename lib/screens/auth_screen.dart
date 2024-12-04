import 'package:flutter/material.dart';
import 'package:point_on_map/screens/map_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isRegistration = false; // Флаг переключения между регистрацией и входом

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.red[200]!, Colors.red[300]!, Colors.red[500]!],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: _isRegistration
                      ? _buildRegistrationForm()
                      : _buildLoginForm(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Column(
      key: ValueKey('registration'),
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Регистрация',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red[800],
          ),
        ),
        SizedBox(height: 20),
        _buildEmailField(),
        SizedBox(height: 10),
        _buildPasswordField(),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              'Зарегистрироваться',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red[500],
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _isRegistration = false; // Переключаемся на вход
            });
          },
          child: Text('Уже есть аккаунт? Войти'),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      key: ValueKey('login'),
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Вход',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red[800],
          ),
        ),
        SizedBox(height: 20),
        _buildEmailField(),
        SizedBox(height: 10),
        _buildPasswordField(),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MapScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              'Войти',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red[500],
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _isRegistration = true; // Переключаемся на регистрацию
            });
          },
          child: Text('Нет аккаунта? Зарегистрироваться'),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Пожалуйста, введите email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Пароль',
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Пожалуйста, введите пароль';
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
