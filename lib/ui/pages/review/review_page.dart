import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_place_app/data/models/place.dart';
import 'package:flutter_search_place_app/ui/pages/review/review_view_model.dart';
import 'package:flutter_search_place_app/ui/pages/review/widgets/review_list_view.dart';

class ReviewPage extends StatefulWidget {
  ReviewPage(this.place);
  Place place;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  TextEditingController reviewTextEditingController = TextEditingController();

  @override
  void dispose() {
    reviewTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final reviewState = ref.watch(reviewViewModel(widget.place));
    // final viewModel = ref.read(reviewViewModel(widget.place).notifier);
    return Consumer(builder: (context, ref, child) {
      final reviewState = ref.watch(reviewViewModel(widget.place));
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
          body: ReviewListView(widget.place),
          bottomSheet: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
              child: Consumer(builder: (context, ref, child) {
                final viewModel = ref.read(reviewViewModel(widget.place).notifier);
                return TextField(
                  decoration: InputDecoration(contentPadding: EdgeInsets.only(bottom: 8)),
                  controller: reviewTextEditingController,
                  onSubmitted: (value) async {
                    //
                    final result = await viewModel.addReview(content: value, mapx: widget.place.mapx, mapy: widget.place.mapy);
                    if (result) {
                      reviewTextEditingController.text = "";
                    } else {
                      //
                    }
                  },
                );
              }),
            ),
          ),
        ),
      );
    });
  }
}
