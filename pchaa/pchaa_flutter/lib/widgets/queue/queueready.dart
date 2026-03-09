import 'dart:async';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pchaa_flutter/services/app_services.dart';

class Queueready extends StatefulWidget {
  final bool isExpanded;
  const Queueready({super.key, this.isExpanded = false});

  @override
  State<Queueready> createState() => _QueuereadyState();
}

class _QueuereadyState extends State<Queueready> {
  List<String> items = [];
  Timer? _refreshTimer;
  bool _isLoading = true;

  final int rows = 2;
  final int columns = 3;

  // 👇 spacing control
  final double horizontalGap = 2;
  final double verticalGap = 10;

  @override
  void initState() {
    super.initState();
    _fetchFinishedOrders();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _fetchFinishedOrders() async {
    try {
      final finishedOrders = await client.order.getFinishedOrder();
      if (mounted) {
        setState(() {
          items = finishedOrders.reversed
              .map((order) => order.order.queueNumber ?? 'N/A')
              .toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Failed to fetch finished orders: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          items = [];
        });
      }
    }
  }

  void _startAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _fetchFinishedOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
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
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final int itemsPerSection = rows * columns;
    final int sectionCount = (items.length / itemsPerSection).ceil();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(5),
      width: double.infinity,
      height: widget.isExpanded ? null : 210,
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

            widget.isExpanded
                ? Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final availableHeight = constraints.maxHeight;
                        final int dynamicRows = (availableHeight / 60)
                            .floor()
                            .clamp(1, 20);
                        final int dynItemsPerSection = dynamicRows * columns;
                        final int dynSectionCount = items.isEmpty
                            ? 0
                            : (items.length / dynItemsPerSection).ceil();

                        return _buildCarousel(
                          dynSectionCount,
                          dynItemsPerSection,
                          dynamicRows,
                          availableHeight,
                        );
                      },
                    ),
                  )
                : _buildCarousel(sectionCount, itemsPerSection, rows, 120),

            if (!_isLoading && items.length > (widget.isExpanded ? 12 : 6))
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

  Widget _buildCarousel(
    int sections,
    int itemsPerSec,
    int currentRows,
    double height,
  ) {
    return CarouselSlider.builder(
      itemCount: sections,
      options: CarouselOptions(
        height: height,
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
        final start = sectionIndex * itemsPerSec;
        final sectionItems = items.skip(start).take(itemsPerSec).toList();

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(currentRows, (rowIndex) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: rowIndex == currentRows - 1 ? 0 : verticalGap,
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
                    padding: EdgeInsets.only(
                      right: colIndex == columns - 1 ? 0 : horizontalGap,
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
    );
  }
}
