import 'package:cafem2/consts/snackbar.dart';
import 'package:cafem2/controller/authController.dart';
import 'package:cafem2/controller/foodController.dart';
import 'package:cafem2/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  void initState() {
    FoodController().fetchfooditem();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () {
                GoRouter.of(context).goNamed(Routes.cart.name);
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              )),
          IconButton(
            onPressed: () {
              AuthController().signOut();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
        title: const Text(
          "Maharaja Chinese",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Consumer<FoodController>(
          builder: (context, controller, _) {
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.FoodItems.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        height: 100.h,
                        width: 120.w,
                        child: Image.network(
                          controller.FoodItems[index]['img'][0].toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.FoodItems[index]['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                StarRating(
                                  rating: 3.5,
                                  size: 20,
                                  color: Colors.orange,
                                  allowHalfRating: true,
                                  starCount: 5,
                                ),
                                Text("3.5")
                              ],
                            ),
                            Text(
                              controller.FoodItems[index]['desc'],
                              maxLines: 2,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: controller.FoodItems[index]['price'],
                                    style:
                                        const TextStyle(color: Colors.black)),
                                const TextSpan(
                                    text: "₹",
                                    style: TextStyle(color: Colors.black))
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              displaySnackbar("Added to cart",
                                  color: Colors.grey);
                            },
                            child: Container(
                              height: 30.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.blue,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Add to cart",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
