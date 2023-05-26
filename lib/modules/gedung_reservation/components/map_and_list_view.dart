import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/models/gedung_list_data.dart';
import 'package:penyewaan_gedung_app/modules/gedung_reservation/components/google_map_ui_view.dart';
import 'package:penyewaan_gedung_app/modules/gedung_reservation/components/time_date_view.dart';
import 'package:penyewaan_gedung_app/modules/gedung_reservation/map_gedung_view.dart';
import 'package:penyewaan_gedung_app/routes/route_names.dart';

class MapAndListView extends StatelessWidget {
  final List<GedungListData> gedungList;
  final Widget searchBarUI;

  const MapAndListView(
      {Key? key, required this.gedungList, required this.searchBarUI})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StatefulBuilder(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              searchBarUI,
              const TimeDateView(),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    GoogleMapUIView(
                      gedungList: gedungList,
                    ),
                    IgnorePointer(
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(1.0),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.4),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: SizedBox(
                        height: 156,
                        // color: Colors.green,
                        child: ListView.builder(
                          itemCount: gedungList.length,
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, right: 16),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return MapGedungListView(
                              callback: () {
                                NavigationServices(context);
                              },
                              gedungData: gedungList[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
