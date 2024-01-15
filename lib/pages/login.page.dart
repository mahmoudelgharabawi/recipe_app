import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_app/pages/home.pgae.dart';
import 'package:recipe_app/pages/register.page.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/utils/images.dart';
import 'package:recipe_app/widgets/widget_scrollable.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formkey;
  bool obsecureText = true;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formkey = GlobalKey<FormState>();
  }

  void toggleObsecure() {
    obsecureText = !obsecureText;
    setState(() {});
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
          Form(
            key: formkey,
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
                  controller: emailController,
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
                    if (value != null || (value?.isEmpty ?? false)) {
                      return 'Email Is Required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: obsecureText,
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
                      hintText: 'password',
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.white,
                      )),
                  validator: (value) {
                    if (value != null || (value?.isEmpty ?? false)) {
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
                    onPressed: () {
                      if (!(formkey.currentState?.validate() ?? false)) {
                        GetIt.I
                            .get<SharedPreferences>()
                            .setBool('isLogin', true);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomePage()));
                      }
                    },
                    child:
                        Text('Login', style: TextStyle(color: Colors.white))),
                const SizedBox(
                  height: 15,
                ),
              ],
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
