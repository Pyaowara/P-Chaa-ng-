import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/services/app_services.dart';
import 'package:pchaa_flutter/widgets/myqueue.dart';

class AllQueuePage extends StatefulWidget {
  const AllQueuePage({super.key});

  @override
  State<AllQueuePage> createState() => _AllQueuePageState();
}

class _AllQueuePageState extends State<AllQueuePage> {
  late List<Order> _queueList;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final orders = await client.order.getMyOrders();
      if (mounted) {
        setState(() {
          _queueList = orders;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Failed to fetch orders: $e');
      if (mounted) {
        setState(() {
          _error = 'ไม่สามารถโหลดออเดอร์ได้';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ออเดอร์ของฉัน"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchOrders,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_error!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _fetchOrders,
                    child: const Text('ลองใหม่'),
                  ),
                ],
              ),
            )
          : _queueList.isEmpty
          ? const Center(child: Text('ไม่มีออเดอร์'))
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemCount: _queueList.length,
              itemBuilder: (context, index) {
                final Order queueitem = _queueList[index];
                debugPrint("$queueitem");
                return QueueListTile(
                  onNavigate: () {
                    _fetchOrders();
                  },
                  order: queueitem,
                );
              },
            ),
    );
  }
}
