import 'package:flutter/material.dart';
import 'dart:async';
import 'package:uts_c14210151/models/menu_model.dart';
import 'package:uts_c14210151/models/styleFood_model.dart';
import 'package:uts_c14210151/pages/details_page.dart';
import 'package:uts_c14210151/pages/home.dart';

class HomeBodyPage extends StatefulWidget {
  // final VoidCallback? onSeeAllPressed;

  const HomeBodyPage({Key? key}) : super(key: key);

  @override
  State<HomeBodyPage> createState() => _HomeBodyPageState();
}

late List<Widget> _pages;

class _HomeBodyPageState extends State<HomeBodyPage> {
  List<MenuModel> menu = [];
  List<StyleFoodModel> styleFood = [];

  int _activeCarousel = 0;
  final PageController _pageController = PageController(initialPage: 0);

  Timer? _timer;

// Method untuk memulai auto slide
  void startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      // Jika sudah mencapai slide terakhir, kembali ke slide pertama
      if (_activeCarousel == styleFood.length - 1) {
        _activeCarousel = 0;
      } else {
        _activeCarousel++;
      }
      // Memperbarui state dan melakukan animasi ke slide yang aktif
      setState(() {
        _pageController.animateToPage(_activeCarousel,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      });
    });
  }

  // Method untuk memulai ulang timer
  void restartTimer() {
    _timer?.cancel(); // Batalkan timer yang sedang berjalan
    startAutoSlide(); // Mulai timer baru
  }

  void _handlePageChange() {
    setState(() {
      _activeCarousel = _pageController.page!
          .round(); // Mengatur _activeCarousel berdasarkan halaman yang aktif
      restartTimer();
    });
  }

  void stopAutoSlide() {
    _timer?.cancel();
  }

  void _getMenu() {
    menu = MenuModel.getMenus();
  }

  void _getStyleFood() {
    styleFood = StyleFoodModel.getStyleFood();
  }

  @override
  void dispose() {
    stopAutoSlide();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getMenu();
    _getStyleFood();
    _pages = List.generate(
      styleFood.length,
      (index) => ImagePlaceHolder(
        imagePath: styleFood[index].imagePath,
        name: styleFood[index].name,
        totalPlaces: styleFood[index].totalPlaces,
      ),
    );
    startAutoSlide();
    _pageController.addListener(_handlePageChange);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          inputField(),
          const SizedBox(
            height: 20,
          ),
          carousel(context),
          Container(
            color: const Color.fromRGBO(245, 240, 241, 1),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 25.0, bottom: 25.0),
              child: Column(
                children: [
                  menuSection("Most Popular"),
                  const SizedBox(
                    height: 20,
                  ),
                  menuSection("Meal Deals"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  SizedBox carousel(BuildContext context) {
    return SizedBox(
      // color: Colors.amber,
      width: double.infinity,
      height: 232,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: styleFood.length,
            itemBuilder: (context, index) {
              return _pages[index];
            },
          ),
          carouselController(),
        ],
      ),
    );
  }

  Positioned carouselController() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: List<Widget>.generate(
            styleFood.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _activeCarousel = index;
                  });
                  _pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                  restartTimer();
                },
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor:
                      _activeCarousel == index ? Colors.amber : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column menuSection(String judul) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              judul,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DetailsPage()),
                );
              },
              child: const Text(
                "See all",
                style: TextStyle(
                  color: Color.fromRGBO(151, 207, 199, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 160,
          child: ListView.separated(
            itemCount: menu.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(
              width: 20,
            ),
            itemBuilder: (context, index) {
              return Container(
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2,
                        spreadRadius: 1,
                      )
                    ]),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      menu[index].imagePath,
                      fit: BoxFit.fitWidth,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          bottom: 8,
                          top: 8,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              menu[index].restaurant,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              menu[index].address,
                              style: const TextStyle(
                                  color: Color.fromRGBO(162, 162, 162, 1),
                                  fontSize: 12),
                            ),
                            Text(
                              '${menu[index].food}, ${menu[index].country}',
                              style: const TextStyle(
                                color: Color.fromRGBO(162, 162, 162, 1),
                                fontSize: 10,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Container inputField() {
    return Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: TextField(
            decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: const Icon(
            Icons.search,
            color: Color.fromRGBO(162, 162, 162, 1),
          ),
          hintText: "Search for restaurant...",
          hintStyle: const TextStyle(
            color: Color.fromRGBO(162, 162, 162, 1),
            // Ubah warna petunjuk sesuai yang Anda inginkan
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromRGBO(226, 226, 226, 1),
                width: 1.5,
              )),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromRGBO(
                  102, 37, 243, 1), // Ubah warna border saat mendapatkan fokus
              width: 1.5,
            ),
          ),
        )));
  }
}
