platform=$1

echo "Install flutter"
echo "Start build $platform"
if [ -d "flutter" ]; then echo "Finish install flutter"
    else
        git clone "https://github.com/flutter/flutter.git" -b stable
    fi

export PATH="$PATH:`pwd`/flutter/bin"
echo "Flutter check"
flutter doctor
echo "Flutter get dependencies"
flutter pub get
echo "Flutter build $platform"
flutter build $platform
echo "Finish"

