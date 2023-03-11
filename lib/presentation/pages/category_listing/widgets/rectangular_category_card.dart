import 'package:flutter/material.dart';
import 'package:task/app/utils/app_colors.dart';
import 'package:task/app/utils/themes.dart';
import 'package:task/data/models/products/product_model.dart';

class RectangularCard extends StatelessWidget {
  const RectangularCard(
      {super.key,
      this.style = const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.black,
          overflow: TextOverflow.ellipsis),
      required this.product,
      this.bannerText = "New Arrival",
      this.odd = 1});
  final TextStyle? style;
  final int? odd;
  final String? bannerText;
  final ProductsModel product;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(66, 161, 174, 242),
      ),
      width: size.width,
      height: size.height * 0.15,
      child: LayoutBuilder(
          builder: (ctx, cstr) => Row(
                children: [
                  Stack(
                    children: [
                      Card(
                        child: SizedBox(
                          height: cstr.maxHeight,
                          width: cstr.maxWidth * 0.4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                                child: Image.network(
                              product.image.toString(),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                return loadingProgress == null
                                    ? child
                                    : SizedBox(
                                        height: size.width * 0.2,
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
                            )),
                          ),
                        ),
                      ),
                      odd!.isOdd
                          ? Banner(
                              message: bannerText!,
                              location: BannerLocation.topStart)
                          : const SizedBox(
                              height: 0,
                              width: 0,
                            )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          product.title.toString(),
                          style: style,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: SizedBox(
                                width: cstr.maxWidth * 0.6 * 0.2,
                                child: Text(
                                  "\u{20B9} ${((product.price! * 1.5).toInt()).toString()}",
                                  style: CustomStyle.style.copyWith(
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Text(
                                "\u{20B9} ${product.price}",
                                style: CustomStyle.style.copyWith(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: cstr.maxWidth,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(
                                    Icons.rate_review_rounded,
                                    color: CustomColors.blackColor,
                                  ),
                                  SizedBox(
                                    width: cstr.maxWidth * 0.3,
                                    child: Text(
                                      "${product.rating!.rate} K Comments",
                                      style: CustomStyle.style
                                          .copyWith(fontSize: 14),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.thumb_up_sharp,
                                    color: CustomColors.blackColor,
                                  ),
                                  Text(
                                    product.rating!.count.toString(),
                                    style: CustomStyle.style
                                        .copyWith(fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )),
    );
  }
}
