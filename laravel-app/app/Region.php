<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Region extends Model
{
    /**
     * The attributes that are mass assignable.
     * @var array
     */
    protected $fillable = [
        'name', 'region', 'endpoint', 'description'
    ];

    /**
     * Get the availability zone for the region.
     */
    public function availability_zones()
    {
        return $this->hasMany('App\AvailabilityZone');
    } 
}
