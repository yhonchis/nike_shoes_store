import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nike_shoes_store/models/nike_shoes_model.dart';

const _buttonSizeWidth = 140.0;
const _buttonSizeHeight = 45.0;
const _buttonCircleSize = 45.0;
const _finalImageSize = 30.0;
const _imageSize = 120.0;

class NikeShoppingCart extends StatefulWidget {
  final NikeShoes shoes;
  const NikeShoppingCart({super.key, required this.shoes});

  @override
  State<NikeShoppingCart> createState() => _NikeShoppingCartState();
}

class _NikeShoppingCartState extends State<NikeShoppingCart>
    with SingleTickerProviderStateMixin {
  int? _shoesSizeCurrent;

  AnimationController? _controller;
  Animation? _animationResize;
  Animation? _animationMovementIn;
  Animation? _animationMovementOut;

  void _selectSize(int current) {
    setState(() {
      if (_shoesSizeCurrent == current) {
        _shoesSizeCurrent = null;
      } else {
        _shoesSizeCurrent = current;
      }
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _animationResize = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller!, curve: const Interval(0.0, 0.3)));
    _animationMovementIn = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller!,
        curve:
            const Interval(0.45, 0.55, curve: Curves.fastLinearToSlowEaseIn)));
    _animationMovementOut = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller!,
        curve: const Interval(0.6, 1.0, curve: Curves.elasticIn)));
    _controller!.addListener(() {
      setState(() {});
    });
    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pop();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final panelSizeWidth = (size.width * _animationResize!.value)
        .clamp(_buttonCircleSize, size.width);
    final currentImageSize = (_imageSize * _animationResize!.value)
        .clamp(_finalImageSize, _imageSize);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedBuilder(
        animation: _controller!,
        builder: (context, child) {
          return child!;
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
                child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                child: Container(
                  color: Colors.black87,
                ),
              ),
            )),
            Positioned.fill(
                child: Stack(
              alignment: Alignment.center,
              children: [
                if (_animationMovementIn!.value != 1)
                  Positioned(
                    top: size.height * 0.4 +
                        (_animationMovementIn!.value * size.height * 0.5),
                    width: panelSizeWidth,
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn,
                      tween: Tween(begin: 1.0, end: 0.0),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(0, value * size.height * 0.6),
                          child: child,
                        );
                      },
                      child: Container(
                        width: (size.width * _animationResize!.value)
                            .clamp(_buttonCircleSize, size.width),
                        height: (size.height * 0.6 * _animationResize!.value)
                            .clamp(_buttonCircleSize, size.height * 0.6),
                        padding: EdgeInsets.symmetric(
                            horizontal: _animationResize!.value == 1 ? 16 : 0,
                            vertical: _animationResize!.value == 1 ? 20 : 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(30),
                                topRight: const Radius.circular(30),
                                bottomLeft: _animationResize!.value == 1
                                    ? const Radius.circular(0)
                                    : const Radius.circular(30),
                                bottomRight: _animationResize!.value == 1
                                    ? const Radius.circular(0)
                                    : const Radius.circular(30))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: _animationResize!.value == 1
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: _animationResize!.value == 1
                                  ? MainAxisAlignment.spaceBetween
                                  : MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  widget.shoes.images.first,
                                  height: currentImageSize,
                                ),
                                if (_animationResize!.value == 1) ...[
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        widget.shoes.model,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "\$${widget.shoes.currentPrice.toInt().toString()}",
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  )
                                ]
                              ],
                            ),
                            if (_animationResize!.value == 1) ...[
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/feet.png',
                                    width: 16,
                                    height: 16,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text(
                                    'SELECT SIZE',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                height: 32,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final bool active =
                                          _shoesSizeCurrent == index;
                                      return GestureDetector(
                                        onTap: () => _selectSize(index),
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: active
                                                  ? Colors.black
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey
                                                      .withOpacity(0.4))),
                                          child: Text(
                                            'US ${shoesSize[index]}',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: active
                                                    ? Colors.white
                                                    : Colors.black87,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          width: 10,
                                          height: 10,
                                        ),
                                    itemCount: shoesSize.length),
                              )
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 40.0 - (_animationMovementOut!.value * 100),
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                    tween: Tween(begin: 1.0, end: 0.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, value * size.height * 0.6),
                        child: child,
                      );
                    },
                    child: InkWell(
                      onTap: _shoesSizeCurrent == null
                          ? null
                          : () {
                              _controller!.forward();
                            },
                      child: AnimatedContainer(
                        width: (_buttonSizeWidth * _animationResize!.value)
                            .clamp(_buttonCircleSize, _buttonSizeWidth),
                        height: (_buttonSizeHeight * _animationResize!.value)
                            .clamp(_buttonCircleSize, _buttonSizeHeight),
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                            color: _shoesSizeCurrent == null
                                ? Colors.black12
                                : Colors.black,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Expanded(
                                child: Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              if (_animationResize!.value == 1) ...[
                                const SizedBox(
                                  width: 5,
                                ),
                                const Expanded(
                                  flex: 3,
                                  child: Text(
                                    'ADD TO CART',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11),
                                  ),
                                )
                              ]
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

List<String> shoesSize = ['6', '7', '9', '9.5', '10'];
