#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
KIT=$(pwd)
[ -d pam_notes ] && { echo "Folder pam_notes sudah ada"; exit 1; }
flutter create --org del.ac.id pam_notes
rm -rf pam_notes/lib
cp -r "$KIT/lib" pam_notes/lib
cp firestore.rules pam_notes/
cp -f .gitignore pam_notes/.gitignore
[ -f run.sh ] && cp run.sh pam_notes/
cd pam_notes
flutter pub add http flutter_map latlong2 google_mobile_ads firebase_core firebase_auth cloud_firestore google_sign_in
python3 - <<'PY'
import re, os
p='android/app/src/main/AndroidManifest.xml'
t=open(p).read()
if 'android.permission.INTERNET' not in t:
    t=t.replace('<application','<uses-permission android:name="android.permission.INTERNET"/>\n    <application',1)
if 'APPLICATION_ID' not in t:
    t=re.sub(r'(<application[^>]*>)',r'\1\n        <meta-data android:name="com.google.android.gms.ads.APPLICATION_ID" android:value="ca-app-pub-3940256099942544~3347511713"/>',t,count=1,flags=re.S)
open(p,'w').write(t)
for g in ('android/app/build.gradle.kts','android/app/build.gradle'):
    if os.path.exists(g):
        c=open(g).read()
        c=re.sub(r'minSdk\s*=\s*flutter\.minSdkVersion','minSdk = 23',c)
        c=re.sub(r'minSdkVersion\s+flutter\.minSdkVersion','minSdkVersion 23',c)
        open(g,'w').write(c)
PY
echo "Selesai. Lanjut ke README bagian B (Firebase)."
