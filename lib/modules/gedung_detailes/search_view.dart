import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/models/gedung_list_data.dart';
import 'package:penyewaan_gedung_app/constants/helper.dart';
import 'package:penyewaan_gedung_app/constants/text_styles.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/widgets/common_card.dart';
import 'package:penyewaan_gedung_app/widgets/list_cell_animation_view.dart';

class SerchView extends StatelessWidget {
  final GedungListData gedungInfo;
  final AnimationController animationController;
  final Animation<double> animation;

  const SerchView(
      {Key? key,
      required this.gedungInfo,
      required this.animationController,
      required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AspectRatio(
          aspectRatio: 0.75,
          child: CommonCard(
            color: AppTheme.backgroundColor,
            radius: 16,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              child: Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: Image.asset(
                     gedungInfo.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                           gedungInfo.titleTxt,
                            style: TextStyles(context).getBoldStyle(),
                          ),
                          Text(
                            Helper.getLastSearchDate(gedungInfo.date!),
                            // Helper.getRoomText(hotelInfo.roomData!),
                            style:
                                TextStyles(context).getRegularStyle().copyWith(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .disabledColor
                                          .withOpacity(0.6),
                                    ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}