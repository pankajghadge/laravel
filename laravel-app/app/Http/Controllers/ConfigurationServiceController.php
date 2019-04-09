<?php

namespace App\Http\Controllers;

use App\ConfigurationService;
use Illuminate\Http\Request;
use App\Http\Controllers\ResponseController as ResponseController;
use Validator;

class ConfigurationServiceController extends ResponseController
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $configuration_service = ConfigurationService::all();
        return $this->sendResponse($configuration_service->toArray(), 'Configuration Service retrieved successfully.'); 
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
            'name' => 'required|unique:configuration_services,name',
            'description' => 'required'
        ]);

        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());
        }
        $configuration_service = ConfigurationService::create($input);
        return $this->sendResponse($configuration_service->toArray(), 'Configuration Service created successfully.');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\ConfigurationService  $configurationService
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $configuration_service = ConfigurationService::find($id);

        if (is_null($configuration_service)) {
            return $this->sendError('Configuration Service not found.');
        }
        return $this->sendResponse($configuration_service->toArray(), 'Configuration Service retrieved successfully.');
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\ConfigurationService  $configurationService
     * @return \Illuminate\Http\Response
     */
    public function edit(ConfigurationService $configurationService)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\ConfigurationService  $configurationService
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, ConfigurationService $configurationService)
    {
        $input = $request->all();

        $validator = Validator::make($input, [
            'name' => 'required|unique:configuration_services,name,'. $configurationService->id,
            'description' => 'required'
        ]);

        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());
        }

        $configurationService->name = $input['name'];
        $configurationService->description = $input['description'];
        $configurationService->save();

        return $this->sendResponse($configurationService->toArray(), 'Configuration Service updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\ConfigurationService  $configurationService
     * @return \Illuminate\Http\Response
     */
    public function destroy(ConfigurationService $configurationService)
    {
        $configurationService->delete();
        return $this->sendResponse($configurationService->toArray(), 'Configuration Service deleted successfully.');
    }
}
