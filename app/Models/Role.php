<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use JamesDordoy\LaravelVueDatatable\Traits\LaravelVueDatatableTrait;

class Role extends Model
{
    use HasFactory,LaravelVueDatatableTrait;
    protected $fillable = [
        'name',
        'guard_name'
    ];
    protected $guard_name = 'api';
    protected $dataTableColumns = [
        'id' => [
            'searchable' => false,
        ],
        'name' => [
            'searchable' => true,
        ]
    ];

    protected $dataTableRelationships = [
        "belongsToMany" => [
            "users" => [
                "model" => User::class,
                "pivot" => [
                    "table_name" => "model_has_roles",
                    "foreign_key" => "model_id",
                    "local_key" => "role_id",
                ],
                "columns" => [
                    "name" => [
                        "searchable" => true,
                        "orderable" => true,
                    ]
                ],
            ],
        ]
    ];
    public function users()
    {
        return $this->belongsToMany(User::class,'model_has_roles','role_id','model_id');
    }
    public function permissions()
    {
        return $this->belongsToMany(Permission::class,'role_has_permissions', 'role_id', 'permission_id');
    }
    public function roleHasPermissions(){
        return $this->hasMany(RoleHasPermission::class,'role_id');
    }
}
