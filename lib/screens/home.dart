import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app9/models/company.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final String titulo;

  const HomeScreen({
    super.key,
    required this.titulo,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Company>> listCompanies;

  Future<List<Company>> getCompanies() async {
    final response = await http.get(
        Uri.parse('https://json-placeholder.mock.beeceptor.com/companies'));

    List<Company> companies = [];

    if (response.statusCode == 200) {
      //debugPrint(response.body);
      final jsonData = jsonDecode(response.body);

      for (var item in jsonData) {
        companies.add(
          Company(
            id: item['id'],
            name: item['name'],
            address: item['address'],
            country: item['country'],
          ),
        );
      }

      return companies;
    } else {
      return Future.error('Falló la conexión...');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listCompanies = getCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        backgroundColor: Colors.yellow[600],
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: listCompanies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: verCompanies(snapshot.data!),
            );
          } else if (snapshot.hasError) {
            return Text('Falló de conexión...');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      backgroundColor: Colors.grey[300],
    );
  }

  List<Widget> verCompanies(List<Company> data) {
    List<Widget> companies = [];

    for (var item in data) {
      companies.add(Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              item.name.substring(0, 2),
            ),
          ),
          title: Text(item.name),
          subtitle: Text(item.address),
          trailing: Text(item.country),
        ),
      ));
    }

    return companies;
  }
}
