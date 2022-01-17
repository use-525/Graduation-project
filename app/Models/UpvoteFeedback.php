<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UpvoteFeedback extends Model
{
    use HasFactory;
    protected $table = 'upvote_feedbacks';
    protected $fillable = ['user_id','feedback_id'];
}
