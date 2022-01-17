<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use JamesDordoy\LaravelVueDatatable\Traits\LaravelVueDatatableTrait;

class Permission extends Model
{
    use HasFactory,LaravelVueDatatableTrait;
    protected $guard_name = 'api';
    protected $fillable = [
        'name',
        'guard_name'
    ];

    protected $dataTableColumns = [
        'id' => [
            'searchable' => false,
        ],
        'name' => [
            'searchable' => true,
        ]
    ];

    protected $dataTableRelationships = [
        //
    ];
    public function roles()
    {
        return $this->belongsToMany(Role::class,'role_has_permissions', 'permission_id', 'role_id');
    }
}
