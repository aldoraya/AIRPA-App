import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/models/gedung_list_data.dart';
import 'package:penyewaan_gedung_app/constants/text_styles.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/widgets/common_card.dart';
import 'package:penyewaan_gedung_app/widgets/list_cell_animation_view.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; 

class ReviewsView extends StatelessWidget {
  final VoidCallback callback;
  final GedungListData reviewsList;
  final AnimationController animationController;
  final Animation<double> animation;

  const ReviewsView({
    Key? key,
    required this.reviewsList,
    required this.animationController,
    required this.animation,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      yTranslation: 40,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 48,
                    child: CommonCard(
                      radius: 8,
                      color: AppTheme.whiteColor,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset(
                            reviewsList.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      reviewsList.titleTxt,
                      style: TextStyles(context).getBoldStyle().copyWith(
                            fontSize: 14,
                          ),
                    ),
                    Row(
                      children: [
                        Text(
                          Locs.alized.last_update,
                          style: TextStyles(context)
                              .getDescriptionStyle()
                              .copyWith(
                                fontWeight: FontWeight.w100,
                                color: Theme.of(context).disabledColor,
                              ),
                        ),
                        Text(
                          reviewsList.dateTxt,
                          style: TextStyles(context)
                              .getDescriptionStyle()
                              .copyWith(
                                fontWeight: FontWeight.w100,
                                color: Theme.of(context).disabledColor,
                              ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "(${reviewsList.rating})",
                          style: TextStyles(context)
                              .getRegularStyle()
                              .copyWith(
                                fontWeight: FontWeight.w100,
                              ),
                        ),
                          RatingBarIndicator(
                          rating: reviewsList.rating / 2,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: AppTheme.primaryColor,
                          ),
                          itemCount: 5,
                          unratedColor: AppTheme.secondaryTextColor,
                          itemSize: 18.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                reviewsList.subTxt,
                style: TextStyles(context).getDescriptionStyle().copyWith(
                      fontWeight: FontWeight.w100,
                      color: Theme.of(context).disabledColor,
                    ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:  const BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            Locs.alized.reply,
                            textAlign: TextAlign.left,
                            style:
                                TextStyles(context).getRegularStyle().copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                          SizedBox(
                            height: 38,
                            width: 26,
                            child: Icon(
                              Icons.arrow_forward,
                              size: 14,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}