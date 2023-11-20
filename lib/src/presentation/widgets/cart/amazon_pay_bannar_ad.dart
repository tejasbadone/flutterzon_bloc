import 'package:flutter/material.dart';

class AmazonPayBannarAd extends StatelessWidget {
  const AmazonPayBannarAd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xffFFF1E4),
          border: Border.all(color: Colors.grey, width: 0.5)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/cart_screen_icons/pay_calender.png',
              height: 50,
              width: 50,
            ),
            SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Amazon Pay Later | Get instant credit up to ₹60,000',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      text: 'Activate & get rewards of ',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '₹600',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xffC40202),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '>',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )
          ]),
    );
  }
}
