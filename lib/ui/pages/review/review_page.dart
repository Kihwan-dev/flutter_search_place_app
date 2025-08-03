import 'package:flutter/material.dart';

class ReviewPage extends StatelessWidget {
  ReviewPage(this.placeName);
  String placeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(placeName),
      ),
      backgroundColor: Colors.white,
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
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
                  "리뷰 글 입니다",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "2025-07-14 23:31:14.0900",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 14);
        },
      ),
    );
  }
}
