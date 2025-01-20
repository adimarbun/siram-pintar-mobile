import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siram_pintar_mobile/cubits/login/login_cubit.dart';
import 'package:siram_pintar_mobile/pages/register/register_page.dart';
import 'package:siram_pintar_mobile/utils/form_validator.dart';
import 'package:siram_pintar_mobile/utils/navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().onLogin(
            onLoading: () {},
            onFailed: (err) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$err')),
              );
            },
            onSuccess: () {},
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selamat Datang Kembali!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height: 32.0),
                    const Text(
                      'Email:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (value) =>
                          emptyValidator(value) ?? emailValidator(value),
                      onChanged: context.read<LoginCubit>().onChangeEmail,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Password:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (value) =>
                          emptyValidator(value) ??
                          minimaLengthValidator(value, 8),
                      onChanged: context.read<LoginCubit>().onChangePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 8.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Lupa Password?',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: _onLogin,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48.0),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 16.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('atau'),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    OutlinedButton(
                      onPressed: () => Navigation.push(
                        context,
                        const RegisterPage(),
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48.0),
                      ),
                      child: const Text('Signup'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
