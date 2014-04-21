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

/**
 * Helper function to add data to the end-user "flash"
 * @param string $type Message type (warning, error, or info)
 * @param string $message The message
 */
function flash($type, $message) {
    if ((!array_key_exists("flash_$type", $_SESSION)) || (!is_array($_SESSION["flash_$type"]))) {
        $_SESSION["flash_$type"] = array();
    }
    array_push($_SESSION["flash_$type"], $message);
}

/**
 * Helper function to add a warning "flash" message
 * @param string $message Message to display
 */
function flash_warning($message) {
    flash('warning', $message);
}

/**
 * Helper function to add an error "flash" message
 * @param string $message Message to display
 */
function flash_error($message) {
    flash('error', $message);
}

/**
 * Helper function to add an info "flash" message
 * @param string $message Message to display
 */
function flash_info($message) {
    flash('info', $message);
}

/**
 * Helper function to handle redirects
 * @param string $url URL to redirect to
 */
function redirect_to($url) {
    global $site_path;
    $site_path = preg_replace("/\\/$/", "", $site_path);
    header("Location: $site_path/$url", true, 301);
    die();
}

/**
 * Render with a specified template, ensuring flash messages are inserted
 * @param string $template_name Name of the template file
 * @param Smarty $engine Smarty template engine instance
 */
function renderWith($template_name, $engine) {
    // First do our flash
    $message_html = '';
    $types = array('info', 'warning', 'error');
    foreach ($types as $type) {
        if ((array_key_exists("flash_$type", $_SESSION)) && (is_array($_SESSION["flash_$type"]))) {
            $tag = ($type != 'error') ? $type : 'danger'; // Because I don't plan ahead...
            foreach ($_SESSION["flash_$type"] as $message) {
                $message_html .=<<<HTML
<div class="alert alert-$tag">
  <a href="#" class="alert-link">$message</a>
</div>
HTML;
            }
            $_SESSION["flash_$type"] = "";
        }
    }
    $engine->assign('messages', $message_html);
    // Then our database
    global $db;
    $db->renderQueryLog($engine);
    // And render
    $engine->display($template_name);
}