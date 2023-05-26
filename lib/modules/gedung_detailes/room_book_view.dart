import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/models/gedung_list_data.dart';

class RoomeBookView extends StatefulWidget {
  final GedungListData roomData;
  final AnimationController animationController;
  final Animation<double> animation;

  const RoomeBookView(
      {Key? key,
      required this.roomData,
      required this.animationController,
      required this.animation})
      : super(key: key);

  @override
  State<RoomeBookView> createState() => _RoomeBookViewState();
}

class _RoomeBookViewState extends State<RoomeBookView> {
  var pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<String> images = widget.roomData.imagePath.split(" ");
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 40 * (1.0 - widget.animation.value), 0.0),
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 0.8,
                      child: PageView(
                        controller: pageController,
                        pageSnapping: true,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          for (var image in images)
                            Image.asset(
                              image,
                              fit: BoxFit.cover,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
