# APK Gawee

APK Gawee adalah aplikasi berbasis mobile yang dikembangkan untuk membantu proses pengelolaan data lowongan kerja dan perusahaan. Project ini terdiri dari **backend sebagai penyedia API** dan **frontend Flutter sebagai aplikasi mobile**.

## Fitur Utama
- Autentikasi pengguna (Login & Register)
- Manajemen data user
- Manajemen data lowongan kerja
- Integrasi API antara Flutter dan Backend
- Penyimpanan token autentikasi

## Teknologi yang Digunakan
### Backend
- PHP (Laravel)
- MySQL
- REST API

### Frontend
- Flutter
- Dart

### Tools Pendukung
- Git & GitHub
- Postman
- Visual Studio Code

---

## Cara Menjalankan Backend

### 1. Clone Repository
```bash
git clone https://github.com/username/apkgawee.git

2. Masuk ke Direktori Project

cd apkgawee

3. Install Dependency

composer install

4. Konfigurasi Environment

Salin file .env.example menjadi .env:

cp .env.example .env

Atur konfigurasi database pada file .env:

DB_DATABASE=nama_database
DB_USERNAME=username
DB_PASSWORD=password

5. Generate Key

php artisan key:generate

6. Migrasi Database

php artisan migrate

7. Menjalankan Server

php artisan serve

Backend akan berjalan pada:

http://localhost:8000

Cara Menjalankan Frontend (Flutter):
1. Masuk ke Folder Flutter

cd apkgawee_flutter

2. Install Dependency

flutter pub get

3. Jalankan Aplikasi

flutter run

Catatan :

Pastikan server backend berjalan sebelum menjalankan aplikasi Flutter

Gunakan emulator Android atau device fisik

IP backend dapat disesuaikan pada file konfigurasi Flutter
