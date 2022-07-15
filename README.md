![View Counter](https://komarev.com/ghpvc/?username=calculator&label=View%20Counter&color=red&style=flat) &nbsp; &nbsp; ![Repo Size](https://img.shields.io/github/repo-size/rajput-hemant/calculator?color=blue)

<div align = center>

# Calculator

### A Simple but elegant Calculator app made with Flutter with Currency (Exchange Rate) & Unit Converter.

## ![][android] Download APK

---

**[<kbd> <br> Universal Release <br> </kbd>][universal-release]**
**[<kbd> <br> arm64 <br> </kbd>][arm64]**
**[<kbd> <br> armabi <br> </kbd>][armabi]**
**[<kbd> <br> Source Code (zip) <br> </kbd>][sc-zip]**
**[<kbd> <br> Source Code (tar.gz) <br> </kbd>][sc-tar.gz]**

---

## 📱 App UI

<details><summary> Click here to expand</summary>

|      _Calculator Screen_      |          _Units Screen_          |     _Exchange Rate Screen_     |
| :---------------------------: | :------------------------------: | :----------------------------: |
|    ![][calculator screen]     |        ![][units screen]         |   ![][exchange rate screen]    |
|    **_Rate Bottom Sheet_**    |  **_Length Conversion Screen_**  |  **_Area Conversion Screen_**  |
|    ![][rate bottom sheet]     |  ![][length conversion screen]   |  ![][area conversion screen]   |
| **_Speed Conversion Screen_** |  **_Weight Conversion Screen_**  |  **_Data Conversion Screen_**  |
| ![][speed conversion screen]  |  ![][weight conversion screen]   |  ![][data conversion screen]   |
| **_Power Conversion Screen_** | **_Pressure Conversion Screen_** | **_Volume Conversion Screen_** |
| ![][power conversion screen]  | ![][pressure conversion screen]  | ![][volume conversion screen]  |
|      **_About Screen_**       |       **Team Screen**        |     **_Settings Screen_**      |
|       ![][about screen]       |         ![][team screen]         |      ![][settings screen]      |

</details>

## Directory Structure

</div>

```
calculator
|
|-- assets
|   |-- fonts
|   |   |-- Montserrat-Regular.ttf
|   |   `-- PTSans-Regular.ttf
|   |
|   `-- images
|       `-- app_icon.png
|
|-- lib
|   |-- brain
|   |   `-- calculator_brain.dart
|   |
|   |-- models
|   |   |-- area.dart
|   |   |-- currency.dart
|   |   |-- data.dart
|   |   |-- length.dart
|   |   |-- power.dart
|   |   |-- pressure.dart
|   |   |-- speed.dart
|   |   |-- volume.dart
|   |   `-- weight.dart
|   |
|   |-- screens
|   |   |-- about_screen.dart
|   |   |-- area_conversion_screen.dart
|   |   |-- calculator_screen.dart
|   |   |-- data_conversion_screen.dart
|   |   |-- exchange_rate_screen.dart
|   |   |-- length_conversion_screen.dart
|   |   |-- power_conversion_screen.dart
|   |   |-- pressure_conversion_screen.dart
|   |   |-- settings_screen.dart
|   |   |-- speed_conversion_screen.dart
|   |   |-- unit_converter_screen.dart
|   |   |-- volume_conversion_screen.dart
|   |   `-- weigth_conversion_screen.dart
|   |
|   |-- utils
|   |   |-- constants.dart
|   |   `-- money_converter.dart
|   |
|   |-- widgets
|   |   |-- bottom_sheet_tile.dart
|   |   |-- field_list_tile.dart
|   |   |-- keypad_builder.dart
|   |   |-- round_button.dart
|   |    |-- scrollable_sheet.dart
|   |   |-- unit_box.dart
|   |   |-- unit_icon.dart
|   |   `-- url_launcher.dart
|   |
|   `-- main.dart
|
`-- pubspec.yaml
```

<div align = center>

## Building from Source

</div>

- If you don't have Flutter SDK installed, please visit official [Flutter](https://flutter.dev/) site.
- Fetch latest source code from master branch.

```console
rajput-hemant@arch:~$ git clone https://github.com/rajput-hemant/calculator
```

- Run the app with Android Studio or VS Code. Or the command line:

```console
rajput-hemant@arch:~$ flutter pub get
rajput-hemant@arch:~$ flutter run
```

<div align = center>

## Contributors:

<a href="https://github.com/rajput-hemant/calculator/graphs/contributors" target="blank"> <img src="https://contrib.rocks/image?repo=rajput-hemant/calculator&max=500" /></a>

</div>

<!----------------------------------{ Images }--------------------------------->

[calculator screen]: https://telegra.ph/file/9207c7449caa0740a9031.png
[units screen]: https://telegra.ph/file/66a9b0b152fd7ae98b618.png
[exchange rate screen]: https://telegra.ph/file/29b7d3a9931649ffaec4f.png
[rate bottom sheet]: https://telegra.ph/file/3c5757d00f860075f14dc.png
[length conversion screen]: https://telegra.ph/file/e3d19290d4dfc1917f57c.png
[area conversion screen]: https://telegra.ph/file/b8529394235697cf4e212.png
[speed conversion screen]: https://telegra.ph/file/a612f8ad46941a0f94bba.png
[weight conversion screen]: https://telegra.ph/file/389570e5b4e59eec06945.png
[data conversion screen]: https://telegra.ph/file/8c65b8e2588d49ae21ef7.png
[power conversion screen]: https://telegra.ph/file/502d08a50aca587131d96.png
[pressure conversion screen]: https://telegra.ph/file/e00c1f155397e669e15f1.png
[volume conversion screen]: https://telegra.ph/file/e9d48778be1fcd7768a85.png
[about screen]: https://telegra.ph/file/4f1b0f47c55931129b5a7.png
[team screen]: https://telegra.ph/file/aa8795b3920b1a87c7f36.png
[settings screen]: https://telegra.ph/file/3bae1d93c68b9b5840731.png
[android]: https://telegra.ph/file/460364b337b65eda65178.png

<!------------------------------------{ apk }----------------------------------->

[universal-release]: https://github.com/rajput-hemant/calculator/releases/download/v0.1.0/Calculator-v0.1.0-universal-release.apk
[arm64]: https://github.com/rajput-hemant/calculator/releases/download/v0.1.0/Calculator-v0.1.0-arm64.apk
[armabi]: https://github.com/rajput-hemant/calculator/releases/download/v0.1.0/Calculator-v0.1.0-armeabi.apk

<!--------------------------------{ source code }------------------------------->

[sc-zip]: https://github.com/rajput-hemant/calculator/archive/refs/tags/v0.1.0.zip
[sc-tar.gz]: https://github.com/rajput-hemant/calculator/archive/refs/tags/v0.1.0.tar.gz
