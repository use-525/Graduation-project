<?php

return [
    // Cấu hình cho các cổng thanh toán tại hệ thống của bạn, các cổng không xài có thể xóa cho gọn hoặc không điền.
    // Các thông số trên có được khi bạn đăng ký tích hợp.

    'gateways' => [
        'MoMoAIO' => [
            'driver' => 'MoMo_AllInOne',
            'options' => [
                'accessKey' => '0YQLC9Ofd1qq6zwh',
                'secretKey' => 'YB8LswXQzNsvSsnaLvVUIn7DBE8AHhAu',
                'partnerCode' => 'MOMOJ10W20210701',
                'testMode' => true,
            ],
        ],
        'VNPay' => [
            'driver' => 'VNPay',
            'options' => [
                'vnpTmnCode' => 'TAROE778',
                'vnpHashSecret' => 'GCJEBWEJZXQDWJCFBNBESTJGHHOSRMWD',
                'testMode' => true,
            ],
        ],
    ],
];
