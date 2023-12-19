import 'package:flutter/material.dart';
import 'package:nike_shoes_store/models/nike_shoes_model.dart';
import 'package:nike_shoes_store/nike_shoes_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ValueNotifier<bool> notifierBottomBarVisible = ValueNotifier(true);

  void _onShoesPressed(NikeShoes shoes, BuildContext context) async {
    notifierBottomBarVisible.value = false;
    await Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: NikeShoesDetailScreen(shoes: shoes),
        );
      },
    ));
    notifierBottomBarVisible.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.white,
                    height: 87,
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/logo/nike_logo.png',
                      height: 40,
                    ),
                  ),
                  Expanded(
                      child: ListView.separated(
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                    itemCount: shoes.length,
                    itemBuilder: (context, index) {
                      return NikeShoesItem(
                        shoes: shoes[index],
                        onTap: () {
                          _onShoesPressed(shoes[index], context);
                        },
                      );
                    },
                  ))
                ],
              ),
            ),
            ValueListenableBuilder<bool>(
                valueListenable: notifierBottomBarVisible,
                child: Container(
                  color: Colors.white.withOpacity(0.9),
                  child: const Row(
                    children: [
                      Expanded(
                          child: Icon(
                        Icons.home_filled,
                        size: 28,
                      )),
                      Expanded(
                          child: Icon(
                        Icons.search_outlined,
                        size: 28,
                      )),
                      Expanded(
                          child: Icon(
                        Icons.favorite_border,
                        size: 28,
                      )),
                      Expanded(
                          child: Icon(
                        Icons.shopping_basket_outlined,
                        size: 28,
                      )),
                      Expanded(
                          child: CircleAvatar(
                              radius: 14,
                              backgroundImage: AssetImage('assets/user.avif'))),
                    ],
                  ),
                ),
                builder: (context, value, child) {
                  return AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      left: 0,
                      right: 0,
                      bottom: value ? 0.0 : -kToolbarHeight,
                      height: kToolbarHeight,
                      child: child!);
                })
          ],
        ),
      ),
    );
  }
}

class NikeShoesItem extends StatelessWidget {
  final NikeShoes shoes;
  final VoidCallback onTap;
  const NikeShoesItem({super.key, required this.shoes, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 400;
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: itemHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: Hero(
                  tag: 'background_${shoes.model}',
                  child: Container(
                    color: Color(shoes.color),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: 'number_${shoes.model}',
                  child: SizedBox(
                      height: itemHeight * 0.5,
                      child: Material(
                        color: Colors.transparent,
                        child: FittedBox(
                          child: Text(
                            shoes.modelNumber.toString(),
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                height: 1.2,
                                color: Colors.black.withOpacity(0.05),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )),
                ),
              ),
              Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  height: itemHeight * 0.65,
                  child: Hero(
                    tag: 'image_${shoes.model}',
                    child: Image.asset(
                      shoes.images.first,
                      fit: BoxFit.contain,
                    ),
                  )),
              const Positioned(
                  left: 30,
                  bottom: 30,
                  child: Icon(
                    Icons.favorite_border,
                    size: 30,
                    color: Colors.black38,
                  )),
              const Positioned(
                  right: 30,
                  bottom: 30,
                  child: Icon(
                    Icons.add_shopping_cart_rounded,
                    size: 30,
                    color: Colors.black38,
                  )),
              Positioned(
                left: 0,
                right: 0,
                bottom: 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      shoes.model,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "\$${shoes.oldPrice.toInt().toString()}",
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          height: 0.6,
                          color: Colors.red.shade300,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "\$${shoes.currentPrice.toInt().toString()}",
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
