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
 * A Query helper class that makes managing query results simple
 *
 * @author Jonathan Enzinna <jonnyfunfun@gmail.com>
 * @version 1.0
 * @package simple-crm
 */
class Query {
    /**
     * @var null|resource Current result set we are working with
     */
    private $resultset = null;

    /**
     * @var int Number of rows in the dataset
     */
    private $count__cached = 0;

    /**
     * @var int The number of the current row in the result set
     */
    private $row = 0;

    /**
     * Create a new query wrapped in the helper class
     * @param resource $db_result Resultset from mysql_query
     */
    public function __construct($db_result) {
        $this->resultset = $db_result;
        $this->count__cached = mysql_num_rows($this->resultset);
    }

    /**
     * Returns the number of records
     * @return int Number of rows
     */
    public function count() {
        return $this->count__cached;
    }

    public function affected() {
        return mysql_affected_rows($this->resultset);
    }

    /**
     * Throw an exception of there are no results in the result set
     * @throws NoResultsException
     */
    private function throwIfNoResults() {
        if ($this->count() == 0)
            throw new NoResultsException();
    }

    /**
     * Grabs a single record from the result
     * @return array Returned record as a named array
     * @param bool $ignore_multiple Should we ignore multiple record errors?
     * @throws DatabaseLayerException
     */
    public function singleRecord($ignore_multiple = false) {
        $this->throwIfNoResults();
        if (($this->count() > 1) && (!$ignore_multiple))
            throw new DatabaseLayerException("Cannot fetch single record with multiple rows.");
        if ($this->atEnd())
            throw new DatabaseLayerException("At end of record.");
        $result = mysql_fetch_array($this->resultset);
        if ($result) {
            ++$this->row;
            return $result;
        }
        throw new DatabaseLayerException("Unable to fetch next row.");
    }

    /**
     * Determines if we are at the end of the result set
     * @return bool
     */
    public function atEnd() {
        return $this->row == $this->count();
    }

    /**
     * Grabs the next record in the record set
     * @return array
     * @throws DatabaseLayerException
     */
    public function nextRecord() {
        return $this->singleRecord(true);
    }

    /**
     * Returns all records as an array of associative arrays
     * @return array
     * @throws DatabaseLayerException
     */
    public function all() {
        $results = array();
        while (!$this->atEnd())
            array_push($results, $this->nextRecord());
        return $results;
    }
}