import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

Reference referenceRoot = FirebaseStorage.instance.ref();
Reference referenceDirImages = referenceRoot.child('images');

String uniquename = DateTime.now().millisecondsSinceEpoch.toString();

Reference referenceImageToUpload = referenceDirImages.child(uniquename);

String imageUrl = '';

class _CameraScreenState extends State<CameraScreen> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }
    try {
      await referenceImageToUpload.putFile(File(pickedImage.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (e) {
      print(e);
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.height / 640;
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 170),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: IconButton(
                      icon: Image.asset(
                        'assets/images/BackButton.png',
                        fit: BoxFit.cover,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
              Image.asset(
                'assets/images/lionimage.png',
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xfff4f4f4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40 * fem),
                topRight: Radius.circular(40 * fem),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Image.asset(
                    'assets/images/Group2.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 80.0),
                Padding(
                  padding: const EdgeInsets.only(left: 235),
                  child: Image.asset(
                    'assets/images/Group3.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xfff4f4f4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40 * fem),
                topRight: Radius.circular(40 * fem),
              ),
            ),
            child: _selectedImage != null
                ? CircleAvatar(
                    radius: 60,
                    backgroundImage: FileImage(_selectedImage!),
                  )
                : const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey,
                  ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xfff4f4f4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40 * fem),
                topRight: Radius.circular(40 * fem),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Image.asset(
                    'assets/images/Group5.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 235),
                  child: Image.asset(
                    'assets/images/Group4.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xfff4f4f4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40 * fem),
                topRight: Radius.circular(40 * fem),
              ),
            ),
            child: _selectedImage != null
                ? Text(
                    'Will you eat this?',
                    style: GoogleFonts.andika(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                  )
                : Text(
                    'Click your meal',
                    style: GoogleFonts.andika(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 50.0),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xfff4f4f4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40 * fem),
                topRight: Radius.circular(40 * fem),
              ),
            ),
            child: _selectedImage != null
                ? GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/final');
                    },
                    child: Ink(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Transform.scale(
                          scale: 2.5,
                          child: Image.asset(
                            'assets/images/YesButton.png',
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(''),
                                content: const Text(
                                    'Thank you for sharing food with me'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.pushNamed(context, '/final');
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: _takePicture,
                    child: Ink(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Transform.scale(
                          scale: 2.5,
                          child: Image.asset(
                            'assets/images/CameraButton.png',
                          ),
                        ),
                        onPressed: _takePicture,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
