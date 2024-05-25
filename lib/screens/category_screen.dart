import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_category.dart';

import '../view_model/news_view_model.dart';
import 'detail_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String category = "Health";
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat("MMMM dd, yyyy");
  List<String> categoeryOptions = [
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology",
    "Politics",
    "Education",
  ];

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 52,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoeryOptions.length,
                itemBuilder: (context, int index) {
                  return InkWell(
                    onTap: () {
                      category = categoeryOptions[index];
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: category == categoeryOptions[index]
                                ? Colors.blue.shade300
                                : Colors.grey.shade500,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              categoeryOptions[index].toString(),
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder<CategoryModel>(
              future: newsViewModel.fetchNewsCategoryApi(category),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitRipple(
                      color: Colors.lightBlue,
                      size: 50,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());
                      return InkWell(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => DetailScreen(
                                  snapshot.data!.articles![index].author.toString(),
                                  snapshot.data!.articles![index].title.toString(),
                                  snapshot.data!.articles![index].description.toString(),
                                  snapshot.data!.articles![index].urlToImage.toString(),
                                  snapshot.data!.articles![index].publishedAt.toString(),
                                  snapshot.data!.articles![index].content.toString(),
                                  snapshot.data!.articles![index].source!.name.toString())));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0, left: 7.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  height: height * .14,
                                  width: width * .3,
                                  fit: BoxFit.cover,
                                  placeholder: (context, uri) =>
                                      const SpinKitFadingCircle(
                                    color: Colors.lightBlue,
                                    size: 50,
                                  ),
                                  errorWidget: (context, uri, error) =>
                                      const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 50,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                    color: Colors.grey.shade200,
                                height: height * .14,
                                padding: const EdgeInsets.all(7.0),
                                    child: Column(
                                      children: [
                                        Text(
                                      snapshot.data!.articles![index].title
                                          .toString(),
                                      maxLines: 2,
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              CupertinoColors.darkBackgroundGray),
                                    ),
                                        const Spacer(),
                                        SizedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index]
                                                .source!.name
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                            style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.blue),
                                          ),
                                          Text(
                                            format.format(dateTime),
                                            maxLines: 2,
                                            overflow: TextOverflow.fade,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ), ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
