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
if (preg_match("/addresses.php/i", $_SERVER['PHP_SELF'])) die();

/*
/*
 * This module's URL scheme:
 *
 *      0             1                  2          3
 * /address/[address_id]/[action]
 */

if (count($params) <= 2) {
    redirect_to("customers/");
    exit;
}

// And determine our action
$action = $params[count($params) - 1];

switch ($action) {
    case 'primary':
        $id = $params[1];
        if (!is_numeric($id)) {
            throw new BadMethodCallException("Provided address ID to delete is not numeric!");
        }
        $q = $db->query("SELECT * FROM address WHERE address_id=? LIMIT 1", $id);
        $email = $q->singleRecord();
        $q = $db->query("UPDATE address SET `primary` = 0 WHERE customer_id=?", $email['customer_id']);
        $q = $db->query("UPDATE address SET `primary` = 1 WHERE address_id=?", $id);
        flash_info("Primary address set successfully!");
        redirect_to("customers/".$email['customer_id']);
        break;
    case 'delete':
        $id = $params[1];
        if (!is_numeric($id)) {
            throw new BadMethodCallException("Provided address ID to delete is not numeric!");
        }
        $q = $db->query("DELETE FROM address WHERE address_id=? LIMIT 1", $id);
        flash_info("Address deleted successfully!");
        redirect_to($_SERVER['HTTP_REFERER']);
        break;
    case 'create':
        $new_address = array(
            $_POST['customer_id'],
            $_POST['address_type_id'],
            $_POST['name'],
            $_POST['address_line_1'],
            $_POST['address_line_2'],
            $_POST['city'],
            $_POST['state'], /* state_province_id */
            $_POST['country'] /* country_id */
        );
        $q = $db->query("INSERT INTO address (
            customer_id, address_type_id, name, address_line_1, address_line_2, city, state_province_id, country_id
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", $new_address);
        flash_info("Address <em>$name</em> added successfully!");
        redirect_to("customers/$customer_id/");
        break;
    case 'new':
        if (preg_match("/customer_([0-9]+)/i", $params[1], $customer) == 0) {
            redirect_to("customers/");
        }
        $customer_id = $customer[1];
        $q = $db->query("SELECT * FROM address_type");
        $address_types = $q->all();
        $q = $db->query("SELECT * FROM state_province");
        $states = $q->all();
        $q = $db->query("SELECT * FROM country");
        $countries = $q->all();
        $tpl->assign('address_types', $address_types);
        $tpl->assign('states', $states);
        $tpl->assign('countries', $countries);
        $tpl->assign('customer_id', $customer_id);
        renderWith('address_form.tpl', $tpl);
        break;
}