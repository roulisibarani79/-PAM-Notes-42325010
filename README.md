# PAM Notes - Kit Praktikum Minggu 11

## A. Setup otomatis (di folder kit ini)
Windows:  powershell -ExecutionPolicy Bypass -File setup.ps1
Mac/Linux: ./setup.sh
Hasil: folder pam_notes/ (paket del.ac.id.pam_notes) lengkap dengan kode, paket, izin INTERNET, App ID AdMob uji, minSdk 23.

## B. Firebase (wajib dilakukan sendiri)
1. console.firebase.google.com -> Create project (mis. pam-notes-NIM).
2. Authentication -> Sign-in method -> aktifkan Email/Password dan Google.
3. Firestore Database -> Create database -> production mode.
4. Firestore -> Rules -> tempel isi firestore.rules -> Publish.
5. Terminal:
     npm i -g firebase-tools
     firebase login
     dart pub global activate flutterfire_cli
     cd pam_notes
     flutterfire configure --project=ID_PROJECT_ANDA     (pilih android)
6. SHA-1: cd android ; gradlew signingReport (Windows) / ./gradlew signingReport
   Salin SHA-1 debug -> Project settings -> Your apps -> Add fingerprint.
   Jalankan flutterfire configure lagi agar google-services.json diperbarui.
7. Salin Web client ID (Authentication -> Google) ke run.bat / run.sh
   menggantikan WEB_CLIENT_ID_ANDA.

## C. Menjalankan
  cd pam_notes
  flutter clean
  flutter pub get
  run.bat     (atau ./run.sh)

run.bat, run.sh, dan google-services.json masuk .gitignore agar tidak ter-commit.

## D. Laporan
Uji 4 skenario Rules Playground (Praktikum 7.3) + uji akun A/B di aplikasi.
