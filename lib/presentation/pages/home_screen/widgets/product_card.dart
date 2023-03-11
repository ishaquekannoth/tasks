import 'package:flutter/material.dart';
import 'package:task/app/utils/app_colors.dart';
import 'package:task/app/utils/themes.dart';
import 'package:task/data/models/products/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onTap});
  final ProductsModel product;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.9,
      child: LayoutBuilder(
          builder: (ctx, cstr) => Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: cstr.maxHeight * 0.3,
                        width: cstr.maxWidth,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          child: Center(
                            child: Image.network(
                              product.image.toString(),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                return loadingProgress == null
                                    ? child
                                    : SizedBox(
                                        height: size.height * 0.5,
                                        child: Center(
                                            child: CircularProgressIndicator(
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
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: cstr.maxWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.rate_review_rounded,
                                  color: CustomColors.googleColor,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                SizedBox(
                                  width: cstr.maxWidth * 0.3,
                                  child: Text(
                                    "${product.rating!.rate} K Comments",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.thumb_up_sharp,
                                  color: CustomColors.blueColor,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                SizedBox(
                                  width: cstr.maxWidth * 0.1,
                                  child: Text(
                                    product.rating!.count.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration:
                                      const BoxDecoration(color: Colors.black),
                                  child: Text(
                                    "\u{20B9}",
                                    textAlign: TextAlign.center,
                                    style: CustomStyle.style.copyWith(
                                        color: CustomColors.whiteColor),
                                  ),
                                ),
                                Container(
                                  decoration:
                                      const BoxDecoration(color: Colors.black),
                                  child: Text(
                                    product.price.toString(),
                                    textAlign: TextAlign.center,
                                    style: CustomStyle.style.copyWith(
                                        color: CustomColors.whiteColor),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: cstr.maxHeight * 0.1,
                      width: cstr.maxWidth,
                      color: CustomColors.blackColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Center(
                        child: Text(
                          product.title.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                        ),
                      )),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    height: cstr.maxHeight * 0.38,
                    child: SingleChildScrollView(
                      child: Text(
                        product.description.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 10,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: cstr.maxWidth,
                    height: cstr.maxHeight * 0.08,
                    decoration: BoxDecoration(border: Border.all()),
                    child: TextButton(
                        onPressed: onTap,
                        child: Text("Add to Cart",
                            style: CustomStyle.style.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w400))),
                  ),
                ],
              )),
    );
  }
}
