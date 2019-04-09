<?php

namespace App\Http\Controllers;

use App\Region;
use App\Http\Controllers\ResponseController as ResponseController;
use Illuminate\Http\Request;
use App\Rules\FQDN;
use Validator;

class RegionController extends ResponseController
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $regions = Region::all();
        return $this->sendResponse($regions->toArray(), 'Regions retrieved successfully.');
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
           'name' => 'required|unique:regions,name',
           'region'=>'required|unique:regions,region',
	   'endpoint'=> ['required', new FQDN, 'unique:regions,endpoint'],
       ]);

       if($validator->fails()){
           return $this->sendError('Validation Error.', $validator->errors());
       }

       $region = Region::create($input);

       return $this->sendResponse($region->toArray(), 'Region created successfully.'); 
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Region  $region
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $region = Region::find($id);

        if (is_null($region)) {
            return $this->sendError('Region not found.');
        }

        return $this->sendResponse($region->toArray(), 'Region retrieved successfully.'); 
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Region  $region
     * @return \Illuminate\Http\Response
     */
    public function edit(Region $region)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Region  $region
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Region $region)
    {
        $input = $request->all();

        $validator = Validator::make($input, [
          'name' => 'required|unique:regions,name,'. $region->id,
          'region'=>'required|unique:regions,region,'.  $region->id,
          'endpoint'=>['required',new FQDN,'unique:regions,endpoint,'. $region->id],
        ]);

        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());
        }

        $region->name = $input['name'];
        $region->region = $input['region'];
        $region->endpoint = $input['endpoint'];
        if(isset($input['description'])) {
 	   $region->description = $input['description'];
	}	
        $region->save();

        return $this->sendResponse($region->toArray(), 'Region updated successfully.');  
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Region  $region
     * @return \Illuminate\Http\Response
     */
    public function destroy(Region $region)
    {
        $region->delete();
        return $this->sendResponse($region->toArray(), 'Region deleted successfully.');
    }
}
