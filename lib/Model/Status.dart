import 'dart:collection';

class Status {
  static Map<int, String> statusMSG = {
    100: "FT",
    6: "1st Half",
    7: "2nd Half",
    0: "",
    31: "HT",
    70: "Cancelled",
    120: "AP"
  };

  static String getStatusMSG(int code) {
    if (statusMSG.containsKey(code)) return statusMSG[code]!;
    return code.toString();
  }

  static bool isScoreNeeded(int code) {
    return !(code == 0 || code == 70);
  }
}
