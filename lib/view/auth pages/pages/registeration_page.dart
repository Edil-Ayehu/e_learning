import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/utils/auth_styles.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthStyles.buildAuthScaffold(
      context,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Create Account',
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Start your learning journey today',
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
                    'Full Name',
                    Icons.person_outline,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: AuthStyles.textFieldDecoration(
                    'Email',
                    Icons.email_outlined,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: AuthStyles.textFieldDecoration(
                    'Password',
                    Icons.lock_outline,
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: AuthStyles.textFieldDecoration(
                    'Confirm Password',
                    Icons.lock_outline,
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: AuthStyles.primaryButtonStyle,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.toNamed('/profile-setup');
                    }
                  },
                  child: const Text('Register'),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed('/login'),
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
