<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
     /**
     * The attributes that are mass assignable.
     * @var array
     */
    protected $fillable = [
        'name', 'description', 'multiple_servers'
    ];

    /**
     * Get the product versions for the product.
     */
    public function product_versions()
    {
        return $this->hasMany('App\ProductVersion');
    }
}
