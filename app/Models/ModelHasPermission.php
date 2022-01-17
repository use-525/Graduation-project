<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ModelHasPermission extends Model
{
    use HasFactory;
    protected $table = "model_has_permissions";
    public $timestamps = false;
    protected $fillable = ['model_id','permission_id','model_type']; 
}
