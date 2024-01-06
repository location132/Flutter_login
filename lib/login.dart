import 'package:flutter/material.dart';
import 'package:login_study/ld_logo_image.dart';

class LogInDartTest extends StatefulWidget {
  const LogInDartTest({super.key});

  @override
  _LogInDartTestState createState() => _LogInDartTestState();
}

class _LogInDartTestState extends State<LogInDartTest>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _offsetAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _fadeinAnimation;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 5.6),
      end: const Offset(0, -0.05),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeinAnimation = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeinAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_fadeController);

    _fadeAnimation = Tween<double>(
      begin: 1.0, // 시작점을 1.0 (완전히 보이는 상태)으로 설정
      end: 0.0, // 끝점을 0.0 (완전히 사라진 상태)으로 설정
    ).animate(_fadeController);
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  bool _isImageVisible = false; // 이미지의 가시성을 제어하는 플래그

  void _startAnimations() {
    if (!_isImageVisible) {
      setState(() {
        _isImageVisible = true; // 상태를 true로 설정
      });

      _slideController.forward().then((_) {
        _fadeController.forward();
      });

      Future.delayed(Duration(milliseconds: 800), () {
        setState(() {
          // 800밀리세컨드 후에 추가적인 상태 변경이 필요한 경우 여기에 로직 추가
        });
      });
    }
  }

  void _resetAnimations() {
    setState(() {
      _isImageVisible = false; // 상태를 초기 상태로 변경
    });

    // 애니메이션 컨트롤러들을 초기 상태로 되돌림
    _slideController.reverse();
    _fadeController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: 180,
                  ),
                  LogoImage(),
                  SizedBox(height: 30),
                  SlideTransition(
                    position: _offsetAnimation,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        minimumSize: const Size(double.infinity, 64),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      onPressed: _startAnimations,
                      child: AnimatedSwitcher(
                        duration:
                            const Duration(milliseconds: 800), // 애니메이션 지속 시간
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                              opacity: animation, child: child);
                        },
                        child: Text(
                          _isImageVisible ? '소셜 로그인' : '쉽고 빠른 원터치 로그인',
                          key: ValueKey(_isImageVisible), // 텍스트 변경을 위한 key
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Visibility(
                    visible: _isImageVisible, // 애니메이션 시작 전까지 숨김
                    child: FadeTransition(
                      opacity: _fadeinAnimation,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  // 카카오 버튼 로직
                                },
                                child: Text('카카오'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // 네이버 버튼 로직
                                },
                                child: Text('네이버'),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  // 애플 버튼 로직
                                },
                                child: Text('애플'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // 구글 버튼 로직
                                },
                                child: Text('구글'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 80,
                  ),
                  //---------------------------------------------
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 90, // 화면 하단에 위치하도록 설정
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        minimumSize: const Size(double.infinity, 64),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      onPressed: () {
                        _fadeController.forward(); // 버튼을 탭하면 fade out 애니메이션 시작
                      },
                      child: const Text(
                        '자체 이메일 로그인',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 800), // 애니메이션 지속 시간
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: _isImageVisible
                    ? InkWell(
                        onTap: _resetAnimations, // 여기에서 _resetAnimations 함수 호출
                        child: Text(
                          '로그인 화면으로 돌아가기',
                          key: ValueKey('로그인 화면으로 돌아가기'),
                        ),
                      )
                    : Text(
                        '메인화면 둘러보기',
                        key: ValueKey('메인화면 둘러보기'),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
