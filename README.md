# mkspiffs for Apple Silicon (macOS ARM64) 執行檔
# mkspiffs Prebuilt Binary for Apple Silicon (macOS ARM64)

---

[點我下載 mkspiffs_espressif32_arduino_macos_arm64](./mkspiffs_espressif32_arduino_macos_arm64)

[Download Here mkspiffs_espressif32_arduino_macos_arm64](./mkspiffs_espressif32_arduino_macos_arm64)


## 簡介 | Introduction

提供可直接在 Apple Silicon macOS 上運作的 mkspiffs 預編譯二進位檔案，方便 PlatformIO 使用 ESP32 的用戶，解決「Bad CPU type in executable」錯誤。

This repository provides a prebuilt mkspiffs binary that works on Apple Silicon macOS, so PlatformIO ESP32 developers can replace the default binary and fix the "Bad CPU type in executable" error.

---

## 使用方法 | How to use

1. **下載本頁的二進位檔案**  
   Download the binary file from this repository.

2. **複製並覆蓋 PlatformIO 舊有檔案**  
   Replace the original file in your PlatformIO tool folder with this binary  
   輸入以下指令（需將 `mkspiffs_for_Apple_Silicon` 換成你下載的實際檔名）：  
   Run the following command in terminal (replace filename as necessary):

   ```bash
   cp mkspiffs_for_Apple_Silicon ~/.platformio/packages/tool-mkspiffs/mkspiffs_espressif32_arduino
   ```

3. **重新執行 PlatformIO 建置檔案系統指令**  
   Run PlatformIO's buildfs/uploadfs as usual:

   ```bash
   pio run --target buildfs
   pio run --target uploadfs
   ```

   如果看到沒有錯誤，就代表已經修復！

---

## 注意事項 | Notes

- 若 PlatformIO 或 ESP32 關聯的套件有重大升級，可能需要**重新用新二進位替代舊檔**，以確保相容性與正常運作。

- If PlatformIO or ESP32 related packages are updated, you may need to **replace the binary again** with a newly built version to ensure compatibility and proper operation.


## 問題回報 | Issues

如果有任何問題，歡迎在本 repo 提出 issue，或補充建議、心得，讓更多人受惠！

If you have any problems or suggestions, feel free to open an issue or contribute to this repo.

---

## 來源 | Source

mkspiffs 專案原始碼：  
[https://github.com/igrr/mkspiffs](https://github.com/igrr/mkspiffs)
