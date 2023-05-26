import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/modules/gedung_reservation/components/calendar_pop_up_view.dart';
import 'package:penyewaan_gedung_app/constants/text_styles.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class TimeDateView extends StatefulWidget {
  const TimeDateView({Key? key}) : super(key: key);

  @override
  TimeDateViewState createState() => TimeDateViewState();
}

class TimeDateViewState extends State<TimeDateView> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  final String languageCode = Get.find<Locs>().locale.languageCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _getDateRoomUi(Locs.alized.choose_date,
              "${DateFormat("dd, MMM", languageCode).format(startDate)} - ${DateFormat("dd, MMM", languageCode).format(endDate)}",
              () {
            _showDemoDialog(context);
          }),
          Container(
            width: 1,
            height: 42,
            color: Colors.grey.withOpacity(0.8),
          ),
        ],
      ),
    );
  }

  Widget _getDateRoomUi(String title, String subtitle, VoidCallback onTap) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(4.0),
              ),
              onTap: onTap,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      // "Choose date",
                      style: TextStyles(context)
                          .getDescriptionStyle()
                          .copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      subtitle,
                      // "${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}",
                      style: TextStyles(context).getRegularStyle(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDemoDialog(BuildContext context) {
    showDialog(
      context: context,
      //custome calendar view
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        maximumDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
          });
        },
        onCancelClick: () {},
      ),
    );
  }
}
