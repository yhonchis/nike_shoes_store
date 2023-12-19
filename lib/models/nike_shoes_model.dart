class NikeShoes {
  final String model;
  final double oldPrice;
  final double currentPrice;
  final List<String> images;
  final int modelNumber;
  final int color;

  NikeShoes(
      {required this.model,
      required this.oldPrice,
      required this.currentPrice,
      required this.images,
      required this.modelNumber,
      required this.color});
}

List<NikeShoes> shoes = [
  NikeShoes(
      model: 'AIR MAX 90 EZ Black',
      oldPrice: 299,
      currentPrice: 149,
      images: [
        'assets/shoes/shoes1_1.png',
        'assets/shoes/shoes1_2.png',
        'assets/shoes/shoes1_3.png'
      ],
      modelNumber: 90,
      color: 0xfff6f6f6),
  NikeShoes(
      model: 'AIR MAX 270 Gold',
      oldPrice: 349,
      currentPrice: 199,
      images: [
        'assets/shoes/shoes2_1.png',
        'assets/shoes/shoes2_2.png',
        'assets/shoes/shoes2_3.png'
      ],
      modelNumber: 270,
      color: 0xfffcf5eb),
  NikeShoes(
      model: 'AIR MAX 95 Red',
      oldPrice: 399,
      currentPrice: 299,
      images: [
        'assets/shoes/shoes3_1.png',
        'assets/shoes/shoes3_2.png',
        'assets/shoes/shoes3_3.png'
      ],
      modelNumber: 95,
      color: 0xfffeefef),
  NikeShoes(
      model: 'AIR MAX 98 Free',
      oldPrice: 299,
      currentPrice: 149,
      images: [
        'assets/shoes/shoes4_1.png',
        'assets/shoes/shoes4_2.png',
        'assets/shoes/shoes4_3.png'
      ],
      modelNumber: 98,
      color: 0xffedf3fe)
];
