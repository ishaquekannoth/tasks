import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task/app/utils/themes.dart';
import 'package:task/data/models/products/product_model.dart';
import 'package:task/domain/entities/firebase/dynamic_links.dart';
import 'package:task/presentation/pages/home_screen/widgets/product_card.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    ProductsModel product = Get.arguments;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            product.category.toString().toUpperCase(),
            style: CustomStyle.style,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  DynamicLinkService().shareProductLink(product.id.toString());
                },
                icon: const FaIcon(FontAwesomeIcons.shareNodes))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ProductCard(
            product: product,
            onTap: () => {},
          ),
        ),
      ),
    );
  }
}
