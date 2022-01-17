<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use GoldSpecDigital\LaravelEloquentUUID\Database\Eloquent\Uuid;
use JamesDordoy\LaravelVueDatatable\Traits\LaravelVueDatatableTrait;
use Carbon\CarbonImmutable;

class Solution extends Model
{
    use HasFactory,Uuid,LaravelVueDatatableTrait;
    protected $keyType = 'string';
    public $incrementing = false;
    protected $guarded = [];
    protected $fillable = [
        'title',
        'description',
        'link_github',
        'demo_url',
        'user_id',
        'challen_id'
    ];
    protected $dataTableColumns = [
        'id' => [
            'searchable' => true,
        ],
        'title' => [
            'searchable' => true,
        ],
        'link_github' => [
            'searchable' => true,
        ],
        'demo_url' => [
            'searchable' => false,
        ],
       
    ];
    protected $dataTableRelationships = [
        "belongsTo" => [
            'challenge' => [
                "model" => Challenge::class,
                'foreign_key' => 'challen_id',
                'columns' => [
                    'title' => [
                        'searchable' => true,
                        'orderable' => true,
                    ],
                ],
            ],
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
        "hasMany" => [
            'feedbacks' => [
                "model" => Feedback::class,
                'foreign_key' => 'solution_id',
                'columns' => [
                    'id' => [
                        'searchable' => true,
                        'orderable' => true,
                    ],
                ],
            ],
            'upvote' => [
                "model" => Upvote::class,
                'foreign_key' => 'solution_id',
                'columns' => [
                    'user_id' => [
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
        return $this->belongsTo(User::class,'user_id');
    }
    public function feedbacks()
    {
        return $this->hasMany(Feedback::class,'solution_id');
    }
    public function challenge()
    {
    return $this->belongsTo(Challenge::class, 'challen_id');
    }
    public function upvote()
    {
        return $this->hasMany(Upvote::class,'solution_id');
    }
}
