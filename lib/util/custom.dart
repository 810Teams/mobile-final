///
/// `custom.dart`
/// Class contains custom designs
/// Mostly copied from other sources
///

import 'package:flutter/material.dart';

class Custom {
  // Utility Method: Returns Custom List Tile
  // Source: Copied from project
  static ListTile getCustomListTile(
    context, {
    String name,
    String subtitle,
    Widget trailing,
    Function onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      isThreeLine: true,
      title: Text(
        name,
        style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.black54),
      ),
      trailing: trailing ??
          Icon(Icons.keyboard_arrow_right, color: Theme.of(context).primaryColor, size: 30.0),
      onTap: onTap ?? () {},
    );
  }

  // Utility Method: Returns custom card
  // Source: Copied from project
  static Card getCustomCard(
    context, {
    String name,
    String subtitle,
    Widget trailing,
    Function onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: getCustomListTile(
          context,
          name: name,
          subtitle: subtitle,
          trailing: trailing,
          onTap: onTap,
        ),
      ),
    );
  }
}
