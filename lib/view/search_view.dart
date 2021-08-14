import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/view_model/cubit/search_cubit.dart';
import 'package:shop_app/core/view_model/states/search_states.dart';
import 'package:shop_app/view/widgets/custom_text.dart';

import 'widgets/build_product_list_item.dart';
import 'widgets/custom_text_field.dart';

class SearchView extends StatelessWidget {
  SearchView({Key key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    text: 'Search',
                    hinttext: 'search here',
                    textType: TextInputType.text,
                    passwordVisible: false,
                    controller: searchController,
                    icon: const Icon(Icons.search),
                    onChanged: (value) {
                      SearchCubit.get(context).getSearchData(text: value);
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'must enter this field';
                      }
                      return null;
                    },
                  ),
                  if (state is SearchLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SearchSucseesState)
                    Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildProductListItem(
                              model: SearchCubit.get(context)
                                  .searchModel
                                  .data
                                  .data[index],
                              cubit: SearchCubit.get(context),
                              context: context,
                              isOldPrice: false),
                          separatorBuilder: (context, index) =>
                              const Divider(color: Colors.grey, height: 30.0),
                          itemCount: SearchCubit.get(context)
                              .searchModel
                              .data
                              .data
                              .length),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
