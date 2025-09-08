import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart'; // Adjust path if needed

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  // Validation flags
  bool hasUpper = false;
  bool hasLower = false;
  bool hasDigit = false;
  bool hasSymbol = false;
  bool hasMinLength = false;
  bool hasValidEmail = false;

  final RegExp _emailReg = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() => _validateEmail(_emailController.text));
    _passwordController.addListener(() => _checkPassword(_passwordController.text));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateEmail(String value) {
    setState(() {
      hasValidEmail = _emailReg.hasMatch(value.trim());
    });
  }

  void _checkPassword(String value) {
    setState(() {
      hasUpper = value.contains(RegExp(r'[A-Z]'));
      hasLower = value.contains(RegExp(r'[a-z]'));
      hasDigit = value.contains(RegExp(r'[0-9]'));
      hasSymbol = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      hasMinLength = value.length >= 8;
    });
  }

  bool get _isPasswordValid =>
      hasUpper && hasLower && hasDigit && hasSymbol && hasMinLength;

  bool get _canSubmit => hasValidEmail && _isPasswordValid && !_isLoading;

  void _fillTestCredentials() {
    _emailController.text = 'test@example.com';
    _passwordController.text = 'Test@1234';
    _validateEmail(_emailController.text);
    _checkPassword(_passwordController.text);
  }

  void _submit() {
    if (!_canSubmit) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid credentials')),
      );
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(milliseconds: 900), () {
      setState(() => _isLoading = false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  Widget _buildRule(String text, bool ok) {
    return Row(
      children: [
        Icon(ok ? Icons.check_circle : Icons.close,
            size: 18, color: ok ? Colors.green : Colors.redAccent),
        const SizedBox(width: 8),
        Text(text,
            style: GoogleFonts.montserrat(
                fontSize: 13, color: ok ? Colors.green : Colors.redAccent)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff4facfe), Color(0xff00f2fe)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Welcome Back 👋',
                        style: GoogleFonts.montserrat(
                            fontSize: 24, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Text('Login to continue',
                        style: GoogleFonts.montserrat(
                            fontSize: 14, color: Colors.grey[700])),
                    const SizedBox(height: 22),

                    // Email
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined),
                        hintText: 'Email Address',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: _emailController.text.isEmpty
                            ? null
                            : Icon(
                          hasValidEmail ? Icons.check_circle : Icons.error,
                          color:
                          hasValidEmail ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                    if (_emailController.text.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            hasValidEmail ? 'Looks good' : 'Enter a valid email',
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color:
                                hasValidEmail ? Colors.green : Colors.red),
                          ),
                        ),
                      ),

                    const SizedBox(height: 12),

                    // Password
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      onChanged: _checkPassword,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () =>
                              setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Rules
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRule('At least 8 characters', hasMinLength),
                        _buildRule('One uppercase letter', hasUpper),
                        _buildRule('One lowercase letter', hasLower),
                        _buildRule('One numeric digit', hasDigit),
                        _buildRule('One special symbol', hasSymbol),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: InkWell(
                        onTap: _canSubmit ? _submit : null,
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: _canSubmit
                                ? const LinearGradient(
                              colors: [Color(0xff4facfe), Color(0xff00f2fe)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                                : null,
                            color: _canSubmit ? null : Colors.grey.shade400,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor:
                              AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                              : Text(
                            'Login',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextButton(
                      onPressed: _fillTestCredentials,
                      child: Text('Need test credentials? Tap here',
                          style: GoogleFonts.montserrat(
                              color: Colors.blueAccent, fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../Login/login_bloc.dart';
// import '../Login/login_event.dart';
// import '../Login/login_state.dart';
// import 'home.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocConsumer<LoginBloc, LoginState>(
//         listener: (context, state) {
//           if (!state.isLoading &&
//               state.isEmailValid &&
//               state.hasUpper &&
//               state.hasLower &&
//               state.hasDigit &&
//               state.hasSymbol &&
//               state.hasMinLength) {
//             Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (_) => const HomeScreen()));
//           }
//         },
//         builder: (context, state) {
//           return Stack(
//             children: [
//               Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Color(0xff4facfe), Color(0xff00f2fe)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//               ),
//               Center(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(24),
//                   child: Container(
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.9),
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: const [
//                         BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 12,
//                             offset: Offset(0, 6))
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           "Welcome Back 👋",
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.montserrat(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           "Login to continue",
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.montserrat(
//                             fontSize: 16,
//                             color: Colors.black54,
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         // Email
//                         TextField(
//                           onChanged: (value) => context
//                               .read<LoginBloc>()
//                               .add(EmailChanged(value)),
//                           decoration: InputDecoration(
//                             prefixIcon: const Icon(Icons.email_outlined),
//                             hintText: "Email Address",
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                             filled: true,
//                             fillColor: Colors.grey[100],
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         // Password
//                         BlocBuilder<LoginBloc, LoginState>(
//                           builder: (context, state) {
//                             bool obscure = true;
//                             return TextField(
//                               onChanged: (value) => context
//                                   .read<LoginBloc>()
//                                   .add(PasswordChanged(value)),
//                               obscureText: obscure,
//                               decoration: InputDecoration(
//                                 prefixIcon: const Icon(Icons.lock_outline),
//                                 hintText: "Password",
//                                 suffixIcon: IconButton(
//                                   icon: const Icon(Icons.visibility),
//                                   onPressed: () {},
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 filled: true,
//                                 fillColor: Colors.grey[100],
//                               ),
//                             );
//                           },
//                         ),
//                         const SizedBox(height: 16),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildRule(
//                                 "At least 8 characters", state.hasMinLength),
//                             _buildRule(
//                                 "One uppercase letter", state.hasUpper),
//                             _buildRule(
//                                 "One lowercase letter", state.hasLower),
//                             _buildRule("One number", state.hasDigit),
//                             _buildRule(
//                                 "One special symbol", state.hasSymbol),
//                           ],
//                         ),
//                         const SizedBox(height: 30),
//                         GestureDetector(
//                           onTap: state.isLoading
//                               ? null
//                               : () => context
//                               .read<LoginBloc>()
//                               .add(LoginSubmitted()),
//                           child: AnimatedContainer(
//                             duration: const Duration(milliseconds: 300),
//                             height: 50,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               gradient: !state.isLoading
//                                   ? const LinearGradient(
//                                 colors: [
//                                   Color(0xff4facfe),
//                                   Color(0xff00f2fe)
//                                 ],
//                               )
//                                   : null,
//                               color: state.isLoading ? Colors.grey : null,
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Colors.black26,
//                                     blurRadius: 8,
//                                     offset: Offset(0, 4))
//                               ],
//                             ),
//                             child: state.isLoading
//                                 ? const CircularProgressIndicator(
//                                 color: Colors.white)
//                                 : Text(
//                               "Login",
//                               style: GoogleFonts.montserrat(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         TextButton(
//                           onPressed: () => context
//                               .read<LoginBloc>()
//                               .add(FillTestCredentials()),
//                           child: const Text("Need test credentials? Tap here"),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildRule(String text, bool conditionMet) {
//     return Row(
//       children: [
//         Icon(
//           conditionMet ? Icons.check_circle : Icons.cancel,
//           size: 18,
//           color: conditionMet ? Colors.green : Colors.red,
//         ),
//         const SizedBox(width: 6),
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 13,
//             color: conditionMet ? Colors.green : Colors.red,
//           ),
//         ),
//       ],
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../Login/login_bloc.dart';
// import '../Login/login_event.dart';
// import '../Login/login_state.dart';
// import 'home.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//
//   bool hasUpper = false;
//   bool hasLower = false;
//   bool hasDigit = false;
//   bool hasSymbol = false;
//   bool hasMinLength = false;
//
//   void _checkPassword(String value) {
//     setState(() {
//       hasUpper = value.contains(RegExp(r'[A-Z]'));
//       hasLower = value.contains(RegExp(r'[a-z]'));
//       hasDigit = value.contains(RegExp(r'[0-9]'));
//       hasSymbol = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
//       hasMinLength = value.length >= 8;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: BlocConsumer<LoginBloc, LoginState>(
//             listener: (context, state) {
//               if (state is LoginSuccess) {
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (_) => const HomeScreen()));
//               } else if (state is LoginFailure) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text(state.message)),
//                 );
//               }
//             },
//             builder: (context, state) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const Text(
//                     "Welcome Back 👋",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   TextField(
//                     controller: _emailController,
//                     decoration: const InputDecoration(
//                       hintText: "Email Address",
//                       prefixIcon: Icon(Icons.email_outlined),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   TextField(
//                     controller: _passwordController,
//                     obscureText: _obscurePassword,
//                     onChanged: _checkPassword,
//                     decoration: InputDecoration(
//                       hintText: "Password",
//                       prefixIcon: const Icon(Icons.lock_outline),
//                       suffixIcon: IconButton(
//                         icon: Icon(_obscurePassword
//                             ? Icons.visibility_off
//                             : Icons.visibility),
//                         onPressed: () {
//                           setState(() {
//                             _obscurePassword = !_obscurePassword;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildRule("Min 8 chars", hasMinLength),
//                       _buildRule("Uppercase", hasUpper),
//                       _buildRule("Lowercase", hasLower),
//                       _buildRule("Number", hasDigit),
//                       _buildRule("Symbol", hasSymbol),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: state is LoginLoading
//                         ? null
//                         : () {
//                       context.read<LoginBloc>().add(
//                         LoginSubmitted(
//                           email: _emailController.text,
//                           password: _passwordController.text,
//                         ),
//                       );
//                     },
//                     child: state is LoginLoading
//                         ? const CircularProgressIndicator()
//                         : const Text("Login"),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRule(String text, bool valid) => Row(
//     children: [
//       Icon(valid ? Icons.check_circle : Icons.cancel,
//           color: valid ? Colors.green : Colors.red, size: 18),
//       const SizedBox(width: 6),
//       Text(text),
//     ],
//   );
// }
