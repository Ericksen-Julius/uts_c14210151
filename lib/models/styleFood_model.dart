// import '';

class StyleFoodModel {
  String name;
  String totalPlaces;
  String imagePath;

  StyleFoodModel({
    required this.name,
    required this.totalPlaces,
    required this.imagePath,
  });

  static List<StyleFoodModel> getStyleFood() {
    List<StyleFoodModel> foodstyle = [];

    foodstyle.add(StyleFoodModel(
      name: 'Thai Style',
      totalPlaces: '12 Places',
      imagePath: 'assets/food_style/thai_food.jpg',
    ));
    foodstyle.add(StyleFoodModel(
      name: 'Chinnese Style',
      totalPlaces: '8 Places',
      imagePath: 'assets/food_style/chinnese_food.jpg',
    ));
    foodstyle.add(StyleFoodModel(
      name: 'Western Style',
      totalPlaces: '3 Places',
      imagePath: 'assets/food_style/western_food.jpg',
    ));
    foodstyle.add(StyleFoodModel(
      name: 'Japan Style',
      totalPlaces: '7 Places',
      imagePath: 'assets/food_style/japan_food.jpg',
    ));

    return foodstyle;
  }
}
