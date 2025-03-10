import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  
  String activeCategory = "Beauty, Health & Personal Care";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            "Shop Now",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 24),
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/images/filter.png',
                width: 25,
                height: 25,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          _buildCategoryChip("Beauty, Health & Personal Care"),
                          _buildCategoryChip("Books"),
                          _buildCategoryChip("Clothing, Shoes, Accessories"),
                          _buildViewAllChip(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 23),
            Expanded(
              child: ListView(
                children: [
                  _buildProductItem(
                    "Polar Bear Penguin Outdoor Decoration",
                    "Chicago",
                    "Mar 03 2025",
                    "\$5.60",
                    "assets/images/image1.png",
                  ),
                  _buildProductItem(
                    "Black Gem Square Necklace",
                    "Chicago",
                    "Mar 03 2025",
                    "\$11.63",
                    "assets/images/image2.png",
                  ),
                  _buildProductItem(
                    "12pcs Gingerbread Man Ornaments",
                    "Chicago",
                    "Mar 03 2025",
                    "\$9.16",
                    "assets/images/image3.png",
                  ),
                ],
              ),
            ),
          ],
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

  // Category Chip Widget with Click Event
  Widget _buildCategoryChip(String label) {
    bool isSelected = label == activeCategory;

    return GestureDetector(
      onTap: () {
        setState(() {
          activeCategory = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient:
              isSelected
                  ? LinearGradient(
                    colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.4, 1.0], // 30% and 100%
                  )
                  : null,
          color: isSelected ? null : Colors.grey[200],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildViewAllChip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "View All",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Icon(Icons.chevron_right, size: 18, color: Colors.black),
        ],
      ),
    );
  }

  // Product Item Widget
  Widget _buildProductItem(
    String title,
    String location,
    String date,
    String price,
    String imagePath,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/shop/single');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 6,
              spreadRadius: 0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(5),
                right: Radius.circular(5),
              ),
              child: Image.asset(
                imagePath,
                width: 146,
                height: 117,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Colors.black,
                      ),
                      SizedBox(width: 4),
                      Text(location, style: _textStyle()),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 14,
                        color: Colors.black,
                      ),
                      SizedBox(width: 4),
                      Text(date, style: _textStyle()),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xAADC7228),
                    ),
                  ),
                ],
              ),
            ),
          ],
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

  TextStyle _textStyle() => TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
}
