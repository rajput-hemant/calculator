import 'package:flutter/material.dart';

class About extends StatelessWidget {
  static const routename = 'About';
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF060606),
        appBar: AppBar(
          backgroundColor: const Color(0xFF060606),
          title: const Text(
            "About us",
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontFamily: 'Roboto'),
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              child: const Center(
                child: Text(
                  "Calculator",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      backgroundColor: Colors.black12),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                const Image(
                  image: NetworkImage(
                      'https://c8.alamy.com/zooms/9/c1ae20f4f9dd4bb1904efa49479a42ac/tb0yme.jpg'),
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  width: 40,
                ),
                Column(
                  children: const [
                    Text("Khushal Agarwal",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    Text("201500340"),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Developer",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                const Image(
                  image: NetworkImage(
                      'https://cdn3.vectorstock.com/i/1000x1000/62/87/young-woman-profile-cartoon-vector-19116287.jpg'),
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  width: 40,
                ),
                Column(
                  children: const [
                    Text(
                      "Kuhoo Saxena",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("201500358"),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Developer",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                const Image(
                  image: NetworkImage(
                      'https://c8.alamy.com/comp/TC2G3D/young-man-avatar-cartoon-character-profile-picture-TC2G3D.jpg'),
                  width: 100,
                  height: 85,
                ),
                const SizedBox(
                  width: 40,
                ),
                Column(
                  children: const [
                    Text("Hemant Rajput",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    Text("201500289"),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Developer",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                const Image(
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDZGmXvuE-fuBVWGnJcQfdUSFNXaqTUWQjEv3lP8va3eMSPL5eRKEE4zE2Fow-kre17Vk&usqp=CAU'),
                  width: 100,
                  height: 80,
                ),
                const SizedBox(
                  width: 50,
                ),
                Column(
                  children: const [
                    Text("Shruti",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    Text("201500676"),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Content",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                const Image(
                  image: NetworkImage(
                      'https://thumbs.dreamstime.com/z/executive-businessman-smilig-profile-cartoon-vector-illustration-graphic-design-154894398.jpg'),
                  width: 100,
                  height: 90,
                ),
                const SizedBox(
                  width: 45,
                ),
                Column(
                  children: const [
                    Text(
                      "Ritik Kuntal",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("201500576"),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Content",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                const Image(
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTW8_CUvB10teIOsE_HOSMiGRMGjogfXVDV_biBoe7VlMGfTCfGYUF9QJZ1jeg-tavCiNQ&usqp=CAU'),
                  width: 70,
                  height: 100,
                ),
                const SizedBox(
                  width: 70,
                ),
                Column(
                  children: const [
                    Text("Suhani Pachouri",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    Text("201500715"),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Content",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                const Image(
                  image: NetworkImage(
                      'https://thumbs.dreamstime.com/z/elegant-man-business-suit-badge-man-business-avatar-profile-picture-vector-illustration-isolated-elegant-man-business-107918671.jpg'),
                  width: 70,
                  height: 100,
                ),
                const SizedBox(
                  width: 70,
                ),
                Column(
                  children: const [
                    Text(
                      "Ayush Sharma",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("201500183"),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Content",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                const Padding(padding: EdgeInsets.only(left: 4)),
                const Image(
                  image: NetworkImage(
                      'https://img.lovepik.com/element/40145/1025.png_860.png'),
                  width: 90,
                  height: 100,
                ),
                const SizedBox(
                  width: 45,
                ),
                Column(
                  children: const [
                    Text("Sakshi Chaudhary",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    Text("201500607"),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Content",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                const Image(
                  image: NetworkImage(
                      'https://image.shutterstock.com/image-illustration/portrait-europe-businessman-600w-1758016598.jpg'),
                  width: 100,
                  height: 80,
                ),
                const SizedBox(
                  width: 45,
                ),
                Column(
                  children: const [
                    Text(
                      "Vikas Singh",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("201500785"),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Content",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )
              ]),
            ),
          ],
        ));
  }
}
