import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_place_app/ui/pages/home/home_view_model.dart';
import 'package:flutter_search_place_app/ui/pages/review/review_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  void dispose() {
    searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Consumer(
            builder: (context, ref, child) {
              return TextField(
                controller: searchTextEditingController,
                onSubmitted: (value) {
                  ref.read(homeViewModel.notifier).searchPlaces(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),
          actions: [
            Container(
              width: 50,
              height: 50,
              child: GestureDetector(
                onTap: () {
                  print("gps");
                },
                child: Icon(Icons.gps_fixed),
              ),
            ),
          ],
        ),
        body: Consumer(builder: (context, ref, child) {
          final places = ref.watch(homeViewModel).places;
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewPage(place)));
                },
                child: Container(
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
                        place.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(place.category),
                      Text(place.roadAddress),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 20,
              );
            },
          );
        }),
      ),
    );
  }
}
