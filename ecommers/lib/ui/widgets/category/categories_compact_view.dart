import 'package:ecommers/core/models/page_arguments.dart';
import 'package:flutter/material.dart';

import '../../../core/common/index.dart';
import '../../../core/models/data_models/index.dart';
import '../../../core/services/index.dart';
import '../../../generated/i18n.dart';
import '../../../ui/decorations/dimens/index.dart';
import '../../../ui/decorations/index.dart';
import '../../../ui/widgets/category/category_item.dart';

class CategoriesCompactView extends StatelessWidget {
  static const _containerHeight = 134.0;
  static const categoryItemSize = Size(74.0, 89.0);

  final List<Category> categories;

  const CategoriesCompactView(this.categories);

  @override
  Widget build(BuildContext context) {
    if (categories == null || categories.isEmpty) return const SizedBox();

    return Container(
      height: _containerHeight,
      padding: const EdgeInsets.symmetric(horizontal: Insets.x6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(
              I18n.of(context).categoriesTitle,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          _createCategoriesListWidget(context),
        ],
      ),
    );
  }

  Widget _createCategoriesListWidget(BuildContext context) {
    final itemCount = _calculateItemCount(context);
    final spacing = _calculateItemSpacing(context, itemCount);

    return SizedBox(
      height: categoryItemSize.height,
      child: ListView.separated(
        itemCount: itemCount,
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: spacing,
          height: spacing,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          if (index == itemCount - 1 && index != categories.length - 1) {
            return _buildSeeAllCategory(context);
          }

          final categoryModel = categories[index];

          return CategoryItem(
            model: categoryModel,
            onTapFunction: () => onCategoryTap(categoryModel.type),
          );
        },
      ),
    );
  }

  void onCategoryTap(Categories type) {
    navigationService.navigateTo(
      Pages.productsGrid,
      arguments: PageArguments(arg1: type),
    );
  }

  Widget _buildSeeAllCategory(BuildContext context) {
    const whiteColorHex = '#ffffff';

    final seeAllCategoryModel = Category(
      title: I18n.of(context).seeAllCategoryTitle,
      shadowColor: '#${BrandingColors.blur.value.toRadixString(16)}',
      type: Categories.seeAll,
      gradientColor1: whiteColorHex,
      gradientColor2: whiteColorHex,
    );

    return CategoryItem(
      model: seeAllCategoryModel,
      onTapFunction: () =>
          navigationService.navigateTo(Pages.categories, arguments: categories),
    );
  }

  int _calculateItemCount(BuildContext context) {
    final categoriesCount = categories.length;

    final categoriesListWidth =
        MediaQuery.of(context).size.width - Dimens.pagePadding * 2;

    var itemCount = categoriesListWidth ~/ categoryItemSize.width;

    if (itemCount > categoriesCount) {
      itemCount = categoriesCount;
    } else {
      itemCount = itemCount;
    }

    return itemCount;
  }

  double _calculateItemSpacing(BuildContext context, int itemCount) {
    final categoriesListWidth =
        MediaQuery.of(context).size.width - Dimens.pagePadding * 2;

    final calculatedListSpacing =
        (categoriesListWidth % categoryItemSize.width) / (itemCount - 1);

    return calculatedListSpacing;
  }
}