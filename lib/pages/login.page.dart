import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/pages/home.pgae.dart';
import 'package:recipe_app/services/prefrences.service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  late GlobalKey<FormState> fromKey;

  bool obsecureText = true;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    fromKey = GlobalKey<FormState>();
    super.initState();
  }

  void toggleObsecure() {
    obsecureText = !obsecureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: fromKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      label: Text('Email'),
                      suffixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'email is required';
                      }

                      if (!EmailValidator.validate(value)) {
                        return 'Not Valid Email';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                    obscureText: obsecureText,
                    controller: passwordController,
                    decoration: InputDecoration(
                        label: const Text('Password'),
                        suffixIcon: InkWell(
                          onTap: () => toggleObsecure(),
                          child: Icon(obsecureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'password is required';
                      }

                      if (value.length < 6) {
                        return 'password too short';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (fromKey.currentState?.validate() ?? false) {
                        await PrefrencesService.prefs?.setBool('isLogin', true);

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => HomePage()));
                      }
                    },
                    child: const Text('Login'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
