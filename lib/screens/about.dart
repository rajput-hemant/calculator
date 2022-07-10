import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Unit Converter",
          style: TextStyle(color: Colors.white, fontSize: 26),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Card(
                margin: const EdgeInsets.all(30),
                color: Colors.black,
                child: Column(children: [
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.language,
                        color: Colors.white,
                        size: 40,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Currency",
                      style: TextStyle(color: Colors.white, fontSize: 20))
                ]),
              ),
              Card(
                margin: const EdgeInsets.all(30),
                color: Colors.black,
                child: Column(children: [
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.straighten,
                        color: Colors.white,
                        size: 40,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Length",
                      style: TextStyle(color: Colors.white, fontSize: 20))
                ]),
              ),
              Card(
                margin: const EdgeInsets.all(30),
                color: Colors.black,
                child: Column(children: [
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.crop_original,
                        color: Colors.white,
                        size: 40,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Area",
                      style: TextStyle(color: Colors.white, fontSize: 20))
                ]),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Card(
                margin: const EdgeInsets.all(30),
                color: Colors.black,
                child: Column(children: [
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.av_timer,
                        color: Colors.white,
                        size: 40,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Speed",
                      style: TextStyle(color: Colors.white, fontSize: 20))
                ]),
              ),
              Card(
                margin: const EdgeInsets.all(30),
                color: Colors.black,
                child: Column(children: [
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.scale_rounded,
                        color: Colors.white,
                        size: 40,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Weight",
                      style: TextStyle(color: Colors.white, fontSize: 20))
                ]),
              ),
              Card(
                margin: const EdgeInsets.all(30),
                color: Colors.black,
                child: Column(children: [
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.flare,
                        color: Colors.white,
                        size: 40,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Temperature",
                      style: TextStyle(color: Colors.white, fontSize: 20))
                ]),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Card(
                margin: const EdgeInsets.all(30),
                color: Colors.black,
                child: Column(children: [
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.cable,
                        color: Colors.white,
                        size: 40,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Power",
                      style: TextStyle(color: Colors.white, fontSize: 20))
                ]),
              ),
              Card(
                margin: const EdgeInsets.all(30),
                color: Colors.black,
                child: Column(children: [
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.timelapse,
                        color: Colors.white,
                        size: 40,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Pressure",
                      style: TextStyle(color: Colors.white, fontSize: 20))
                ]),
              ),
              Card(
                margin: const EdgeInsets.all(30),
                color: Colors.black,
                child: Column(children: [
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.school,
                        color: Colors.white,
                        size: 40,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Voulme",
                      style: TextStyle(color: Colors.white, fontSize: 20))
                ]),
              )
            ],
          )
        ],
      )));
}
