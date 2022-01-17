<?php

namespace App\Models;
use Carbon\CarbonImmutable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use JamesDordoy\LaravelVueDatatable\Traits\LaravelVueDatatableTrait;
class ChallengeCategory extends Model
{
    use HasFactory,LaravelVueDatatableTrait;
    protected $table = "challenge_categories";
    protected $fillable = [
        'slug',
        'name',
        'slug',
        'image',
        'description',
        'rule',
    ];
    protected $dataTableColumns = [
        'id' => [
            'searchable' => false,
        ],
        'name' => [
            'searchable' => true,
        ],
        'image' => [
            'searchable' => true,
        ],
    ];
    protected $dataTableRelationships = [
        "hasMany" => [
            'challenges' => [
                "model" => Challenge::class,
                'foreign_key' => 'cate_challen_id',
                'columns' => [
                    'title' => [
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
    public function challenges(){
        return $this->hasMany(Challenge::class,'cate_challen_id');
    }
}
