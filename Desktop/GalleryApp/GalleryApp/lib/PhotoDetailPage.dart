import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'apiResponseModalClass.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;


class PhotoDetailPage extends StatelessWidget {
  final Photo photo;

  const PhotoDetailPage({super.key, required this.photo});

  // Save to gallery
  Future<void> _saveImage(BuildContext context) async {
    try {
      var imageId = await ImageDownloader.downloadImage(photo.imageUrl);
      if (imageId == null) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image saved to gallery")),
      );
    } catch (e) {
      print("Error saving image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save image")),
      );
    }
  }

  // Share image
  Future<void> _shareImage() async {
    await Share.share(photo.imageUrl);
  }

  // Set as wallpaper
  Future<void> _setWallpaper(BuildContext context) async {
    try {
      int location = WallpaperManager.HOME_SCREEN; // or LOCK_SCREEN or BOTH
      await setWallpaperFromUrl(photo.imageUrl, location);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Wallpaper set successfully")),
      );
    } catch (e) {
      print("Error setting wallpaper: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to set wallpaper")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(photo.photographer),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareImage,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.network(
              photo.imageUrl,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Photo by ${photo.photographer}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => _saveImage(context),
                icon: Icon(Icons.download),
                label: Text("Save"),
              ),
              ElevatedButton.icon(
                onPressed: () => _setWallpaper(context),
                icon: Icon(Icons.wallpaper),
                label: Text("Set Wallpaper"),
              ),
              ElevatedButton.icon(
                onPressed: _shareImage,
                icon: Icon(Icons.share),
                label: Text("Share"),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }



  Future<void> setWallpaperFromUrl(String imageUrl, int location) async {
    try {
      // Get temporary directory
      var tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      String filePath = '$tempPath/wallpaper.jpg';

      // Download image using http package
      var response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Set wallpaper from local file path
        bool result = await WallpaperManager.setWallpaperFromFile(filePath, location);

        if(result) {
          print("Wallpaper set successfully!");
        } else {
          print("Failed to set wallpaper");
        }
      } else {
        print("Failed to download image");
      }
    } catch (e) {
      print("Error setting wallpaper: $e");
    }
  }

}
