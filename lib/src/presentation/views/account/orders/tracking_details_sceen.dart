// import 'package:amazon_clone_flutter/common/widgets/custom_app_bar.dart';
// import 'package:amazon_clone_flutter/features/admin/services/admin_services.dart';
// import 'package:amazon_clone_flutter/features/order_details/screens/order_details.dart';
// import 'package:amazon_clone_flutter/features/order_details/widgets/tracking_details.dart';
// import 'package:amazon_clone_flutter/features/product_details/widgets/divider_with_sizedbox.dart';
// import 'package:amazon_clone_flutter/models/order.dart';
// import 'package:amazon_clone_flutter/models/user.dart';
// import 'package:amazon_clone_flutter/providers/user_provider.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../constants/global_variables.dart';
// import '../../../constants/utils.dart';
// import '../../../models/product.dart';

// class TrackingDetailsScreen extends StatefulWidget {
//   static const routeName = '/tracking-details';
//   final Order order;
//   const TrackingDetailsScreen({super.key, required this.order});

//   @override
//   State<TrackingDetailsScreen> createState() => _TrackingDetailsScreenState();
// }

// class _TrackingDetailsScreenState extends State<TrackingDetailsScreen> {
//   final AdminServices adminServices = AdminServices();
//   int status = 0;

//   @override
//   void initState() {
//     super.initState();
//     status = widget.order.status;
//   }

//   final TextStyle textStyle = TextStyle(
//       fontSize: 20,
//       fontWeight: FontWeight.w500,
//       color: GlobalVariables.selectedNavBarColor);

//   final TextStyle subtextStyle = const TextStyle(
//       fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black87);

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserProvider>(context, listen: false).user;

//     return Scaffold(
//       appBar: const PreferredSize(
//           preferredSize: Size.fromHeight(60), child: CustomAppBar()),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               user.type == 'user'
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         DeliveryStatusBlock(
//                             status: status,
//                             textStyle: textStyle,
//                             subtextStyle: subtextStyle,
//                             product: widget.order.products[0],
//                             widget: widget),
//                         const DividerWithSizedBox(
//                           thickness: 0.5,
//                         ),
//                         UserAddressBlock(
//                             status: status,
//                             user: user,
//                             subtextStyle: subtextStyle,
//                             widget: widget),
//                         const DividerWithSizedBox(
//                           thickness: 4,
//                           sB1Height: 20,
//                           sB2Height: 20,
//                         ),
//                         const Text(
//                           'Delivery by Amazon',
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black87),
//                         ),
//                         Text(
//                           ' Order ID: ${widget.order.id}',
//                           style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black87),
//                         ),
//                       ],
//                     )
//                   : TrackingDetails(order: widget.order),
//               const DividerWithSizedBox(
//                 thickness: 4,
//                 sB1Height: 20,
//                 sB2Height: 15,
//               ),
//               const Text(
//                 'Order Info',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black87),
//               ),
//               const SizedBox(height: 10),
//               const Divider(
//                 thickness: 0.5,
//                 color: Color(0xffD5D9DA),
//               ),
//               ListTile(
//                 onTap: () {
//                   Navigator.pushNamed(context, OrderDetailsScreen.routeName,
//                       arguments: widget.order);
//                 },
//                 title: Text('View order details', style: subtextStyle),
//                 style: ListTileStyle.list,
//                 trailing: Icon(
//                   Icons.chevron_right_rounded,
//                   color: user.type == 'user'
//                       ? Colors.black87
//                       : GlobalVariables.greenColor,
//                 ),
//               ),
//               const Divider(
//                 thickness: 0.5,
//                 color: Color(0xffD5D9DA),
//               ),
//               const DividerWithSizedBox(
//                 thickness: 4,
//                 sB1Height: 20,
//                 sB2Height: 15,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class UserAddressBlock extends StatelessWidget {
//   const UserAddressBlock({
//     super.key,
//     required this.user,
//     required this.status,
//     required this.subtextStyle,
//     required this.widget,
//   });

//   final User user;
//   final int status;
//   final TextStyle subtextStyle;
//   final TrackingDetailsScreen widget;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
//           height: 30,
//           width: 30,
//           color: const Color(0xff4CC2B4),
//           child: Image.network(
//             'https://cdn-icons-png.flaticon.com/512/18/18442.png',
//             color: Colors.white,
//           ),
//         ),
//         const SizedBox(width: 12),
//         SizedBox(
//           height: 80,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 getStatus(status),
//                 style: subtextStyle,
//               ),
//               Text(
//                 user.name,
//                 style: subtextStyle,
//               ),
//               Text(
//                 user.address,
//                 style: subtextStyle,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   showModalBottomSheet(
//                       backgroundColor: Colors.white,
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(0),
//                           topRight: Radius.circular(0),
//                         ),
//                       ),
//                       context: context,
//                       builder: (context) {
//                         return TrackingDetails(order: widget.order);
//                       });
//                 },
//                 child: Text(
//                   'See all updates',
//                   style: subtextStyle.copyWith(
//                       color: GlobalVariables.selectedNavBarColor),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class DeliveryStatusBlock extends StatelessWidget {
//   const DeliveryStatusBlock({
//     super.key,
//     required this.status,
//     required this.textStyle,
//     required this.product,
//     required this.subtextStyle,
//     required this.widget,
//   });

//   final int status;
//   final Product product;
//   final TextStyle textStyle;
//   final TextStyle subtextStyle;
//   final TrackingDetailsScreen widget;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           flex: 6,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 getStatus(status),
//                 style: textStyle,
//               ),
//               Text(
//                 getSubStatus(status),
//                 style: subtextStyle,
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           flex: 2,
//           child: GestureDetector(
//             onTap: () {
//               navigateToProductDetails(
//                   context: context,
//                   product: product,
//                   deliveryDate: 'Null for now');
//             },
//             child: CachedNetworkImage(
//               imageUrl: widget.order.products[0].images[0],
//               height: 60,
//               width: 60,
//               fit: BoxFit.fitHeight,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
