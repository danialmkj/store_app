import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../../common/params/product_params.dart';
import '../../data/models/all_product_model.dart';
import '../../repository/all_product_repository.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final AllProductsRepository allProductsRepository;
  SearchTextField(
      {Key? key, required this.controller, required this.allProductsRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: [
      /// textfield
      SizedBox(
        height: 40,
        child: TypeAheadField(
            noItemsFoundBuilder: (context) {
              return ListTile(
                title: Text("محصولی یافت نشد."),
              );
            },
            textFieldConfiguration: TextFieldConfiguration(
              onTap: () {
                if (controller.text[controller.text.length - 1] != ' ') {
                  controller.text = (controller.text + ' ');
                }
                if (controller.selection ==
                    TextSelection.fromPosition(
                        TextPosition(offset: controller.text.length - 1))) {}
              },
              onSubmitted: (String prefix) {
                // Navigator.pushNamed(
                //   context,
                //   AllProductsScreen.routeName,
                //   arguments: ProductsArguments(searchTxt: prefix),);
              },
              controller: controller,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                contentPadding: EdgeInsets.all(3),
                prefixIcon: Container(
                    child: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    // Navigator.pushNamed(
                    //   context,
                    //   AllProductsScreen.routeName,
                    //   arguments: ProductsArguments(searchTxt: controller.text),);
                  },
                )),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0.0,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 0.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            suggestionsCallback: (String prefix) {
              return allProductsRepository.fetchAllProductsDataSearch(
                  ProductsParams(step: 6, search: prefix));
            },
            itemBuilder: (context, Products model) {
              return ListTile(
                title: Text(
                  model.name!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              );
            },
            onSuggestionSelected: (Products products) {
              controller.text = products.name!;
              // Navigator.pushNamed(
              //   context,
              //   AllProductsScreen.routeName,
              //   arguments: ProductsArguments(searchTxt: products.name!),);
            }),
      ),

      /// text and logo
      IgnorePointer(
        child: Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Row(
            children: [
              const Text(
                'جستوجو در',
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: "Yekan",
                    color: Colors.grey,
                    fontWeight: FontWeight.w200),
              ),
              ColorFiltered(
                  colorFilter:
                      ColorFilter.mode(Colors.grey.shade800, BlendMode.srcIn),
                  child: Icon(
                    Icons.shopify_rounded,
                    size: 28,
                  )),
            ],
          ),
        ),
      )
    ]);
  }
}
