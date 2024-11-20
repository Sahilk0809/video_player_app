import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player_app/provider/video_provider.dart';
import 'package:video_player_app/view/video_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<VideoProvider>(context);
    var providerFalse = Provider.of<VideoProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white.withOpacity(0.9),
        // elevation: 5,
        // shadowColor: Colors.grey.shade200,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Image.network(
              'https://t3.ftcdn.net/jpg/03/00/38/90/360_F_300389025_b5hgHpjDprTySl8loTqJRMipySb1rO0I.jpg',
              height: 50,
            ), // profile
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.cast,
                color: Colors.black,
              ),
              onPressed: () {},
              tooltip: 'Cast',
            ),
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ),
              onPressed: () {},
              tooltip: 'Notifications',
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {},
              tooltip: 'Search',
            ),
            const SizedBox(width: 10),
            const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                  'https://lh3.googleusercontent.com/a/ACg8ocLkTgBKPwC4kcFj-twlw6HrCG7m5dINEC_Pf1z4dNLi3KU4JTR5=s360-c-no'),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: providerFalse.fetchApiData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount:
                  providerTrue.videoPlayerModal!.categories.first.videos.length,
              itemBuilder: (context, index) {
                final video = providerTrue
                    .videoPlayerModal!.categories.first.videos[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Video Thumbnail
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => VideoPage(
                                videoUrl: video.sources.first,
                                title: video.title,
                                channelName: video.description,
                                views: '1M',
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: [
                              Image.network(
                                video.thumb,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              // Positioned(
                              //   bottom: 8,
                              //   right: 8,
                              //   child: Container(
                              //     padding: const EdgeInsets.symmetric(
                              //       horizontal: 8,
                              //       vertical: 4,
                              //     ),
                              //     decoration: BoxDecoration(
                              //       color: Colors.black.withOpacity(0.6),
                              //       borderRadius: BorderRadius.circular(5),
                              //     ),
                              //     child: const Text(
                              //       "10:25",
                              //       style: TextStyle(
                              //         color: Colors.white,
                              //         fontSize: 12,
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      // Video Details
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                        leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/img/ytlogo.png'),
                        ),
                        title: Text(
                          video.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          'Channel Name • ${index + 1}M views • ${index + 1} days ago',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'Shorts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: 'Subscriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}
