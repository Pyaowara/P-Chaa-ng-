import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/screens/main_page.dart';
import 'package:pchaa_flutter/services/app_services.dart';

class CheckoutModal extends StatefulWidget {
  const CheckoutModal({super.key});

  @override
  State<CheckoutModal> createState() => _CheckoutModalState();
}

class _CheckoutModalState extends State<CheckoutModal> {
  String _selectedOption = 'immediate'; // 'immediate' or 'schedule'
  TimeOfDay? _selectedTime;



  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _handleSend() async {
    final now = DateTime.now();
    final scheduledPickupTime =
        _selectedOption != 'immediate' && _selectedTime != null
            ? DateTime(
      now.year,
      now.month,
      now.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    ).add(const Duration(hours: 7))
            : null;

    try {
      Order order = await client.order.createOrder(
        _selectedOption == "immediate" ? OrderType.I : OrderType.S,
        scheduledPickupTime,
      );

      if (!mounted) return;

      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(orderToOpen: order),
        ),
        (route) => false,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _selectedOption == 'immediate'
                ? 'immediate order confirmed!'
                : 'Scheduled for ${_selectedTime!.format(context)}',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "เวลาต้องมากกว่าปัจจุบัน",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'เลือกประเภทการสั่ง',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // immediate option
            InkWell(
              onTap: () {
                setState(() {
                  _selectedOption = 'immediate';
                });
              },
              child: ListTile(
                title: const Text('immediate'),
                subtitle: const Text('รับสินค้าทันที'),
                leading: Radio<String>(
                  value: 'immediate',
                  groupValue: _selectedOption,
                  onChanged: null,
                ),
              ),
            ),

            // Schedule option
            InkWell(
              onTap: () {
                setState(() {
                  _selectedOption = 'schedule';
                });
              },
              child: ListTile(
                title: const Text('Schedule'),
                subtitle: const Text('กำหนดเวลารับสินค้า'),
                leading: Radio<String>(
                  value: 'schedule',
                  groupValue: _selectedOption,
                  onChanged: null,
                ),
              ),
            ),

            // Time picker for schedule
            if (_selectedOption == 'schedule') ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: OutlinedButton.icon(
                  onPressed: _selectTime,
                  icon: const Icon(Icons.access_time),
                  label: Text(
                    _selectedTime == null
                        ? 'เลือกเวลา'
                        : 'เวลา: ${_selectedTime!.format(context)}',
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Send button
            ElevatedButton(
              onPressed:
                  (_selectedOption == 'schedule' && _selectedTime == null)
                      ? null
                      : _handleSend,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'ส่ง',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
