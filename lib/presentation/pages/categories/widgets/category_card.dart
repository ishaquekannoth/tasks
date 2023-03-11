import 'package:flutter/material.dart';
import 'package:task/data/models/products/product_model.dart';

class CategoryCard extends StatelessWidget {
  void Function()? onTap;
  TextStyle? style;
  String? bottomText;
  ProductsModel? productsModel;
  CategoryCard(
      {super.key,
      this.style,
      this.bottomText,
      this.onTap,
      this.productsModel}) {
    bottomText ?? (bottomText = "Bottom Text");
    style ??
        (style = const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.white,
            overflow: TextOverflow.ellipsis));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsetsDirectional.all(10),
        height: size.height * 0.3,
        width: size.width * 0.5,
        decoration:
            BoxDecoration(border: Border.all(), shape: BoxShape.rectangle),
        child: LayoutBuilder(
            builder: (ctx, cstr) => Stack(
                  children: [
                    Card(
                      child: SizedBox(
                        height: size.height * 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Center(
                            child: productsModel == null
                                ? Image.asset(
                                    "assets/images/image4.jpg",
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    productsModel!.image!,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      return loadingProgress == null
                                          ? child
                                          : SizedBox(
                                              height: size.width * 0.2,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              )));
                                    },
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: cstr.maxWidth,
                        margin: const EdgeInsets.only(
                            top: 0, bottom: 0, right: 0, left: 0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0)),
                          color: Color.fromARGB(200, 0, 0, 0),
                        ),
                        height: cstr.maxHeight * 0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(bottomText!, style: style),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
      ),
    );
  }
}
