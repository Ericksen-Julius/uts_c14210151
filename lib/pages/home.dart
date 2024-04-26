import 'package:flutter/material.dart';
import 'package:uts_c14210151/models/menu_model.dart';
import 'package:uts_c14210151/models/styleFood_model.dart';
import 'package:uts_c14210151/pages/blank_page.dart';
import 'package:uts_c14210151/pages/homeBody.dart';

class ImagePlaceHolder extends StatelessWidget {
  final String? imagePath;
  final String? totalPlaces;
  final String? name;
  const ImagePlaceHolder(
      {super.key, this.imagePath, this.totalPlaces, this.name});

  @override
  Widget build(BuildContext context) {
    return Stack(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            imagePath!,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          // right: 0,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  totalPlaces!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  final BuildContext context;

  const HomePage({Key? key, required this.context}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MenuModel> menu = [];
  List<StyleFoodModel> styleFood = [];

  int _currentIndex = 0;

  Widget? leadingWidget; // Menggunakan tipe Widget?

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home_outlined,
        size: 25,
      ),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.location_on_outlined,
        size: 25,
      ),
      label: "Discovery",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.bookmark_outline,
        size: 25,
      ),
      label: "Bookmark",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.emoji_events_outlined,
        size: 25,
      ),
      label: "Top Foodie",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.person_outline,
        size: 25,
      ),
      label: "Profile",
    ),
  ];

  List<Widget> pages = const [
    HomeBodyPage(),
    BlankPage(myColor: Colors.red),
    BlankPage(myColor: Colors.blue),
    BlankPage(myColor: Colors.green),
    BlankPage(myColor: Colors.yellow),
  ];

  // Logika if di luar leading IconButton

  @override
  void initState() {
    super.initState();
    // _initListeners();
  }

  // void _initListeners() {
  //   // Mendengarkan perubahan di HomeBodyPage
  //   setState(() {
  //     _body = HomeBodyPage(
  //       onSeeAllPressed: () {
  //         // Panggil fungsi setState untuk memperbarui body
  //         setState(() {
  //           leadingWidget = IconButton(
  //             icon: const Icon(
  //               Icons.arrow_back,
  //               color: Color.fromRGBO(252, 210, 83, 1),
  //               size: 40,
  //             ),
  //             onPressed: () {
  //               setState(() {
  //                 _initListeners();
  //                 leadingWidget = null;
  //               });
  //             },
  //           );
  //           _body = const DetailsPage();
  //         });
  //       },
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Deklarasikan IconButton di luar if

    // _getStyleFood();
    // final double screenHeight = MediaQuery.of(context).size.height;
    // final double appBarHeight = AppBar().preferredSize.height;
    // double bottomNavigationBarHeight = kBottomNavigationBarHeight;

    // final double bodyHeight =
    //     screenHeight - appBarHeight - bottomNavigationBarHeight;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: pages[_currentIndex],
      ),
      // body: const DetailsPage(),
      bottomNavigationBar: bottomNavigationBarMethod(),
    );
  }

  BottomNavigationBar bottomNavigationBarMethod() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int newIndex) {
        setState(() {
          _currentIndex = newIndex;
        });
      },
      backgroundColor: Colors.transparent,
      selectedItemColor: const Color.fromRGBO(252, 210, 83, 1),
      unselectedItemColor: const Color.fromRGBO(162, 162, 162, 1),
      showUnselectedLabels: true,
      items: items,
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Sydney CBD',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 24,
        ),
      ),
      centerTitle: true,
      leading: null,
      // elevation: 0.5,
    );
  }
}
