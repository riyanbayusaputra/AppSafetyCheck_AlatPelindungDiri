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
      Navigator.push(context, MaterialPageRoute(builder: (context) {
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'), // Ganti dengan path gambar latar belakang yang sesuai
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login Page",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Image.asset(
                'assets/logoAuth.png', // Ganti dengan path gambar yang sesuai
                width: 200, // Sesuaikan lebar gambar sesuai kebutuhan
                height: 250, // Sesuaikan tinggi gambar sesuai kebutuhan
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                controller: emailController,
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                controller: passwordController,
              ),
              const SizedBox(
                height: 16,
              ),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginLoaded) {
                    emailController!.clear();
                    passwordController!.clear();
                    // Navigasi
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.blue,
                        content: const Text('Success login'),
                      ),
                    );
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                  return ElevatedButton(
                    onPressed: () {
                      final requestModel = LoginModel(
                        email: emailController!.text,
                        password: passwordController!.text,
                      );

                      context.read<LoginBloc>().add(DoLoginEvent(loginModel: requestModel));
                    },
                    child: const Text('Login'),
                  );
                },
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const RegisterPage();
                  }));
                },
                child: const Text(
                  'Belum Punya Akun? Register',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
