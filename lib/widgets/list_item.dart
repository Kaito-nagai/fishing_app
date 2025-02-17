import 'package:flutter/material.dart';
import 'package:fishing_app/screens/my_list_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:logger/logger.dart'; // 🔹 追加

class ListItem extends StatefulWidget {
  final String title;
  final String location;
  final String imagePath;
  final bool isFavorite;
  final VoidCallback? onFavoritePressed;
  final bool navigateToMyListScreen;
  final String catchInfoUrl;

  const ListItem({
    super.key,
    required this.title,
    required this.location,
    required this.imagePath,
    required this.isFavorite,
    this.onFavoritePressed,
    this.navigateToMyListScreen = false,
    required this.catchInfoUrl,
  });

  @override
  ListItemState createState() => ListItemState();
}

class ListItemState extends State<ListItem> {
  late bool _isFavorite;
  final Logger _logger = Logger(); // 🔹 追加

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
    _logger.d('ListItem initState: navigateToMyListScreen = ${widget.navigateToMyListScreen}'); // 🔹 ログ追加
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    if (widget.onFavoritePressed != null) {
      widget.onFavoritePressed!();
    }

    _logger.d('ListItem _toggleFavorite: navigateToMyListScreen = ${widget.navigateToMyListScreen}'); // 🔹 ログ追加

    if (widget.navigateToMyListScreen == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyListScreen()),
      );
    }
  }

  void _launchCatchInfo() async {
    final Uri url = Uri.parse(widget.catchInfoUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'このURLを開けません: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    _logger.d('ListItem build: navigateToMyListScreen = ${widget.navigateToMyListScreen}'); // 🔹 ログ追加
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: _launchCatchInfo,
      child: SizedBox(
        width: double.infinity,
        height: screenHeight * 0.07,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: screenHeight * 0.07,
              decoration: BoxDecoration(
                color: const Color(0xFF2E2E2E),
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(64, 0, 0, 0),
                    offset: Offset(4, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            Positioned(
              left: screenWidth * 0.87,
              top: screenHeight * 0.011,
              child: IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : Colors.grey,
                  size: screenWidth * 0.053,
                ),
                onPressed: _toggleFavorite,
              ),
            ),
            Positioned(
              left: screenWidth * 0.332,
              top: screenHeight * 0.036,
              child: Opacity(
                opacity: 0.50,
                child: Text(
                  widget.location,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.034,
                    fontFamily: 'Noto Sans JP',
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.295,
              top: screenHeight * 0.039,
              child: Icon(
                Icons.location_pin,
                size: screenWidth * 0.035,
                color: const Color(0xFF777777),
              ),
            ),
            Positioned(
              left: screenWidth * 0.30,
              top: screenHeight * 0.008,
              child: SizedBox(
                width: screenWidth * 0.3,
                height: screenHeight * 0.06,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.045,
                    fontFamily: 'Noto Sans JP',
                    fontWeight: FontWeight.w900,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: screenWidth * 0.25,
                height: screenHeight * 0.07,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
