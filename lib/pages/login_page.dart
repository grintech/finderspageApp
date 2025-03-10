import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool buttonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/login_image.png", fit: BoxFit.contain),
            SizedBox(height: 20),
            Text(
              "Welcome $name",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter Username",
                      labelText: "Username",
                    ),
                    onChanged: (value) {
                      name = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      labelText: "Password",
                    ),
                  ),
                  SizedBox(height: 30),

                  InkWell(
                    onTap: () async {
                      setState(() {
                        buttonClicked = true;
                      });

                      final navigator = Navigator.of(
                        context,
                      ); 
                      await Future.delayed(Duration(seconds: 2));
                      navigator.pushNamed("/home"); 
                    },
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      height: 45,
                      width: buttonClicked ? 50 : 120,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(
                          buttonClicked ? 50 : 8,
                        ),
                      ),
                      alignment: Alignment.center,
                      child:
                          buttonClicked
                              ? Icon(Icons.done, color: Colors.white)
                              : Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                    ),
                  ),

                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, "/home");
                  //   },
                  //   style: TextButton.styleFrom(minimumSize: Size(120, 45)),
                  //   child: Text("Login"),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
