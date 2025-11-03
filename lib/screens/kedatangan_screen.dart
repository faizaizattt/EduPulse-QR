import 'package:flutter/material.dart';

class KedatanganScreen extends StatelessWidget {
	const KedatanganScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Kehadiran Pelajar')),
			body: const Center(
				child: Text('Halaman Kehadiran Pelajar — kandungan akan ditambah kemudian.'),
			),
		);
	}
}
