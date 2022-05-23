import 'package:flutter/material.dart';
import 'package:json_prettier_viewer/json_prettier_viewer.dart';

import 'dart:convert';

import 'package:flutter/services.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<dynamic> readJson() async {
      final String response =
          await rootBundle.loadString('assets/example2.json');
      final data = await json.decode(response);
      return data;
    }

    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                primaryColor: const Color(0xff450b65),
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      secondary: const Color(0xffeb0045),
                    ),
              ),
              child: FutureBuilder<dynamic>(
                  future: readJson(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data is! Map<String, dynamic>) {
                        return const Text("Formato não suportado");
                      }

                      return JsonPrettierViewer(
                        titleStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        keStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        valueStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff434343),
                        ),
                        json: snapshot.data as Map<String, dynamic>,
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ],
        ));
  }
}
