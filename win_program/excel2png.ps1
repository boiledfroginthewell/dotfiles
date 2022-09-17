Param( $excelFile )

function Clipboald-To-Png($filePath) {
	Add-Type -AssemblyName System.Windows.Forms
	$clipboardImage = [Windows.Forms.Clipboard]::GetImage()
	if ($clipboardImage -ne $null) {
	  $clipboardImage.Save($filePath)
	}
}

$histFile = (Join-Path $env:TMP "excel2png\hist")
if (! $excelFile) {
	if (Test-Path $histFile) {
		$hist = Get-Content $histFile
	} else {
		echo "No input file"
		exit 1
	}
	echo $histFile
	$excelFile = $hist
} else {
	New-Item (Split-Path -Parent $histFile) -ItemType Directory -force
	$excelFile  | Out-File $histFile
}


$excel = New-Object -ComObject Excel.Application
try {
	#$excel.Visible = $true

	$book = $excel.Workbooks.Open($excelFile)
	$dir = (Join-Path (Split-Path -Parent $excelFile) "assets")
	New-Item $dir -ItemType Directory -force

	for ($i=1; $i -le $book.WorkSheets.Count; $i++) {
		$sheet = $book.WorkSheets.item($i)
		if ($sheet.name.substring(0, 4) -eq "img_") {
			$name = $sheet.name.substring(4) + ".png"
			$sheet.Select()
			$sheet.Shapes.SelectAll()
			$excel.Selection.Copy()
			echo $name
			Clipboald-To-Png (Join-Path $dir $name)
		}
	}
} finally {
	$excel.Quit()
	$excel = $null
	[GC]::Collect()
}

#pause
