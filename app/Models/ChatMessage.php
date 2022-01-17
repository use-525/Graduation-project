<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\CarbonImmutable;

class ChatMessage extends Model
{
    use HasFactory;
   
    protected $fillable = [
        'chat_room_id',
        'user_id',
        'message',
        'image',
        'receiver_id'
    ];
    protected $appends = [
        'time',
    ];
    public function getTimeAttribute()
    {
        return CarbonImmutable::parse($this->updated_at)->calendar();
    }
    public function room()
    {
        return $this->hasOne('App\Models\ChatRoom', 'id', 'chat_room_id');
    }
    public function user()
    {
        return $this->hasOne('App\Models\User', 'id', 'user_id');
    }
}