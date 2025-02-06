import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildHeader(),
          _buildRecommendationSection(),
          _buildAdArea(),
          _buildSearchBar(),
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 54,
      left: 23,
      child: Text(
        'おすすめの渡船や遊漁船',
        style: TextStyle(
          color: Colors.white,
          fontSize: 27,
          fontFamily: 'Noto Sans JP',
          fontWeight: FontWeight.w700,
          letterSpacing: 0.9,
        ),
      ),
    );
  }

  Widget _buildRecommendationSection() {
    return Positioned(
      top: 278,
      left: 8,
      child: Container(
        width: 377,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[850],
        ),
        child: Row(
          children: [
            _buildThumbnail(),
            SizedBox(width: 10),
            _buildVendorDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return Container(
      width: 95,
      height: 56,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: NetworkImage("https://via.placeholder.com/95x56"),
          fit: BoxFit.cover,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }

  Widget _buildVendorDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '浜丸渡船',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '和歌山県すさみ町見老津',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildAdArea() {
    return Positioned(
      top: 107,
      left: 17,
      child: Container(
        width: 360,
        height: 111,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(153), // 0.6 * 255 = 153
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            '広告エリア',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Positioned(
      top: 54,
      left: 23,
      child: Container(
        width: 315,
        height: 32,
        decoration: BoxDecoration(
          color: Color(0xFF424242),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '業者名、場所などで検索',
              style: TextStyle(
                color: Colors.white.withAlpha(153), // 0.6 * 255 = 153
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Positioned(
      bottom: 20,
      left: 29,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem('ホーム', Icons.home, true),
          _buildNavItem('検索', Icons.search, false),
          _buildNavItem('マイリスト', Icons.favorite, false),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, IconData icon, bool isActive) {
    return Column(
      children: [
        Icon(
          icon,
          color: isActive ? Colors.white : Colors.grey,
        ),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
