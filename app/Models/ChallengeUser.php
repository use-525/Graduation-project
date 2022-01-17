<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ChallengeUser extends Model
{
    use HasFactory;
    protected $table = "challenge_users";

    protected $fillable = ['user_id','challen_id','status'];
  
}
