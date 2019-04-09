<?php

namespace App\Http\Controllers;

use App\ProductVersion;
use Illuminate\Http\Request;
use App\Http\Controllers\ResponseController as ResponseController;
use Validator;

class ProductVersionController extends ResponseController
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //$product_versions = ProductVersion::all();
	$product_versions = ProductVersion::with('product')->get();
        return $this->sendResponse($product_versions->toArray(), 'Product versions retrieved successfully.');
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
           'product_id' => 'required|exists:products,id|unique:product_versions,product_id,NULL,id,value,'.$input["value"],
           'value' => 'required'
       ]);

       if($validator->fails()){
           return $this->sendError('Validation Error.', $validator->errors());
       }

       $product_version = ProductVersion::create($input);

       return $this->sendResponse($product_version->toArray(), 'Product version created successfully.');  
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\ProductVersion  $productVersion
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        #$product_version = ProductVersion::find($id);
	$product_version = ProductVersion::with('product')->get()->find($id);

        if (is_null($product_version)) {
            return $this->sendError('Product version not found.');
        }
        return $this->sendResponse($product_version->toArray(), 'Product version retrieved successfully.'); 
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\ProductVersion  $productVersion
     * @return \Illuminate\Http\Response
     */
    public function edit(ProductVersion $productVersion)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\ProductVersion  $productVersion
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, ProductVersion $productVersion)
    {
        $input = $request->all();

	$id = $productVersion->id ?: 'NULL';

        $validator = Validator::make($input, [
	   'product_id' => 'required|exists:products,id|unique:product_versions,product_id,'. $id .',id,value,'.$input["value"],
           'value' => 'required'
       ]);

        if($validator->fails()){
            return $this->sendError('Validation Error.', $validator->errors());
        }

        $productVersion->product_id = $input['product_id'];
        $productVersion->value = $input['value'];
        $productVersion->save();

        return $this->sendResponse($productVersion->toArray(), 'Product version updated successfully.'); 
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\ProductVersion  $productVersion
     * @return \Illuminate\Http\Response
     */
    public function destroy(ProductVersion $productVersion)
    {
        $productVersion->delete();
        return $this->sendResponse($productVersion->toArray(), 'Product version deleted successfully.');
    }
}
