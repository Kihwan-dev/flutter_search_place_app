import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_place_app/data/models/place.dart';
import 'package:flutter_search_place_app/data/models/review.dart';
import 'package:flutter_search_place_app/ui/pages/review/review_view_model.dart';
import 'package:flutter_search_place_app/ui/pages/review/widgets/review_option_dialog.dart';

class ReviewListView extends StatelessWidget {
  ReviewListView(this.place);
  final Place place;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final reviewState = ref.watch(reviewViewModel(place));
      return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        itemCount: reviewState.reviews.length,
        itemBuilder: (context, index) {
          final review = reviewState.reviews[index];
          return _getReviewCard(
            context: context,
            review: review,
            place: place,
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 14);
        },
      );
    });
  }

  GestureDetector _getReviewCard({
    required BuildContext context,
    required Review review,
    required Place place,
  }) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return ReviewOptionDialog(
              review: review,
              place: place,
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[400]!,
            ),
            borderRadius: BorderRadius.circular(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.content,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              review.createdAt.toString(),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
