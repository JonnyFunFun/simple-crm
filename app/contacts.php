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
if (preg_match("/contacts.php/i", $_SERVER['PHP_SELF'])) die();

/*
 * This module's URL scheme:
 *
 *      0             1                  2          3
 * /contacts/customer_<customer_id>/[contact_id]/[action]
 */

if (count($params) < 3) {
    redirect_to("customers/");
    exit;
}

// Get our customer ID
if (preg_match("/customer_([0-9]+)/i", $params[1], $customer) == 0) {
    redirect_to("customers/");
}
$customer_id = $customer[1];

if (count($params) == 4) {
    $action = $params[3];
} else {
    $action = $params[2];
}

switch ($action) {
    case 'view':
        try {
            $id = $params[2];
            $q = $db->query("SELECT * FROM contact WHERE contact_id=? LIMIT 1", $id);
            $contact = $q->singleRecord();
            $tpl->assign('contact', $contact);
            renderWith('contact_info.tpl', $tpl);
        } catch (NoResultsException $e) {
            echo 'Contact not found.';
        }
        break;
    case 'create':
        $new_contact = array(
            /* title */         $_POST['title'],
            /* description */   $_POST['description'],
            /* contact_type_id */ $_POST['contact_type_id'],
            /* customer_id */   $customer_id
        );
        $q = $db->query("INSERT INTO contact (title, description, contact_type_id, customer_id) VALUES (?, ?, ?, ?)", $new_contact);
        flash_info("Contact <em>$name</em> added successfully!");
        redirect_to("contacts/customer_$customer_id/list/");
        break;
    case 'new':
        $q = $db->query("SELECT * FROM contact_type");
        $contact_types = $q->all();
        $tpl->assign('contact_types', $contact_types);
        $tpl->assign('customer', $customer_id);
        renderWith('contact_form.tpl', $tpl);
        break;
}