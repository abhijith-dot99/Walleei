import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waleei/pages/widgets/image_grid_item.dart';
import '../provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.loadImages();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        provider.loadImages();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "Walleei",
              style: TextStyle(fontFamily: 'ArchitectsDaughter'),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              color: Colors.white,
              width: 50,
            ),
          ],
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.images.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            padding: const EdgeInsets.all(8),
            itemCount: provider.images.length,
            itemBuilder: (context, index) {
              final image = provider.images[index];
              return ImageGridItem(image: image);
            },
          );
        },
      ),
    );
  }
}
