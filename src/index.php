<?php

ini_set('display_errors', '1');
ini_set('display_startup_errors', '1');

$env_array = parse_ini_file(__DIR__ . DIRECTORY_SEPARATOR . '.env');
if ($env_array['PROJECT_DEBUG'] === true) {
    error_reporting(E_ALL);
} else {
    error_reporting(E_ALL ^ E_NOTICE ^ E_WARNING ^ E_DEPRECATED );
}

echo '<strong>PHP</strong> works' ."<br /><br />\n";
echo '<strong>connect to DB</strong>' ."<br />\n";
$dbname = 'test';
$dbuser = 'dev';
$dbpass = 'dev';
$dbhost = 'lemp-mysql';

// SQLite
//$ver = SQLite3::version();
//echo $ver['versionString'] . "<br />\n";
//echo $ver['versionNumber'] . "<br />\n";
//print_r($ver);
//echo "<br />\n" .'SQLite3 test results' . "<br />\n";
//$db = new SQLite3('db/test');
//$sql = "SELECT * FROM testare WHERE price < 3.00";
//$result = $db->query($sql);
//while ($row = $result->fetchArray(SQLITE3_ASSOC)){
//    echo $row['name'] . ': $' . $row['price'] . '<br/>';
//}
//unset($db);

// PostgreSQL test
//$db_connection = pg_connect("host=$dbhost dbname=$dbname user=$dbuser password=$dbpass") or die("Unable to Connect to '$dbhost'");

// MySQL test
$connect = mysqli_connect($dbhost, $dbuser, $dbpass) or die("Unable to Connect to '$dbhost'");

$test_query = "SHOW SCHEMAS";
$result = mysqli_query($connect, $test_query);

$dbCnt = 0;
while($db = mysqli_fetch_array($result)) {
    $dbCnt++;
    echo $db[0]."<br />\n";
}

mysqli_select_db($connect, $dbname) or die("Could not open the db '$dbname'");

$test_query = "SHOW TABLES FROM $dbname";
$result = mysqli_query($connect, $test_query);

$tblCnt = 0;
while($tbl = mysqli_fetch_array($result)) {
    $tblCnt++;
    echo $tbl[0]."<br />\n";
}

if (!$tblCnt) {
    echo "There are no tables<br />\n";
} else {
    echo "There are $tblCnt tables<br />\n";
}

// test mailer
// MailSlurper
//echo "<br />\n" . 'mailer <strong>MailCatcher</strong> test' ."<br />\n";
// Import PHPMailer classes into the global namespace
// These must be at the top of your script, not inside a function
//use PHPMailer\PHPMailer\PHPMailer;
//use PHPMailer\PHPMailer\SMTP;
//use PHPMailer\PHPMailer\Exception;

// Load Composer's autoloader
//require 'vendor/autoload.php';

// Instantiation and passing `true` enables exceptions
//$mail = new PHPMailer(true);
//
//try {
//    //Server settings
//    $mail->SMTPDebug = SMTP::DEBUG_SERVER;                      // Enable verbose debug output
//    $mail->isSMTP();                                            // Send using SMTP
//    $mail->Host       = 'lemp-mailhog';                    // Set the SMTP server to send through
//    $mail->SMTPAuth   = false;                                   // Enable SMTP authentication
////    $mail->Username   = 'user@example.com';                     // SMTP username
////    $mail->Password   = 'secret';                               // SMTP password
////    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;         // Enable TLS encryption; `PHPMailer::ENCRYPTION_SMTPS` encouraged
//    $mail->Port       = 1025;                                    // TCP port to connect to, use 465 for `PHPMailer::ENCRYPTION_SMTPS` above
//
//    //Recipients
//    $mail->setFrom('from@example.com', 'Mailer');
//    $mail->addAddress('joe@example.net', 'Joe User');     // Add a recipient
//    $mail->addAddress('ellen@example.com');               // Name is optional
//    $mail->addReplyTo('info@example.com', 'Information');
//    $mail->addCC('cc@example.com');
//    $mail->addBCC('bcc@example.com');
//
//    // Attachments
////    $mail->addAttachment('/var/tmp/file.tar.gz');         // Add attachments
////    $mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name
//
//    // Content
//    $mail->isHTML(true);                                  // Set email format to HTML
//    $mail->Subject = 'Here is the subject';
//    $mail->Body    = 'This is the HTML message body <b>in bold!</b>';
//    $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';
//
//    $mail->send();
//    echo 'Message has been sent';
//} catch (Exception $e) {
//    echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
//}
