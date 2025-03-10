import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects/utils/routes.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/arrow.png',
              width: 25,
              height: 25,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 15),
          child: Column(
            children: [
              const SizedBox(height: 23),
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 48.5,
                      backgroundImage: AssetImage(
                        'assets/images/profile-pic.png',
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                          ),
                        ),
                        child: Image.asset(
                          "assets/images/photo-icon.png",
                          height: 10.27,
                          width: 10.27,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Form Fields
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInputField("Name"),
                  buildInputField("User Name"),
                  buildInputField("Email"),
                  buildInputField("Phone"),
                  buildInputField("Bio", maxLines: 1),

                  const SizedBox(height: 35),

                  // Save & Continue Button
                  Center(
                    child: SizedBox(
                      // width: double.infinity,
                      height: 43,
                      width: 194,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFDC7228),
                              Color(0xFFA54DB7),
                            ], // Gradient Colors
                            stops: [0.3, 100],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(
                                0x40000000,
                              ), // #00000040 (Opacity 25%)
                              offset: Offset(0, 4), // Shadow position
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.transparent, // Make button transparent
                            shadowColor: Colors.transparent, // Remove shadow
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            "Save & Continue",
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ), // Optional border
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Home
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, MyRoutes.homeRoute);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/home-icon.png',
                    color: Colors.black,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(height: 4), // Space between icon and text
                  Text(
                    "Home",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ),

            // Calendar
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/events',
                ); // Navigate to Calendar Screen
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/calendar-icon.png',
                    color: Colors.black,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Calendar",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ),

            // Center Floating Button
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: IconButton(
                icon: Icon(Icons.add, size: 35, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/create');
                },
              ),
            ),

            // Create List
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/create-list',
                ); // Navigate to Create List Screen
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/newpost-icon.png',
                    color: Colors.black,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Create List",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ),

            // Profile
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/profile',
                ); // Navigate to Profile Screen
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/profile-icon.png',
                    color: Colors.black,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Profile",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Function to build **Floating Label Input Field with Bottom Border**
  Widget buildInputField(String label, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: GoogleFonts.montserrat(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFEBEBEB),
                width: 1,
              ), // **Bottom Border**
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFDC7228),
                width: 1.5,
              ), // **Highlighted Bottom Border**
            ),
          ),
        ),
        const SizedBox(height: 2),
      ],
    );
  }
}
