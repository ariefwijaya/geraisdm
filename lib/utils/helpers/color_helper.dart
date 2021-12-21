//Temporary fixed, should be sent from BE
class ColorHelper {
  const ColorHelper._();

  static int getChartHexColor(int identifier) {
    switch (identifier) {
      case 14: // Gaji
        return 0xFF1DC6FC;
      case 15: // Tagihan
        return 0xFF1DC6FC;
      case 16: // Transportasi
        return 0xFF219653;
      case 17: // Liburan
        return 0xFFF2994A;
      case 20: // Groceries
        return 0xFF6FCF97;
      case 19: // Makan dan Minum
        return 0xFFF34A23;
      case 21: // Pemasukan Lainnya
        return 0xFFBDBDBD;
      case 6: // Investasi
        return 0xFF2F80ED;
      case 18: // Hasil Investasi
        return 0xFF2F80ED;
      case 2: // Belanja
        return 0xFF000000;
      case 3: // Donasi
        return 0xFFDC8787;
      case 4: // Edukasi
        return 0xFFFFD144;
      case 5: // Hiburan
        return 0xFF9B51E0;
      case 7: //Keluarga dan Teman
        return 0xFF4B0D80;
      case 8: //Kesehatan
        return 0xFFE7194F;
      case 9: //Lainnya
        return 0xFFBDBDBD;
      case 13: //Bonus
        return 0xFF4B0D80;
      default:
        return 0xFFBDBDBD;
    }
  }
}
