import 'package:flutter/material.dart';

class feed extends StatefulWidget {
  @override
  _feedState createState() => _feedState();
}

class _feedState extends State<feed> {
  bool onpress = false;
  _pressed() {
    setState(() {
      onpress = !onpress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 35, 2),
              child: Text(
                'hello',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(325, 10, 15, 1),
              child: IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 31, 35, 2),
              child: Text(
                'publishers',
                style: TextStyle(
                  fontSize: 8,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(15, 55, 15, 0),
                child: Text('Snippet', style: TextStyle(fontSize: 10))),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                addbutton(),
                starbutton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class addbutton extends StatefulWidget {
  @override
  _addbuttonState createState() => _addbuttonState();
}

class _addbuttonState extends State<addbutton> {
  bool onpress = false;
  _pressed() {
    setState(() {
      onpress = !onpress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          onpress ? Icons.add_to_photos_outlined : Icons.add_to_photos_rounded,
          color: onpress ? Colors.blue[200] : Colors.blue[200],
        ),
        onPressed: () => _pressed());
  }
}

class starbutton extends StatefulWidget {
  @override
  _starbuttonState createState() => _starbuttonState();
}

class _starbuttonState extends State<starbutton> {
  bool onpress = false;
  pressed() {
    setState(() {
      onpress = !onpress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          onpress ? Icons.star_rounded : Icons.star_border_rounded,
          color: onpress ? Colors.yellow : Colors.yellow,
        ),
        onPressed: () => pressed());
  }
}
