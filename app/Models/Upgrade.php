<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use JamesDordoy\LaravelVueDatatable\Traits\LaravelVueDatatableTrait;
use Carbon\CarbonImmutable;

class Upgrade extends Model
{
    use HasFactory,LaravelVueDatatableTrait;
    protected $fillable = [
        'name',
        'description',
        'price',
        'period'
    ];
    protected $dataTableColumns = [
        'id' => [
            'searchable' => false,
        ],
        'name' => [
            'searchable' => true,
        ],
        'price' => [
            'searchable' => true,
        ],
        'period' => [
            'searchable' => true,
        ],
    ];

    protected $dataTableRelationships = [
        //
    ];
    protected $appends = [
        'time',
    ];
    public function getTimeAttribute()
    {
        return CarbonImmutable::parse($this->updated_at)->calendar();
    }
    public function orders(){
        return $this->hasMany(Order::class,'upgrade_id');
    }
}
