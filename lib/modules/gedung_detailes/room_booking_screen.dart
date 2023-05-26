import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/modules/gedung_detailes/room_book_view.dart';
import 'package:penyewaan_gedung_app/models/gedung_list_data.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';

class RoomBookingScreen extends StatefulWidget {
  const RoomBookingScreen({Key? key}) : super(key: key);
  @override
  State<RoomBookingScreen> createState() => _RoomBookingScreenState();
}

class _RoomBookingScreenState extends State<RoomBookingScreen>
    with TickerProviderStateMixin {
  List<GedungListData> romeList = GedungListData.romeList;
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
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppTheme.primaryTextColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0.0),
              itemCount: romeList.length,
              itemBuilder: (context, index) {
                var count = romeList.length > 10 ? 10 : romeList.length;
                var animation = Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: animationController,
                        curve: Interval((1 / count) * index, 1.0,
                            curve: Curves.fastOutSlowIn)));
                animationController.forward();
                //room book view and room data
                return RoomeBookView(
                  roomData: romeList[index],
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
}
