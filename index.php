<?php
/**
 * Copyright (c) 2014: Jonathan Enzinna <jonnyfunfun@gmail.com>
 *
 * This program is free software. It comes without any warranty, to
 * the extent permitted by applicable law. You can redistribute it
 * and/or modify it under the terms of the Do What The Fuck You Want
 * To Public License, Version 2, as published by Sam Hocevar. See
 * http://www.wtfpl.net/ for more details.
 */

// Base configuration
require('include/config.inc');

// Are we debugging?
if (DEBUG) error_reporting(E_ALL);

// And all our helpers and classes
require('include/database.inc.php');
require('lib/smarty/Smarty.class.php');
require('include/helpers.inc.php');

session_start();

try {
    // Start up our database
    $db = new Database();
    $db->connect($db_hostname, $db_username, $db_password);
    $db->select_database($db_name);

    // And our templating engine
    $tpl = new Smarty;
    $tpl->caching = 0;


    // Common Smarty elements
    $tpl->assign('base_url', $site_path);
    $tpl->assign('messages', '');

    if (!array_key_exists('q', $_GET)) {
        $params = array('home',);
    } else {
        $params = preg_split('/\//', $_GET['q']);
    }

    // Determine what we're doing
    if (count($params) == 0) {
        $params = array('home',);
    }
    $action = $params[0];
    // Remove the last empty parameter if it is present
    if ($params[count($params) - 1] == '')
        array_pop($params);

    // And include our runner
    require_once('app/'.strtolower($action).'.php');
}
catch (Exception $e) {
?>

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Simple CRM</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="navbar-fixed-top.css" rel="stylesheet">

        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>

    <body>

    <div class="container">
        <?php print_r($e); ?>
    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    </body>
    </html>


<?php } // end catch ?>