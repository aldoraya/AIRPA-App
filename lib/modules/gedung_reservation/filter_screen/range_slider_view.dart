import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/constants/currency_format.dart';

class RangeSliderView extends StatefulWidget {
  final Function(RangeValues) onChnageRangeValues;
  final RangeValues values;

  const RangeSliderView(
      {Key? key, required this.values, required this.onChnageRangeValues})
      : super(key: key);
  @override
  RangeSliderViewState createState() => RangeSliderViewState();
}

class RangeSliderViewState extends State<RangeSliderView> {
  late RangeValues _values;

  @override
  void initState() {
    _values = widget.values;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: _values.start.round(),
                  child: const SizedBox(),
                ),
                SizedBox(
                  width: 54,
                  child: Text(
                     CurrencyFormat.convertToIdr((_values.start)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1000 - _values.start.round(),
                  child: const SizedBox(),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: _values.end.round(),
                  child: const SizedBox(),
                ),
                SizedBox(
                  width: 54,
                  child: Text(
                    "\$${_values.end.round()}",
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1000 - _values.end.round(),
                  child: const SizedBox(),
                ),
              ],
            ),
          ],
        ),
        SliderTheme(
          data: const SliderThemeData(
              //   rangeThumbShape: CustomRangeThumbShape(),
              ),
          child: RangeSlider(
            values: _values,
            min: 1000000.0,
            max: 30000000.0,
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Colors.grey.withOpacity(0.4),
            divisions: 1000,
            onChanged: (RangeValues values) {
              try {
                setState(() {
                  _values = values;
                });
                widget.onChnageRangeValues(_values);
              } catch (_) {}
            },
          ),
        ),
      ],
    );
  }
}
