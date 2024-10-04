import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<Post> posts = [
    Post(
      userAvatarUrl: 'https://via.placeholder.com/150',
      username: 'User One',
      imageUrl: 'https://via.placeholder.com/600x400',
      description: 'This is a description of the first post.',
      timestamp: DateTime.now().subtract(Duration(hours: 1)),
    ),
    Post(
      userAvatarUrl: 'https://via.placeholder.com/150',
      username: 'User Two',
      imageUrl: 'https://via.placeholder.com/600x400',
      description: 'This is a description of the second post.',
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
    ),
    // Add more posts as needed
  ];

  void _removePost(Post post) {
    setState(() {
      posts.remove(post);
    });
  }

  void _addPost() {
    // Implement your add post logic here
    // For demonstration, you could show a Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Add Post button pressed')),
    );
  }

  void _openSearch() {
    // Implement your search functionality here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Search icon pressed')),
    );
  }

  void _openNotifications() {
    // Implement your notification functionality here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Notification icon pressed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('Explore'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _openSearch,
            tooltip: 'Search',
            color: Colors.deepPurpleAccent,
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: _openNotifications,
            tooltip: 'Notifications',
            color: Colors.deepPurpleAccent,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(
            post: posts[index],
            onRemove: _removePost,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPost,
        child: Icon(Icons.add_a_photo_outlined),
        tooltip: 'Add Post',
        focusColor: Colors.deepPurpleAccent,
        backgroundColor: Colors.blueGrey.shade900,
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final Post post;
  final Function(Post) onRemove;

  const PostCard({Key? key, required this.post, required this.onRemove}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final TextEditingController commentController = TextEditingController();

  void _addComment() {
    if (commentController.text.isNotEmpty) {
      setState(() {
        // Here you can assign a static avatar and username for demo purposes
        widget.post.comments.add(Comment(
          avatarUrl: 'https://via.placeholder.com/150',
          username: 'Commenter', // Replace with actual username
          text: commentController.text,
        ));
        commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info and Post Image
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info with Popup Menu
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(widget.post.userAvatarUrl),
                ),
                title: Text(
                  widget.post.username,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  _formatTimestamp(widget.post.timestamp),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) => _handleMenuSelection(value, context),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      value: 'report',
                      child: Text('Report'),
                    ),
                    PopupMenuItem(
                      value: 'not_interested',
                      child: Text('Not Interested'),
                    ),
                  ],
                ),
              ),
              // Adjusted Post Image height
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.post.imageUrl,
                  width: double.infinity,
                  height: 300, // Increased height
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: double.infinity,
                      height: 300, // Match the image height
                      color: Colors.grey[300],
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes!)
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 300, // Match the image height
                      color: Colors.grey[300],
                      child: Center(
                        child: Icon(Icons.broken_image,
                            size: 50, color: Colors.grey[700]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          // Add more padding if needed
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: () {
                    setState(() {
                      widget.post.likeCount++;
                    });
                  },
                ),
                Text('${widget.post.likeCount}'), // Display like count
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    // Toggle comments visibility
                    setState(() {
                      widget.post.isCommentsVisible = !widget.post.isCommentsVisible;
                    });
                  },
                ),
              ],
            ),
          ),
          // Post Description
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.post.description,
              style: TextStyle(fontSize: 14),
            ),
          ),
          // Comments section
          if (widget.post.isCommentsVisible) ...[
            // Display existing comments
            for (var comment in widget.post.comments)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(comment.avatarUrl),
                      radius: 12, // Set radius to 3/4 of 16
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comment.username,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            comment.text,
                            style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            // Input field for new comments
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _addComment,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    // Format the timestamp as needed
    return "${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute}";
  }

  void _handleMenuSelection(String value, BuildContext context) {
    // Handle the selected menu option
    if (value == 'report') {
      // Report the post (you can add your report logic here)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post reported')),
      );
    } else if (value == 'not_interested') {
      // Remove the post when the user selects 'Not Interested'
      widget.onRemove(widget.post);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post removed from Explore')),
      );
    }
  }
}

// Comment class to hold comment data
class Comment {
  final String avatarUrl;
  final String username;
  final String text;

  Comment({
    required this.avatarUrl,
    required this.username,
    required this.text,
  });
}

// Dummy Post class for demonstration
class Post {
  final String userAvatarUrl;
  final String username;
  final String imageUrl;
  final String description;
  final DateTime timestamp;
  List<Comment> comments; // List to hold comments
  bool isCommentsVisible; // Flag to toggle comments visibility
  int likeCount; // Like count

  Post({
    required this.userAvatarUrl,
    required this.username,
    required this.imageUrl,
    required this.description,
    required this.timestamp,
    List<Comment>? comments,
    this.isCommentsVisible = false, // Default to not visible
    this.likeCount = 0, // Default like count
  }) : comments = comments ?? []; // Initialize comments list
}
