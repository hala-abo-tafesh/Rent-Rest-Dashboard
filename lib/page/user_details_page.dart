import 'package:admin_interface/models/admin_model.dart';
import 'package:flutter/material.dart';
import 'full_image_page.dart';

class UserDetailsPage extends StatelessWidget {
  final AdminModel user;

  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Front Side of ID',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const FullImagePage(
                                imagePath: 'https://i.imgur.com/5QFQ5Yk.png',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 280,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Image.network(
                              'https://i.imgur.com/5QFQ5Yk.png',
                              width: 280,
                              height: 130,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Back Side of ID',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const FullImagePage(
                                imagePath: 'https://i.imgur.com/7cW6G3V.png',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 280,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Image.network(
                              'https://i.imgur.com/7cW6G3V.png',
                              width: 280,
                              height: 130,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            Text(
              "Phone number:", //${user.phone ?? '--'}
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Email:", //${user.email ?? '--'}
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Date of birth:" ,// ${user.birthDate ?? '--'}
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
