import 'package:flutter/material.dart';
import 'package:nike_shoes_store/models/nike_shoes_model.dart';
import 'package:nike_shoes_store/nike_shooping_cart.dart';
import 'package:nike_shoes_store/widgets/shake_transition.dart';

class NikeShoesDetailScreen extends StatelessWidget {
  final NikeShoes shoes;
  final ValueNotifier<bool> notifierButtonsVisible = ValueNotifier(false);
  final ValueNotifier<int> notifierCurrentpage = ValueNotifier(0);

  NikeShoesDetailScreen({super.key, required this.shoes});

  void _openShoppingCart(
    BuildContext context,
  ) async {
    notifierButtonsVisible.value = false;
    await Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: NikeShoppingCart(shoes: shoes),
          );
        },
        opaque: false));
    notifierButtonsVisible.value = true;
  }

  Widget _buildCaroucel(BuildContext context, Size size) {
    return SizedBox(
      height: size.height * 0.4,
      child: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: 'background_${shoes.model}',
              child: Container(
                color: Color(shoes.color),
              ),
            ),
          ),
          Positioned(
            left: 70,
            right: 70,
            top: 10,
            child: ShakeTransition(
              axis: Axis.vertical,
              child: Hero(
                tag: 'number_${shoes.model}',
                child: Material(
                  color: Colors.transparent,
                  child: FittedBox(
                    child: Text(
                      shoes.modelNumber.toString(),
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black.withOpacity(0.05),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ShakeTransition(
            axis: Axis.vertical,
            child: PageView.builder(
              onPageChanged: (value) {
                notifierCurrentpage.value = value;
              },
              itemCount: shoes.images.length,
              itemBuilder: (context, index) {
                final tag = index == 0
                    ? 'image_${shoes.model}'
                    : 'image_${shoes.model}_$index';
                return Container(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: tag,
                    child: Image.asset(
                      shoes.images[index],
                      width: 250,
                      height: 250,
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 30,
              height: 6,
              child: ValueListenableBuilder(
                valueListenable: notifierCurrentpage,
                builder: (context, value, child) {
                  return Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final bool active = value == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInCubic,
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              color: active
                                  ? Colors.black
                                  : Colors.grey.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(6)),
                        );
                      },
                      itemCount: shoes.images.length,
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        notifierButtonsVisible.value = true;
      },
    );

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          'assets/logo/nike_logo.png',
          height: 40,
        ),
        leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.pop(context);
              notifierButtonsVisible.value = false;
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 18,
            )),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCaroucel(context, size),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ShakeTransition(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            shoes.model,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${shoes.oldPrice.toInt().toString()}",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
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
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const ShakeTransition(
                      duration: Duration(milliseconds: 1100),
                      child: Text(
                        'AVAILABLE SIZES',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ShakeTransition(
                      duration: const Duration(milliseconds: 1100),
                      child: SizedBox(
                          height: 16,
                          child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Text(
                                  'US ${shoesSize[index]}',
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    width: 20,
                                  ),
                              itemCount: shoesSize.length)),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const ShakeTransition(
                      child: Text(
                        'DESCRIPTION',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const ShakeTransition(
                      child: Text(
                        'The Nike Air Max 270 Men´s Shoe is inspired by...',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
          ValueListenableBuilder<bool>(
              valueListenable: notifierButtonsVisible,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      heroTag: 1,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      highlightElevation: 0,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(0, 6),
                              ),
                            ]),
                        child: const Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.grey,
                          size: 26,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    FloatingActionButton(
                      heroTag: 2,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      highlightElevation: 0,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 4,
                                blurRadius: 7,
                                offset: const Offset(0, 6),
                              ),
                            ]),
                        child: const Icon(
                          Icons.add_shopping_cart_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      onPressed: () {
                        _openShoppingCart(context);
                      },
                    )
                  ],
                ),
              ),
              builder: (context, value, child) {
                return AnimatedPositioned(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOutCubic,
                    left: 0,
                    right: 0,
                    bottom: value ? 20.0 : -kToolbarHeight * 2,
                    child: child!);
              })
        ],
      ),
    );
  }
}

List<String> shoesSize = ['6', '7', '9', '9.5', '10'];
