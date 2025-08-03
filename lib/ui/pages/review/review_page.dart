import 'package:flutter/material.dart';
import 'package:flutter_search_place_app/data/models/place.dart';

class ReviewPage extends StatelessWidget {
  ReviewPage(this.place);
  Place place;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(place.title),
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
        bottomSheet: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            child: TextField(
              decoration: InputDecoration(contentPadding: EdgeInsets.only(bottom: 8)),
            ),
          ),
        ),
      ),
    );
  }
}
