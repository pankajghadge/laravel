<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateItemsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('items', function (Blueprint $table) {
            $table->increments('id');
	    $table->softDeletes();
            $table->string('name');
	    $table->string('short_name',10)->nullable();
	    $table->foreign('environment_id')->references('id')->on('environments');
	    $table->string('region');
	    $table->enum('item_request_status', ['pending', 'approved', 'rejected', 'cancelled']);
	    $table->json('json_item_data')->nullable();
	    $table->text('description')->nullable();
	    $table->foreign('approved_by')->references('id')->on('users')->nullable();
	    $table->foreign('crerated_by')->references('id')->on('users')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('items');
    }
}
