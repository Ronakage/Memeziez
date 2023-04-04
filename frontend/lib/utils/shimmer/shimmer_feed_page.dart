import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerFeedPage extends StatefulWidget {
   const ShimmerFeedPage({Key? key}) : super(key: key);

  @override
  State<ShimmerFeedPage> createState() => _ShimmerFeedPageState();
}

class _ShimmerFeedPageState extends State<ShimmerFeedPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              Shimmer(
                  child: Container(
                      width: 100,
                      height: 15,
                      color: Colors.grey[300]
                  )
              ),
              SizedBox(height: 10),
              Shimmer(
                  child: Container(
                      width: 100,
                      height: 15,
                      color: Colors.grey[300]
                  )
              ),
            ],
          ),
        ),
        Shimmer(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4,
              color: Colors.grey[300]
            )
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Column(
              children: [
                Shimmer(
                    child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey[300]
                    )
                ),
                SizedBox(height: 10),
                Shimmer(
                    child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey[300]
                    )
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
