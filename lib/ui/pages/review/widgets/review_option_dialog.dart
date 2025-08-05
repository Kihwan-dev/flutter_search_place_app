import 'package:flutter/material.dart';
import 'package:flutter_search_place_app/data/models/review.dart';
import 'package:flutter_search_place_app/ui/pages/review/review_view_model.dart';

class ReviewOptionDialog extends StatelessWidget {
  ReviewOptionDialog({required this.editTextEditingController, required this.viewModel, required this.review});

  final TextEditingController editTextEditingController;
  final ReviewViewModel viewModel;
  final Review review;

  @override
  Widget build(BuildContext context) {
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
                _getDialogOption(
                    title: "수정",
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) {
                          editTextEditingController.text = review.content;
                          return Dialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: TextField(
                                controller: editTextEditingController,
                                onSubmitted: (value) async {
                                  await viewModel.editReview(id: review.id, content: editTextEditingController.text).then((_) {
                                    if (!context.mounted) return;
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      );
                      // Navigator.pop(context);
                      // editTextEditingController.dispose();
                    }), // 수정
                Divider(height: 1),
                _getDialogOption(
                  title: "삭제",
                  onTap: () async {
                    await viewModel.deleteReview(review.id).then((_) {
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _getDialogOption({
    required String title,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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
              title,
              style: TextStyle(fontSize: 24, height: 2),
            ),
          ],
        ),
      ),
    );
  }
}
