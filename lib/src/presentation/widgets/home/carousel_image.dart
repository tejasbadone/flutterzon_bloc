import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/logic/blocs/home_blocs/carousel_bloc/carousel_image_bloc.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_offers.dart';
import 'custom_carousel_slider.dart';
import 'dots_indicator.dart';

class CarouselImage extends StatelessWidget {
  CarouselImage({super.key});

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselImageBloc, CarouselImageState>(
      builder: (context, state) {
        if (state is CarouselImageChangeState) {
          return CarouselImageWidget(
            controller: _controller,
            index: state.index,
          );
        } else {
          return CarouselImageWidget(
            controller: _controller,
            index: 0,
          );
        }
      },
    );
  }
}

class CarouselImageWidget extends StatelessWidget {
  const CarouselImageWidget({
    super.key,
    required CarouselController controller,
    required this.index,
  }) : _controller = controller;

  final CarouselController _controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomCarouselSliderMap(
            sliderImages: Constants.carouselImages,
            onPageChanged: (index, reason) {
              BlocProvider.of<CarouselImageBloc>(context)
                  .add(CarouselImageChangedEvent(index: index));
            }),
        Positioned(
          top: 245,
          left: MediaQuery.sizeOf(context).width / 3.3,
          child: DotsIndicatorMap(
            controller: _controller,
            current: index,
            sliderImages: Constants.carouselImages,
          ),
        ),
        Positioned(
            bottom: 0,
            child: Container(
              height: 180,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.95),
                    Colors.white,
                  ],
                  stops: const [0, 0.1, 0.4, 0.6],
                ),
              ),
            )),
        const Positioned(
          bottom: 0,
          child: BottomOffers(),
        ),
      ],
    );
  }
}
