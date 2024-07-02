import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import '../forms/theme.dart';

enum RenderImage { platform, web }

class PickedImage {
  dynamic imagePath;
  RenderImage renderType;
  XFile? file;
  String base64;
  String extension;

  PickedImage(
      {required this.imagePath,
        required this.file,
        required this.renderType,
        required this.extension,
        required this.base64});

  PickedImage copyWith({imagePath, file, renderType, extension, base64}) =>
      PickedImage(
          imagePath: imagePath ?? this.imagePath,
          file: file ?? this.file,
          renderType: renderType ?? this.renderType,
          extension: extension ?? this.extension,
          base64: base64 ?? this.base64);
}

class ImagePick extends StatefulWidget {
  final String? title;
  final bool isMultiple;
  final PickedImage? previewImage;
  final List<PickedImage> previewImageList;
  final void Function() onClose;
  final void Function(List<PickedImage> pickedImage) onSave;

  ImagePick(
      {this.title,
        this.previewImage,
        this.isMultiple = false,
        this.previewImageList = const [],
        required this.onClose,
        required this.onSave});

  @override
  State<ImagePick> createState() => _ImagePickScreenState();
}

class _ImagePickScreenState extends State<ImagePick> {
  List<PickedImage> pickedImages = [];
  late PageController _pageController;
  int activePage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
    pickedImages.clear();
    if (widget.previewImage != null) {
      setState(() {
        pickedImages.add(widget.previewImage!);
      });
    }
    if (widget.previewImageList.isNotEmpty) {
      setState(() {
        pickedImages = widget.previewImageList;
      });
    }
  }

  void imagePicker(ImageSource imageSourceType) async {
    final ImagePicker picker = ImagePicker();
    if (widget.isMultiple == false) {
      pickedImages.clear();
    }

    if (!kIsWeb) {
      XFile? response = await picker.pickImage(source: imageSourceType);
      if (response != null) {
        pickedImages.add(PickedImage(
            imagePath: File(response.path),
            extension: "data:image/jpg;base64",
            file: response,
            base64: base64Encode(await response.readAsBytes()),
            renderType: RenderImage.platform));
        setState(() {
          pickedImages;
        });
      }
      setState(() {
        pickedImages;
      });
    } else if (kIsWeb) {
      XFile? response = await picker.pickImage(source: ImageSource.gallery);
      if (response != null) {
        pickedImages.add(PickedImage(
            imagePath: File(response.path),
            extension: "data:image/jpg;base64",
            file: response,
            base64: base64Encode(await response.readAsBytes()),
            renderType: RenderImage.platform));
        setState(() {
          pickedImages;
        });
      }
    }
  }

  void closePicker() {
    widget.onClose();
  }

  void saveImage() {
    widget.onSave([...pickedImages]);
  }

  void deleteImage() {
    setState(() {
      pickedImages.removeAt(activePage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.appColor,
        appBar: widget.title != null
            ? AppBar(
          toolbarHeight: 55,
          backgroundColor: AppTheme.secondaryColor,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20, // customize color as per requirement
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(widget.title!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              )),
          centerTitle: true,
          actions: [
            pickedImages.isNotEmpty
                ? IconButton(
              onPressed: saveImage,
              icon: const Icon(Icons.done),
              color: Colors.white,
              iconSize: 25,
            )
                : const SizedBox.shrink()
          ],
        )
            : null,
        body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                widget.title == null
                    ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          onPressed: closePicker,
                          icon: const Icon(Icons.close)),
                      pickedImages.isNotEmpty
                          ? IconButton(
                        onPressed: saveImage,
                        icon: const Icon(Icons.done),
                        color: Color(0XFF20013C),
                        iconSize: 25,
                      )
                          : const SizedBox.shrink()
                    ])
                    : const SizedBox.shrink(),
                Expanded(
                    child: pickedImages.isNotEmpty
                        ? Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          child: PageView.builder(
                              itemCount: pickedImages.length,
                              pageSnapping: true,
                              controller: _pageController,
                              onPageChanged: (page) {
                                setState(() {
                                  activePage = page;
                                });
                              },
                              itemBuilder: (context, pagePosition) {
                                bool active = pagePosition == activePage;
                                return slider(
                                    pickedImages, pagePosition, active);
                              }),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: indicators(
                                pickedImages.length, activePage))
                      ],
                    )
                        : const SizedBox.shrink()),
                Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.appColor,
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.0))),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Select Source",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.lableColor90,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ActionButton(
                                actionIcon: Icons.camera,
                                label: "Camera",
                                onPressed: () =>
                                    imagePicker(ImageSource.camera)),
                            const SizedBox.shrink(),
                            ActionButton(
                                actionIcon: Icons.collections,
                                label: "Gallery",
                                onPressed: () =>
                                    imagePicker(ImageSource.gallery))
                          ],
                        )
                      ]),
                )
              ],
            )));
  }
}

AnimatedContainer slider(List<PickedImage> images, pagePosition, active) {
  double margin = active ? 10 : 20;

  return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.all(margin),
      child: images[pagePosition].renderType == RenderImage.platform
          ? FractionallySizedBox(
        heightFactor: 0.9,
        child: Image.file(images[pagePosition].imagePath,
            fit: BoxFit.contain),
      )
          : FractionallySizedBox(
        heightFactor: 0.9,
        child: Image.network(images[pagePosition].imagePath,
            fit: BoxFit.contain),
      ));
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}

class ActionButton extends StatelessWidget {
  final IconData actionIcon;
  final double iconSize;
  final String label;
  final Color background;
  final void Function() onPressed;

  ActionButton(
      {Key? key,
        required this.actionIcon,
        this.background = const Color(0XFF20013C),
        this.iconSize = 50,
        required this.onPressed,
        required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size(50, 50),
          padding: EdgeInsets.zero,
          backgroundColor: AppTheme.secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Icon(
          actionIcon,
          size: 25,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
      const SizedBox(height: 10.0),
      Text(
        label,
        style: const TextStyle(
            color: AppTheme.lableColor90,
            fontWeight: FontWeight.w600,
            fontSize: 14),
      )
    ]);
  }
}