import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/presentation/views/account/orders/order_details.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';

class OrderedProducts extends StatelessWidget {
  const OrderedProducts({
    super.key,
    required this.widget,
    required this.textSyle,
  });

  final OrderDetailsScreen widget;
  final TextStyle textSyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.order.products.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // navigateToProductDetails(
                //     context: context,
                //     product: widget.order.products[i],
                //     deliveryDate: getDeliveryDate());
              },
              child: Row(
                children: [
                  Image.network(
                    widget.order.products[i].images[0],
                    height: 110,
                    width: 100,
                    fit: BoxFit.contain,
                    // width: 120,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.order.products[i].name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text('Qty. ${widget.order.quantity[i]}'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '₹${formatPrice(widget.order.products[i].price)}',
                    style: textSyle.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
