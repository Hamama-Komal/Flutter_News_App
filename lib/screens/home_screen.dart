

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_channel.dart';
import 'package:news_app/screens/category_screen.dart';
import 'package:news_app/screens/detail_screen.dart';

import '../view_model/news_view_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList {
  bbcNews,
  aryNews,
  News24,
  cnn,
  techcrunch,
  googleNews,
  rbc,
  recode
}

class _HomeScreenState extends State<HomeScreen> {

  String name = "ary-news";
  FilterList? selectedMenu;
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat("MMMM dd, yyyy");

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset(
              "assets/images/category_icon.png",
              height: 30,
              width: 30,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryScreen()));
            },
          ),
          title: Center(
              child: Text(
            "News",
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
          )),
          actions: [
            PopupMenuButton<FilterList>(
                initialValue: selectedMenu,
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.black,
                ),
                onSelected: (FilterList item) {
                  if (FilterList.bbcNews == item) {
                    name = "bbc-news";
                  }
                  if (FilterList.aryNews == item) {
                    name = "ary-news";
                  }
                  if (FilterList.googleNews == item) {
                    name = "google-news";
                  }
                  if (FilterList.News24 == item) {
                    name = "news24";
                  }
                  if (FilterList.recode == item) {
                    name = "recode";
                  }
                  if (FilterList.rbc == item) {
                    name = "rbc";
                  }
                  if (FilterList.techcrunch == item) {
                    name = "techcrunch";
                  }
                  if (FilterList.cnn == item) {
                    name = "cnn";
                  }

                  setState(() {
                    selectedMenu = item;
                  });
                },
                itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                      const PopupMenuItem(
                        value: FilterList.aryNews,
                        child: Text("ARY News"),
                      ),
                      const PopupMenuItem(
                        value: FilterList.bbcNews,
                        child: Text("BBC News"),
                      ),
                      const PopupMenuItem(
                        value: FilterList.googleNews,
                        child: Text("Google News"),
                      ),
                      const PopupMenuItem(
                        value: FilterList.News24,
                        child: Text("News 24"),
                      ),
                      const PopupMenuItem(
                        value: FilterList.recode,
                        child: Text("Recode"),
                      ),
                    const PopupMenuItem(
                        value: FilterList.rbc,
                        child: Text("RBC"),
                      ),
                    const PopupMenuItem(
                        value: FilterList.cnn,
                        child: Text("CNN"),
                      ),
                    const PopupMenuItem(
                        value: FilterList.techcrunch,
                        child: Text("TechCrunch"),
                      ),

                    ])
          ],
          elevation: 3,
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(vertical: 7.0),
          children: [
            SizedBox(
              height: height * .45,
              width: width,
              child: FutureBuilder<NewsChannel>(
                future: newsViewModel.fetchNewsChannelHeadlinesApi(name),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitSpinningCircle(
                        color: Colors.blue,
                        size: 50,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
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
                          child: SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: height * 0.6,
                                  width: width * 0.9,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: height * 0.02,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, uri) => Container(
                                        child: spinKit2,
                                      ),
                                      errorWidget: (context, uri, error) =>
                                          const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      height: height * .22,
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: width * .7,
                                            child: Text(
                                              snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            width: width * .7,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data!.articles![index]
                                                      .source!.name
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.blue),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
              child: SizedBox(
                height: height,
                width: width,
                child: FutureBuilder<NewsChannel>(
                  future: newsViewModel.fetchNewsChannelHeadlinesApi("cnn"),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitRipple(
                          color: Colors.blue,
                          size: 50,
                        ),
                      );
                    } else {
                      return  ListView.builder(
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
                                        color: Colors.blue,
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
            ),
          ],
        ));
  }
}

const spinKit2 = SpinKitRipple(
  color: Colors.blue,
  size: 40,
);
