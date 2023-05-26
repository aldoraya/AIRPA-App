import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/modules/myReservation/gedung_list_view_page.dart';
import 'package:penyewaan_gedung_app/routes/route_names.dart';
import '../../models/gedung_list_data.dart';

class FavoritesListView extends StatefulWidget {
  final AnimationController animationController;

  const FavoritesListView({Key? key, required this.animationController}) : super(key: key);
  
  @override
  FavoritesListViewState createState() => FavoritesListViewState();
}

class FavoritesListViewState extends State<FavoritesListView> {
  var gedungList = GedungListData.gedungList;

  @override
  void initState() {
    widget.animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: gedungList.length,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return getListView(index);
      },
    );
  }

  Widget getListView(int index) {
    var gedungList = GedungListData.gedungList;
    List<Widget> list = [];
    for (var f in gedungList) {
      var animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: widget.animationController,
          curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      list.add(
        GedungListViewPage(
          callback: () {
            NavigationServices(context).gotoGedungDetailes(f);
          },
          gedungData: f,
          animation: animation,
          animationController: widget.animationController,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: list,
      ),
    );
  }
}
