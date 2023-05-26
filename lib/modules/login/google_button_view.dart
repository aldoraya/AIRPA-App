import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/widgets/common_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/widgets/tap_effect.dart';

class GoogleButtonView extends StatelessWidget {
  final Function()? onTap;

  const GoogleButtonView({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _fTButtonUI();
  }

  Widget _fTButtonUI() {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 24,
        ),
        Expanded(
          child: TapEffect(
            onClick: onTap ?? () {},
            child: CommonButton(
              padding: EdgeInsets.zero,
              backgroundColor: AppTheme.whiteColor,
              buttonTextWidget: _buttonTextUI(),
            ),
          ),
        ),
        const SizedBox(
          width: 24,
        ),
      ],
    );
  }

  Widget _buttonTextUI() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          'assets/icons/google.svg',
          width: 20,
          height: 20,
          semanticsLabel: 'SVG Image',
        ),
        const SizedBox(
          width: 8,
        ),
        const Text(
          "Masuk dengan Google",
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
        )
      ],
    );
  }
}
