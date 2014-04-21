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

require_once('database.exceptions.php');
require_once('database.query.php');

/**
 * A simple class to handle connections and queries with a database
 *
 * @author Jonathan Enzinna <jonnyfunfun@gmail.com>
 * @version 1.0
 * @package simple-crm
 */
class Database {

    /**
     * @var resource Database link
     */
    private $db_link = null;

    /**
     * @var string Name of the currently selected database
     */
    private $current_database = '';

    /**
     * @var array List of all queries performed when LOG_QUERIES is true
     */
    private $query_log = array();

    /**
     * Establish a connection with the database
     * @param string $hostname Hostname for the database
     * @param string $username Username to use when connecting
     * @param string $password Password to use when connecting
     * @throws PDOException
     */
    public function connect($hostname, $username, $password) {
        $this->db_link = mysql_connect($hostname, $username, $password);
        if (!$this->db_link) {
            throw new PDOException("Could not connect to database");
        }
    }

    /**
     * Select a database to USE
     * @param string $name Name of the database to use
     * @throws DatabaseLayerException
     */
    public function select_database($name) {
        if (!mysql_select_db($name, $this->db_link)) {
            throw new DatabaseLayerException(sprintf("Unable to select database: %s", mysql_error()), 0);
        }
        $this->current_database = $name;
    }

    /**
     * Sanitizes a query and binds variables
     * @param string $_query The query to sanitize with inputs bound to question marks
     * @param array $_params The parameters to bind to the query
     * @return string
     * @uses _Q_escape($_value, $_position) Helper function for sanitation
     * @access private
     */
    private function sanitize($_query, $_params = null)
    {
            if ($_params)
                $argc = count($_params);
            else
                $argc = 0;
            $n = 0;                 // first vararg $argv[1]
            
            $out = '';
            $quote = FALSE;         // quoted string state
            $slash = FALSE;         // backslash state

            // b - pointer to start of uncopied text
            // e - pointer to current input character
            // end - end of string pointer
            $end = strlen($_query);
            for ($b = $e = 0; $e < $end; ++$e)
            {
                    $ch = $_query{$e};

                    if ($quote !== FALSE)
                    {
                            if ($slash)
                            {
                                    $slash = FALSE;
                            }
                            elseif ($ch === '\\')
                            {
                                    $slash = TRUE;
                            }
                            elseif ($ch === $quote)
                            {
                                    $quote = FALSE;
                            }
                    }
                    elseif ($ch === "'" || $ch === '"')
                    {
                            $quote = $ch;
                    }
                    elseif ($ch === '?')
                    {
                            $out .= substr($_query, $b, $e - $b) .
                                    $this->_Q_escape($_params[$n], $n);
                            $b = $e + 1;
                            $n++;
                    }
            }
            $out .= substr($_query, $b, $e - $b);

            // warn on arg count mismatch
            if ($argc != $n)
            {
                    $adj = ($argc > $n) ? 'many' : 'few';
                    trigger_error('Too ' . $adj . ' arguments ' .
                                    '(expected ' . $n . '; got ' . $argc . ')',
                            E_USER_WARNING);
            }

            return $out;
    }

    /**
     * Helper function for "Q($_query)" - do not use directly
     * @param  $_value
     * @param bool $_position
     * @return string
     * @see Q($_query)
     * @access private
     */
    private function _Q_escape($_value, $_position = FALSE)
    {
            static $r_position;
            // Save $_position to simplify recursive calls.
            if ($_position !== FALSE)
            {
                    $r_position = $_position;
            }

            if (is_null($_value))
            {
                    // The NULL value
                    return 'NULL';
            }
            elseif (is_int($_value) || is_float($_value))
            {
                    $result = "$_value";
            }
            elseif (is_array($_value))
            {
                    $result = implode(', ', array_map('_Q_escape', array_values($_value)));
            }
            else
            {
                    // Warn if given an unexpected value type
                    if (!is_string($_value))
                    {
                            trigger_error('Unexpected value of type "' .
                                    gettype($_value) . '" in arg '.$r_position,
                                    E_USER_WARNING);
                    }

                    // Everything else gets escaped as a string
                    $result = "'" . addslashes($_value) . "'";
            }

            return $result;
    }

    /**
     * @param string $sql Query string
     * @param null $params array of parameters to bind to the query
     * @return Query Query object
     * @throws DatabaseLayerException
     */
    public function query($sql, $params = null) {
        if ($this->db_link === null)
            throw new DatabaseLayerException("Not connected.");
        if ($this->current_database === '')
            throw new DatabaseLayerException("No database selected.");

        $sql = $this->sanitize($sql, $params);

        $result = mysql_query($sql, $this->db_link);

        $this->logQuery($sql);

        if (!$result)
            throw new DatabaseLayerException(sprintf("Query error: %s", mysql_error($this->db_link)));

        if (is_bool($result)) {
            return $result;
        } else {
            return new Query($result);
        }
    }

    /**
     * Log a query to the internal logger
     * @param string $sql
     */
    private function logQuery($sql) {
        if (!LOG_QUERIES) return;

        array_push($this->query_log, $sql);
    }

    /**
     * Renders all query logs to the template engine using placeholder {{query_log}}
     * @param Smarty $tpl Smarty template engine instance
     */
    public function renderQueryLog($tpl) {
        if (!LOG_QUERIES) return;

        $tpl->assign('query_log', print_r($this->query_log, true));
    }
}
