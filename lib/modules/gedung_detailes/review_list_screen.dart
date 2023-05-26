import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/widgets/common_appbar_view.dart';
import '../../models/gedung_list_data.dart';
import 'review_data_view.dart';

class ReviewsListScreen extends StatefulWidget {

  const ReviewsListScreen({Key? key}) : super(key: key);

  @override
  ReviewsListScreenState createState() => ReviewsListScreenState();
}

class ReviewsListScreenState extends State<ReviewsListScreen>
    with TickerProviderStateMixin {
  List<GedungListData> reviewsList = GedungListData.reviewsList;
  late AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CommonAppbarView(
            iconData: Icons.close,
            onBackClick: () {
              Navigator.pop(context);
            },
            titleText: "Review(20)",
          ),
          // animation of Review and feedback data
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                  top: 8, bottom: MediaQuery.of(context).padding.bottom + 8),
              itemCount: reviewsList.length,
              itemBuilder: (context, index) {
                var count = reviewsList.length > 10 ? 10 : reviewsList.length;
                var animation = Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: animationController,
                        curve: Interval((1 / count) * index, 1.0,
                            curve: Curves.fastOutSlowIn)));
                animationController.forward();
                // page to redirect the feedback and review data
                return ReviewsView(
                  callback: () {},
                  reviewsList: reviewsList[index],
                  animation: animation,
                  animationController: animationController,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: AppBar().preferredSize.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: SizedBox(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 4, left: 24),
          child: Text(
            "Reviews (20)",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}