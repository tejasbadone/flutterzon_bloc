import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/home/address_bar.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/home/carousel_image.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/home/deal_of_the_day.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/home/multi_image_offer.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/home/single_image_offer.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/widgets/home/top_categories.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const AddressBar(),
              const TopCategories(),
              CarouselImage(),
              Container(
                decoration:
                    const BoxDecoration(gradient: Constants.goldenGradient),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DealOfTheDay(),
                      MultiImageOffer(
                        mapName: Constants.multiImageOffer2,
                        headtitle: 'Water bottles, lunch boxes, jars & more',
                        subTitle: 'Minimum 60% off',
                        productCategory: 'Home',
                      ),
                      SingleImageOffer(
                        headTitle:
                            'Limited period offers on best-selling TVs | Starting ₹8,999',
                        subTitle: 'Up to 18 months No Cost EMI',
                        image:
                            'https://res.cloudinary.com/dthljz11q/image/upload/v1699881799/single_image_offers/ulrpitq6hf4rocgo0m8w.jpg',
                        productCategory: 'Electronics',
                      ),
                      MultiImageOffer(
                        mapName: Constants.multiImageOffer3,
                        headtitle: 'Lowest prices on latest 4K smart TVs',
                        subTitle: 'Save up to ₹40000 + Up to 3 years warranty',
                        productCategory: 'Electronics',
                      ),
                      SingleImageOffer(
                        headTitle: 'Top deals on headsets',
                        subTitle: 'Up to 80% off',
                        image:
                            'https://res.cloudinary.com/dthljz11q/image/upload/v1699881798/single_image_offers/x5gqgg5ynbjkslyvefpk.jpg',
                        productCategory: 'Mobiles',
                      ),
                      MultiImageOffer(
                        mapName: Constants.multiImageOffer1,
                        headtitle: 'Deals on electronics and accessories',
                        subTitle: 'Up to 75% off + Rs. 5000 back discount',
                        productCategory: 'Grocrey',
                      ),
                      SizedBox.square(
                        dimension: 10,
                      ),
                      SingleImageOffer(
                        headTitle: 'Buy 2 Get 10% off, freebies & more offers',
                        subTitle: 'See all offers',
                        image:
                            'https://res.cloudinary.com/dthljz11q/image/upload/v1699881798/single_image_offers/u0ozqtcnhnl1eqoht85j.jpg',
                        productCategory: 'Home',
                      ),
                      MultiImageOffer(
                        mapName: Constants.multiImageOffer4,
                        headtitle: 'Handpicked sports & fitness products',
                        subTitle: 'Starting ₹49 + 20% cashback',
                        productCategory: 'Home',
                      ),
                      SingleImageOffer(
                        headTitle: 'Price crash | Amazon Brands & more',
                        subTitle: 'Under ₹499 | T-shirts & shirts',
                        image:
                            'https://res.cloudinary.com/dthljz11q/image/upload/v1699881800/single_image_offers/kwfypkjyfqjsipniefav.png',
                        productCategory: 'Fashion',
                      ),
                      MultiImageOffer(
                        mapName: Constants.multiImageOffer5,
                        headtitle: 'Festival specials',
                        subTitle:
                            'Minimum 40% off + Extra up to ₹120 cashback ',
                        productCategory: 'Grocery',
                      ),
                      SingleImageOffer(
                        headTitle: 'Amazon coupons | Smartphones & accessories',
                        subTitle: 'Extra up to ₹2000 off with coupons',
                        image:
                            'https://res.cloudinary.com/dthljz11q/image/upload/v1699881799/single_image_offers/rmtbk89pmenhd3mulcus.jpg',
                        productCategory: 'Mobiles',
                      ),
                      SizedBox.square(dimension: 8)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
