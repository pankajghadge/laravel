<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Item extends Model
{

   /**
     * Get the product versions for the product.
     */
    public function servers()
    {
        return $this->hasMany('App\Server');
    } 
}
