function mdcd {
mkdir $1
if [ $? -eq 0 ]; then
	cd $1
fi
}
