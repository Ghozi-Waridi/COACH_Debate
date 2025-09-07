import 'package:choach_debate/features/Auth/presentation/widgets/textField_widget.dart';
import 'package:flutter/material.dart';

class AuthWidget {
  List<Widget> buildLoginFields(
    TextEditingController _emailController,
    TextEditingController _passwordController,
  ) {
    return [
      TextfieldWidget(
        controller: _emailController,
        labelText: 'Nickname or email',
        icon: Icons.person_outline,
      ),
      const SizedBox(height: 20),
      TextfieldWidget(
        controller: _passwordController,
        labelText: 'Password here',
        icon: Icons.lock_outline,
        obscureText: true,
        suffixIcon: Icons.visibility_off_outlined,
      ),
      const SizedBox(height: 10),
      Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {},
          child: const Text(
            'Forgot Password',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ];
  }

  List<Widget> buildSignUpFields(
    TextEditingController _fullNameController,
    TextEditingController _emailController,
    TextEditingController _passwordController,
    TextEditingController _confirmPasswordController,
    TextEditingController _institusiController,
  ) {
    return [
      TextfieldWidget(
        controller: _fullNameController,
        labelText: 'Full Name',
        icon: Icons.person_outline,
      ),
      const SizedBox(height: 20),
      TextfieldWidget(
        controller: _emailController,
        labelText: 'E-mail',
        icon: Icons.email_outlined,
        keyboardType: TextInputType.emailAddress,
      ),
      const SizedBox(height: 20),
      TextfieldWidget(
        controller: _institusiController,
        labelText: 'Institusi',
        icon: Icons.business_outlined,
        keyboardType: TextInputType.text,
      ),
      const SizedBox(height: 20),
      TextfieldWidget(
        controller: _passwordController,
        labelText: 'Password',
        icon: Icons.lock_outline,
        obscureText: true,
        suffixIcon: Icons.visibility_off_outlined,
      ),
      const SizedBox(height: 20),
      TextfieldWidget(
        controller: _confirmPasswordController,
        labelText: 'Confirm Password',
        icon: Icons.lock_outline,
        obscureText: true,
        suffixIcon: Icons.visibility_off_outlined,
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          Checkbox(
            value: true,
            onChanged: (bool? value) {},
            activeColor: Colors.white,
            checkColor: Colors.deepPurple,
            side: BorderSide(color: Colors.white.withOpacity(0.8)),
          ),
          Expanded(
            child: Text(
              'By clicking signup you agree our Terms & Condition',
              style: TextStyle(color: Colors.white.withOpacity(0.8)),
            ),
          ),
        ],
      ),
    ];
  }
}
