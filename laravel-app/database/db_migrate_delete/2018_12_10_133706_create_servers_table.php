<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateServersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('servers', function (Blueprint $table) {
            $table->increments('id');
	    $table->string('instance_id')->nullable();
	    $table->string('region')->nullable();
	    $table->string('availability_zone')->nullable();

	    $table->integer('item_id')->unsigned();
	    $table->foreign('item_id')->references('id')->on('items');

	    $table->mediumInteger('ram')->unsigned();
	    $table->smallInteger('cpu')->unsigned();
            $table->string('os');
	    $table->string('domain');
	    $table->ipAddress('ip_address');
	    $table->text('description')->nullable();
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
        Schema::dropIfExists('servers');
    }
}
