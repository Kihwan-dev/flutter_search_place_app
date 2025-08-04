import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_place_app/data/models/place.dart';
import 'package:flutter_search_place_app/ui/pages/review/review_view_model.dart';

class ReviewPage extends ConsumerStatefulWidget {
  ReviewPage(this.place);
  Place place;

  @override
  ConsumerState<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends ConsumerState<ReviewPage> {
  TextEditingController reviewTextEditingController = TextEditingController();

  @override
  void dispose() {
    reviewTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviewState = ref.watch(reviewViewModel(widget.place));
    final viewModel = ref.read(reviewViewModel(widget.place).notifier);
    // viewModel.getReviews(mapx: widget.place.mapx, mapy: widget.place.mapy);
    return GestureDetector(
      onTap: () {
        if (reviewState.isWriting) return;
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.place.title),
        ),
        backgroundColor: Colors.white,
        body: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          itemCount: reviewState.reviews.length,
          itemBuilder: (context, index) {
            final review = reviewState.reviews[index];
            return GestureDetector(
              onLongPress: () {
                print("long press");
                showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Material(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        child: SizedBox(
                          width: 150,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print("수정");
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.edit, size: 26),
                                        SizedBox(width: 8),
                                        Text(
                                          "수정",
                                          style: TextStyle(fontSize: 24, height: 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(height: 1),
                                GestureDetector(
                                  onTap: () {
                                    print("삭제");
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.delete, size: 24),
                                        SizedBox(width: 8),
                                        Text(
                                          "삭제",
                                          style: TextStyle(fontSize: 24, height: 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 14);
          },
        ),
        bottomSheet: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            child: TextField(
              decoration: InputDecoration(contentPadding: EdgeInsets.only(bottom: 8)),
              controller: reviewTextEditingController,
              onSubmitted: (value) async {
                //
                final result = await viewModel.addReview(content: value, mapx: widget.place.mapx, mapy: widget.place.mapy);
                print(result);
                if (result) {
                  reviewTextEditingController.text = "";
                } else {
                  //
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
