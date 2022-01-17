<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use JamesDordoy\LaravelVueDatatable\Traits\LaravelVueDatatableTrait;
use Carbon\CarbonImmutable;
class Notification extends Model
{
    use HasFactory,LaravelVueDatatableTrait;
    protected $fillable = ['user_id','title','content','is_read'];
    protected $dataTableColumns = [
        'id' => [
            'searchable' => true,
        ],
        'title' => [
            'searchable' => true,
        ],
        'content' => [
            'searchable' => true,
        ],
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
        ],
    ];
    protected $appends = [
        'time',
    ];
    public function getTimeAttribute()
    {
        return CarbonImmutable::parse($this->updated_at)->calendar();
    }
    public function user(){
        return $this->belongsTo(User::class,'user_id');
    }
}
