<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use JamesDordoy\LaravelVueDatatable\Traits\LaravelVueDatatableTrait;
use Carbon\CarbonImmutable;


class Order extends Model
{
    use HasFactory,LaravelVueDatatableTrait;
    protected $fillable = [
        'order_nr',
        'upgrade_id',
        'user_id',
        'expiration',
        'amount',
        'status'
    ];
    protected $dataTableColumns = [
        'id' => [
            'searchable' => false,
        ],
        'order_nr' => [
            'searchable' => true,
        ],
        'status' => [
            'searchable' => true,
        ],
        'expiration' => [
            'searchable' => true,
        ]
    ];

    protected $dataTableRelationships = [
        "belongsTo" => [
            'user' => [
                "model" => User::class,
                'foreign_key' => 'user_id',
                'columns' => [
                    'name' => [
                        'searchable' => true,
                        'orderable' => true,
                    ],
                ],
            ],
            'upgrade' => [
                "model" => Upgrade::class,
                'foreign_key' => 'upgrade_id',
                'columns' => [
                    'name' => [
                        'searchable' => true,
                        'orderable' => true,
                    ],
                ],
            ],
        ],
    ];
    protected $appends = [
        'time',
    ];
    public function getTimeAttribute()
    {
        return CarbonImmutable::parse($this->updated_at)->calendar();
    }
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
    public function upgrade()
    {
        return $this->belongsTo(Upgrade::class, 'upgrade_id');
    }
}
