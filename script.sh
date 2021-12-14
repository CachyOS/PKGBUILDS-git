files=$(find . -name "PKGBUILD")

for f in $files
do
        d=$(dirname $f)
        echo "makepkg -src --sign --skipinteg --noconfirm $f"
        cd $d
        docker run --name dockerbuild -e EXPORT_PKG=1 -v $PWD:/pkg pttrr/docker-makepkg:latest
        docker rm dockerbuild
        cd ..
done

mv */*.tar.zst* /home/ptr1337/packages/
