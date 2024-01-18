import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/pages/register.page.dart';
import 'package:recipe_app/provider/app_auth.provider.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/utils/images.dart';
import 'package:recipe_app/widgets/widget_scrollable.widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              child: WidgetScrollable(
                isColumn: true,
                columnMainAxisAlignment: MainAxisAlignment.center,
                widgets: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 50, right: 50, top: 50, bottom: 25),
                    child: Image.asset(ImagesPath.baseHeader),
                  ),
                  Text(
                    'Login',
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
                    validator: (value) {
                      if (value == null || (value?.isEmpty ?? false)) {
                        return 'Email Is Required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    obscureText: authProvider.obsecureText,
                    style: TextStyle(color: Colors.white),
                    controller: authProvider.passwordController,
                    decoration: InputDecoration(
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
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        fillColor: Colors.transparent,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: 'password',
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.white,
                        )),
                    validator: (value) {
                      if (value == null || (value?.isEmpty ?? false)) {
                        return 'Password Is Required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(400, 50),
                          backgroundColor: Color(ColorsConst.mainColor)),
                      onPressed: () => authProvider.logIn(context),
                      child:
                          Text('Login', style: TextStyle(color: Colors.white))),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
          if (MediaQuery.of(context).viewInsets.bottom == 0)
            Positioned.fill(
              bottom: 10,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RegisterPage()));
                        },
                        child: const Text(
                          'Not Have Account , Register Now ?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
