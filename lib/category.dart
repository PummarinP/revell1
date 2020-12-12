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
      rating: 4.6,
    ),
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
      rating: 4.6,
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
      imagePath: 'assets/images/noodle.png.png',
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
  ];
}
