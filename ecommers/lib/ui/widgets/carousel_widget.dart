import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

class CarouselWidget extends StatelessWidget {
  final List<String> assetImagePaths;
  final ValueNotifier<int> currentPageNotifier;
  final double height;

  const CarouselWidget(
      {@required this.assetImagePaths,
      @required this.currentPageNotifier,
      this.height});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _buildCircleIndicator(),
        _buildPageView(),
      ],
    );
  }

  Widget _buildCircleIndicator() {
    return CirclePageIndicator(
      itemCount: assetImagePaths.length,
      selectedDotColor: BrandingColors.secondary,
      dotColor: BrandingColors.backgroundIcon,
      currentPageNotifier: currentPageNotifier,
    );
  }

  Widget _buildPageView() {
    return SizedBox(
      height: height,
      child: PageView.builder(
          itemCount: assetImagePaths.length,
          controller: PageController(initialPage: 0),
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Image.asset(
                assetImagePaths[index],
                scale: 0.5,
              ),
            );
          },
          onPageChanged: (int index) {
            currentPageNotifier.value = index;
          }),
    );
  }
}
