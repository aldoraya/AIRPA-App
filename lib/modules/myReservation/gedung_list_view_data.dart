import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:penyewaan_gedung_app/constants/helper.dart';
import 'package:penyewaan_gedung_app/constants/text_styles.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/models/gedung_list_data.dart';
import 'package:penyewaan_gedung_app/widgets/common_card.dart';
import 'package:penyewaan_gedung_app/widgets/list_cell_animation_view.dart';
import 'package:penyewaan_gedung_app/constants/currency_format.dart';

class GedungListViewData extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final GedungListData gedungData;
  final AnimationController animationController;
  final Animation<double> animation;

  const GedungListViewData(
      {Key? key,
      required this.gedungData,
      required this.animationController,
      required this.animation,
      required this.callback,
      this.isShowDate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          onTap: () {
            try {
              callback();
            } catch (_) {}
          },
          child: Row(
            children: <Widget>[
              isShowDate ? getUI(context) : const SizedBox(),
              CommonCard(
                color: AppTheme.backgroundColor,
                radius: 16,
                child: SizedBox(
                  height: 150,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Image.asset(
                        gedungData.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              !isShowDate ? getUI(context) : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getUI(BuildContext context) {
    return Expanded(
      child: Container(
        height: 150,
        padding: EdgeInsets.only(
            left: !isShowDate ? 16 : 8,
            top: 8,
            bottom: 8,
            right: isShowDate ? 16 : 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              isShowDate ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              gedungData.titleTxt,
              maxLines: 2,
              textAlign: isShowDate ? TextAlign.right : TextAlign.left,
              style: TextStyles(context).getBoldStyle().copyWith(
                    fontSize: 16,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              gedungData.subTxt,
              style: TextStyles(context).getDescriptionStyle().copyWith(
                    fontSize: 14,
                  ),
            ),
            Text(
              Helper.getDateText(gedungData.date!),
              maxLines: 2,
              textAlign: isShowDate ? TextAlign.right : TextAlign.left,
              style: TextStyles(context).getRegularStyle().copyWith(
                    fontSize: 12,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
            // Text(
            //   Helper.getRoomText(gedungData.roomData!),
            //   maxLines: 2,
            //   textAlign: isShowDate ? TextAlign.right : TextAlign.left,
            //   style: TextStyles(context).getRegularStyle().copyWith(
            //         fontSize: 12,
            //       ),
            //   overflow: TextOverflow.ellipsis,
            // ),
            Expanded(
              child: FittedBox(
                child: SizedBox(
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: isShowDate
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: isShowDate
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.locationDot,
                            size: 8,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            " ${gedungData.dist.toStringAsFixed(1)}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles(context)
                                .getDescriptionStyle()
                                .copyWith(
                                  fontSize: 8,
                                ),
                          ),
                          Text(
                           Locs.alized.km_to_city,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles(context)
                                .getDescriptionStyle()
                                .copyWith(
                                  fontSize: 8,
                                ),
                          ),
                        ],
                      ),
                    
                      Row(
                        mainAxisAlignment: isShowDate
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            CurrencyFormat.convertToIdr((gedungData.perDay)),
                            textAlign: TextAlign.left,
                            style:
                                TextStyles(context).getRegularStyle().copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 8,
                                    ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: Get.find<Locs>().isRTL ? 4.0 : 2.0),
                            child: Text(
                             Locs.alized.per_day,
                              style: TextStyles(context)
                                  .getDescriptionStyle()
                                  .copyWith(
                                    fontSize: 8,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}