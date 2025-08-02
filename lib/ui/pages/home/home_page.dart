import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextField(
          controller: searchTextEditingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            ),
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey[300]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "구의3동 주민센터",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("구의3동 주민센터"),
                Text("구의3동 주민센터"),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20,
          );
        },
      ),
    );
  }
}
