import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> fees = [
      {'title': 'Tuition Fee', 'amount': 2500, 'status': 'Unpaid'},
      {'title': 'Library Fee', 'amount': 150, 'status': 'Paid'},
      {'title': 'Lab Fee', 'amount': 300, 'status': 'Unpaid'},
      {'title': 'Sports Fee', 'amount': 100, 'status': 'Paid'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fee Management'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: fees.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final fee = fees[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: ListTile(
              leading: Icon(
                fee['status'] == 'Paid' ? Icons.check_circle : Icons.error,
                color: fee['status'] == 'Paid' ? Colors.green : Colors.red,
              ),
              title: Text(fee['title']),
              subtitle: Text('Amount: \$${fee['amount']}'),
              trailing: fee['status'] == 'Unpaid'
                  ? ElevatedButton(
                      onPressed: () {
                        // هنا تضع كود الدفع الفعلي
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing payment for ${fee['title']}...')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Pay'),
                    )
                  : const Text('Paid', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w900)),
            ),
          );
        },
      ),
    );
  }
}
