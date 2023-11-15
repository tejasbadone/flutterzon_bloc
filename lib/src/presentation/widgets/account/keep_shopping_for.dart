// import 'package:amazon_clone_flutter/features/home/screens/category_deals_screen.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../constants/global_variables.dart';
// import '../../../constants/utils.dart';
// import '../../../providers/user_provider.dart';
// import '../screens/browsing_history.dart';

// class KeepShoppingFor extends StatelessWidget {
//   const KeepShoppingFor({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final user = context.watch<UserProvider>().user;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Keep shopping for',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
//               ),
//               TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, BrowsingHistory.routeName);
//                   },
//                   child: Text(
//                     'Browsing history',
//                     style: TextStyle(
//                         fontWeight: FontWeight.normal,
//                         fontSize: 14,
//                         color: GlobalVariables.selectedNavBarColor),
//                   ))
//             ],
//           ),
//           user.keepShoppingFor.isEmpty
//               ? const SizedBox()
//               : GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   scrollDirection: Axis.vertical,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     mainAxisSpacing: 8,
//                     crossAxisSpacing: 15,
//                     childAspectRatio: user.keepShoppingFor.length == 1
//                         ? 2.0
//                         : user.keepShoppingFor.length == 3
//                             ? 0.7
//                             : 1.15,
//                     crossAxisCount: user.keepShoppingFor.length >= 4
//                         ? 2
//                         : user.keepShoppingFor.length,
//                   ),
//                   itemCount: user.keepShoppingFor.length >= 4
//                       ? 4
//                       : user.keepShoppingFor.length,
//                   itemBuilder: (context, index) {
//                     if (user.wishList.length >= 4) {
//                       index =
//                           getUniqueRandomInt(max: user.keepShoppingFor.length);
//                     }

//                     return InkWell(
//                       onTap: () {
//                         Navigator.pushNamed(
//                             context, CategoryDealsScreen.routeName,
//                             arguments: user.keepShoppingFor[index]['product']
//                                 ['category']);
//                       },
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 7, horizontal: 6),
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               border:
//                                   Border.all(color: Colors.black12, width: 1.5),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             child: CachedNetworkImage(
//                               imageUrl: user.keepShoppingFor[index]['product']
//                                   ['images'][0],
//                               height: 110,
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             '  ${user.keepShoppingFor[index]['product']['category']}',
//                             style: const TextStyle(
//                                 fontSize: 14, color: Colors.black87),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//         ],
//       ),
//     );
//   }
// }
