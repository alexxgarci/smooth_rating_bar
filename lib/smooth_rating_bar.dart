library smooth_rating_bar;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

typedef void RatingChangeCallback(double rating);

class SmoothRatingBar extends StatefulWidget {
  SmoothRatingBar(
      {Key? key,
      required this.onRatingCallback,
      this.rating = 0.0,
      required this.starCount,
      required this.starSize,
      required this.color,
      this.borderColor,
      required this.starPadding,
      this.isBackgroundGray = false});

  final double rating;
  final int starCount;
  final double starSize;
  final Color color;
  final Color? borderColor;
  final RatingChangeCallback onRatingCallback;
  final EdgeInsets starPadding;
  final bool isBackgroundGray;

  @override
  // ignore: no_logic_in_create_state
  SmoothRatingBarState createState() => SmoothRatingBarState(
      borderColor: borderColor ?? color,
      color: color,
      isBackgroundGray: isBackgroundGray,
      onRatingCallback: onRatingCallback,
      rating: rating,
      starCount: starCount,
      starPadding: starPadding,
      starSize: starSize);
}

class SmoothRatingBarState extends State<SmoothRatingBar>
    with TickerProviderStateMixin {
  SmoothRatingBarState(
      {required this.onRatingCallback,
      required this.rating,
      required this.starCount,
      required this.starSize,
      required this.color,
      required this.borderColor,
      required this.starPadding,
      required this.isBackgroundGray});

  double rating;
  final int starCount;
  final double starSize;
  final Color color;
  final Color borderColor;
  final RatingChangeCallback onRatingCallback;
  final EdgeInsets starPadding;
  final bool isBackgroundGray;

  AnimationController? controller;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller!);

    controller!.forward();
  }

  double getRatingValue(double dragDx) {
    if (dragDx <= 0) return 0.0;
    double totalWidth = starSize * starCount +
        ((starCount - 1) * (starPadding.left + starPadding.right));
    double singleDistance = totalWidth / starCount;
    double halfStar = starSize / 2;
    for (int i = 1; i <= starCount; i++) {
      if (dragDx < singleDistance * i + halfStar) {
        if (dragDx < singleDistance * (i * 2 - 1) / 2 + halfStar) {
          return (i * 2 - 1) / 2;
        }
        return i * 1.0;
      }
    }
    return starCount * 1.0;
  }

  @override
  Widget build(BuildContext context) {
    void postInvalidateRatingValue(double rating) {
      onRatingCallback(rating);
      setState(() {
        this.rating = rating;
      });
    }

    return GestureDetector(
      onHorizontalDragUpdate: (dragDetails) {
        RenderBox box = context.findRenderObject()! as RenderBox;
        double dragDx = box.globalToLocal(dragDetails.globalPosition).dx;
        postInvalidateRatingValue(getRatingValue(dragDx));
        if (onRatingCallback != null) {
          onRatingCallback(getRatingValue(dragDx));
        }
      },
      child: FadeTransition(
        opacity: animation!,
        child: StarRating(
          rating: rating,
          starCount: starCount,
          starSize: starSize,
          color: color,
          borderColor: borderColor,
          onRatingChanged: (rating) => postInvalidateRatingValue(rating),
          starPadding: starPadding,
          isBackgroundGrey: isBackgroundGray,
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final double starSize;
  final Color color;
  final Color borderColor;
  final RatingChangeCallback onRatingChanged;
  final EdgeInsets starPadding;
  final bool isBackgroundGrey;

  StarRating(
      {super.key, required this.starCount,
      required this.starSize,
      required this.rating,
      required this.onRatingChanged,
      required this.color,
      required this.borderColor,
      required this.starPadding,
      required this.isBackgroundGrey});

  Widget buildStar(BuildContext context, int index, bool isBackgroundGrey) {
    SvgPicture icon;
    if ((index >= rating || rating == 0) && !isBackgroundGrey) {
      icon = SvgPicture.asset(
        "assets/star/star_border.svg",
        height: starSize,
        width: starSize,
        color: borderColor,
      );
    } else if ((index >= rating || rating == 0) && isBackgroundGrey) {
      icon = SvgPicture.asset(
        "assets/star/star_empty_gray.svg",
        height: starSize,
        width: starSize,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = SvgPicture.asset(
        "assets/star/star_half.svg",
        height: starSize,
        width: starSize,
        color: color,
      );
    } else {
      icon = SvgPicture.asset(
        "assets/star/star.svg",
        height: starSize,
        width: starSize,
        color: color,
      );
    }

    return GestureDetector(
      onTap: () => onRatingChanged(index + 1.0),
      child: Container(
        padding: starPadding,
        child: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            starCount, (index) => buildStar(context, index, isBackgroundGrey)));
  }
}
