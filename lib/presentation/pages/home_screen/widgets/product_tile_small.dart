import 'package:flutter/material.dart';
import 'package:task/app/utils/themes.dart';
import 'package:task/data/models/products/product_model.dart';

class ProductTileSmall extends StatelessWidget {
  const ProductTileSmall({super.key, required this.model, this.onTap});
  final ProductsModel model;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: onTap ?? () {},
        child: Container(
            height: size.height * 0.25,
            width: size.width * 0.32,
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: LayoutBuilder(
                builder: (ctx, cstr) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: cstr.maxHeight * 0.1,
                            width: cstr.maxWidth,
                            child: Text(
                              model.category.toString(),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: CustomStyle.style.copyWith(fontSize: 14),
                            ),
                          ),
                          Card(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: cstr.maxHeight * 0.4,
                              width: cstr.maxWidth,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Center(
                                  child: Image.network(
                                    model.image.toString(),
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      return loadingProgress == null
                                          ? child
                                          : SizedBox(
                                              height: size.width * 0.1,
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
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: cstr.maxHeight * 0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    model.title.toString(),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  '\u{20B9}  ${model.price.toString()}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ]))));
  }
}
