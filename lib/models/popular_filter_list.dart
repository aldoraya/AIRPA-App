class PopularFilterListData {
  String titleTxt;
  bool isSelected;

  PopularFilterListData({
    this.titleTxt = '',
    this.isSelected = false,
  });

  static List<PopularFilterListData> popularFList = [
    PopularFilterListData(
      titleTxt: 'free_Parking',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Free_Wifi',
      isSelected: false,
    ),
  ];

  static List<PopularFilterListData> accomodationList = [
    PopularFilterListData(
      titleTxt: 'all_text',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'gedung_data',
      isSelected: false,
    ),
  ];
}