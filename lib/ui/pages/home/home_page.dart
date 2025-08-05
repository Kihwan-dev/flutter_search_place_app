import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_place_app/ui/pages/home/home_view_model.dart';
import 'package:flutter_search_place_app/ui/pages/home/widgets/place_list_view.dart';

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
            Consumer(builder: (context, ref, child) {
              return Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () async {
                    final address = await ref.read(homeViewModel.notifier).searchByCurrentLocation();
                    searchTextEditingController.text = address.isEmpty ? "" : address;
                  },
                  child: Icon(Icons.gps_fixed),
                ),
              );
            }),
          ],
        ),
        body: Consumer(builder: (context, ref, child) {
          final homeState = ref.watch(homeViewModel);
          return homeState.isSearching
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : PlaceListView();
        }),
      ),
    );
  }
}
