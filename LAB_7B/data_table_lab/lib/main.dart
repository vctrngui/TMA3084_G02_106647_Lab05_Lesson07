import 'package:flutter/material.dart';

void main() => runApp(const MainApp());

class Car {
  Car(this.make, this.model, this.price);

  final String make;
  final int model;
  final int price;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CarTablePage(),
    );
  }
}

class CarTablePage extends StatefulWidget {
  const CarTablePage({super.key});

  @override
  State<CarTablePage> createState() => _CarTablePageState();
}

class _CarTablePageState extends State<CarTablePage> {
  final List<Car> cars = [
    Car('Honda', 2021, 35000),
    Car('Toyota', 2011, 6000),
    Car('BMW', 2010, 9000),
  ];

  int? sortColumnIndex;
  bool sortAscending = true;

  void sortBy(
      int columnIndex, bool ascending, int Function(Car a, Car b) compare) {
    setState(() {
      cars.sort((a, b) => ascending ? compare(a, b) : compare(b, a));
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataTable Sorting'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: DataTable(
        sortColumnIndex: sortColumnIndex,
        sortAscending: sortAscending,
        border: TableBorder.all(color: Colors.black),
        headingRowColor: WidgetStateProperty.all<Color>(Colors.grey),
        columns: [
          DataColumn(
            label: const Text('Car Make'),
            onSort: (i, asc) =>
                sortBy(i, asc, (a, b) => a.make.compareTo(b.make)),
          ),
          DataColumn(
            label: const Text('Model'),
            numeric: true,
            onSort: (i, asc) =>
                sortBy(i, asc, (a, b) => a.model.compareTo(b.model)),
          ),
          DataColumn(
            label: const Text('Price'),
            numeric: true,
            onSort: (i, asc) =>
                sortBy(i, asc, (a, b) => a.price.compareTo(b.price)),
          ),
        ],
        rows: cars.map((car) {
          return DataRow(cells: [
            DataCell(Text(car.make)),
            DataCell(Text('${car.model}')),
            DataCell(Text('${car.price}')),
          ]);
        }).toList(),
      ),
    );
  }
}