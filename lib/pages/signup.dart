import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects/utils/routes.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  // Custom TextField widget
  Widget customTextField({
    required String labelText,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF000000),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: 43,
          child: TextField(
            cursorColor: const Color(0xFF616161),
            style: const TextStyle(color: Colors.black, fontSize: 13),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.montserrat(
                fontSize: 13,
                color: const Color(0xFF616161),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color(0xFFDC7228),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color(0xFFDC7228),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color(0xFFDC7228),
                  width: 1,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 10,
              ),
            ),
          ),
        ),
        const SizedBox(height: 13),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 334,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 22),
              // Logo
              Center(
                child: Image.asset("assets/images/new_logo.png", width: 50),
              ),

              const SizedBox(height: 16.79),

              // Sign up Title
              Container(
                height: 43,
                width: double.infinity,
                decoration: const BoxDecoration(color: Color(0xFFA54DB7)),
                child: Center(
                  child: Text(
                    "Sign up",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Inside the build method

              // Use customTextField for all inputs with added padding
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: customTextField(
                  labelText: "Name",
                  hintText: "Enter name",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: customTextField(
                  labelText: "Email",
                  hintText: "Enter email",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: customTextField(
                  labelText: "Password",
                  hintText: "Enter password",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: customTextField(
                  labelText: "Confirm Password",
                  hintText: "Enter password",
                ),
              ),

              const SizedBox(height: 24),

              // Signup Button
              Center(
                child: SizedBox(
                  width: 145,
                  height: 43,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFDC7228),
                          const Color(0xFFA54DB7),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.3, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x40000000),
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            MyRoutes.loginRoute,
                          );
                        },
                        borderRadius: BorderRadius.circular(50),
                        child: Center(
                          child: Text(
                            "Sign up",
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // Signup Link
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Already have an account?",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.loginRoute);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(4),
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "Login",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // "Or" Text
              Center(
                child: Text(
                  "Or",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 9),

              Center(
                child: Text(
                  "Login with",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 21),

              // Social Login Buttons
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: SizedBox(
                        width: 32,
                        height: 32,
                        child: Image.asset("assets/images/facebook-icon.png"),
                      ),
                      iconSize: 32,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: SizedBox(
                        width: 32,
                        height: 32,
                        child: Image.asset("assets/images/google-icon.png"),
                      ),
                      iconSize: 32,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 21),
            ],
          ),
        ),
      ),
    );
  }
}
