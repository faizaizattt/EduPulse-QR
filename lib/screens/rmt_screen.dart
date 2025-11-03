import 'package:flutter/material.dart';

class RmtScreen extends StatelessWidget {
	const RmtScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Rancangan Makanan Tambahan (RMT)')),
			body: const Center(
				child: Text('Halaman RMT — kandungan akan ditambah kemudian.'),
			),
		);
	}
}
