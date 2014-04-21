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
if (preg_match("/home.php/i", $_SERVER['PHP_SELF'])) die();

$tpl->display('index.tpl');