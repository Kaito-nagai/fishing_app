import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:fishing_app/widgets/bottom_nav.dart';
import 'package:fishing_app/widgets/list_item.dart'; // ← ListItem をインポート
import 'package:fishing_app/widgets/label_text_widget.dart';
import 'package:fishing_app/widgets/ad_banner.dart';



// グローバルスコープで Logger を初期化
final logger = Logger();

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;

            return ListView(
              children: [
                Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.1,
                  alignment: Alignment.center,
                  child: Text(
                    'レスポンシブデザインの基盤',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
class HomeInitialScreen extends StatelessWidget {
  const HomeInitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          width: screenWidth,
          height: screenHeight,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.black),
          child: Stack(
            children: [
              Positioned(
                left: screenWidth * 0.46,
                top: screenHeight * 0.88,
                child: SizedBox(
                  width: screenWidth * 0.23,
                  height: screenHeight * 0.04,
                  child: Stack(
                    children: [
                      Positioned(
                        left: screenWidth * 0.07,
                        top: screenHeight * 0.02,
                        child: Transform.rotate(
                          angle: 2.43,
                          child: Container(
                            width: screenWidth * 0.05,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 1,
                                  color: Color(0xFFFD473B),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: screenHeight * 0.010,
                        child: Container(
                          width: screenWidth * 0.23,
                          height: screenHeight * 0.012,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFD473B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.005,
                        top: 0,
                        child: SizedBox(
                          width: screenWidth * 0.22,
                          height: screenHeight * 0.05,
                          child: Text(
                            'タップで検索',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.035,
                              fontFamily: 'Noto Sans JP',
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), 
              Positioned(
                left: 0,
                top: screenHeight * 0.90,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: screenWidth,
                    height: screenHeight * 0.3,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD9D9D9),
                    ),
                  ),
                ),
              ),
AdBanner(
  positionTop: 0.71, // top の比率だけを指定
  onTap: () => logger.i('下部の広告クリック'), // onTap イベントを渡す
),


Positioned(
  left: screenWidth * 0.02,
  top: screenHeight * 0.340,
  child: SizedBox(
    width: screenWidth * 0.96,
    height: screenHeight * 0.45,
    child: Column(
      children: [
        ListItem(
          title: '浜丸渡船',
          location: '和歌山県すさみ町見老津',
          imagePath: 'assets/images/placeholder_image.png',
        ),
        SizedBox(height: screenHeight * 0.005), // リスト間の余白
        ListItem(
          title: '林渡船',
          location: '和歌山県すさみ町見老津',
          imagePath: 'assets/images/placeholder_image.png',
        ),
      ],
    ),
  ),
),

      LabelTextWidget(
        text: 'まだ未登録の状態です',
        fontSize: 0.040,
        positionTop: 238 / 812, 
        positionLeft: 0.02,
        width: 0.98,
        height: 0.035,
      ),
      LabelTextWidget(
        text: 'マイリストに業者を登録しよう',
        fontSize: 0.06,
        positionTop: 200 / 812,
        positionLeft: 0.02,
        width: 1.5,
        height: 0.05,
      ),

AdBanner(
  positionTop: 0.090,
  onTap: () => logger.i('上部の広告クリック'),
),

      Positioned(
        left: screenWidth * 0.48,
        top: screenHeight * -0.045,
        child: Container(
          width: screenWidth * 0.25,
          height: screenHeight * 0.12,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(),
                ),
              ),
              const BottomNav(), 
            ],
          ),
        ),
      ],
    );
  }
}
