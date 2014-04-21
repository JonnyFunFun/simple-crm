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

// Prevent direct access
if (preg_match("/config.inc/i", $_SERVER['PHP_SELF'])) die();

/**
 * Hostname for the MySQL connection
 */
$db_hostname = 'localhost';

/**
 * Username for the MySQL connection
 */
$db_username = 'root';

/**
 * Password for the MySQL connection
 */
$db_password = '';

/**
 * Name of the MySQL database
 */
$db_name = 'crm';

/**
 * Table prefix in the MySQL database
 */
$db_prefix = '';

/**
 * Path of the application relative to the site root
 */
$site_path = '/crm/';

/**
 * Are we in debug mode?
 */
define('DEBUG', true);

/**
 * Should we log all queries and output them after the page is rendered?
 */
define('LOG_QUERIES', true);