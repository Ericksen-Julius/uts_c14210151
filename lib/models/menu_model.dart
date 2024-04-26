// import '';

class MenuModel {
  String restaurant;
  String food;
  String address;
  String country;
  String imagePath;

  MenuModel({
    required this.restaurant,
    required this.food,
    required this.address,
    required this.country,
    required this.imagePath,
  });

  static List<MenuModel> getMenus() {
    List<MenuModel> menu = [];

    menu.add(MenuModel(
      restaurant: 'KFC Broadway',
      food: 'Fried Chicken',
      address: "122 Queen Street",
      country: "American",
      imagePath: 'assets/menu/kfc.jpg',
    ));

    menu.add(MenuModel(
      restaurant: 'Greek House',
      food: 'Burritos',
      address: "23 Queen Street",
      country: "Greek",
      imagePath: 'assets/menu/burritos.jpg',
    ));

    menu.add(MenuModel(
      restaurant: 'Bon Cafe',
      food: 'Steak',
      address: "452 Queen Street",
      country: "Australia",
      imagePath: 'assets/menu/steak.jpg',
    ));

    menu.add(MenuModel(
      restaurant: 'PizzaHut',
      food: 'Pizza',
      address: "76 Queen Street",
      country: "Italy",
      imagePath: 'assets/menu/pizza.jpg',
    ));

    return menu;
  }
}
