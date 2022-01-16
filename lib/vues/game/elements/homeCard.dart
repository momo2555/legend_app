import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String name;
  final IconData icon;
  Function onTap;
  final Widget description;
  final String orientation;
  HomeCard({
    required this.name,
    required this.icon,
    required this.onTap,
    required this.description,
    required this.orientation,
  });
  Widget _Horizontal(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, size: 180, color: Theme.of(context).primaryColor),
                Text(
                  this.name,
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
        ),
        this.description
      ],
    );
  }

  Widget _Vertical(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 100, color: Theme.of(context).primaryColor),
        Container(
          child: Text("coucou"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 2,
        child: orientation == "horizontal"
            ? _Horizontal(context)
            : _Vertical(context),
      ),
    );
  }
}
