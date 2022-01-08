import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback? onRatingChanged;
  final Color? color;
  final Color? borderColor;
  final double size;
  final bool allowHalfRating;
  final IconData? filledIconData;
  final IconData? halfFilledIconData;
  final IconData? defaultIconData;
  final double spacing;

  StarRating({
    this.starCount = 5,
    this.spacing = 0.0,
    this.rating = 0.0,
    this.defaultIconData,
    this.onRatingChanged,
    this.color,
    this.borderColor,
    this.size = 24,
    this.filledIconData,
    this.halfFilledIconData,
    this.allowHalfRating = true,
  }) {
    assert(this.rating != null);
  }

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        defaultIconData != null ? defaultIconData : Icons.star_border,
        color: borderColor ?? Theme.of(context).primaryColor,
        size: size,
      );
    } else if (index > rating - (allowHalfRating ? 1.0 : 0.5) &&
        index < rating) {
      icon = new Icon(
        halfFilledIconData != null ? halfFilledIconData : Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
        size: size,
      );
    } else {
      icon = new Icon(
        filledIconData != null ? filledIconData : Icons.star,
        color: color ?? Theme.of(context).primaryColor,
        size: size,
      );
    }

  final _key = GlobalKey();
  return new GestureDetector(
      onTap: () {
        if (this.onRatingChanged != null) onRatingChanged!(index + 1.0);
      },
      // onHorizontalDragUpdate: (dragDetails) {
      //   RenderObject? box = _key.currentContext!.findRenderObject();
      //   var _pos = box!.globalToLocal(dragDetails.globalPosition);
      //   var i = _pos.dx / size;
      //   var newRating = allowHalfRating ? i.round().toDouble() : i;
      //   if (newRating > starCount) {
      //     newRating = starCount.toDouble();
      //   }
      //   if (newRating < 0) {
      //     newRating = 0.0;
      //   }
      //   if (this.onRatingChanged != null) onRatingChanged!(newRating);
      // },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: spacing,
        children: new List.generate(
          starCount,
          (index) => buildStar(context, index),
        ),
      ),
    );
  }
}
