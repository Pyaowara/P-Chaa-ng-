import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Queueready extends StatefulWidget {
  const Queueready({super.key});

  @override
  State<Queueready> createState() => _QueuereadyState();
}

class _QueuereadyState extends State<Queueready> {
  final List<String> items = [
    "A001",
    "A002",
    "A003",
    "A004",
    "A005",
    "A006",
    "A007",
  ];

  final int rows = 2;
  final int columns = 3;

  // 👇 spacing control
  final double horizontalGap = 2;
  final double verticalGap = 10;

  @override
  Widget build(BuildContext context) {
    final int itemsPerSection = rows * columns;
    final int sectionCount = (items.length / itemsPerSection).ceil();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(5),
      width: double.infinity,
      height: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xFFfbdf9d),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 10,
            offset: const Offset(5, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "พร้อมเสริฟ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(height: 10),

            CarouselSlider.builder(
              itemCount: sectionCount,
              options: CarouselOptions(
                height: 120,
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: false,
                pageSnapping: true,
                viewportFraction: 1,
                padEnds: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 10),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                // autoPlayCurve: Curves.easeInOut,
                pauseAutoPlayOnTouch: true,
                scrollPhysics: const BouncingScrollPhysics(),
              ),
              itemBuilder: (context, sectionIndex, realIndex) {
                final start = sectionIndex * itemsPerSection;
                final sectionItems = items
                    .skip(start)
                    .take(itemsPerSection)
                    .toList();

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(rows, (rowIndex) {
                    return Padding(
                      // 👇 vertical gap between rows
                      padding: EdgeInsets.only(
                        bottom: rowIndex == rows - 1 ? 0 : verticalGap,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(columns, (colIndex) {
                          final itemIndex = rowIndex * columns + colIndex;

                          if (itemIndex >= sectionItems.length) {
                            return SizedBox(
                              width: 80 + horizontalGap,
                              height: 50,
                            );
                          }

                          return Padding(
                            // 👇 horizontal gap between columns
                            padding: EdgeInsets.only(
                              right: colIndex == columns - 1
                                  ? 0
                                  : horizontalGap,
                            ),
                            child: Container(
                              width: 80,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                sectionItems[itemIndex],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  }),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("เลื่อนเพื่อดูคิวเพิ่ม"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
