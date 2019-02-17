alias calc='set -f;_calc';
_calc(){
	if [ "$1" = "-e" ];then
		shift
		perl -e "print(sprintf('%.2e', $*)\n)";
	else
		perl -e "print($*\n)";
	fi

	set +f;
}
