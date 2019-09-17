import 'package:flutter/material.dart';

class AppConstants {
  static final String logoMin = "assets/logo.png";
  static final String logo_max = "assets/logo_extended.png";
  static final String appName = "Bizynest";
  static final Color appBlue = new Color(0xff1565c0);
  static final Color appPurple = new Color(0xFF601183);

  //REST API
  static final String BASE_WEBSITE = "https://bizynest.com/";
  static final String BASE_URL = "https://bizynest.com/api/src/routes/";
  static final String PROCESS_GET = BASE_URL + "process_one.php?";
  static final String PROCESS_POST = BASE_URL + "process_post.php";

  // 9JA States
  static const List<String> NIG_STATES = [
    "Abia",
    "Adamawa",
    "Anambra",
    "Akwa Ibom",
    "Bauchi",
    "Bayelsa",
    "Benue",
    "Borno",
    "Cross River",
    "Delta",
    "Ebonyi",
    "Enugu",
    "Edo",
    "Ekiti",
    "FCT - Abuja",
    "Gombe",
    "Imo",
    "Jigawa",
    "Kaduna",
    "Kano",
    "Katsina",
    "Kebbi",
    "Kogi",
    "Kwara",
    "Lagos",
    "Nasarawa",
    "Niger",
    "Ogun",
    "Ondo",
    "Osun",
    "Oyo",
    "Plateau",
    "Rivers",
    "Sokoto",
    "Taraba",
    "Yobe",
    "Zamfara",
  ];
}
