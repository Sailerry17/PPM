@echo off
if not exist android flutter create --project-name wisata_sukabumi --org id.sukabumi .
flutter pub get
flutter run
