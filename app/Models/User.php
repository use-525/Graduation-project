<?php

namespace App\Models;

use Laravel\Passport\HasApiTokens;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Spatie\Permission\Traits\HasRoles;
use JamesDordoy\LaravelVueDatatable\Traits\LaravelVueDatatableTrait;
use Spatie\Permission\Models\Permission;
use Illuminate\Support\Facades\Auth;
use Carbon\CarbonImmutable;

class User extends Authenticatable
{
    use HasApiTokens,HasFactory, Notifiable,HasRoles,LaravelVueDatatableTrait;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'username',
        'email',
        'password',
        'image',
        'online',
        'name',
        'address',
        'gender',
        'phone' ,
        'socket_id',
        'is_active',
        'provider',
        'provider_id',
        'github_url'
    ];

    protected $guard_name = 'api';
    protected $dataTableColumns = [
        'id' => [
            'searchable' => true,
        ],
        'username' => [
            'searchable' => true,
        ],
        'email' => [
            'searchable' => true,
        ],
        'image' => [
            'searchable' => false,
        ],
        'name' => [
            'searchable' => true,
        ],
    ];

    protected $dataTableRelationships = [
        "hasMany" => [
            'solutions' => [
                "model" => Solution::class,
                'foreign_key' => 'user_id',
                'columns' => [
                    'title' => [
                        'searchable' => true,
                        'orderable' => true,
                    ],
                ],
            ],
        ],
        "belongsToMany" => [
            "roles" => [
                "model" => Role::class,
                "pivot" => [
                    "table_name" => "model_has_roles",
                    "foreign_key" => "role_id",
                    "local_key" => "model_id",
                ],
                "columns" => [
                    "name" => [
                        "searchable" => true,
                        "orderable" => true,
                    ]
                ],
            ],
            "challenges" => [
                "model" => Challenge::class,
                "pivot" => [
                    "table_name" => "challenge_users",
                    "foreign_key" => "challen_id",
                    "local_key" => "user_id",
                ],
                "columns" => [
                    "title" => [
                        "searchable" => true,
                        "orderable" => true,
                    ]
                ],
            ]
        ]
    ];
    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    protected $appends = [
        'photo_url',
        'time',

    ];
   
    public function getTimeAttribute()
    {
        return CarbonImmutable::parse($this->updated_at)->calendar();
    }

    /**
     * Get the profile photo URL attribute.
     *
     * @return string
     */
    public function getPhotoUrlAttribute()
    {
        return vsprintf('https://www.gravatar.com/avatar/%s.jpg?s=200&d=%s', [
            md5(strtolower($this->email)),
            $this->name ? urlencode("https://ui-avatars.com/api/$this->name") : 'mp',
        ]);
    }

    public function getAllPermissionsAttribute() {
        $permissions = [];
          foreach (Permission::all() as $permission) {
            if (Auth::user()->can($permission->name)) {
              $permissions[] = $permission->name;
            }
          }
          return $permissions;
    }
    public function roles()
    {
        return $this->belongsToMany(Role::class,'model_has_roles', 'model_id', 'role_id');
    }
    public function permissions()
    {
        return $this->belongsToMany('App\Models\Permission','model_has_permissions', 'model_id', 'permission_id');
    }
    public function hasPermission()
    {
        return $this->hasMany(ModelHasPermission::class,'model_id');
    }
    public function challenges()
    {
        return $this->belongsToMany(Challenge::class,'challenge_users', 'user_id', 'challen_id');
    }
    public function solutions()
    {
        return $this->hasMany(Solution::class,'user_id');
    }
    public function feedbacks()
    {
        return $this->hasMany(Feedback::class,'user_id');
    }
    public function upvote()
    {
        return $this->hasMany(Upvote::class,'user_id');
    }
}
