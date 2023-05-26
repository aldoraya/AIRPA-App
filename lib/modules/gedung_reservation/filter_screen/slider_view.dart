import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';

class SliderView extends StatefulWidget {
  final Function(double) onChnagedistValue;
  final double distValue;

  const SliderView(
      {Key? key, required this.onChnagedistValue, required this.distValue})
      : super(key: key);
  @override
  SliderViewState createState() => SliderViewState();
}

class SliderViewState extends State<SliderView> {
  double distValue = 50.0;

  @override
  void initState() {
    distValue = widget.distValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: distValue.round(),
              child: const SizedBox(),
            ),
            SizedBox(
              width: 170,
              child: Row(
                children: [
                  Text(
                   Locs.alized.less_than,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Text(
                      (distValue / 10).toStringAsFixed(1),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    Locs.alized.km_text,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 100 - distValue.round(),
              child: const SizedBox(),
            ),
          ],
        ),
        Slider(
          onChanged: (value) {
            setState(() {
              distValue = value;
            });
            try {
              widget.onChnagedistValue(distValue);
            } catch (_) {}
          },
          min: 0.0,
          max: 100.0,
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Colors.grey.withOpacity(0.4),
          //   divisions: 100,
          value: distValue,
        ),
      ],
    );
  }
}
