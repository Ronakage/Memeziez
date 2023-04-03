import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:memeziez/domain/meme_model.dart';
import 'package:memeziez/domain/user_model.dart';
import 'package:http/http.dart' as http;

import '../utils/helpers.dart';
import '../utils/urls.dart';
import 'comments_page.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  bool isLoading = true;
  var feedPageViewController = PageController(initialPage: 0);
  List<MemeModel> memes = [];

  callback(MemeModel modifiedMeme){
    setState(() {
      for(MemeModel meme in memes){
        if(meme.id == modifiedMeme.id){
          meme = modifiedMeme;
        }
      }
    });
  }

  @override
  void initState() {
    loadMemes(memes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? const Center(child : CircularProgressIndicator()) :
        PageView.builder(
          controller: feedPageViewController,
          scrollDirection: Axis.vertical,
          itemCount: memes.length,
          itemBuilder: (BuildContext context, int index) {
            bool isLiked = memes[index].likes.any((like) => like.likerId == widget.user.id);
            return Stack(
              children: [
                InteractiveViewer(
                    child: Center(
                        child:Image.memory(base64Decode(memes[index].data)
                        )
                    )
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Text(
                          memes[index].creatorUsername,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30
                          ),
                        ),
                        onTap: (){}, //Others profiles pages
                      ),
                      Text(
                        Helpers.getDifferenceInTime(memes[index].createdAt),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child : Container(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: (){
                                if(mounted){
                                  setState(() {
                                    if(isLiked) {
                                      memes[index].likes.removeWhere((like) => like.likerId == widget.user.id);
                                      unpostLike(memes[index].id, widget.user.id);
                                    } else {
                                      Likes like = Likes(id: 0, likerId: widget.user.id, likerUsername: widget.user.username, likedAt: DateTime.now());
                                      memes[index].likes.add(like);
                                      postLike(memes[index].id, widget.user.id);
                                    }
                                    isLiked = !isLiked;
                                  });
                                }
                              },
                              icon: isLiked ? const Icon(Icons.thumb_up) : const Icon(Icons.thumb_up_outlined)
                              ,iconSize: 30),
                          Text(memes[index].likes.length.toString()),
                          const SizedBox(height: 20),
                          IconButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CommentsPage(user: widget.user, meme:memes[index], callback: callback)),
                            );
                          }, icon: const Icon(Icons.mode_comment_outlined, semanticLabel: "Comment",),iconSize: 30),
                          Text(memes[index].comments.length.toString()),
                        ],
                      ),
                    )
                ),
              ],
            );
          },
    );
  }

  void loadMemes(List<MemeModel> memes) async {
    final response = await http.get(
      Uri.parse(URLS.memeURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
    if (response.statusCode == 200) {
      if(mounted){
        setState(() {
          isLoading = false;
        });
      }
      List<dynamic> list = jsonDecode(response.body);
      for (var element in list) {
        if(mounted){
          setState(() {
            memes.add(MemeModel.fromJson(element));
          });
        }
      }
    } else {
      if(mounted){
        setState(() {
          isLoading = false;
        });
      }
      debugPrint("Failed to get memes for feed.");
    }
  }

  Future<void> postLike(int memeId, int likerId) async {
    await http.post(
        Uri.parse("${URLS.memeURL}/like/$memeId/$likerId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',});
  }

  Future<void> unpostLike(int memeId, int likerId) async {
    await http.post(
        Uri.parse("${URLS.memeURL}/unlike/$memeId/$likerId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',});
  }

}
