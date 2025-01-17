import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/utils/auth_styles.dart';

class ForgotPasswordPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  
  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthStyles.buildAuthScaffold(
      context,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Reset Password',
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Enter your email to receive reset instructions',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: AuthStyles.textFieldDecoration(
                    'Email',
                    Icons.email_outlined,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: AuthStyles.primaryButtonStyle,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle password reset
                    }
                  },
                  child: const Text('Send Reset Link'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Back to Login'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
