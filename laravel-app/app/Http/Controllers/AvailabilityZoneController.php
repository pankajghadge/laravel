<?php

namespace App\Http\Controllers;

use App\AvailabilityZone;
use Illuminate\Http\Request;
use App\Http\Controllers\ResponseController as ResponseController;
use Validator;

class AvailabilityZoneController extends ResponseController
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
         $availability_zones = AvailabilityZone::with('region')->get();
         return $this->sendResponse($availability_zones->toArray(), 'Availability Zone retrieved successfully.');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
       $input = $request->all();

       $validator = Validator::make($input, [
           'region_id' => 'required|exists:regions,id|unique:availability_zones,region_id,NULL,id,code,'.$input["code"],
           'name' => 'required|unique:availability_zones,name', 
           'code' => 'required|unique:availability_zones,code',
       ]);

       if($validator->fails()){
           return $this->sendError('Validation Error.', $validator->errors());
       }

       $availability_zone = AvailabilityZone::create($input);

       return $this->sendResponse($availability_zone->toArray(), 'Availability Zone created successfully.'); 
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\AvailabilityZone  $availabilityZone
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $availability_zone = AvailabilityZone::with('region')->get()->find($id);

        if (is_null($availability_zone)) {
            return $this->sendError('Availability Zone not found.');
        }
        return $this->sendResponse($availability_zone->toArray(), 'Availability Zone retrieved successfully.'); 
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\AvailabilityZone  $availabilityZone
     * @return \Illuminate\Http\Response
     */
    public function edit(AvailabilityZone $availabilityZone)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\AvailabilityZone  $availabilityZone
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, AvailabilityZone $availabilityZone)
    {
        $input = $request->all();

        $id = $availabilityZone->id ?: 'NULL';

        $validator = Validator::make($input, [
           'region_id' => 'required|exists:regions,id|unique:availability_zones,region_id,'. $id .',id,code,'.$input["code"],
           'name' => 'required|unique:availability_zones,name,'. $availabilityZone->id,
           'code' => 'required|unique:availability_zones,code,'. $availabilityZone->id,
        ]);

        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());
        }

        $availabilityZone->region_id = $input['region_id'];
        $availabilityZone->name = $input['name'];
        $availabilityZone->code = $input['code'];
        if(isset($input['description'])) {
	   $availabilityZone->description = $input['description'];
	}
        $availabilityZone->save();

        return $this->sendResponse($availabilityZone->toArray(), 'Availability Zone updated successfully.'); 
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\AvailabilityZone $availabilityZone
     * @return \Illuminate\Http\Response
     */
    public function destroy(AvailabilityZone $availabilityZone)
    {
        $availabilityZone->delete();
	return $this->sendResponse($availabilityZone->toArray(), 'Availability Zone deleted successfully.');
    }
}
