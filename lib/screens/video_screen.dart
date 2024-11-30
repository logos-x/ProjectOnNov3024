import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// class VideoListScreen extends StatefulWidget {
//   const VideoListScreen({super.key});
//
//   @override
//   _VideoListScreenState createState() => _VideoListScreenState();
// }

// class _VideoListScreenState extends State<VideoListScreen> {
//   // Danh sách video (bao gồm tên video và đường dẫn đến tài nguyên)
//   // final List<Map<String, String>> videos = [
//   //   {'title': 'Video 1', 'asset': 'assets/videos/sample.mp4'},
//   //   {'title': 'Video 2', 'asset': 'assets/videos/sample.mp4'},
//   //   {'title': 'Video 3', 'asset': 'assets/videos/sample.mp4'},
//   //   {'title': 'Video 4', 'asset': 'assets/videos/sample.mp4'},
//   //   // có thể thêm nhiều video ở đây
//   // ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Video List")),
//       body: ListView.builder(
//         itemCount: videos.length,
//         itemBuilder: (context, index) {
//           final video = videos[index];
//
//           return ListTile(
//             contentPadding: const EdgeInsets.all(8),
//             leading:const Icon(Icons.video_library, size: 40), // Thêm icon video
//             title: Text(video['title']!), // Tiêu đề video
//             onTap: () {
//               // Khi nhấn vào một video, chuyển đến màn hình video
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => VideoScreen(
//                     videos: videos,
//                     initialIndex: index,
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

class VideoScreen extends StatefulWidget {
  // final List<Map<String, String>> videos;
  final List<String> videos;
  final int initialIndex;

  const VideoScreen({super.key, required this.videos, required this.initialIndex});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _initializeVideoController();
  }

  void _initializeVideoController() {
    // _controller?.dispose(); // Hủy controller cũ để tránh xung đột
    _controller = VideoPlayerController.asset(widget.videos[_currentIndex])
      ..initialize().then((_) {
        setState(() {}); // Cập nhật lại trạng thái khi video mới đã sẵn sàng
      });
  }

  void _loadVideo(String videoAsset) {
    _controller = VideoPlayerController.asset(videoAsset)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  void _playNextVideo() {
    setState(() {
      // Chuyển sang video tiếp theo (quay về đầu nếu đang ở cuối)
      _currentIndex = (_currentIndex + 1) % widget.videos.length;
      _loadVideo(widget.videos[_currentIndex]);
    });
  }

  void _playPreviousVideo() {
    setState(() {
      // Chuyển về video trước đó (quay về cuối nếu đang ở đầu)
      _currentIndex = (_currentIndex - 1 + widget.videos.length) % widget.videos.length;
      _loadVideo(widget.videos[_currentIndex]);
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video ${_currentIndex + 1}")),
      body: Center(
        child: _controller.value.isInitialized
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.7,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Text(
                _controller.value.isPlaying ? "Pause" : "Play",
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _playPreviousVideo,
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: _playNextVideo,
                ),
              ],
            )
          ],
        )
            : const CircularProgressIndicator(),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(title: Text("Video ${_currentIndex + 1}")),
    //   body: _controller.value.isInitialized
    //       ? PageView.builder(
    //     onPageChanged: (index) {
    //       setState(() {
    //         _currentIndex = index;
    //         _initializeVideoController(); // Hàm khởi tạo lại controller khi chuyển video
    //       });
    //     },
    //     itemCount: widget.videos.length,// Danh sách các URL video
    //     itemBuilder: (context, index) {
    //       return Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             SizedBox(
    //               width: MediaQuery.of(context).size.width * 0.9,
    //               height: MediaQuery.of(context).size.width * 0.7,
    //               child: AspectRatio(
    //                 aspectRatio: _controller.value.aspectRatio,
    //                 child: VideoPlayer(_controller),
    //               ),
    //             ),
    //             const SizedBox(height: 20),
    //             ElevatedButton(
    //               onPressed: () {
    //                 setState(() {
    //                   _controller.value.isPlaying
    //                       ? _controller.pause()
    //                       : _controller.play();
    //                 });
    //               },
    //               child: Text(
    //                 _controller.value.isPlaying ? "Pause" : "Play",
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   )
    //       : const Center(child: CircularProgressIndicator()),
    // );
  }
}
