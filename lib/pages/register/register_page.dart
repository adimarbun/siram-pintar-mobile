import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siram_pintar_mobile/cubits/register/register_cubit.dart';
import 'package:siram_pintar_mobile/utils/form_validator.dart';
import 'package:siram_pintar_mobile/utils/navigation.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      context.read<RegisterCubit>().onRegister(
            onLoading: () {},
            onFailed: (err) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$err')),
              );
            },
            onSuccess: () => Navigation.pop(context),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Buat Akun!'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text(
                'Nama:',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nama',
                ),
                validator: emptyValidator,
                onChanged: context.read<RegisterCubit>().onChangeName,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 16.0),
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
                onChanged: context.read<RegisterCubit>().onChangeEmail,
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
                    emptyValidator(value) ?? minimaLengthValidator(value, 8),
                onChanged: context.read<RegisterCubit>().onChangePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onRegister,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Register'),
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
                onPressed: () => Navigation.pop(context),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
