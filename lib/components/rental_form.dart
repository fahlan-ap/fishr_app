import 'package:flutter/material.dart';
import 'package:fishr_app/services/rental_service.dart';

class RentalForm extends StatefulWidget {
  final int idPancing;
  final String imageUrl;
  final String productName;
  final String price;

  const RentalForm({
    super.key,
    required this.idPancing,
    required this.imageUrl,
    required this.productName,
    required this.price,
  });

  @override
  State<RentalForm> createState() => _RentalFormState();
}

class _RentalFormState extends State<RentalForm> {
  DateTime? startDate;
  DateTime? endDate;
  String? selectedPaymentMethod;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  Future<void> _submitRental() async {
    try {
      await RentalService().createRental(
        idPancing: widget.idPancing,
        startDate: startDate!,
        endDate: endDate!,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Rental berhasil dikirim!")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menyimpan: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🖼️ Product Preview
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.price,
                            style: const TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 📅 Tanggal Rental
              ListTile(
                title: const Text("Start Date"),
                subtitle: Text(
                  startDate?.toLocal().toString().split(' ')[0] ?? 'Pilih tanggal',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, true),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text("End Date"),
                subtitle: Text(
                  endDate?.toLocal().toString().split(' ')[0] ?? 'Pilih tanggal',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, false),
              ),

              const SizedBox(height: 16),

              // 💳 Metode Pembayaran
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedPaymentMethod,
                    hint: const Text("Pilih metode pembayaran"),
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: "Dana",
                        child: Text("Dana"),
                      ),
                      DropdownMenuItem(
                        value: "E-Money",
                        child: Text("E-Money"),
                      ),
                      DropdownMenuItem(
                        value: "PayPal",
                        child: Text("PayPal"),
                      ),
                      DropdownMenuItem(
                        value: "Bank",
                        child: Text("Bank"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // 📤 Tombol Submit
              Center(
                child: ElevatedButton(
                  onPressed: (startDate != null &&
                          endDate != null &&
                          selectedPaymentMethod != null)
                      ? _submitRental
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade400,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Book Now",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}