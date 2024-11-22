import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';
import 'package:videos/Widget/customVideoControls.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  _ReelsScreenState createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final CollectionReference _reelsCollection =
      FirebaseFirestore.instance.collection("reels");

  List<Map<String, dynamic>> _reels = [];
  final List<FlickManager?> _flickManagers = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchReelsFromFirestore();
  }

  Future<void> fetchReelsFromFirestore() async {
    try {
      final QuerySnapshot snapshot = await _reelsCollection.get();

      if (snapshot.docs.isNotEmpty) {
        final List<Map<String, dynamic>> reels = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {
            "id": doc.id,
            "description": data['description'] ?? "",
            "hashtags": List<String>.from(data['hashtags'] ?? []),
            "isLiked": data['isLiked'] ?? false,
            "postedBy": data['postedBy'] ?? "",
            "profileImage": data['profileImage'] ?? "",
            "title": data['title'] ?? "",
            "url": data['url'] ?? "",
          };
        }).toList();

        setState(() {
          _reels = reels;
        });

        initializeFlickManagers();
      }
    } catch (e) {
      print("Error fetching reels from Firestore: $e");
    }
  }


   Future<void> toggleLike(int index) async {
    final reel = _reels[index];
    final newLikeStatus = !reel['isLiked']; // Toggle the `isLiked` value

    try {
      // Update Firestore database
      await _reelsCollection.doc(reel['id']).update({"isLiked": newLikeStatus});

      // Update local state
      setState(() {
        _reels[index]['isLiked'] = newLikeStatus;
      });
    } catch (e) {
      print("Error updating like status: $e");
    }
  }


 void initializeFlickManagers() {
    for (var reel in _reels) {
      _flickManagers.add(
        FlickManager(
          videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(reel['url'])),
        ),
      );
    }
    if (_flickManagers.isNotEmpty) {
      _flickManagers[0]?.flickControlManager?.play(); // Play the first video
    }
  }

void handlePageChange(int index) {
    if (index < _flickManagers.length) {
      // Pause the previous video
      _flickManagers[_currentIndex]?.flickControlManager?.pause();

      // Play the next video
      _flickManagers[index]?.flickControlManager?.play();

      setState(() {
        _currentIndex = index;
      });
    }
  }

  

 

  @override
  Widget build(BuildContext context) {
    // print(_flickManagers[0].toString());
    return Scaffold(
      body: _reels.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _reels.length,
              onPageChanged:handlePageChange,
              itemBuilder: (context, index) {
                final reel = _reels[index];
                final flickManager = _flickManagers[index];

                return GestureDetector(
                  onDoubleTap: () => toggleLike( index) ,
                  child: flickManager != null
                      ? Stack(
                          children: [
                            FlickVideoPlayer(
                                flickManager: flickManager,
                                flickVideoWithControls: FlickVideoWithControls(
                                  videoFit: BoxFit.cover,
                                  
                                  // controls: FlickPortraitControls(
                                  //   progressBarSettings: FlickProgressBarSettings(
                                  //     padding: EdgeInsets.only(top: 20),
                                  //     backgroundColor: Colors.grey.withOpacity(0.5),
                                  //     bufferedColor: Colors.white.withOpacity(0.7),
                                  //   ),
                                    
                                  //    iconSize: 0,
                                  //     fontSize: 0,
                                  // ),
                                  
                                  controls: CustomVideoControls(flickManager: flickManager),
                                  
                                )),
                            Positioned(
                              top: 45,
                              left: 20,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(reel['profileImage']),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(reel['postedBy'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 150,
                              right: 20,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () =>  toggleLike(index),
                                    icon: Icon(
                                      reel['isLiked']
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.redAccent,
                                      size: 35,
                                    ),
                                  ),
                                  // SizedBox(width: 5),
                                  // Text(
                                  //   reel['isLiked'] ? 'Liked' : 'Like',
                                  //   style: TextStyle(color: Colors.white),
                                  // )
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 1,
                              
                              // left: 10,
                              // right: 10,
                              child: Container(
                                
                                padding: const EdgeInsets.only(bottom: 35),
                                width: MediaQuery.of(context).size.width,
                                // height: double.infinity,

                                decoration: const BoxDecoration(
                                  color: Colors.black45
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: 10),
                                    Text(reel['title'],
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18)),
                                    const SizedBox(height: 5),
                                    Text(reel['description'],
                                        style: const TextStyle(
                                            color: Colors.white70, fontSize: 14)),
                                    const SizedBox(height: 5),
                                    Text(
                                      reel['hashtags'].join('#'),
                                      style: const TextStyle(
                                          color: Colors.blueAccent, fontSize: 12),
                                    ),
                                    const SizedBox(height: 10),
                                    
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : const Center(child: CircularProgressIndicator()),
                );
              },
            ),
    );
  }
}
