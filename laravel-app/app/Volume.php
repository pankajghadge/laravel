<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Volume extends Model
{
    public function servers()
    {
        return $this->belongsTo('App\Server');
    }
}
