<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Server extends Model
{
    
    public function items()
    {
        return $this->belongsTo('App\Item');
    } 
    public function volumes()
    {
       return $this->hasMany('App\Volume');
    }
}
