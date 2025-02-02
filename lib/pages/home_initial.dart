import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:fishing_app/widgets/ad_placeholder.dart';

// グローバルスコープで Logger を初期化
final logger = Logger();

void main() {
  runApp(const FigmaToCodeApp());
}

// Generated by: https://www.figma.com/community/plugin/842128343887142055/
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
              Positioned(
                left: screenWidth * 0.07,
                top: screenHeight * 0.905,
                child: SizedBox(
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.08,
                  child: Stack(
                    children: [
                      Positioned(
                        left: screenWidth * 0.67,
                        top: 0,
                        child: SizedBox(
                          width: screenWidth * 0.18,
                          height: screenHeight * 0.08,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: screenHeight * 0.037,
                                child: SizedBox(
                                  width: screenWidth * 0.18,
                                  height: screenHeight * 0.07,
                                  child: Text(
                                    'マイリスト',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xFF777777),
                                      fontSize: screenWidth * 0.035,
                                      fontFamily: 'Noto Sans JP',
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: screenWidth * 0.055,
                                top: screenHeight * 0.002,
                                child: Icon(
                                  Icons.favorite,
                                  size: screenWidth * 0.07,
                                  color: const Color(0xFF777777),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        left: screenWidth * 0.35,
                        top: 0,
                        child: SizedBox(
                          width: screenWidth * 0.12,
                          height: screenHeight * 0.07,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: screenHeight * 0.037,
                                child: SizedBox(
                                  width: screenWidth * 0.12,
                                  height: screenHeight * 0.05,
                                  child: Text(
                                    '検索',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xFF777777),
                                      fontSize: screenWidth * 0.035,
                                      fontFamily: 'Noto Sans JP',
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: screenWidth * 0.03,
                                top: screenHeight * 0.002,
                                child: Icon(
                                  Icons.search,
                                  size: screenWidth * 0.07,
                                  color: const Color(0xFF777777),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        top: 0,
                        child: SizedBox(
                          width: screenWidth * 0.15,
                          height: screenHeight * 0.08,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 5,
                                top: screenHeight * 0.037,
                                child: SizedBox(
                                  width: screenWidth * 0.12,
                                  height: screenHeight * 0.08,
                                  child: Text(
                                    'ホーム',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.035,
                                      fontFamily: 'Noto Sans JP',
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: screenWidth * 0.035,
                                top: screenHeight * 0.002,
                                child: Icon(
                                  Icons.home,
                                  size: screenWidth * 0.07,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              Positioned(
                left: screenWidth * 0.04,
                top: screenHeight * 0.71,
                child: GestureDetector(
                  onTap: () {
                    logger.i('画面下部の広告がクリックされました');
                  },
                  child: AdPlaceholder(
                    adContent: null,
                    showPlaceholder: true,
                    width: screenWidth * 0.92,
                    height: screenHeight * 0.13,
                  ),
                ),
              ),

              Positioned(
                left: screenWidth * 0.02,
                top: screenHeight * 0.365,
                child: SizedBox(
                  width: screenWidth * 0.96,
                  height: screenHeight * 0.45,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: screenHeight * 0.074,
                        child: SizedBox(
                          width: screenWidth * 0.96,
                          height: screenHeight * 0.07,
                          child: Stack(
                            children: [
                              // フレームを最背面に追加
                              Container(
                                width: screenWidth * 0.96,
                                height: screenHeight * 0.07,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2E2E2E),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(64, 0, 0, 0),
                                      offset: const Offset(4, 4),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                              // 業者リストの要素を配置
                              Positioned(
                                left: screenWidth * 0.87,
                                top: screenHeight * 0.015,
                                child: SizedBox(
                                  width: screenWidth * 0.04,
                                  height: screenHeight * 0.04,
                                  child: Icon(
                                    Icons.favorite,
                                    size: screenWidth * 0.053,
                                    color: const Color(0xFFD8D8D8),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: screenWidth * 0.34,
                                top: screenHeight * 0.040,
                                child: SizedBox(
                                  width: screenWidth * 0.45,
                                  height: screenHeight * 0.04,
                                  child: Opacity(
                                    opacity: 0.50,
                                    child: Text(
                                      '和歌山県すさみ町見老津',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.037,
                                        fontFamily: 'Noto Sans JP',
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: screenWidth * 0.295,
                                top: screenHeight * 0.043,
                                child: SizedBox(
                                  width: screenWidth * 0.02,
                                  height: screenHeight * 0.01,
                                  child: Icon(
                                    Icons.location_pin,
                                    size: screenWidth * 0.04,
                                    color: const Color(0xFF777777),
                                  ),
                                ),
                              ),

              Positioned(
                left: screenWidth * 0.30,
                top: screenHeight * 0.008,
                child: SizedBox(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.06,
                  child: Text(
                    '林渡船',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.047,
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
                    image: const DecorationImage(
                      image: AssetImage("assets/images/placeholder_image.png"),
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
      ),
      Positioned(
        left: 0,
        top: 0,
        child: Container(
          width: screenWidth * 0.96,
          height: screenHeight * 0.07,
          decoration: BoxDecoration(
            color: const Color(0xFF2E2E2E),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              const BoxShadow(
                color: Color.fromARGB(64, 0, 0, 0),
                offset: Offset(4, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: screenWidth * 0.87,
                top: screenHeight * 0.015,
                child: SizedBox(
                  width: screenWidth * 0.04,
                  height: screenHeight * 0.04,
                  child: Icon(
                    Icons.favorite,
                    size: screenWidth * 0.053,
                    color: const Color(0xFFD8D8D8),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.34,
                top: screenHeight * 0.040,
                child: SizedBox(
                  width: screenWidth * 0.45,
                  height: screenHeight * 0.04,
                  child: Opacity(
                    opacity: 0.50,
                    child: Text(
                      '和歌山県すさみ町見老津',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.037,
                        fontFamily: 'Noto Sans JP',
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.295,
                top: screenHeight * 0.043,
                child: SizedBox(
                  width: screenWidth * 0.02,
                  height: screenHeight * 0.01,
                  child: Icon(
                    Icons.location_pin,
                    size: screenWidth * 0.04,
                    color: const Color(0xFF777777),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.30,
                top: screenHeight * 0.008,
                child: SizedBox(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.06,
                  child: Text(
                    '浜丸渡船',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.047,
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
                    image: const DecorationImage(
                      image: AssetImage("assets/images/placeholder_image.png"),
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
      ),
     ],
    ),
   ),
  ),

      Positioned(
        left: screenWidth * 0.015,
        top: screenHeight * (265 / 812), // Y = 265px を画面の高さに比例させる
        child: SizedBox(
          width: screenWidth * 0.98,
          height: screenHeight * 0.035,
          child: Text(
            '現在は未登録の状態です',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.038,
              fontFamily: 'Noto Sans JP',
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ), 
      Positioned(
        left: screenWidth * 0.02,
        top: screenHeight * (238 / 812), // Y = 240px を画面の高さに比例させる
        child: SizedBox(
          width: screenWidth * 0.98,
          height: screenHeight * 0.035,
          child: Text(
            '🔍をタップして自分だけのリストを作成しよう',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.04,
              fontFamily: 'Noto Sans JP',
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
      Positioned(
        left: screenWidth * 0.02,
        top: screenHeight * (200 / 812), // Y = 200px を画面の高さに比例させる
        child: SizedBox(
          width: screenWidth * 0.65,
          height: screenHeight * 0.05,
          child: Text(
            'マイリスト',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.07,
              fontFamily: 'Noto Sans JP',
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
      Positioned(
        left: screenWidth * 0.04,
        top: screenHeight * 0.090,
        child: GestureDetector(
          onTap: () {
            logger.i('広告がクリックされました');
          },
          child: AdPlaceholder(
            adContent: null,
            showPlaceholder: true,
            width: screenWidth * 0.92,
            height: screenHeight * 0.13,
          ),
        ),
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
            ],
          ),
        ),
      ],
    );
  }
}

