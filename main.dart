import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up Form',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.grey,
        brightness: Brightness.dark,
      ),
      home: const SignUpForm(),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String fieldHint;
  final bool isName;
  final bool isEmail; // E-mail doğrulama için eklenen özellik
  final bool isPassword;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.fieldHint,
    this.isName = false,
    this.isEmail = false,
    this.isPassword = false,
    required this.controller,
  });

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'İsim boş olamaz';
    }
    return null;
  }

  // E-mail doğrulama işlevi
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-posta adresi boş olamaz';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Geçerli bir e-posta adresi giriniz';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre boş olamaz';
    }
    if (value.length < 6) {
      return 'Şifre 6 karakterden kısa olamaz';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: fieldHint,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 3),
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        validator: (value) {
          if (isName) {
            return _validateName(value);
          }else if (isEmail) {
            return _validateEmail(value); // E-posta doğrulaması
          }else if (isPassword) {
            return _validatePassword(value);  // Şifre doğrulaması
          }
          return null;  // Diğer alanlar için doğrulama yapmıyoruz
        }
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: Colors.grey,
        title: const Text('Kayıt Formu'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              CustomTextField(
                fieldHint: 'İsim',
                isName: true,
                controller: nameController,
              ),
              CustomTextField(
                fieldHint: 'E-posta',
                isEmail: true,
                controller: emailController,
              ),
              CustomTextField(
                fieldHint: 'Şifre',
                isPassword: true,
                controller: passwordController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // Tüm alanlar geçerliyse bu blok çalışır
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form başarıyla dolduruldu!')),
                    );
                  }
                },
                child: const Text('Kayıt ol'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
