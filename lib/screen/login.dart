import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  bool _isLoading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final email = emailController.text.trim();
        final password = passwordController.text.trim();

        // Sign in user
        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        final uid = userCredential.user?.uid;
        if (uid == null) throw FirebaseAuthException(code: 'NO_UID', message: 'UID is null');

        final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
        final doc = await docRef.get();

        Map<String, dynamic> userData;

        if (!doc.exists) {
          // For old users without Firestore document, create one
          userData = {
            'name': 'Anonymous',
            'email': email,
            'createdAt': FieldValue.serverTimestamp(),
          };
          await docRef.set(userData);
        } else {
          userData = doc.data() as Map<String, dynamic>;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Welcome, ${userData['name'] ?? 'User'}")),
        );

        Navigator.pushReplacementNamed(context, '/home', arguments: userData);
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: ${e.message}")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/img_2.png', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.3)),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Image.asset('assets/img.png', height: 100, width: 100),
                  const SizedBox(height: 20),
                  Text("Welcome Back!",
                      style: GoogleFonts.poppins(fontSize: 28, color: Colors.white)),
                  const SizedBox(height: 20),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    padding: const EdgeInsets.all(24),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12)],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildInputField("Email", Icons.email_outlined, false),
                          const SizedBox(height: 16),
                          _buildInputField("Password", Icons.lock_outline, true),
                          const SizedBox(height: 24),
                          _isLoading
                              ? const CircularProgressIndicator(color: Color(0xFF4059F1))
                              : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4059F1),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: _login,
                            child: Text("Login",
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: Colors.white)),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushReplacementNamed(context, 'register'),
                            child: Text("Don't have an account? Sign Up",
                                style:
                                GoogleFonts.poppins(color: Colors.grey[800])),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String hint, IconData icon, bool isPassword) {
    return TextFormField(
      controller: isPassword ? passwordController : emailController,
      obscureText: isPassword && _obscure,
      validator: (value) =>
      (value == null || value.isEmpty) ? 'Enter $hint' : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Colors.black),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off,
              color: Colors.black),
          onPressed: () => setState(() => _obscure = !_obscure),
        )
            : null,
        hintText: hint,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black, width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black, width: 1.2)),
      ),
    );
  }
}
