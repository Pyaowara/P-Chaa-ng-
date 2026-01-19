import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuDetailScreen extends StatefulWidget {
  final int menuId;
  const MenuDetailScreen({super.key, required this.menuId});

  @override
  State<MenuDetailScreen> createState() => _MenuDetailScreenState();
  
}

class _MenuDetailScreenState extends State<MenuDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Future<MenuItemWithUrl?> _getMenuDetail() {

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // Background food image (hidden if logged in)
                  Container(
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/food.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Gradient / overlay container
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha:0.3),
                          Colors.black.withValues(alpha:0.5),
                        ],
                      ),
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),

                  // Positioned welcome text and button
                ],
              ),
              Text(widget.menuId.toString())
            ],
          ),
        ),
      ),
    );
  }
}
