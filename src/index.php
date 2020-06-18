<?php

ini_set('display_errors', '1');
ini_set('display_startup_errors', '1');

$env_array = parse_ini_file(__DIR__ . DIRECTORY_SEPARATOR . '.env');
if ($env_array['PROJECT_DEBUG'] === true) {
    error_reporting(E_ALL);
} else {
    error_reporting(E_ALL ^ E_NOTICE ^ E_WARNING ^ E_DEPRECATED );
}

echo 'php works' ."<br />\n";
echo 'connect to DB' ."<br />\n";
$dbname = 'test';
$dbuser = 'dev';
$dbpass = 'dev';
$dbhost = 'lemp-postgresql';

// SQLite
//$ver = SQLite3::version();
//echo $ver['versionString'] . "<br />\n";
//echo $ver['versionNumber'] . "<br />\n";
//print_r($ver);

// PostgreSQL test
$db_connection = pg_connect("host=$dbhost dbname=$dbname user=$dbuser password=$dbpass") or die("Unable to Connect to '$dbhost'");

// MySQL test
//$connect = mysqli_connect($dbhost, $dbuser, $dbpass) or die("Unable to Connect to '$dbhost'");
//
//$test_query = "SHOW SCHEMAS";
//$result = mysqli_query($connect, $test_query);
//
//$dbCnt = 0;
//while($db = mysqli_fetch_array($result)) {
//    $dbCnt++;
//    echo $db[0]."<br />\n";
//}
//
//mysqli_select_db($connect, $dbname) or die("Could not open the db '$dbname'");
//
//$test_query = "SHOW TABLES FROM $dbname";
//$result = mysqli_query($connect, $test_query);
//
//$tblCnt = 0;
//while($tbl = mysqli_fetch_array($result)) {
//    $tblCnt++;
//    echo $tbl[0]."<br />\n";
//}
//
//if (!$tblCnt) {
//    echo "There are no tables<br />\n";
//} else {
//    echo "There are $tblCnt tables<br />\n";
//}