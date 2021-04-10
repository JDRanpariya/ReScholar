import 'package:flutter/material.dart';

// NAVIGATION DRAWER BUTTON
class NavigationDrawerButton extends StatelessWidget {
  final Icon leadingIcon;
  final List<Color> leadingIconGradient;

  NavigationDrawerButton(this.leadingIcon, this.leadingIconGradient);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {/* Write listener code here */},
      child: ShaderMask(
        shaderCallback: (rect) => LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: leadingIconGradient,
        ).createShader(rect),
        child: leadingIcon,
      ),
    );
  }
}

// SEARCH BUTTON
class SearchButton extends StatelessWidget {
  final List<Color> searchGradient;

  SearchButton(this.searchGradient);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {/* Write listener code here */},
      child: ShaderMask(
        shaderCallback: (rect) => LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: searchGradient,
        ).createShader(rect),
        child: Icon(
          Icons.search_rounded,
          size: 54,
        ),
      ),
    );
  }
}

// POP-UP MENU BUTTON
class PopUpMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.more_vert, size: 21),
        onPressed: () {/* Write listener code here */});
  }
}

// ADD TO FOLDER
class ToFolder extends StatefulWidget {
  @override
  _ToFolderState createState() => _ToFolderState();
}

class _ToFolderState extends State<ToFolder> {
  bool onpress = false;

  _pressed() {
    /* Write listener code here */
    setState(() {
      onpress = !onpress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.all(0),
        icon: Icon(
          onpress ? Icons.add_to_photos_rounded : Icons.add_to_photos_outlined,
          color: Color(0xFF9DD0FF),
          size: 30,
        ),
        onPressed: _pressed);
  }
}

// ADD TO FAVOURITES
class ToFavourites extends StatefulWidget {
  @override
  _ToFavouritesState createState() => _ToFavouritesState();
}

class _ToFavouritesState extends State<ToFavourites> {
  bool onpress = false;
  pressed() {
    /* Write listener code here */
    setState(() {
      onpress = !onpress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.all(0),
        icon: Icon(
          onpress ? Icons.star_rounded : Icons.star_border_rounded,
          color: Color(0xFFFFC000),
          size: 36,
        ),
        onPressed: pressed);
  }
}
