<?php
/**
 * @author Mougrim <rinat@mougrim.ru>
 */

namespace Mougrim\XdebugProxy;

return [
    'xdebugServer' => [
        'listen' => '127.0.0.1:9000',
    ],
    'ideServer' => [
        'defaultIde' => '127.0.0.1:9003',
        'predefinedIdeList' => [
            'idekey' => '127.0.0.1:9100',
        ],
    ],
    'ideRegistrationServer' => [
        'listen' => '127.0.0.1:9001',
    ],
];
