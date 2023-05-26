import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/models/date_data.dart';
import 'package:penyewaan_gedung_app/constants/local_files.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GedungListData {
  String imagePath;
  String titleTxt;
  String desc1;
  String desc2;
  String subTxt;
  DateText? date;
  List subImage;
  String dateTxt;
  String roomSizeTxt;
  double dist;
  double rating;
  int reviews;
  double perDay;
  bool isSelected;
  LatLng location;
  Offset? screenMapPin;
  String locationTxt; // we used this screen Offset for adding on Map layer

  GedungListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.desc1 = '',
    this.desc2 = '',
    this.subTxt = "",
    this.subImage = const <String>[],
    this.dateTxt = "",
    this.roomSizeTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.perDay = 0,
    this.isSelected = false,
    this.date,
    this.location = const LatLng(0, 0),
    this.screenMapPin,
    this.locationTxt = '',
  });

  // we need location in this GedungList bcz we using that in map
  static List<GedungListData> gedungList = [
    GedungListData(
      imagePath: LocalFiles.aulaSekolah,
      titleTxt: 'Aula Sekolah SMKN 2 Bekasi',
      subTxt: 'Bekasi',
      desc1:
          'Penyewaan gedung sekolah adalah proses meminjam atau menyewa gedung atau ruang-ruang di dalamnya',
      desc2:
          'Penyewaan gedung sekolah adalah proses meminjam atau menyewa gedung atau ruang-ruang di dalamnya yang dimiliki oleh sebuah sekolah. Gedung sekolah biasanya digunakan untuk acara-acara seperti pertemuan orang tua murid, konferensi guru, lokakarya, pertunjukan seni, atau acara-acara lainnya yang berkaitan dengan pendidikan dan kegiatan sekolah. Dalam proses penyewaan gedung sekolah, calon penyewa harus terlebih dahulu mengajukan permohonan kepada pihak sekolah dan menentukan jadwal dan waktu yang diinginkan untuk menggunakan gedung tersebut. Selain itu, calon penyewa juga harus membayar biaya sewa sesuai dengan aturan yang telah ditetapkan oleh pihak sekolah.',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      perDay: 10000000.0,
      isSelected: true,
      date: DateText(1, 5),
      location: const LatLng(-6.302275271504314, 106.89513443902813),
      locationTxt: 'Jl. Lap. Bola Rw. Butun, RT.001/RW.006, 17153, Ciketingudik, Jawa Barat',
    ),
    GedungListData(
      imagePath: LocalFiles.gedung_1,
      titleTxt: 'Gedung Anjungan Jawa Tengah',
      subTxt: 'Jakarta',
      desc1:
          'Anjungan Provinsi Jawa Tengah adalah salah satu Anjungan Daerah di Taman Mini Indonesia Indah.',
      desc2:
          'Anjungan Provinsi Jawa Tengah adalah salah satu Anjungan Daerah di Taman Mini Indonesia Indah. Anjungan ini menampilkan tujuh bangunan tradisional, yakni Pendopo Agung sebagai bangunan utama, pringgitan, tajuk mangkurat, Sasono Suko, joglo pengrawit apitan, dara gepak, dan panggung terbuka Ojo Dumeh. Selain itu, di dalam anjungan ini ditampilkan juga bangunan miniatur Candi Borobudur, Candi Prambanan, dan Candi Mendut.',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      perDay: 15000000.0,
      isSelected: true,
      date: DateText(1, 5),
      location: const LatLng(-6.302275271504314, 106.89513443902813),
      locationTxt: 'Taman Mini Indonesia Indah, Ceger, Cipayung, Jakarta Timur',
    ),
    GedungListData(
      imagePath: LocalFiles.gedung_2,
      titleTxt: 'Aula Dharmagati',
      subTxt: 'Jakarta',
      desc1:
          'Aula Dharmagati Ksatria Jaya yang berlokasi di Kramat Jati Jakarta Timur.',
      desc2:
          'Salah satu gedung yang juga biasa disewakan untuk acara pernikahan adalah Aula Dharmagati Ksatria Jaya yang berlokasi di Kramat Jati Jakarta Timur. Menurut sejumlah ulasan para pengguna, gedung ini cukup memadai untuk memuat sekitar 500 undangan. Gedung ini juga difasilitasi tempat parkir yang cukup luas. Ini komentar salah seorang pengguna gedung ini yang dikutip dari ulasantempat.com. “Aulanya dalam komplek perkantoran TNI, aulanya bagus, akustik ruangannya bagus, cocok dijadikan tempat acara nikahan atau resepsi lainnya, banyak ruangan yang bisa dijadikan backstage. Parkiran gratis motor ataupun mobil cuma dengan kapasitas terbatas.untuk naik angkot umum juga bisa naik busway berhenti di halte kramat jati, tinggal jalan sekitar 100 meter sudah sampai depan Aula.',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      perDay: 14000000,
      isSelected: false,
      date: DateText(2, 6),
      location: const LatLng(-6.274993095692956, 106.86804503491857),
      locationTxt: 'Jl. Raya Bogor No.2, RT.2/RW.9, Kramat Jati, Jakarta Timur',
    ),
    GedungListData(
      imagePath: LocalFiles.gedung_3,
      titleTxt: 'Gedung Balai Komando',
      subTxt: 'Jakarta',
      desc1:
          'Salah satu gedung yang terletak di Cijantung Jakarta Timur ini cukup luas dan mampu menampung sampai 1000 orang lebih',
      desc2:
          'Salah satu gedung yang terletak di Cijantung Jakarta Timur ini cukup luas dan mampu menampung sampai 1000 orang lebih, sehingga gedung ini cocok untuk menyelenggarakan berbagai acara resepsi. Gedung atau tempat resepsi ini memiliki fungsi yang sangat penting dalam sebuah acara resmi, karena gedung ini cocok menjadi tempat untuk menampung sekian jumlah undangan dan sangat berpengaruh terhadap kelancaran serta keberhasilan sebuah acara.',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      perDay: 11000000.0,
      isSelected: false,
      date: DateText(5, 9),
      location: const LatLng(-6.317111449582971, 106.85416146786338),
      locationTxt: 'Jl. RA. Fadillah No.9, RT.1/RW.5, Cijantung, Kec. Ps. Rebo, Jakarta',
    ),
    GedungListData(
      imagePath: LocalFiles.gedung_4,
      titleTxt: 'Gedung Bkow',
      subTxt: 'Jakarta',
      desc1:
          'Gedung BKOW merupakan salah satu gedung yang terletak di daerah Jakarta Timur.',
      desc2:
          'Gedung BKOW merupakan salah satu gedung yang terletak di daerah Jakarta Timur. Gedung ini bisa digunakan untuk menggelar acara-acara besar seperti pernikahan dan yang lainnya. Bentuk bangunan yang megah di tambah dengan interior yang bagus, membuat gedung ini menjadi salah satu gedung favorit bagi calon pengantin. Sehingga tidak mengherankan jika banyak pasangan calon pengantin butuh waktu yang cukup lama untuk membooking gedung ini.',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perDay: 17000000.0,
      isSelected: false,
      date: DateText(1, 5),
      location: const LatLng(-6.241046973484325, 106.92155225436751),
      locationTxt: 'Jl. Raden Inten II No.90-91, Duren Sawit, Jakarta Timur',
    ),
    GedungListData(
      imagePath: LocalFiles.gedung_5,
      titleTxt: 'Gedung Pencak Silat',
      subTxt: 'Jakarta',
      desc1:
          'Gedung Padepokan Pencak Silat Indonesia merupakan gedung pernikahan yang terletak di sekitar Taman Mini Indonesia Indah',
      desc2:
          'Gedung Padepokan Pencak Silat Indonesia merupakan gedung pernikahan yang terletak di sekitar Taman Mini Indonesia Indah, Jakarta Timur. Lokasi ini sangat memudahkan pemangku hajat dan juga para tamu karena aksesnya yang sangat mudah dijangkau. Kapasitas tamu untuk acara pernikahan dengan format standing party dapat memuat mulai 600 orang / 300 undangan hingga 1100 orang / 550 undangan. Tamu pun akan dipermudah dengan fasilitas area parkir yang luas yang juga cukup untuk menampung bus - bus pariwisata jika ada anggota keluarga yang datang bersamaan dari luar kota.',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      isSelected: false,
      perDay: 2000000.0,
      date: DateText(1, 4),
      location: const LatLng(-6.296039954193657, 106.8841892476718),
      locationTxt: 'Taman Mini Indonesia Indah, Jakarta, Indoneia',
    ),
    GedungListData(
      imagePath: LocalFiles.gedung_6,
      titleTxt: 'Gedung Sasana Modern',
      subTxt: 'Jakarta',
      desc1:
          'Gedung Sasana Modern - adalah sebuah gedung serba guna yang lokasinya sangat strategis mudah',
      desc2:
          'Gedung Sasana Modern - adalah sebuah gedung serba guna yang lokasinya sangat strategis mudah di jangkau dari berbagai wilayah  seperti Cakung sekitarnya dan Bekasi serta dekat dengan exit tol seperti tol Cakung Barat, Cakung Timur dan Pulogebang dan memiliki interior yang eksklusif, memiliki sarana dan prasana yang memadai dalam mewujudkan keinginan yang menjadi harapan seperti memiliki kapasitas hingga 1300 orang dan ditambah lagi seluruh ruangan full AC dan full karpet, penerangan dengan lampu Kristal yang sangat menawan dan terkesan mewah serta memiliki area parkir yang sangat memadai, penggunaan waktu yang cukup fleksibel.',
      dist: 2.0,
      reviews: 240,
      rating: 4.6,
      isSelected: false,
      perDay: 2000000.0,
      date: DateText(1, 4),
      location: const LatLng(-6.256379056536001, 106.99636990796036),
      locationTxt: 'Jalan Raya Bekasi KM.24, Ujung Menteng, Cakung, Jakarta Timur.'
    ),
    GedungListData(
      imagePath: LocalFiles.gedung_7,
      titleTxt: 'Gedung Sasana Adiguno',
      subTxt: 'Bekasi',
      desc1:
          'Sasono Adiguno adalah gedung serba guna berbentuk segi empat dengan luas ruangan sekitar 1.000 m2',
      desc2:
          'Sasono Adiguno adalah gedung serba guna berbentuk segi empat dengan luas ruangan sekitar 1.000 m2. Ruang ini mampu menampung 800 tempat duduk dan 1.500 orang berdiri sangat cocok untuk kegiatan pertemuan, resepsi pernikahan, jamuan makan, seminar dan pameran. Selain ruangan cukup luas, penataan gedungnya artistic dengan ukiran kayu jati yang terdapat pada dinding belakang dan langit-langit.Ukiran-ukiran yang memiliki nilai seni tinggi ini memberikan nilai tambah dan keanggunan gedung ini.',
      dist: 2.0,
      reviews: 240,
      rating: 4.7,
      isSelected: false,
      perDay: 2000000.0,
      date: DateText(1, 4),
      location: const LatLng(-6.301717902829476, 106.89148922142479),
      locationTxt: 'Taman Mini Indonesia Indah, Jakarta Indoneia',
    ),
    GedungListData(
      imagePath: LocalFiles.gedung_8,
      titleTxt: 'Gedung United Tractor',
      subTxt: 'Jakarta',
      desc1:
          'United Tractor Grand Ballroom adalah gedung ballroom yang sangat megah dengan kapasitas maksimum hingga 2000 orang',
      desc2:
          'United Tractor Grand Ballroom adalah gedung ballroom yang sangat megah dengan kapasitas maksimum hingga 2000 orang. Kemewahannya pun tak perlu anda ragukan lagi karena ini adalah satu-satunya gedung ballroom full carpet dengan standar hotel bintang lima di Jakarta Timur. Lokasi gedung ini sangat strategis, dengan kemudahan akses dari pintu exit tol cakung barat. Lahan parkir yang disediakan pun luas dan terjamin, didukung dengan security team yang ramah dan membantu. Anda dan pasangan dapat melangsungkan pesta pernikahan istimewa anda dalam balutan kemewahan ballroom berstandar hotel bintang 5. Pesta anda pun akan terus dikenang dan tak terlupakan sepanjang kebersamaan anda berdua.',
      dist: 2.0,
      reviews: 240,
      rating: 4.7,
      isSelected: false,
      perDay: 25000000.0,
      date: DateText(1, 4),
      location: const LatLng(-6.183600837573613, 106.93124595252212),
      locationTxt: 'Jl. Raya Bekasi Km 22, Cakung, Jakarta Timur',
    ),
  ];

  static List<GedungListData> popularList = [
    GedungListData(
      imagePath: LocalFiles.popular_1,
      titleTxt: 'Jakarta',
    ),
    GedungListData(
      imagePath: LocalFiles.popular_2,
      titleTxt: 'Bekasi',
    ),
  ];

  static List<GedungListData> romeList = [
    GedungListData(
      imagePath: LocalFiles.asGambar1,
    ),
    GedungListData(
      imagePath: LocalFiles.asGambar2,
    ),
    GedungListData(
      imagePath: LocalFiles.asGambar3,
    ),
    GedungListData(
      imagePath: LocalFiles.asGambar4,
    ),
    GedungListData(
      imagePath: LocalFiles.asGambar5,
    ),
  ];

  static List<GedungListData> reviewsList = [
    GedungListData(
      imagePath: LocalFiles.avatar1,
      titleTxt: 'Nur Dewi',
      subTxt:
          'Ini terletak di tempat yang bagus dekat dengan toko-toko dan Jajanan jalanan, lokasi yang strategis',
      rating: 8.0,
      dateTxt: '21 Jan, 2023',
    ),
    GedungListData(
      imagePath: LocalFiles.avatar2,
      titleTxt: 'Muhammad Dwi',
      subTxt:
          'Staf yang baik, tempat yang sangat nyaman, lokasi yang sangat tenang',
      rating: 8.0,
      dateTxt: '21 Jan, 2023',
    ),
    GedungListData(
      imagePath: LocalFiles.avatar3,
      titleTxt: 'Putri Sari',
      subTxt:
          'Ini terletak di tempat yang bagus dekat dengan toko-toko dan Jajanan jalanan, lokasi yang strategis',
      rating: 6.0,
      dateTxt: '21 Jan, 2023',
    ),
    GedungListData(
      imagePath: LocalFiles.avatar4,
      titleTxt: 'Siti Ayu',
      subTxt:
          'Staf yang baik, tempat yang sangat nyaman, lokasi yang sangat tenang',
      rating: 9.0,
      dateTxt: '21 Jan, 2023',
    ),
    GedungListData(
      imagePath: LocalFiles.avatar5,
      titleTxt: 'Agus Kurniawan',
      subTxt:
          'Ini terletak di tempat yang bagus dekat dengan toko-toko dan Jajanan jalanan, lokasi yang strategis',
      rating: 8.0,
      dateTxt: '21 Jan, 2023',
    ),
    GedungListData(
      imagePath: LocalFiles.avatar6,
      titleTxt: 'Nurul Wulandari',
      subTxt:
          'Staf yang baik, tempat yang sangat nyaman, lokasi yang sangat tenang',
      rating: 7.0,
      dateTxt: '21 Jan, 2023',
    ),
    GedungListData(
      imagePath: LocalFiles.avatar7,
      titleTxt: 'Muhammad Abdul',
      subTxt:
          'Ini terletak di tempat yang bagus dekat dengan toko-toko dan Jajanan jalanan, lokasi yang strategis',
      rating: 9.0,
      dateTxt: '21 Jan, 2023',
    ),
  ];

  static List<GedungListData> gedungTypeList = [
    GedungListData(
      imagePath: LocalFiles.gedung_1,
      titleTxt: 'multipurpose_building',
      isSelected: false,
    ),
  ];

  static List<GedungListData> lastsSearchesList = [
    GedungListData(
      imagePath: LocalFiles.popular_1,
      titleTxt: 'Jakarta',
      date: DateText(12, 22),
      dateTxt: '12 - 22 Feb',
    ),
    GedungListData(
      imagePath: LocalFiles.popular_2,
      titleTxt: 'Bekasi',
      date: DateText(10, 15),
      dateTxt: '10 - 15 Mei',
    ),
  ];
}
