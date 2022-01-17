<?php

namespace App\Models;

use Carbon\CarbonImmutable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use JamesDordoy\LaravelVueDatatable\Traits\LaravelVueDatatableTrait;

class Challenge extends Model
{
    use HasFactory,LaravelVueDatatableTrait;
    protected $fillable = [
        'title',
        'slug',
        'description',
        'language',
        'link_figma',
        'design_on_figma',
        'image',
        'resources',
        'level',
        'cate_challen_id',
    ];
    protected $dataTableColumns = [
        'id' => [
            'searchable' => true,
        ],
        'title' => [
            'searchable' => true,
        ],
        'language' => [
            'searchable' => true,
        ],
        'level' => [
            'searchable' => true,
        ]
    ];
    protected $dataTableRelationships = [
        "belongsTo" => [
            'category' => [
                "model" => ChallengeCategory::class,
                'foreign_key' => 'cate_challen_id',
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
    public function category()
    {
        return $this->belongsTo(ChallengeCategory::class, 'cate_challen_id');
    }
    public function users()
    {
        return $this->belongsToMany(User::class,'challenge_users','challen_id','user_id');
    }
    public function solutions()
    {
        return $this->hasMany(Solution::class,'solution_id');
    }
}
