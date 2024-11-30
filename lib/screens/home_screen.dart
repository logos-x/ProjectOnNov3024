import 'package:buoi4/utils/post_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Post> posts = [
    Post(
      userName: 'Quang Vinh',
      content: 'Chào em em ăn cơm chưa.',
      imageUrl: 'assets/images/anh1.png',
      videoUrl: null,
      likes: 10,
      comments: [
        Comment(userName: 'User 2', text: 'Great post!'),
        Comment(userName: 'User 3', text: 'Very informative.'),
      ],
    ),
    Post(
      userName: 'Vinh Quang',
      content: 'A yêu em',
      imageUrl: 'assets/images/anh2.png',
      videoUrl: null,
      likes: 5,
      comments: [
        Comment(userName: 'User 4', text: 'I love this idea.'),
        Comment(userName: 'User 5', text: 'Nice perspective.'),
      ],
    ),
  ];

  // Hàm để thích bài viết
  void _likePost(Post post) {
    setState(() {
      post.likes += 1;
    });
  }

  // Hàm để thêm comment
  void _addComment(Post post, String commentText, TextEditingController controller) {
    setState(() {
      post.comments.add(Comment(userName: 'New User', text: commentText));
      controller.clear();  // Reset TextField sau khi gửi comment
    });
  }

  // Hàm chia sẻ bài viết (hiện thông báo)
  void _sharePost(Post post) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Shared ${post.userName}\'s post!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            title: const Text("Home"),
            floating: true,
            pinned: true,
            snap: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/facebook_banner.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ];
      },
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          TextEditingController commentController = TextEditingController(); // Controller cho TextField
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/user_avatar.png'),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        post.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(post.content, style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 10),
                  if (post.imageUrl != null)
                    Image.asset(post.imageUrl!),
                  const SizedBox(height: 10),
                  if (post.videoUrl != null)
                    VideoPostPlayer(videoUrl: post.videoUrl!),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.thumb_up_alt_outlined),
                            onPressed: () => _likePost(post),
                          ),
                          Text('${post.likes} Like(s)'),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.comment_outlined),
                            onPressed: () {},
                          ),
                          Text('${post.comments.length} Comment(s)'),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.share_outlined),
                            onPressed: () => _sharePost(post),
                          ),
                          const Text('Share'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 5),
                  ...post.comments.map((comment) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.person, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${comment.userName}: ${comment.text}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 10),
                  TextField(
                    controller: commentController,
                    onSubmitted: (text) {
                      _addComment(post, text, commentController);
                    },
                    decoration: InputDecoration(
                      labelText: 'Add a comment...',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          _addComment(post, commentController.text, commentController);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class VideoPostPlayer extends StatefulWidget {
  final String videoUrl;

  const VideoPostPlayer({required this.videoUrl, super.key});

  @override
  _VideoPostPlayerState createState() => _VideoPostPlayerState();
}

class _VideoPostPlayerState extends State<VideoPostPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}