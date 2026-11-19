#!/usr/bin/env bash
# Jalankan sekali dari folder ini: bash run.sh
set -e
if [ ! -d android ]; then
  flutter create --project-name wisata_sukabumi --org id.sukabumi .
fi
flutter pub get
flutter run
