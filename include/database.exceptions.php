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
 * An exception thrown as a result of a bad query or other action while
 * connected to the MySQL server.
 *
 * @author Jonathan Enzinna <jonnyfunfun@gmail.com>
 * @version 1.0
 * @package simple-crm
 */
class DatabaseLayerException extends Exception {}

/**
 * An exception thrown as a result of a query having no results, yet a
 * Query object has been requested to fetch a row
 *
 * @author Jonathan Enzinna <jonnyfunfun@gmail.com>
 * @version 1.0
 * @package simple-crm
 */
class NoResultsException extends Exception {}