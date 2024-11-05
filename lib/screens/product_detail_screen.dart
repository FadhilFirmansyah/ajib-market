import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/styles.dart';
import 'package:flutter_application_1/screens/sales_screen.dart';


class ProductDetailScreen extends StatelessWidget {
  final String productName;
  final String description;
  final String imagePath;
  final String ingredientsProduct;
  final String price;

  const ProductDetailScreen({super.key, 
    required this.productName,
    required this.description,
    required this.imagePath,
    required this.ingredientsProduct,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(imagePath),
            ),
            buttonArrow(context),
            scroll(),
          ],
        ),
      ),
    );
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  scroll() {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 35,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    productName,
                    style: TextStyles.title.copyWith(fontSize: 20.0),
                  ),
                  /*Row(//profil screen
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage("assets/avatar1.png"),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("data",
                          style: Theme.of(context).textTheme.headlineMedium!),
                      const Spacer(),
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.darkGrey,
                        child: Icon(
                          IconlyLight.heart,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text("273 Likes",
                          style: Theme.of(context).textTheme.headlineMedium!),
                    ],
                  ),*/
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Text(
                    "Description",
                    style: TextStyles.title.copyWith(fontSize: 20.0),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    description,
                    style: TextStyles.body.copyWith(fontSize: 18.0),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  /*Text(
                    "Ingredients",
                    style: TextStyles.title.copyWith(fontSize: 20.0),
                  ),*/
                  const SizedBox(
                    height: 10,
                  ),
                  ingredients(context, ingredientsProduct.split('\n')),

                  /*Text(
                    "Steps",
                    style: TextStyles.title.copyWith(fontSize: 20.0),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) => steps(context, index),
                  ),*/
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SalesScreen(productName: productName, imagePath: imagePath, description: description, price: price, ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Tambah ke Keranjang',
                        style: TextStyles.title.copyWith(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        });
  }

  ingredients(BuildContext context, List<String> ingredientList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "detail",
          style: TextStyles.title.copyWith(fontSize: 20.0),
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: ingredientList.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Color(0xFFE3FFF8),
                  child: Icon(
                    Icons.done,
                    size: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  ingredientList[index],
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Divider(
            height: 4,
          ),
        ),
      ],
    );
  }

  /*steps(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.darkBlue,
            radius: 12,
            child: Text("${index + 1}"),
          ),
          Column(children: [
              SizedBox(
                width: 270,
                child: Text("data",
                  maxLines: 3,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 10,),
              
            ],
          ),
        ],
      ),
    );
  }*/
}
