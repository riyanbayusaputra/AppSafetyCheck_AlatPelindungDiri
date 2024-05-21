import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cp6_apd/bloc/login/login_bloc.dart';
import 'package:cp6_apd/data/localsources/auth_local_storage.dart';
import 'package:cp6_apd/data/models/requests/login_model.dart';
import 'package:cp6_apd/views/dashboard/dashboard_view.dart';
import 'package:cp6_apd/views/dashboard/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    isLogin();
    Future.delayed(const Duration(seconds: 2));
    super.initState();
  }

  void isLogin() async {
    final isTokenExist = await AuthLocalStorage().isTokenExist();
    if (isTokenExist) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const DashboardView();
      }));
    }
  }

  @override
  void dispose() {
    emailController!.dispose();
    passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade400, Colors.green.shade300],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _JudulFormLogin(),
              const _LogoAplikasi(),
              _FormLogin(emailController: emailController, passwordController: passwordController),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormLogin extends StatelessWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  const _FormLogin({
    Key? key,
    this.emailController,
    this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
              label: 'Email',
              controller: emailController,
            ),
            InputField(
              label: 'Password',
              obscure: true,
              controller: passwordController,
            ),
            const SizedBox(height: 20),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginLoaded) {
                  emailController!.clear();
                  passwordController!.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.blue,
                      content: Text('Success login'),
                    ),
                  );
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return const DashboardView();
                  }));
                } else if (state is LoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return _TombolLogin(
                  emailController: emailController,
                  passwordController: passwordController,
                );
              },
            ),
            const SizedBox(height: 15),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const RegisterPage();
                  }));
                },
                child: const Text(
                  'Belum Punya Akun? Register',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TombolLogin extends StatelessWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  const _TombolLogin({
    Key? key,
    this.emailController,
    this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      onPressed: () {
        final requestModel = LoginModel(
          email: emailController!.text,
          password: passwordController!.text,
        );
        context.read<LoginBloc>().add(DoLoginEvent(loginModel: requestModel));
      },
      child: const Text(
        'Login',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String label;
  final bool obscure;
  final TextEditingController? controller;

  const InputField({
    Key? key,
    required this.label,
    this.obscure = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class _LogoAplikasi extends StatelessWidget {
  const _LogoAplikasi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Image.asset(
        'assets/APD.jpg', // Update with your logo path
        width: 150,
      ),
    );
  }
}

class _JudulFormLogin extends StatelessWidget {
  const _JudulFormLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: const [
          Text(
            'APLIKASI DETEKSI Apd',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'Safetycheck',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
