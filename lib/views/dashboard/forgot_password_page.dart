// ui/forgot_password_page.dart
import 'package:cp6_apd/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:cp6_apd/bloc/forgot_password/forgot_password_event.dart';
import 'package:cp6_apd/bloc/forgot_password/forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
              listener: (context, state) {
                if (state is ForgotPasswordSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                } else if (state is ForgotPasswordFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                if (state is ForgotPasswordLoading) {
                  return CircularProgressIndicator();
                }

                return ElevatedButton(
                  onPressed: () {
                    final email = emailController.text;
                    context.read<ForgotPasswordBloc>().add(ForgotPasswordRequested(email));
                  },
                  child: Text('Send Reset Link'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
