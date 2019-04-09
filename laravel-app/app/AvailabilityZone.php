<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class AvailabilityZone extends Model
{
    /**
     * The attributes that are mass assignable.
     * @var array
     */
    protected $fillable = [
        'region_id', 'name', 'code', 'description'
    ];

    public function region()
    {
        return $this->belongsTo('App\Region');
    } 
}
