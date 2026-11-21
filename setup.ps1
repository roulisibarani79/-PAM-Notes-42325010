# Jalankan dari folder kit ini:  powershell -ExecutionPolicy Bypass -File setup.ps1
$ErrorActionPreference = 'Stop'
$kit = $PSScriptRoot
Set-Location $kit
if (Test-Path "pam_notes") { throw "Folder pam_notes sudah ada. Hapus dulu." }

flutter create --org del.ac.id pam_notes
Remove-Item "pam_notes\lib" -Recurse -Force
Copy-Item "$kit\lib" "pam_notes\lib" -Recurse
Copy-Item "$kit\firestore.rules" "pam_notes\firestore.rules"
Copy-Item "$kit\.gitignore" "pam_notes\.gitignore" -Force
if (Test-Path "$kit\run.bat") { Copy-Item "$kit\run.bat" "pam_notes\run.bat" }

Set-Location pam_notes
flutter pub add http flutter_map latlong2 google_mobile_ads firebase_core firebase_auth cloud_firestore google_sign_in

$mf = "android\app\src\main\AndroidManifest.xml"
$t = Get-Content $mf -Raw
if ($t -notmatch 'android.permission.INTERNET') {
  $t = $t -replace '<application', "<uses-permission android:name=`"android.permission.INTERNET`"/>`n    <application"
}
if ($t -notmatch 'APPLICATION_ID') {
  $meta = "`n        <meta-data android:name=`"com.google.android.gms.ads.APPLICATION_ID`" android:value=`"ca-app-pub-3940256099942544~3347511713`"/>"
  $re = [regex]'(?s)<application[^>]*>'
  $t = $re.Replace($t, { param($m) $m.Value + $meta }, 1)
}
Set-Content $mf $t -NoNewline

foreach ($g in "android\app\build.gradle.kts","android\app\build.gradle") {
  if (Test-Path $g) {
    $c = Get-Content $g -Raw
    $c = $c -replace 'minSdk\s*=\s*flutter\.minSdkVersion', 'minSdk = 23'
    $c = $c -replace 'minSdkVersion\s+flutter\.minSdkVersion', 'minSdkVersion 23'
    Set-Content $g $c -NoNewline
  }
}
Write-Host "Selesai. Lanjut ke README bagian B (Firebase), lalu jalankan run.bat" -ForegroundColor Green
