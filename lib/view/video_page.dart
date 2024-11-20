import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../provider/video_provider.dart';

class VideoPage extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String channelName;
  final String views;

  const VideoPage({
    super.key,
    required this.videoUrl,
    required this.title,
    required this.channelName,
    required this.views,
  });

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<VideoProvider>(context, listen: false)
          .initializePlayer(widget.videoUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<VideoProvider>(context);
    var providerFalse = Provider.of<VideoProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Video Player Section
              if (providerTrue.chewieController != null &&
                  providerTrue.videoPlayerController.value.isInitialized)
                AspectRatio(
                  aspectRatio:
                      providerTrue.videoPlayerController.value.aspectRatio,
                  child: Chewie(controller: providerTrue.chewieController!),
                )
              else
                const Center(child: CircularProgressIndicator()),

              // Video Details Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${widget.channelName} • ${widget.views} views',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            _buildAction(Icons.thumb_up, 'Like'),
                            const SizedBox(width: 16),
                            _buildAction(Icons.thumb_down, 'Dislike'),
                          ],
                        ),
                        Row(
                          children: [
                            _buildAction(Icons.share, 'Share'),
                            const SizedBox(width: 16),
                            _buildAction(Icons.download, 'Download'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.grey, height: 1),

              // Channel Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'https://lh3.googleusercontent.com/a/ACg8ocLkTgBKPwC4kcFj-twlw6HrCG7m5dINEC_Pf1z4dNLi3KU4JTR5=s360-c-no'),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sahil',
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '1.2M subscribers',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Subscribe',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.grey, height: 1),

              // Comments Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Comments (123)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      leading: const CircleAvatar(
                        child: Text(
                          'J',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      title: const Text(
                        'John Doe',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                        'Great video, really enjoyed it!',
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.thumb_up, color: Colors.grey),
                        onPressed: () {},
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),

              // Suggested Videos Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Up Next',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              // FutureBuilder(
              //   future: providerFalse.fetchApiData(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return ListView.builder(
              //         itemCount: 6,
              //         itemBuilder: (context, index) {
              //           return Padding(
              //             padding: const EdgeInsets.all(10.0),
              //             child: Shimmer.fromColors(
              //               baseColor: Colors.grey.shade300,
              //               highlightColor: Colors.grey.shade100,
              //               child: Container(
              //                 height: 200,
              //                 width: double.infinity,
              //                 decoration: BoxDecoration(
              //                   color: Colors.grey,
              //                   borderRadius: BorderRadius.circular(10),
              //                 ),
              //               ),
              //             ),
              //           );
              //         },
              //       );
              //     } else {
              //       return ListView.builder(
              //         physics: const NeverScrollableScrollPhysics(),
              //         shrinkWrap: true,
              //         itemCount: providerTrue
              //             .videoPlayerModal!.categories.first.videos.length,
              //         itemBuilder: (context, index) {
              //           final video = providerTrue
              //               .videoPlayerModal!.categories.first.videos[index];
              //
              //           return ListTile(
              //             leading: ClipRRect(
              //               borderRadius: BorderRadius.circular(5),
              //               child: Image.network(
              //                 video.thumb,
              //                 height: 70,
              //                 width: 120,
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //             title: Text(
              //               video.title,
              //               style: const TextStyle(
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //               maxLines: 2,
              //               overflow: TextOverflow.ellipsis,
              //             ),
              //             subtitle: Text(
              //               'Channel Name • 2.3M views • ${index + 1} days ago',
              //               style: const TextStyle(
              //                 fontSize: 12,
              //                 color: Colors.grey,
              //               ),
              //             ),
              //             trailing: IconButton(
              //               icon: const Icon(Icons.more_vert),
              //               onPressed: () {},
              //             ),
              //           );
              //         },
              //       );
              //     }
              //   },
              // ),
              FutureBuilder(
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
                    // Filter out the current video based on the URL or another unique property
                    final videos = providerTrue
                        .videoPlayerModal!.categories.first.videos
                        .where(
                            (video) => video.sources.first != widget.videoUrl)
                        .toList();

                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        final video = videos[index];

                        return ListTile(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
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
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              video.thumb,
                              height: 70,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            video.title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            'Channel Name • 2.3M views • ${index + 1} days ago',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {},
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAction(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.grey[700]),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
