<?php

namespace App\Http\Controllers;

use App\Environment;
use Illuminate\Http\Request;
use App\Http\Controllers\ResponseController as ResponseController;
use Validator;

class EnvironmentController extends ResponseController
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $environments = Environment::all();
        return $this->sendResponse($environments->toArray(), 'Environments retrieved successfully.');
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
            'name' => 'required|unique:environments,name',
            'description' => 'required'
        ]);

        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());
        }
        $environment = Environment::create($input);
        return $this->sendResponse($environment->toArray(), 'Environment created successfully.'); 
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Environment  $environment
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $environment = Environment::find($id);

        if (is_null($environment)) {
            return $this->sendError('Environment not found.');
        }
        return $this->sendResponse($environment->toArray(), 'Environment retrieved successfully.'); 
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Environment  $environment
     * @return \Illuminate\Http\Response
     */
    public function edit(Environment $environment)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Environment  $environment
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Environment $environment)
    {
        $input = $request->all();

        $validator = Validator::make($input, [
            'name' => 'required|unique:environments,name,'. $environment->id,
            'description' => 'required'
        ]);

        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());
        }

        $environment->name = $input['name'];
        $environment->description = $input['description'];
        $environment->save();

        return $this->sendResponse($environment->toArray(), 'Environment updated successfully.'); 
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Environment  $environment
     * @return \Illuminate\Http\Response
     */
    public function destroy(Environment $environment)
    {
        $environment->delete();
        return $this->sendResponse($environment->toArray(), 'Environment deleted successfully.');
    }
}
