#!/bin/sh

test_utility_installed() {
	which $1 > /dev/null
	if [ $? -eq 1 ]; then
		echo "ERROR: \"$1\" utility not found. Install it via \"apt install $1\" (Ubuntu/Debian) or \"yum install $1\" (RedHat) or \"pkg install $1\" (FreeBSD) etc..."
		exit 1
	fi
}

test_utility_installed curl
test_utility_installed unzip

FILES="02_getting_an_image_on_the_screen \
04_key_presses \
05_optimized_surface_loading_and_soft_stretching \
06_extension_libraries_and_loading_other_image_formats \
10_color_keying \
11_clip_rendering_and_sprite_sheets \
12_color_modulation \
13_alpha_blending \
14_animated_sprites_and_vsync \
15_rotation_and_flipping \
16_true_type_fonts \
21_sound_effects_and_music"

mkdir -p data
cd data
for f in $FILES
do
	echo
	echo "Downloading $f.zip..."
	curl "http://lazyfoo.net/tutorials/SDL/$f/$f.zip" > "$f.zip"
	unzip -j -o "$f.zip" "*.png" "*.bmp" "*.ttf" "*.wav" > /dev/null 2> /dev/null

	# specialities...
	if [ "$f" = "10_color_keying" ]; then
		mv foo.png foo2.png
	fi
	if [ "$f" = "14_animated_sprites_and_vsync" ]; then
		mv foo.png foo_sprite.png
		mv foo2.png foo.png
	fi
done
rm -f *.zip

echo
echo "Done."
