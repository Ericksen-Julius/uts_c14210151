import 'package:flutter/material.dart';
import 'package:uts_c14210151/models/menu_model.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<MenuModel> menu = [];

  void _getMenu() {
    menu = MenuModel.getMenus();
  }

  @override
  Widget build(BuildContext context) {
    _getMenu();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sydney CBD',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(252, 210, 83, 1),
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView.separated(
          itemCount: menu.length,
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          itemBuilder: (context, index) {
            return Center(
              child: FractionallySizedBox(
                widthFactor: 0.85,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        menu[index].imagePath,
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
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
                                  fontSize: 14),
                            ),
                            Text(
                              '${menu[index].food}, ${menu[index].country}',
                              style: const TextStyle(
                                color: Color.fromRGBO(162, 162, 162, 1),
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
