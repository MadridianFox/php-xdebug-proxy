<?php
/**
 * @author Mougrim <rinat@mougrim.ru>
 */

namespace Mougrim\XdebugProxy;

use Monolog\Handler\RotatingFileHandler;
use Monolog\Logger;

$logger = new Logger('xdebug-proxy');
$handler = new RotatingFileHandler('/var/log/dbgp/dbgp.log', 5, Logger::ERROR);
$handler->setFormatter(new LoggerFormatter());
return $logger->pushHandler($handler);
