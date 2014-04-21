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
if (preg_match("/customers.php/i", $_SERVER['PHP_SELF'])) die();

if (count($params) == 1) {
    $action = 'list';
} elseif (is_numeric($params[1])) {
    $action = 'view';
} else {
    $action = $params[1];
}

switch ($action) {
    case 'list':
        $q = $db->query("SELECT c.customer_id, c.name, ct.type_name as customer_type FROM customer c
                            LEFT JOIN customer_type ct on ct.customer_type_id = c.customer_type_id");
        $customers = $q->all();
        $q = $db->query("SELECT * FROM customer_type");
        $customer_types = $q->all();
        $tpl->assign('customer_types', $customer_types);
        $tpl->assign('customers', $customers);
        renderWith('customer_list.tpl', $tpl);
        break;
    case 'view':
        try {
            $customer_id = $params[1];
            $q = $db->query("SELECT c.customer_id, c.name, ct.type_name as customer_type FROM customer c
                                LEFT JOIN customer_type ct on ct.customer_type_id = c.customer_type_id
                                WHERE customer_id=? LIMIT 1", $customer_id);
            $customer = $q->singleRecord();
            $q = $db->query("SELECT a.*, at.type_name as address_type, sp.name as state_prov_name, c.name as country_name FROM address a
                                LEFT JOIN address_type at ON at.address_type_id = a.address_type_id
                                LEFT JOIN state_province sp ON sp.state_province_id = a.state_province_id
                                LEFT JOIN country c ON c.country_id = a.country_id
                                WHERE a.customer_id=?", $customer_id);
            $addresses = $q->all();
            $q = $db->query("SELECT e.*, et.type_name as email_type FROM email e
                                LEFT JOIN email_type et ON et.email_type_id = e.email_type_id
                                WHERE e.customer_id=?", $customer_id);
            $emails = $q->all();
            $q = $db->query("SELECT c.contact_id, c.title, c.date_time, ct.type_name as contact_type,
                                    COALESCE(a.attachment_count,0) as attachment_count FROM contact c
                                LEFT JOIN contact_type ct ON ct.contact_type_id = c.contact_type_id
                                LEFT JOIN (
                                    SELECT COUNT(*) as attachment_count, a.contact_id FROM attachment a
                                    WHERE a.contact_id IN (
                                        SELECT contact_id FROM contact WHERE customer_id=?
                                    ) GROUP BY a.contact_id
                                ) a
                                    ON a.contact_id = c.contact_id
                                WHERE c.customer_id=?", array($customer_id, $customer_id));
            $contacts = $q->all();
            $q = $db->query("SELECT * FROM email_type");
            $email_types = $q->all();
            // Assign our thingies
            $tpl->assign('customer', $customer);
            $tpl->assign('addresses', $addresses);
            $tpl->assign('emails', $emails);
            $tpl->assign('contacts', $contacts);
            $tpl->assign('email_types', $email_types);
            // And render!
            renderWith('customer_view.tpl', $tpl);
        } catch (NoResultsException $e) {
            echo 'No records found.';
        }
        break;
    case 'delete':
        $customer_id = $params[2];
        if (!is_numeric($customer_id)) {
            throw new BadMethodCallException("Provided customer ID to delete is not numeric!");
        }
        $q = $db->query("DELETE FROM customer WHERE customer_id=? LIMIT 1", $customer_id);
        if (!$q) {
            flash_warning("Unable to delete the customer: ".mysql_error());
        } else {
            flash_info("Customer deleted successfully!");
        }
        redirect_to("customers/list/");
        break;
    case 'add':
        $new_customer = array(
            /* customer_type_id */  $_POST['customer_type_id'],
            /* name */              $_POST['name']
        );
        $q = $db->query("INSERT INTO customer (customer_type_id, name) VALUES (?, ?)", $new_customer);
        flash_info("Customer <em>$name</em> added successfully!");
        redirect_to("customers/list/");
        break;
}