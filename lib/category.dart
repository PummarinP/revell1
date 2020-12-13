class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.review = 0,
    this.fav = 0,
    this.rating = 0.0,
  });

  String title;
  int review;
  int fav;
  double rating;
  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/images/anua2.png',
      title: 'ANUA Heartleaf 77% Soothing Toner 250 ml',
      review: 24,
      fav: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/images/vitc.png',
      title: 'DHC Supplement Vitamin C \60 Days',
      review: 22,
      fav: 18,
      rating: 4.4,
    ),
    Category(
      imagePath: 'assets/images/JP1.png',
      title: 'APIEU Juicy Pang Mousse Tint',
      review: 59,
      fav: 172,
      rating: 4.7,
    ),
    Category(
      imagePath: 'assets/images/Cerave.png',
      title: 'CeraVe Daily Moisturizing Lotion for Dry Skin',
      review: 23,
      fav: 15,
      rating: 4.5,
    ),
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/images/noodle.png',
      title: 'Samyang Ramen/Spicy Chicken Roasted Noodles',
      review: 12,
      fav: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/images/xm.jpg',
      title: 'Xiaomi roidmi f8',
      review: 28,
      fav: 208,
      rating: 4.9,
    ),
    Category(
      imagePath: 'assets/images/origin.jpg',
      title: 'ORIGINS Mega Mushroom Relief & Resilience Soothing Treatment Lotion 200 ml',
      review: 12,
      fav: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/images/mascara.jpg',
      title: 'Maybelline Mascara Png - Volum Express Hypercurl Mascara',
      review: 28,
      fav: 208,
      rating: 4.9,
    ),
  ];
}
