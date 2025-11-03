import 'package:flutter/material.dart';

class SahsiahScreen extends StatelessWidget {
	const SahsiahScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Sahsiah Murid')),
			body: const Center(
				child: Text('Halaman Sahsiah Murid — kandungan akan ditambah kemudian.'),
			),
		);
	}
}
