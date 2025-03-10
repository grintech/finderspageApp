import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects/utils/routes.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 334,
          // height: 322,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
          
              Center(
                child: Image.asset("assets/images/new_logo.png", width: 50),
              ),

              const SizedBox(height: 12.79),

             
              Container(
                height: 43,
                width: double.infinity,
                decoration: const BoxDecoration(color: Color(0xFFA54DB7)),
                child: Center(
                  child: Text(
                    "Forgot Password",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 21),

              // Email Field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Email Label
                    Text(
                      "Email",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF000000),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Email Input Field
                    SizedBox(
                      width: double.infinity, 
                      height: 43,
                      child: TextField(
                        cursorColor: Color(0xFF616161),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter email",
                          hintStyle: GoogleFonts.montserrat(
                            fontSize: 13,
                            color: Color(0xFF616161),
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

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, MyRoutes.loginRoute);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'assets/images/back-btn.png',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "Back",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Submit Button
              Center(
                child: SizedBox(
                  width: 145,
                  height: 43,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: LinearGradient(
                        colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.3, 1.0], // 30% and 100%
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x40000000),
                          offset: Offset(0, 4), 
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            MyRoutes.resetPasswordRoute,
                          );
                        },
                        borderRadius: BorderRadius.circular(50),
                        child: Center(
                          child: Text(
                            "Submit",
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

              const SizedBox(height: 34),
            ],
          ),
        ),
      ),
    );
  }
}
