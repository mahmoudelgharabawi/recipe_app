import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/pages/home.pgae.dart';
import 'package:recipe_app/services/prefrences.service.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/utils/images.dart';

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
          Column(
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
                decoration: InputDecoration(
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
                decoration: const InputDecoration(
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
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(400, 50),
                      backgroundColor: Color(ColorsConst.mainColor)),
                  onPressed: () {},
                  child:
                      Text('register', style: TextStyle(color: Colors.white))),
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
        ],
      ),
    );
  }
}
