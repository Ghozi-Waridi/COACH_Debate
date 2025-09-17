import 'dart:math';
import 'dart:ui';

import 'package:choach_debate/core/router/app_router_enum.dart';
import 'package:choach_debate/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:choach_debate/features/Auth/presentation/widgets/auth_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class AuthPages extends StatefulWidget {
  const AuthPages({super.key});

  @override
  State<AuthPages> createState() => _AuthPagesState();
}

class _AuthPagesState extends State<AuthPages> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _usernameController;
  late TextEditingController _institusiController;
  bool _isLogin = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _usernameController = TextEditingController();
    _institusiController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    _institusiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            setState(() => _isLoading = true);
          } else {
            setState(() => _isLoading = false);
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is Authenticated) {
            print(AppRouterEnum.homeScreen.path);
            context.goNamed(AppRouterEnum.homeScreen.name);

            print(
              "User authenticated: ${state.user.email} sudah berhasil tinggal navigasi",
            );
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.6)),
            ),

            /// Konten utama
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LiquidGlass(
                    shape: LiquidRoundedSuperellipse(
                      borderRadius: Radius.circular(50.0),
                    ),
                    settings: LiquidGlassSettings(
                      thickness: 12,
                      lightAngle: 0.5 * pi,
                      blend: 60,
                      chromaticAberration: 1.2,
                      lightIntensity: 1.2,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _isLogin ? 'Log in' : 'Sign up',
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _isLogin
                                    ? 'Now no more worries about get lost.'
                                    : 'No more worries about get lost.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                              const SizedBox(height: 30),

                              if (_isLogin)
                                ...AuthWidget().buildLoginFields(
                                  _emailController,
                                  _passwordController,
                                ),
                              if (!_isLogin)
                                ...AuthWidget().buildSignUpFields(
                                  _usernameController,
                                  _emailController,
                                  _passwordController,
                                  _confirmPasswordController,
                                  _institusiController,
                                ),
                              const SizedBox(height: 10),

                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  if (_isLogin) {
                                    if (_emailController.text.isEmpty ||
                                        _passwordController.text.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Email dan password harus diisi',
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    context.read<AuthBloc>().add(
                                      LoginButtonPressed(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                                  } else {
                                    // Validasi signup
                                    if (_usernameController.text.isEmpty ||
                                        _emailController.text.isEmpty ||
                                        _passwordController.text.isEmpty ||
                                        _confirmPasswordController
                                            .text
                                            .isEmpty ||
                                        _institusiController.text.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Semua field harus diisi',
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    if (_passwordController.text !=
                                        _confirmPasswordController.text) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Password dan konfirmasi password tidak sama',
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    context.read<AuthBloc>().add(
                                      SingUpButtonPressed(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        user: {
                                          "username": _usernameController.text,
                                          "institusi":
                                              _institusiController.text,
                                        },
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurpleAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                  ),
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                child: Text(
                                  _isLogin ? 'Log in' : 'Sign up',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _isLogin
                                        ? "I don't have an account?"
                                        : "I already have an account?",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _isLogin = !_isLogin;
                                      });
                                    },
                                    child: Text(
                                      _isLogin ? 'Sign up' : 'Log in',
                                      style: const TextStyle(
                                        color: Colors.deepPurpleAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
