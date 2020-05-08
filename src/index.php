<?php

echo 'php works' . PHP_EOL;
echo 'connect to MySQL';
$dbname = 'name';
$dbuser = 'user';
$dbpass = 'pass';
$dbhost = 'host';

$connect = mysqli_connect($dbhost, $dbuser, $dbpass) or die("Unable to Connect to '$dbhost'");
mysqli_select_db($dbname) or die("Could not open the db '$dbname'");

$test_query = "SHOW TABLES FROM $dbname";
$result = mysqli_query($test_query);

$tblCnt = 0;
while($tbl = mysqli_fetch_array($result)) {
    $tblCnt++;
    #echo $tbl[0]."<br />\n";
}

if (!$tblCnt) {
    echo "There are no tables<br />\n";
} else {
    echo "There are $tblCnt tables<br />\n";
}