import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Shortcut {
  Widget voteAdd() {
    return Padding(
      padding: const EdgeInsets.only(left: 298.0, bottom: 22.0),
      child: Stack(
        children: [
          Container(
            height: 40.0,
            child: Image(
                image: NetworkImage(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Logo_vote.svg/1200px-Logo_vote.svg.png")),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48.0, top: 28.0),
            child: Text(
              "+",
              style: TextStyle(color: Colors.white, fontSize: 44.0),
            ),
          ),
        ],
      ),
    );
  }
}
