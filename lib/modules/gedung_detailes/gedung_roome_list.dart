import 'package:flutter/material.dart';
import '../../models/gedung_list_data.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/widgets/common_card.dart';
import 'package:penyewaan_gedung_app/constants/local_files.dart';

class GedungRoomeList extends StatefulWidget {
  const GedungRoomeList({Key? key}) : super(key: key);

  @override
  State<GedungRoomeList> createState() => _GedungRoomeListState();
}

class _GedungRoomeListState extends State<GedungRoomeList> {
  @override
  Widget build(BuildContext context) {

    List<String> photosList = [
      LocalFiles.asGambar1,
      LocalFiles.asGambar2,
      LocalFiles.asGambar3,
      LocalFiles.asGambar4,
      LocalFiles.asGambar5
    ];

    return SizedBox(
      height: 120,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 0, bottom: 8, right: 16, left: 16),
        itemCount: photosList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonCard(
              color: AppTheme.backgroundColor,
              radius: 8,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    photosList[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
