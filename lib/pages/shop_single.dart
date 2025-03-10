import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Imported this for redirection
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:carousel_slider/carousel_slider.dart';

class ShopSingle extends StatefulWidget {
  const ShopSingle({super.key});
  @override
  State<ShopSingle> createState() => _ShopSingleState();
}

class _ShopSingleState extends State<ShopSingle> {
  int quantity = 1;
  String selectedSize = "L";

  int _currentIndex = 0;

  final List<String> productImages = [
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Shop Now",
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
          padding: EdgeInsets.only(left: 24),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 244,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items:
                        productImages.map((imagePath) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              imagePath,
                              width: double.infinity,
                              height: 244,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                  ),

                  // Custom Dots Indicator (Inside Image)
                  Positioned(
                    bottom: 10, 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          productImages.asMap().entries.map((entry) {
                            int index = entry.key;
                            return Container(
                              width: _currentIndex == index ? 25 : 25,
                              height: 10.0,
                              margin: EdgeInsets.symmetric(horizontal: 3.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:
                                    _currentIndex == index
                                        ? Color.fromARGB(255, 233, 121, 42)
                                        : const Color.fromARGB(255, 0, 0, 0),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),

              // ClipRRect(
              //   borderRadius: BorderRadius.circular(10),
              //   child: Image.asset(
              //     'assets/images/product1.png',
              //     width: double.infinity,
              //     height: 244,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              SizedBox(height: 10),
              Text(
                "Polar Bear Penguin Outdoor Decoration",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price:",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "\$5.60",
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xAADC7228),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 54),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Size:",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildSizeOption("S"),
                          _buildSizeOption("M"),
                          _buildSizeOption("L"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x14000000), 
                      offset: Offset(0, 2), 
                      blurRadius: 6,
                      spreadRadius: 0, 
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                        15,
                      ), 
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                height: 1.62,
                                color:
                                    Colors
                                        .black, 
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      "Make sure you are ready to illuminate the holiday festive season by purchasing our 6-ft Christmas Inflatable Polar Bear Penguin Outdoor Decoration! This cute and attractive backyard decor that blows up is designed to help make your home sparkle throughout the ",
                                ),
                                TextSpan(
                                  text: "festive season",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.black,
                                    color: Colors.black,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          launchUrl(
                                            Uri.parse(
                                              "https://www.finderspage.com",
                                            ),
                                          );
                                        },
                                ),
                                TextSpan(
                                  text:
                                      ". Your home can become the ultimate holiday spot by putting up our 6-ft Christmas Inflatable Polar Bear Penguin Outdoor Decor.",
                                ),
                              ],
                            ),
                          ),

                       
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 122,
                          height: 43,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.black,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (quantity > 1) quantity--;
                                  });
                                },
                                child: Icon(Icons.remove, color: Colors.white),
                              ),
                              SizedBox(width: 10),
                              Text(
                                quantity.toString(),
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                child: Icon(Icons.add, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 167,
                          height: 43,
                          child: Material(
                            borderRadius: BorderRadius.circular(50),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFDC7228),
                                    Color(0xFFA54DB7),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {},
                                child: Center(
                                  child: Text(
                                    "Buy Now",
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // bottomNavbar
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBottomNavItem('assets/images/home-icon.png', 'Home', '/home'),
            _buildBottomNavItem(
              'assets/images/calendar-icon.png',
              'Calendar',
              '',
            ),
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
                onPressed: () {},
              ),
            ),
            _buildBottomNavItem(
              'assets/images/newpost-icon.png',
              'Create List',
              '',
            ),
            _buildBottomNavItem(
              'assets/images/profile-icon.png',
              'Profile',
              '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeOption(String size) {
    bool isSelected = selectedSize == size;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },
      child: Center(
        child: Container(
          height: 19,
          width: 26,
          margin: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFFA54DB7) : Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text(
            size,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(String iconPath, String label, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconPath, color: Colors.black, height: 20, width: 20),
          SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.black)),
        ],
      ),
    );
  }
}
