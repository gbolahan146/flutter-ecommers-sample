import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/order/counter.dart';
import 'package:ecommers/ui/widgets/order/index.dart';
import 'package:flutter/material.dart';

class OrderWidget extends StatefulWidget {
  final String assetImagePath;
  final String primaryText;
  final String secondaryText;
  final double cost;
  final int count;
  final Function() countIncrementFunction;
  final Function() countDecrementFunction;
  final Function() tapOrderFunction;

  static const orderCircleImageSize = Size(80.0, 80.0);

  const OrderWidget({
    @required this.assetImagePath,
    @required this.primaryText,
    @required this.secondaryText,
    @required this.cost,
    @required this.count,
    @required this.countIncrementFunction,
    @required this.countDecrementFunction,
    this.tapOrderFunction,
  });

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.tapOrderFunction,
      child: Row(
        children: [
          const SizedBox(width: Insets.x4),
          CircleImage(
            size: OrderWidget.orderCircleImageSize,
            image: CachedImage(imagePath: widget.assetImagePath),
          ),
          const SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.primaryText,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText1),
                Text(widget.secondaryText,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText2),
                const SizedBox(height: 8.0),
                Text(
                  Formatter.getCost(widget.count * widget.cost),
                  style: textTheme.bodyText1
                      .copyWith(color: BrandingColors.primary),
                ),
                const SizedBox(height: 8.0),
                Counter(
                    count: widget.count,
                    countIncrementFunction: widget.countIncrementFunction,
                    countDecrementFunction: widget.countDecrementFunction)
              ],
            ),
          ),
          const SizedBox(width: Insets.x4),
        ],
      ),
    );
  }
}
