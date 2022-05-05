class Common {
  // 获取分数位数
  static int getFractionDigits(double value) {
    List<String> indexList = value.toString().split('.');
    if (indexList.length == 1) return 0;
    if (indexList[1] == '0') return 0;
    return indexList[1].length;
  }
}
