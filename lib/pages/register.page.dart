import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/provider/app_auth.provider.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/utils/images.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false).providerInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImagesPath.background),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.black38),
          ),
          Consumer<AppAuthProvider>(
            builder: (context, authProvider, _) => Form(
              key: authProvider.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 50, right: 50, top: 50, bottom: 25),
                    child: Image.asset(ImagesPath.baseHeader),
                  ),
                  Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: authProvider.emailController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        fillColor: Colors.transparent,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: 'email',
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: authProvider.passwordController,
                    obscureText: authProvider.obsecureText,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        fillColor: Colors.transparent,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: 'password',
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.white,
                        ),
                        suffixIcon: InkWell(
                          onTap: () => authProvider.toggleObsecure(),
                          child: authProvider.obsecureText
                              ? Icon(
                                  Icons.visibility_off,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                ),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: authProvider.nameController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        fillColor: Colors.transparent,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: 'name',
                        prefixIcon: Icon(
                          Icons.document_scanner,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(400, 50),
                          backgroundColor: Color(ColorsConst.mainColor)),
                      onPressed: () {
                        authProvider.signUp(context);
                      },
                      child: Text('register',
                          style: TextStyle(color: Colors.white))),
                  Spacer(
                    flex: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
