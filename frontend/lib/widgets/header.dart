import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

/// Builds an AppBar with a leading icon, title and an optional local search button.
class Header extends StatelessWidget implements PreferredSizeWidget {
  final Icon leadingIcon;
  final List<Color> leadingIconGradient;
  final String title;
  final List<Color> titleGradient;
  final bool withSearch;
  final List<Color> searchGradient;

  Header(this.leadingIcon, this.leadingIconGradient, this.title,
      this.titleGradient, this.withSearch, this.searchGradient);

  @override
  Size get preferredSize => Size.fromHeight(75);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: AppBar(
        backgroundColor: Colors.black87,
        toolbarHeight: 75,
        automaticallyImplyLeading: false,
        leadingWidth: 50.0,
        leading: GestureDetector(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: ShaderMask(
            shaderCallback: (rect) => LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: leadingIconGradient,
            ).createShader(rect),
            child: leadingIcon,
          ),
        ),
        title: ShaderMask(
          shaderCallback: (rect) => LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: titleGradient)
              .createShader(rect),
          child: AutoSizeText(
            title.toLowerCase(),
            maxLines: 1,
            style: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: withSearch
            ? <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 2.0),
                  child: GestureDetector(
                    onTap: () {/* TODO: Implement Search Button logic */},
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
                  ),
                )
              ]
            : null,
      ),
    );
  }
}
