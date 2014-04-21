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
if (preg_match("/emails.php/i", $_SERVER['PHP_SELF'])) die();

/*
 * This module's URL scheme:
 * 
 *      0             1                  2          3
 * /emails/[email_id]/[action]
 */

if (count($params) < 2) {
    redirect_to("customers/");
    exit;
}

// And determine our action
$action = $params[count($params) - 1];

switch ($action) {
    case 'primary':
        $id = $params[1];
        if (!is_numeric($id)) {
            throw new BadMethodCallException("Provided email ID to delete is not numeric!");
        }
        $q = $db->query("SELECT * FROM email WHERE email_id=? LIMIT 1", $id);
        $email = $q->singleRecord();
        $q = $db->query("UPDATE email SET `primary` = 0 WHERE customer_id=?", $email['customer_id']);
        $q = $db->query("UPDATE email SET `primary` = 1 WHERE email_id=?", $id);
        flash_info("Primary email set successfully!");
        redirect_to("customers/".$email['customer_id']);
        break;
    case 'delete':
        $id = $params[1];
        if (!is_numeric($id)) {
            throw new BadMethodCallException("Provided email ID to delete is not numeric!");
        }
        $q = $db->query("DELETE FROM email WHERE email_id=? LIMIT 1", $id);
        flash_info("Email deleted successfully!");
        redirect_to($_SERVER['HTTP_REFERER']);
        break;
    case 'add':
        $new_email = array(
            $_POST['customer_id'],
            $_POST['email_type_id'],
            $_POST['email']
        );
        $customer_id = $_POST['customer_id'];
        $q = $db->query("INSERT INTO email (customer_id, email_type_id, address) VALUES (?, ?, ?)", $new_email);
        flash_info("Email <em>$name</em> added successfully!");
        redirect_to("customers/$customer_id/");
        break;
}