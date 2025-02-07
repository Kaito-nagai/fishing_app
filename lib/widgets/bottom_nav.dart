import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // 背景用の装飾
        Positioned(
          left: 0,
          top: screenHeight * 0.90,
          child: Opacity(
            opacity: 0.1,
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.3,
              decoration: const BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
            ),
          ),
        ),
        // ボトムナビゲーションのアイコン部分
        Positioned(
          left: screenWidth * 0.07,
          top: screenHeight * 0.905,
          child: SizedBox(
            width: screenWidth * 0.85,
            height: screenHeight * 0.08,
            child: Stack(
              children: [
                // マイリストアイコン
                Positioned(
                  left: screenWidth * 0.67,
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      debugPrint('マイリストアイコンがタップされました');
                    },
                    child: SizedBox(
                      width: screenWidth * 0.18,
                      height: screenHeight * 0.08,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: screenHeight * 0.037,
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
                ),

                // 検索アイコン
                Positioned(
                  left: screenWidth * 0.35,
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/search'); // 検索画面への遷移
                    },
                    child: SizedBox(
                      width: screenWidth * 0.12,
                      height: screenHeight * 0.07,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 1,
                            top: screenHeight * 0.037,
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
                ),

                // ホームアイコン
                Positioned(
                  left: 8,
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/'); // ホーム画面への遷移
                    },
                    child: SizedBox(
                      width: screenWidth * 0.15,
                      height: screenHeight * 0.08,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 5,
                            top: screenHeight * 0.037,
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
