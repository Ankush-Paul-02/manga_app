import 'package:flutter/material.dart';

class OverlapCarousel extends StatelessWidget {
  const OverlapCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 260,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // LEFT IMAGE — stronger tilt
          Positioned(
            left: width * 0.03,
            top: 40,
            child: Transform.rotate(
              angle: -0.28, // MORE TILT LEFT
              child: _carouselImage("assets/car1.jpg", 165),
            ),
          ),

          // RIGHT IMAGE — stronger tilt
          Positioned(
            right: width * 0.03,
            top: 40,
            child: Transform.rotate(
              angle: 0.28, // MORE TILT RIGHT
              child: _carouselImage("assets/car3.jpg", 165),
            ),
          ),

          // CENTER IMAGE
          Positioned(
            left: (width / 2) - (210 / 1.8),
            top: -10,
            child: _carouselImage("assets/car2.jpg", 210),
          ),
        ],
      ),
    );
  }

  Widget _carouselImage(String path, double size) {
    return Container(
      width: size,
      height: size * 1.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            blurRadius: 14,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
    );
  }
}
