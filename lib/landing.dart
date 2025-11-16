import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _sushiAnimation;
  late Animation<Offset> _plateAnimation;
  late Animation<Offset> _textAnimation;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _plateAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0, 0.25, curve: Curves.decelerate),
          ),
        );
    _sushiAnimation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.25, 0.5, curve: Curves.ease),
          ),
        );
    _textAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.5, 0.75, curve: Curves.decelerate),
          ),
        );
    _buttonAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.75, 1, curve: Curves.decelerate),
      ),
    );
    super.initState();
    startAnimation();
  }

  void startAnimation() async {
    await Future.delayed(Duration(seconds: 2));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(120),
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/sushiBack.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 100,
                      child: AnimatedBuilder(
                        animation: _textAnimation,
                        builder: (context, child) {
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: Transform.translate(
                              offset: _textAnimation.value * 400,
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          "Sushi Home",
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: -40,
                      child: AnimatedBuilder(
                        animation: _plateAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: _plateAnimation.value * 600,
                            child: child,
                          );
                        },

                        child: Container(
                          height: 450,
                          width: 450,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/plate.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),

                    
                    Positioned(
                      top: 220,
                      child: AnimatedBuilder(
                        animation: _sushiAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: _sushiAnimation.value * 1000,
                            child: child,
                          );
                        },
                        child: Container(
                          height: 500,
                          width: 500,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/sushi.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            AnimatedBuilder(
              animation: _buttonAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _buttonAnimation.value,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffFF5C00), Color(0xffFF8A00)],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        'Get Started',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
