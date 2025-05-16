import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  // Controllers
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/img_2.png',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.3)),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 30,
                        offset: Offset(0, 10),
                      )
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Hero(
                          tag: 'title',
                          child: Text(
                            "Create Account",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        _buildTextField("Full Name", Icons.person_outline, controller: fullNameController),
                        const SizedBox(height: 20),
                        _buildTextField("Email", Icons.email_outlined, controller: emailController),
                        const SizedBox(height: 20),
                        _buildTextField("Password", Icons.lock_outline, controller: passwordController, isPassword: true),
                        const SizedBox(height: 30),
                        Hero(
                          tag: 'button',
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4059F1),
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 8,
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final name = fullNameController.text.trim();
                                  final email = emailController.text.trim();
                                  final password = passwordController.text.trim();

                                  // Create user in Firebase Auth
                                  UserCredential userCredential = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(email: email, password: password);

                                  // Save to Firestore
                                  await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
                                    'uid': userCredential.user!.uid,
                                    'email': email,
                                    'name': name,
                                    'createdAt': FieldValue.serverTimestamp(),
                                  });


                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Account created successfully! Redirecting to login..."),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.green,
                                    ),
                                  );

                                  await Future.delayed(const Duration(seconds: 2));
                                  Navigator.pushReplacementNamed(context, '/');
                                } on FirebaseAuthException catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.message ?? "Error")),
                                  );
                                }
                              }
                            },
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(context, '/'),
                          child: Text(
                            "Already have an account? Sign In",
                            style: GoogleFonts.poppins(
                              color: Colors.grey[800],
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon,
      {bool isPassword = false, TextEditingController? controller}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && _obscurePassword,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Colors.black),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        )
            : null,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black, width: 1.2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Enter $hint';
        return null;
      },
    );
  }
}
/*await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
'uid': userCredential.user!.uid,
'email': email,
'name': name,
'createdAt': FieldValue.serverTimestamp(),
});*/
