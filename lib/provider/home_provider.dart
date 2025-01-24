import 'package:flutter/material.dart';
import 'package:waleei/models/unsplash_api_service.dart';

class HomeProvider extends ChangeNotifier {
  final UnsplashApiService _apiService = UnsplashApiService();
  List<dynamic> images = [];
  bool isLoading = false;
  int page = 1;

  Future<void> loadImages() async {
    if (isLoading) return;
    isLoading = true;

    try {
      final newImages = await _apiService.fetchImages(page);
      images.addAll(newImages);
      page++;
    } catch (e) {
      print("Error loading imges: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
