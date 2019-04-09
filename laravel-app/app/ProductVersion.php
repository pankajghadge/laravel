<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProductVersion extends Model
{
    /**
     * The attributes that are mass assignable.
     * @var array
     */
    protected $fillable = [
        'product_id', 'value', 'salt_config_data', 'ansible_config_data', 'description'
    ]; 

    public function product()
    {
        return $this->belongsTo('App\Product');
    } 
}
