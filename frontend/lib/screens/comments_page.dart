import 'package:flutter/material.dart';
import 'package:memeziez/domain/meme_model.dart';
import 'package:memeziez/domain/user_model.dart';

import 'package:http/http.dart' as http;

import '../utils/helpers.dart';
import '../utils/urls.dart';

class CommentsPage extends StatefulWidget {
  CommentsPage({Key? key, required this.user, required this.meme, required this.callback}) : super(key: key);
  final UserModel user;
  final MemeModel meme;
  final Function(MemeModel) callback;

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  var commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text("Comments"),
          ),
          body: Stack(
            children: [
              ListView.builder(
                  itemCount: widget.meme.comments.length,
                  itemBuilder: (context, index){
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.meme.comments[index].commenterUsername, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                              Text(widget.meme.comments[index].comment, style: TextStyle(fontSize: 17),),
                              Text(Helpers.getDifferenceInTime(widget.meme.comments[index].commentedAt), style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10),),
                            ],
                          ),
                        ),
                        Divider(),
                        index == widget.meme.comments.length-1 ? SizedBox(height: 80) : SizedBox(height: 0),
                      ],
                    );
                  }
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40,left: 10, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                                hintText: 'Comment',
                                filled: true,
                                prefixIcon: Icon(Icons.comment)
                            ),
                            keyboardType: TextInputType.text,
                            controller: commentController,

                          ),
                        ),
                        IconButton(
                            onPressed: (){
                              if(mounted){
                                setState(() {
                                  Comments comment = Comments(id: 0, commenterId: widget.user.id, commenterUsername: widget.user.username, comment: commentController.text, commentedAt: DateTime.now());
                                  widget.meme.comments.add(comment);
                                  widget.callback(widget.meme);
                                  postComment(widget.meme.id,widget.user.id,commentController.text);
                                });
                              }
                            },
                            icon: const Icon(Icons.send, size: 30,)
                        )
                      ],
                    ),
                  )
              ),
            ],
          )
    );
  }

  Future<void> postComment(int memeId, int commenterId, String comment) async {
    await http.post(
        Uri.parse("${URLS.memeURL}/comment/$memeId/$commenterId/$comment"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',});
  }
}
