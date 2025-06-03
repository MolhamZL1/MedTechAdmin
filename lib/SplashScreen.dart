import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'features/auth/presentation/views/sign_in_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignInView()),
      );

    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
             Theme.of(context).colorScheme.secondary,

            Colors.white,
          ],
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:  Center(
          child: AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return FadeTransition(
                opacity: _scaleAnimation,
                child: ScaleTransition(
                  scale: _fadeAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        //  _buildImage('assets/images/1.jpg'),
                          const SizedBox(height: 15),
                        //  _buildImage('assets/images/2.jpg'),
                          const SizedBox(height: 15),
                          _buildImage('assets/images/3.jpg'),
                          const SizedBox(height: 15),
                          _buildImage('assets/images/4.jpg'),
                          const SizedBox(height: 15),
                          _buildImage('assets/images/5.jpg'),
                        ],
                      ),
                      const SizedBox(width: 60),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildImage('assets/images/1.jpg'),
                          const SizedBox(height: 15),
                          _buildImage('assets/images/2.jpg'),
                          const SizedBox(height: 15),
                        //  _buildImage('assets/images/3.jpg'),
                          const SizedBox(height: 15),
                         // _buildImage('assets/images/4.jpg'),
                          const SizedBox(height: 15),
                          _buildImage('assets/images/5.jpg'),
                        ],
                      ),
                      const SizedBox(width: 60),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

      ),
    );

  }
  Widget _buildImage(String imagePath) {
    return Opacity(
      opacity: 0.4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imagePath,
          width: 250,
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

}